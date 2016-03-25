TermSuite offre un bon moyen d'executer l'extraction de terminologie et l'alignement de terminologies multilingues depuis ses API Java. 
Comme on peut s'y attendre, ce moyen d'executer TermSuite permet un meilleur contrôle que la [ligne de commande API](/documentation/fr/command-line-api/) et le [UI graphique]().

* TOC
{:toc}

### Extraction de terminologie

#### La classe utilitaire* `TermSuitePipeline`

Toutes les fonctions et configurations dont vous avez besoin pour executer la chaîne de traitement d'exctraction de terminologie avec l'API Java est fourni par la classe "TermSuitePipeline". La chaîne d'extraction type est utilisé et executé comme ceci :

{% highlight java %}
TermSuitePipeline pipeline = TermSuitePipeline.create("en")
			.setResourcePath("/path/to/resource/pack")
			.setCollection(
					TermSuiteCollection.TXT,
					"/path/to/corpus", "UTF-8")
			.aeWordTokenizer()
			.setTreeTaggerHome("/path/to/treetagger")
			.aeTreeTagger()
			.aeUrlFilter()
			.aeStemmer()
			.aeRegexSpotter()
			.aeSpecificityComputer()
			.aeCompostSplitter() // morphological analysis
			.aeSyntacticVariantGatherer()
			.aeGraphicalVariantGatherer()
			.aeTermClassifier(TermProperty.FREQUENCY)
			.setTsvExportProperties(
					TermProperty.PILOT,
					TermProperty.FREQUENCY,
					TermProperty.WR
				)
			.haeTsvExporter("terminology.tsv")
			.haeJsonExporter("terminology.json")
			.run();
{% endhighlight %}

Un objet pipeline est créé en invoquant la méthode :

{% highlight java %}
 `TermSuitePipeline.create(langCode)`
{% endhighlight %}

Ensuite, vous devez invoquer la configuration obligatoire, i.e. le chemin du corpus (la racine d'un [corpus multilingue TermSuite](/documentation/fr/corpus/)), tapé, et encodé, et le chemin vers le paquet ressource :

{% highlight java %}
 .setResourcePath("/path/to/resource/pack")
 .setCollection(
		 TermSuiteCollection.TXT,
		 "/path/to/corpus", "UTF-8")
  {% endhighlight %}

Après cela, les méthodes commençant par 'ae' (pour  *analysis engines*) sont **primary** (ou *kernel*). Ces dernières implantent les fonctions des polices de l'extraction de terminologie : découpe en unité lexicales élémentaires (tokénisation), stemming, étiquettage, repérage de multi-mots, spécificités informatiques, détections de terme variable, analyse morphologique, etc.

Les méthodes commençant par "hae" sont **helper** *analysis engines*, elles mettent en place des fonctionnalités secondaires telles que l'importation ou l'exportation.

Les méthodes commençant par 'set' ou 'enable' aident à configurer les moteurs d'analyse. Dans ce cas, ils doivent précéder l'AE, car ils configurent la chaîne de traitement.

Par exemple :

{% highlight java %}
.setTreeTaggerHome("/path/to/treetagger")
.aeTreeTagger()
{% endhighlight %}

Enfin, la méthode 'run' démarre le processus de traitement du corpus. À la fin de ce processus, vous pouvez avoir la terminologie Java (un objet de la classe 'TermIndex') extrait avec la méthode 'getTermIndex()' :

{% highlight java %}
TermIndex terminology = pipeline.getTermIndex();
{% endhighlight %}

#### Executer une chaîne de traitement depuis un terminologie existante

'TermSuitePipeline' autorise également l'execution d'une chaîne de traitement existante. Pour faire cela, passez une terminologie existante par la méthode 'TermSuitePipeline.create()', invoquez 'emptyCollection()', et invoquez l'AE que vous souhaitez.

Par exemple les lignes suivantes filtrent tous les termes ayant moins de deux occurrences dans la terminologie :

{% highlight java %}
TermSuitePipeline.create(myTerminology)
		.emptyCollection()
		.aeThresholdCleaner(TermProperty.FREQUENCY, 2)
		.run();
{% endhighlight %}

#### La liste complète des Moteurs d'Analyse et leurs configurations

L'environnement de développement auto-complétion vous aidera à trouver les méthodes disponibles pour construire vos propres chaînes de traitement.
Autrement, pour voir vos possibilités avec 'TermSuitePipeline', regardez le [Javadoc](http://www.javadoc.io/doc/fr.univ-nantes.termsuite/termsuite-core/{{site.termsuite.version}}).

### Exporter / Importer des terminologies 'json'

#### Exporter

Les terminologies peuvent être exportées directement de la chaîne de traitement en invoquant l'AE 'jsonExporter()'. D'autres exporteurs ('tbx' et 'tsv') sont également disponibles depuis la chaîne de traitement, mais ils ne peuvent être réimportés ensuite. Seules les terminologies 'json' peuvent être importées.

Vous pouvez aussi exporter l'objet de la terminologie (l'exemple de classe 'TermIndex') dans une ligne comme ici :

{% highlight java %}
JSONTermIndexIO.save(
		new FileWriter(""),
		myTermino,
		true, 	// store all occurrences
		false); // do not store term contexts (very expensive)

{% endhighlight %}

#### Importer

Il est également possible de charger les terminologies qui ont été calculées précédemment, en une seule ligne :

{% highlight java %}
TermIndex myTerminology = JSONTermIndexIO.load(
				new FileReader("myterminology.json"),
				false);
{% endhighlight %}

### Alignement de termes multilingues

Pour l'alignement de termes multilingues, vous avez besoin :


	* de deux terminologies TermSuite (comme des fichiers 'json', la source termino et la cible termino). De pareilles terminologies sont celles sorties par TermSuite [pipelines d'extraction de terminologie](/documentation/fr/command-line-api/#termino) dans un [corpora](documentation/fr/corpus) d'un domaine de spécificité comparable.
 * un [dictionnaire bilingue](/documentation/fr/ressources/#dictionary).


#### Produire des terminologies TermSuite valables pour l'alignement

Afin d'executer l'alignement depuis une *terminologie source* vers une *terminologie source*, vous devez extraire ces deux terminologies avec un vecteur contextuel pour chacun d'entre eux.
Pour faire cela, vous devez ajouter l'AE *Contextualizer* (`aeContextualizer()`) à la fin de votre chaîne de traitement d'extraction, juste avant d'exporter les AE :

{% highlight java %}
TermSuitePipeline pipeline = TermSuitePipeline.create("en")
			.setResourcePath("/path/to/resource/pack")
			.setCollection(
					TermSuiteCollection.TXT,
					"/path/to/corpus", "UTF-8")
			.aeWordTokenizer()
			.setTreeTaggerHome("/path/to/treetagger")
			.aeTreeTagger()
			.aeUrlFilter()
			.aeStemmer()
			.aeRegexSpotter()
			.aeSpecificityComputer()
			.aeCompostSplitter()
			.aeSyntacticVariantGatherer()
			.aeGraphicalVariantGatherer()
			.aeContextualizer(5, true) // computes scope-5 contexts for all terms, including multi-word terms
			.setExportJsonWithContext(true)
			.setExportJsonWithOccurrences(true) // expensive in disk size, but mandatory
			.haeJsonExporter("terminology.json")
			.run();
{% endhighlight %}

Notez que dans la chaîne ci--dessus, vous devez spécifiquement déclarer que vous voulez que les vecteurs contextuels tout juste crééés soient stockés dans le fichier json.
Si vous voulez sauvegarder le termino séparément du pipeline :

{% highlight java %}
JSONTermIndexIO.save(
		new FileWriter(""),
		myTermino,
		true, 	// garde toutes les occurrences
		true); // garde les contextes
{% endhighlight %}

#### Executer l'alignement bilingue : 'BiliguaAligner'

Un aligneur bilingue peut aisément être créé depuis les deux terminologies et le dictionnaire, grâce à la *builder class* `BilingualAligner` (voir [Javadoc]({{site.javadoc}}) pour plus de détails). Une fois l'aligneur créé, vous effectuez l'alignement en appelant la méthode 'align()' comme suit :

{% highlight java %}
// Load terminologies from json files
TermIndex sourceTermino = JSONTermIndexIO.load(new FileReader("wind-energy-fr.json"), true);
TermIndex targetTermino = JSONTermIndexIO.load(new FileReader("wind-energy-en.json"), true);


BilingualAligner aligner = TermSuiteAlignerBuilder.start()
		.setTargetTerminology(targetTermino)
		.setDicoPath("my-dico.fr")
		.setDistance(DISTANCE)
		.create();


/*
 * Aligne le terme français 'hydroélectrique' avecl le corpus anglais
 * et récupère 10 candidats. Force les candidats à apparaître
 * au moins deux fois dans le termino cible
 */
List<TranslationCandidate> results = aligner.align(
		sourceTermino.getTermByGroupingKey("a: hydroélectrique"),
		10,
		2);

//
int i = 0;
for (BilingualAligner.TranslationCandidate r : results) {
	i++;
	System.out.format("%2d [%.2f] %-15s %s\n",
			i,
			r.getScore(),
			r.getTerm().getLemma(),
			r.getExplanation()
		);
}
{% endhighlight %}

#### Explication

Il est important de remarquer que vous pouvez aussi...
