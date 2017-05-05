---
layout: documentation
title: title.properties
menu_title: menu-title.properties
menu: theory
excerpt: excerpt.properties  
permalink: /documentation/properties/
---


{% if "fr" == site.lang %}
<div class="alert alert-warning" role="alert">
<strong>Désolé ! </strong>Cette page n'existe pas en langue française. Veuillez vous référer à la <a href="{{ page.url }}"> version anglaise</a>.
</div>
{% else %}
  {% translate_file documentation/properties.md %}
{% endif %}
