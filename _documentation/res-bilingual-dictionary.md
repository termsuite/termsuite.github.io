---
layout: documentation
title: title.bilingual-dictionary
menu_title: menu-title.bilingual-dictionary
menu: resources
order: 200
excerpt: excerpt.bilingual-dictionary
permalink: /documentation/bilingual-dictionary/
---


{% if "fr" == site.lang %}
<div class="alert alert-warning" role="alert">
  <strong>Désolé ! </strong>Cette page n'existe pas en langue française. Veuillez vous référer à la <a href="{{ page.url }}"> version anglaise</a>.
</div>
{% else %}
  {% translate_file documentation/res-bilingual-dictionary.md %}
{% endif %}
