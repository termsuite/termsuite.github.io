---
layout: documentation
title: title.post-processing
menu_title: menu-title.post-processing
menu: theory
order: 200
excerpt: excerpt.post-processing
permalink: /documentation/post-processing/
---
{% if "fr" == site.lang %}
  <div class="alert alert-warning" role="alert">
  <strong>Désolé ! </strong>Cette page n'existe pas en langue française. Veuillez vous référer à la <a href="{{ page.url }}"> version anglaise</a>.
</div>
{% else %}
  {% translate_file documentation/post-processing.md %}
 {% endif %}
