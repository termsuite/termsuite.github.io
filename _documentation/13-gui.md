---
layout: documentation
title: title.gui
menu_title: menu-title.gui
menu: gui
excerpt: excerpt.gui
permalink: /gui/
getting_started: true
---
{% if "fr" == site.lang %}
  <div class="alert alert-warning" role="alert">
  <strong>Désolé ! </strong>Cette page n'existe pas en langue française. Veuillez vous référer à la <a href="{{ page.url }}"> version anglaise</a>.
</div>
{% else %}
  {% translate_file documentation/gui.md %}
 {% endif %}
