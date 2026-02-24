---
layout: home
title: Zachary's Blog
---
# Hi, I'm Zachary.


Generative AI and Machine Learning Engineer working @ [Datatonic](https://datatonic.com/).

LangChain tutorials @ [YouTube](https://www.youtube.com/@cutwell946)

Solo developer @ [StoryScribbler](https://storyscribbler.com/)

* [GitHub][1]
* [LinkedIn][2]

[1]: https://github.com/Cutwell
[2]: https://www.linkedin.com/in/zacharysmith5/

_Sometimes I write about technology and sci-fi:_
{% if site.compression.blogs and site.posts %}
<table class="post-list">{% for post in site.posts %}<tr><td>{{ post.date | date: "%b %e, %Y" }} >>> </td><td><a href="{{ site.url }}{{ post.url }}">{{ post.title }}</a></td></tr>{% endfor %}</table>
{% endif %}
