<div class="alert alert-danger" role="alert">
<strong>Avertissement: </strong> Cette page de documentation est obsolète. Certaines parties de son contenu peuvent ne pas s'appliquer à la version actuelle de TermSuite : {{site.termsuite.version}}
</div>


* TOC
{:toc}

### L'extraction de terminologie

Pour l'extraction de la terminologie, différentes ressources sont nécessaires pour chaque langue.
Heureusement, ces ressources peuvent être téléchargées en une seule et même fois grâce au paquet :

<a href="{{site.resources.jar}}" class="btn btn-success" role="button">{{site.resources.filename}}</a>
{:class="text-center"}

Pour plus d'informations sur les ressources TermSuite, voir la page du projet Github  [termsuite-ressources](https://github.com/termsuite/termsuite-resources).

### L'alignement multilingue

Pour un alignement multilingue, vous avez besoin :

* de deux terminologies TermSuite (comme les fichiers 'json', la source termino et la cible termino). De telles terminologies sont celles sorties par TermSuite [chaîne de traitement d'exctraction de terminologie]({{site.baseurl}}/documentation/fr/command-line-api/#termino)
* un dictionnaire bilingue


#### Le dictionnaire bilingue
{:id="dictionary"}

<a href="{{site.dicos.zip}}" class="btn btn-success" role="button">Télécharger dictionnaire</a>
{:class="text-center"}

Un tel dictionnaire bilingue est une simple liste de mots sources-cibles, séparés par des tabulations. Les mots n'ont pas besoin d'être lemmatisés :

~~~
rebelle	contumacious
rebelle	defiant
rebelle	disaffected
rebelle	flyaway
rebelle	mutinous
rebelle	obstinate
rebelle	obstreperous
rebelle	rebel
rebelle	rebellious
rebelle	refractory
rebelle	renegade
rebelle	resistant
rebelle	restive
rebelle	stubborn
rebelle	unmanageable
rebelle	unruly
rebelle	unworkable
rebelle	wayward
rebelle	rebel
rebelote	here we go again
rebelote	rebelote
rebiquer	curl up at the ends
rebiquer	stick up
rebirth	rebirthing
reblanchir	rewhiten
reblanchir	rewhitewash
rebobinage	rewinding
rebobiner	rewind
reboisement	reafforestation
reboisement	reforestation
reboiser	afforest
reboiser	reafforest
reboiser	reforest
~~~
