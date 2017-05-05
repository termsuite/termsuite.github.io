---
layout: documentation
title: title.json
menu_title: menu-title.json
menu: theory
order: 15
excerpt: excerpt.json
permalink: /documentation/json/
---
{% if "fr" == site.lang %}
  <div class="alert alert-warning" role="alert">
  <strong>Désolé ! </strong>Cette page n'existe pas en langue française. Veuillez vous référer à la <a href="{{ page.url }}"> version anglaise</a>.
</div>
{% else %}
  {% translate_file documentation/json.md %}
 {% endif %}
