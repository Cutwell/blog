---
layout: home
title: Zachary's Blog
---
# Hi, I'm Zachary.


Generative AI and Machine Learning Engineer working @ [Datatonic](https://datatonic.com/).

LangChain tutorials @ [YouTube](https://www.youtube.com/@cutwell946)

Solo developer @ [StoryScribbler](https://storyscribbler.com/)

<br>

*Sometimes I write about technology and sci-fi:*
{% if site.compression.blogs and site.articles %}
{% assign articles = site.articles | sort: 'last-updated' | reverse %}
<table class="post-list">{% assign current_year = '' %}{% for post in articles %}{% assign post_year = post['last-updated'] | date: "%Y" %}{% if post_year != current_year %}{% assign current_year = post_year %}<tr><td class="post-list-year">{{ post_year }}</td></tr>{% endif %}<tr><td><a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a></td></tr>{% endfor %}</table>
{% endif %}
