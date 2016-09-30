---
layout: documentation
title: titles.developers
menu: menus.developers
excerpt: excerpts.developers
permalink: /documentation/developers/
---
{% if "fr" == site.lang %}
  <div class="alert alert-warning" role="alert">
    <strong>ATTENTION: </strong>Désolé, cette page n'existe pas en langue française. Veuillez vous référer à la <a href="{{ page.url }}"> version anglaise</a>.
  </div>
{% else %}
  {% translate_file documentation/developers.md %}
{% endif %}
