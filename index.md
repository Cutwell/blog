---
layout: home
title: Zachary's Blog
---
# Hi, I'm Zachary.


Generative AI and Machine Learning Engineer working @ [Datatonic](https://datatonic.com/).

LangChain tutorials @ [YouTube](https://www.youtube.com/@cutwell946)

Solo developer @ [StoryScribbler](https://storyscribbler.com/)

*Get in touch*

* Check out my projects on [GitHub](https://github.com/Cutwell)
* Or follow me on [LinkedIn](https://www.linkedin.com/in/zacharysmith5/)

_Sometimes I write about technology and sci-fi:_
{% if site.compression.blogs and site.articles %}
{% assign articles = site.articles | sort: 'last-updated' | reverse %}
<table class="post-list">{% for post in articles %}<tr><td><a href="{{ site.url }}{{ post.url }}">{{ post.title }}</a></td></tr>{% endfor %}</table>
{% endif %}
