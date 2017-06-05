---
layout: documentation
title: title.getting-started-cmd
menu_title: menu-title.getting-started
menu: getting-started
excerpt: excerpt.getting-started-cmd
permalink: /getting-started/
getting_started: true
order: 20
---



{% if "fr" == site.lang %}
<div class="alert alert-warning" role="alert">
<strong>Désolé ! </strong>Cette page n'existe pas en langue française. Veuillez vous référer à la <a href="{{ page.url }}"> version anglaise</a>.
</div>
{% else %}
  {% translate_file documentation/getting-started-cmd.md %}
{% endif %}
