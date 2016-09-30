* TOC
{:toc}

### Terminology extraction

For Terminology extraction, you need several different resources for each language. Fortunately, these resources can all be downloaded at once as a single TermSuite resource pack :

<a href="{{site.resources.jar}}" class="btn btn-success" role="button">{{site.resources.filename}}</a>
{:class="text-center"}

See more information about TermSuite resources on Github project [termsuite-resources](https://github.com/termsuite/termsuite-resources).

### Multilingual term alignment

For multilingual term alignment, you need:

 * two TermSuite terminologies (as `json` files, the source termino and the target termino). Such terminologies are the outputs of TermSuite [terminology extraction pipelines](/documentation/command-line-api/#termino) processed on domain-specific corpora,
 * a bilingual dictionary.

#### The bilingual dictionary
{:id="dictionary"}

<a href="{{site.dicos.zip}}" class="btn btn-success" role="button">Download dicos</a>
{:class="text-center"}

Such a bilingual dictionary is a simple list of tab-separated source-target words. Words do not need to be lemmatized :

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
