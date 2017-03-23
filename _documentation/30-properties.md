---
layout: documentation
title: titles.properties
menu: menus.properties
excerpt: excerpts.properties  
permalink: /documentation/properties/
---


{% if "fr" == site.lang %}
<div class="alert alert-warning" role="alert">
<strong>Désolé ! </strong>Cette page n'existe pas en langue française. Veuillez vous référer à la <a href="{{ page.url }}"> version anglaise</a>.
</div>
{% else %}
  {% translate_file documentation/properties.md %}
{% endif %}
