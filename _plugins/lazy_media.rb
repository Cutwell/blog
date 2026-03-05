require 'base64'
require 'digest'
require 'fileutils'
require 'tempfile'
require 'nokogiri'

begin
  require 'mini_magick'
  MINI_MAGICK_AVAILABLE = true
rescue LoadError
  MINI_MAGICK_AVAILABLE = false
  Jekyll.logger.warn('LazyMedia:', 'mini_magick not available — LQIP generation disabled. Run: bundle install')
end

module LazyMedia
  CACHE = {}
  SUPPORTED_EXTS = %w[.jpg .jpeg .png .gif .webp].freeze
  TRANSPARENT_GIF = 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7'.freeze
  SKIP_ANCESTORS = %w[h1 h2 h3 h4 h5 h6 nav td th].freeze

  def self.cache_dir
    @cache_dir ||= File.join(Dir.pwd, '.lazy-cache')
  end

  def self.lqip_for(src, site_source)
    return nil unless MINI_MAGICK_AVAILABLE
    return nil if src.nil? || src.empty? || src.match?(/\A(data:|https?:\/\/|\/\/)/)

    clean_src = src.split(/[?#]/).first
    full_path = File.join(site_source, clean_src.sub(%r{\A/}, ''))
    return nil unless File.exist?(full_path)

    ext = File.extname(full_path).downcase
    return nil unless SUPPORTED_EXTS.include?(ext)

    mtime = File.mtime(full_path).to_i rescue 0
    cache_key = Digest::MD5.hexdigest("#{full_path}:#{mtime}")

    return CACHE[cache_key] if CACHE.key?(cache_key)

    FileUtils.mkdir_p(cache_dir)
    cache_file = File.join(cache_dir, "#{cache_key}.b64")

    if File.exist?(cache_file)
      data = File.read(cache_file).chomp
      CACHE[cache_key] = data
      return data
    end

    generate_lqip(full_path, ext, cache_key, cache_file)
  end

  def self.generate_lqip(full_path, ext, cache_key, cache_file)
    out_ext = %w[.gif .webp].include?(ext) ? '.jpg' : ext
    tmp = Tempfile.new(['lqip', out_ext])
    tmp.close
    tmp_path = tmp.path

    begin
      MiniMagick::Tool::Convert.new do |c|
        c << (ext == '.gif' ? "#{full_path}[0]" : full_path)
        c.resize('30x30>')
        c.blur('0x8')
        c.quality('15')
        c.strip
        c << tmp_path
      end

      return nil unless File.exist?(tmp_path) && File.size(tmp_path) > 0

      mime = out_ext == '.png' ? 'image/png' : 'image/jpeg'
      data_uri = "data:#{mime};base64,#{Base64.strict_encode64(File.binread(tmp_path))}"

      File.write(cache_file, data_uri)
      CACHE[cache_key] = data_uri
      data_uri
    rescue => e
      Jekyll.logger.warn('LazyMedia:', "LQIP failed for #{File.basename(full_path)}: #{e.message}")
      nil
    ensure
      File.delete(tmp_path) rescue nil
    end
  end
  private_class_method :generate_lqip
end

Jekyll::Hooks.register [:pages, :documents], :post_render do |doc|
  next unless doc.output_ext == '.html'
  next if doc.output.nil? || doc.output.empty?
  site = doc.site
  baseurl = (site.baseurl || '').chomp('/')
  parsed = Nokogiri::HTML.parse(doc.output)
  modified = false

  parsed.css('img').each do |img|
    src = img['src']
    next if src.nil? || src.start_with?('data:')
    next if img['data-no-lazy']
    next if img.ancestors.any? { |a| LazyMedia::SKIP_ANCESTORS.include?(a.name.downcase) }
    next if img.ancestors.any? { |a| a['class']&.include?('lazy-media-container') }

    lqip = LazyMedia.lqip_for(src, site.source)
    has_lqip = !lqip.nil?

    wrapper = Nokogiri::XML::Node.new('div', parsed)
    wrapper['class'] = 'lazy-media-container'

    # Prepend baseurl to root-relative paths so deployed URLs resolve correctly
    resolved_src = (src.start_with?('/') && !baseurl.empty? && !src.start_with?(baseurl + '/')) ? baseurl + src : src
    img['data-src'] = resolved_src
    img['src'] = has_lqip ? lqip : LazyMedia::TRANSPARENT_GIF

    classes = (img['class'] || '').split.reject { |c| c == 'lazy-img' }
    classes << 'lazy-img'
    classes << (has_lqip ? 'lazy-loading' : 'lazy-no-lqip')
    img['class'] = classes.join(' ')
    img.remove_attribute('loading')

    spinner = Nokogiri::XML::Node.new('div', parsed)
    spinner['class'] = 'lazy-spinner'

    img.add_next_sibling(wrapper)
    wrapper.add_child(img.remove)
    wrapper.add_child(spinner)
    modified = true
  end

  parsed.css('video').each do |video|
    next if video.ancestors.any? { |a| a['class']&.include?('lazy-media-container') }

    wrapper = Nokogiri::XML::Node.new('div', parsed)
    wrapper['class'] = 'lazy-media-container lazy-video-container'

    video.css('source').each do |source|
      next unless source['src']
      vsrc = source['src']
      source['data-src'] = (vsrc.start_with?('/') && !baseurl.empty? && !vsrc.start_with?(baseurl + '/')) ? baseurl + vsrc : vsrc
      source.remove_attribute('src')
    end

    if video['src']
      vsrc = video['src']
      video['data-src'] = (vsrc.start_with?('/') && !baseurl.empty? && !vsrc.start_with?(baseurl + '/')) ? baseurl + vsrc : vsrc
      video.remove_attribute('src')
    end

    classes = (video['class'] || '').split.reject { |c| c == 'lazy-video' }
    classes << 'lazy-video'
    video['class'] = classes.join(' ')

    spinner = Nokogiri::XML::Node.new('div', parsed)
    spinner['class'] = 'lazy-spinner'

    video.add_next_sibling(wrapper)
    wrapper.add_child(video.remove)
    wrapper.add_child(spinner)
    modified = true
  end

  doc.output = parsed.to_html if modified
end
