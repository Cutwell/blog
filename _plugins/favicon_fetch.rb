require 'net/http'
require 'uri'
require 'digest'
require 'base64'
require 'fileutils'
require 'nokogiri'

module FaviconFetch
  CACHE = {}

  def self.cache_dir
    @cache_dir ||= File.join(Dir.pwd, '.favicon-cache')
  end

  def self.favicon_data_uri(hostname)
    return CACHE[hostname] if CACHE.key?(hostname)

    FileUtils.mkdir_p(cache_dir)
    cache_file = File.join(cache_dir, "#{Digest::MD5.hexdigest(hostname)}.b64")

    if File.exist?(cache_file)
      data = File.read(cache_file).chomp
      CACHE[hostname] = data
      return data
    end

    data_uri = fetch_favicon(hostname)
    if data_uri
      File.write(cache_file, data_uri)
      CACHE[hostname] = data_uri
    else
      CACHE[hostname] = nil
    end
    data_uri
  end

  def self.fetch_favicon(hostname)
    url = URI("https://icons.duckduckgo.com/ip3/#{hostname}.ico")
    redirects_remaining = 3

    begin
      loop do
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = url.scheme == 'https'
        http.open_timeout = 5
        http.read_timeout = 5

        response = http.get(url.request_uri, 'User-Agent' => 'Jekyll-FaviconFetch/1.0')

        case response.code.to_i
        when 200
          body = response.body
          return nil if body.nil? || body.empty?

          mime = response['content-type']&.split(';')&.first&.strip || 'image/png'
          mime = 'image/png' unless mime.start_with?('image/')
          return "data:#{mime};base64,#{Base64.strict_encode64(body)}"
        when 301, 302, 303, 307, 308
          redirects_remaining -= 1
          return nil if redirects_remaining < 0

          location = response['location']
          return nil if location.nil? || location.empty?

          url = URI(location)
        else
          Jekyll.logger.warn('FaviconFetch:', "Got #{response.code} for #{hostname}")
          return nil
        end
      end
    rescue => e
      Jekyll.logger.warn('FaviconFetch:', "Failed for #{hostname}: #{e.message}")
      nil
    end
  end
  private_class_method :fetch_favicon
end

Jekyll::Hooks.register [:pages, :documents], :post_render do |doc|
  next unless doc.output_ext == '.html'
  next if doc.output.nil? || doc.output.empty?

  site = doc.site
  site_hostname = begin
    URI.parse(site.config['url'] || '').host
  rescue
    nil
  end

  parsed = Nokogiri::HTML.parse(doc.output)
  modified = false

  parsed.css('a[href^="http"]').each do |a|
    href = a['href']
    next if href.nil?

    begin
      uri = URI.parse(href)
    rescue
      next
    end

    next if uri.host.nil?
    next if uri.host == site_hostname
    next if a.at_css('img.link-favicon')

    data_uri = FaviconFetch.favicon_data_uri(uri.host)
    next unless data_uri

    img = Nokogiri::XML::Node.new('img', parsed)
    img['src'] = data_uri
    img['class'] = 'link-favicon'
    img['aria-hidden'] = 'true'
    a.prepend_child(img)
    modified = true
  end

  doc.output = parsed.to_html if modified
end
