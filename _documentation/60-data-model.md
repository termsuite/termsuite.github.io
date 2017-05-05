---
layout: documentation
title: title.data-model
menu_title: menu-title.data-model
menu: theory
order: 10
excerpt: excerpt.data-model
status: draft
permalink: /documentation/data-model/
---
{% if "fr" == site.lang %}
  <div class="alert alert-warning" role="alert">
  <strong>Désolé ! </strong>Cette page n'existe pas en langue française. Veuillez vous référer à la <a href="{{ page.url }}"> version anglaise</a>.
</div>
{% else %}
  {% translate_file documentation/data-model.md %}
 {% endif %}
