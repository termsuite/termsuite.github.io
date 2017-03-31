<div class="alert alert-danger" role="alert">
<strong>Warning: </strong> This documentation page is out of date. Some of its information cannot be applied to current version of TermSuite {{site.termsuite.version}}
</div>



TermSuite offers a convenient way of running terminology extraction and multilingual terminology alignment from its Java API. As expected, this way of running TermSuite allows a deeper control over the components than the [command line API](/documentation/command-line-api/) and the [graphical UI]().

* TOC
{:toc}

### The data model

In TermSuite, a terminology can be seen as a graph where nodes are terms and edges are term variations.

#### The `TermIndex` class (the terminology)

A terminology is an instance of the class `TermIndex`, i.e. a collection of `Term` instances linked to each other by relations of type `TermVariation`.

Inside a given TermIndex, each term is uniquely identified by its words' syntactic labels and lemmas. The identifier property of a term is `groupingKey`. The groupingKey built by concatenating:

 1. its words' syntactic labels,
 2. a colons `:`,
 3. its lemmas.

Example of groupingKey: "npan: production of electric power"

See section [Navigating Terminologies](#navigating-terminologies) to see how to access terms from a TermIndex object.

#### `Term` and `Word` classes

A term is an instance of the class `Term`. A term is composed of *1* to *n* `TermWord` instances, each TermWord instance being a pointer to a TermIndex-unique `Word` instance wrapped with a syntactic label, as illustrated by class diagram below.


![Class diagram of TermIndex, Term, TermWord, and Word classes]({{site.baseurl_root}}/img/datamodel1.png)


##### Example

The term having `npan: production of electric power` as groupingKey is composed of four TermWord instances:

 1. TermWord{syntacticLabel=N, word=*[pointer to word "production"]*}
 1. TermWord{syntacticLabel=P, word=*[pointer to word "of"]*}
 1. TermWord{syntacticLabel=A, word=*[pointer to word "electric"]*}
 1. TermWord{syntacticLabel=N, word=*[pointer to word "power"]*}

#### Term properties
{:id="term-properties"}

In Java code, all properties of a java term can you can be accessed by both its Java Bean method `#get*PropertyName*()` and by its property object `TermProperty.PROPERTY_NAME` (via the TermProperty enum class):

{% highlight java %}

Term term =  myTermIndex.getTermByGroupingKey("npan: production of electric power");
System.out.println("Frequency: " + TermProperty.FREQUENCY.getValue(term));
System.out.println("Frequency: " + term.getFrequency());

{% endhighlight %}


This is the list of all term properties currently supported by TermSuite:

<table class="table table-striped">
	<thead>
		<tr>
			<th>Java constant</th>
			<th>Name</th>
			<th>Shortname</th>
			<th>Description</th>
		</tr>
	</thead>
	<tbody>
	{% for p in site.data.filtering-properties %}
	<tr>
		<td>	{{p.java}}	</td>
		<td>	{{p.name}}	</td>
		<td>	{{p.shortname}}	</td>
		<td>	{%t p.description %}	</td>
	</tr>
	{% endfor %}
	</tbody>
</table>


#### The `TermVariation` class

One of the most interesting features of TermSuite is its ability to detect and extract term variations. This is reified in the data model with the `TermVariation` class.

A TermVariation instance is a directed link that binds two Term instances, the `base` and the `variant`. (In the case of a variation of type VariationType.GRAPHICAL, the TermVariation instance must be interpreted as a bidirectional relation)

All variations (resp. bases) of a term are accessed via the method `Term#getVariations()` (resp. Term#getBases()):

{% highlight java %}
Term term =  myTermIndex.getTermByGroupingKey("nn: wind turbine");
for(TermVariation variation:term.getVariations()) {
	System.out.format("%s --%s--> %s %n",
			variation.getBase(),
			variation.getVariationType(),
			variation.getVariant()
			);
}
{% endhighlight %}

This is the current list of all variation types supported by TermSuite:

<table class="table table-striped">
	<thead>
		<tr><th>Java constant</th><th>Description</th></tr>
	</thead>
	<tbody>
	<tr>
		<td>	SYNTACTIC	</td> <td> A syntagmatic variation between two terms (e.g. from <i>nn: wind power</i> to <i>nnn: wind turbine power</i>)</td>
	</tr>
	<tr>
		<td>	MORPHOLOGICAL	</td> <td> A morphological variation between two terms (e.g. from <i>n: chemotherapy</i> to <i>an: chemohormonal therapy</i>)</td>
		</tr>
		<tr>
		<td>	GRAPHICAL	</td> <td>[Bidirectional]	A small orthographic variation between two terms (most probably a mistake)</td>
		</tr>
		<tr>
		<td>	DERIVES_INTO	</td> <td> (for single-word terms only)	A derivation between two words (e.g. from <i>n: behavior</i> to <i>a: behavioral</i>)</td>
		</tr>
		<tr>
		<td>	IS_PREFIX_OF	</td> <td> (for single-word terms only) A word prefixing (e.g. from <i>n: biodiversity</i> to <i>n: diversity</i>)</td>
	</tr>
	</tbody>
</table>



### Navigating terminologies
{:id="navigating-terminologies"}

#### `TermIndex#getTermByGroupingKey()`

Any term with a TermIndex can be accessed via the method `#getTermByGroupingKey()`.

{% highlight java %}

Term t =  myTermIndex.getTermByGroupingKey("npan: production of electric power");
System.out.println(t.getFrequency());

{% endhighlight %}


#### `TermIndex#getTerms()` (very basic)

Use the `TermIndex#getTerms()` method  (the terminology) to retrieve all
of terms of the terminology and do your processing manually with the collection api.

{% highlight java %}

List<Term> terms = new ArrayList<Term>(myTermIndex.getTerm());
Collections.sort(terms, TermProperty.SPECIFICITY.getComparator(true));

{% endhighlight %}

#### The `Traverser` class

<div class="alert alert-warning" role="alert">
<strong>Note: </strong> The traverser mechanism is TermSuite is still in its embryonic form. Expect
substantial changes in the next versions of the API.
</div>

The `Traverser` class is inspired from [Neo4j's traversal framework](https://neo4j.com/docs/java-reference/current/#tutorial-traversal).
It aims at:

 1. navigating easily the terms of a terminology
 2. navigating the variants of a term (Not yet supported)

A traverser is initiated by invoking the `Traverser#by` method. It makes uses of [term property names](#term-properties).

##### Example 1: navigating the terms by specificity

{% highlight java %}
Traverser.by("sp desc").stream(myTermIndex).forEach(term -> {
		System.out.println(term.getGroupingKey());
});
{% endhighlight %}

##### Example 2: navigating the terms by document frequency

{% highlight java %}
Traverser.by("dfreq desc,sp desc").stream(myTermIndex).forEach(term -> {
		System.out.println(term.getGroupingKey());
});
{% endhighlight %}

##### Example 3: navigating the variations of a term (to come)

<div class="alert alert-warning" role="alert">
Not yet implemented. To come in the next version of TermSuite. Use Term#getVariations() in the meantime.
</div>

### Preprocessing files: `TermSuitePreprocessor`
{:id="termsuite-preprocessor"}

**Note:** Explore `TermSuitePreprocessor` javadoc and discover all capabilities of this launcher class.

The `TermSuitePreprocessor` launcher allows to apply on a corpus only the preprocessings
 available in TermSuite. Preprocessed corpus can then be reused either for terminology extraction
 within TermSuite or for a completely different external use.

The preprocessing steps by applied `TermSuitePreprocessor` are:

  * tokenization,
	* POS-tagging with TreeTagger,
	* lemmatization with TreeTagger,
	* stemming,
	* and multi-word term spotting.

Preprocessing outputs are available as UIMA CASes (Common Analysis System), either as
`xmi` files, as `json` files, or as Java `JCas` instance if using the Java 8 streaming API.

The following subsections give the laucnher code for each of these three cases.

#### Outputs as `json` files

{% highlight java %}
TermSuitePreprocessor
		.fromTxtCorpus(lang, "/path/to/corpus")
		.setTreeTaggerHome("/path/to/treetagger")
		.toJson("/path/to/output/files", "UTF-8")
		.execute();
{% endhighlight %}

#### Outputs as `xmi` files

{% highlight java %}
TermSuitePreprocessor
		.fromTxtCorpus(lang, "/path/to/corpus")
		.setTreeTaggerHome("/path/to/treetagger")
		.toXmi("/path/to/output/files", "UTF-8")
		.execute();
{% endhighlight %}

#### Outputs as UIMA `JCas` instances stream

{% highlight java %}
TermSuitePreprocessor
		.fromTxtCorpus(lang, "/path/to/corpus")
		.setTreeTaggerHome("/path/to/treetagger")
		.stream().forEach(jCas -> {
				/*
				 * Iterate over UIMA anotations...
				 */  
		});
{% endhighlight %}

### Terminology extraction: `TerminoExtractor` (Simple)
{:id="termino-extractor"}

**Note:** Explore `TerminoExtractor` javadoc and discover all capabilities of this launcher class.

#### Extract terminology from text files

The minimal terminology extraction launcher is coded as:

{% highlight java %}
TermIndex termIndex = TerminoExtractor
		.fromTxtCorpus(Lang.FR, "/path/to/root/dir", "UTF-8")
		.setTreeTaggerHome("/path/to/tree/tagger")
		.execute();
{% endhighlight %}

This launcher code above analyzes all `**/*.txt` files within the directory `/path/to/root/dir` and produces the returned terminology as a `TermIndex` instance. Use wildcards to refer to text files with other extensions:

{% highlight java %}
TermIndex termIndex = TerminoExtractor
		.fromTxtCorpus(Lang.FR, "/path/to/root/dir", "**/*.{txt,data}", "UTF-8")
		.setTreeTaggerHome("/path/to/tree/tagger")
		.execute();
{% endhighlight %}


#### Extract terminology from preprocessed files (`xmi` or `json`)

Instead of text files, it is also possible to start a terminology extraction pipeline from a set of preprocessed `xmi` or `json` files. (See [`TermSuitePreprocessor`](#termsuite-preprocessor) for details on preprocessing)

{% highlight java %}
TermIndex termIndex = TerminoExtractor
		.fromPreprocessedXmiFiles(Lang.FR, "/path/to/preprocessed/xmi/files")
		.setTreeTaggerHome(FunctionalTests.getTaggerPath())
		.execute();
{% endhighlight %}


#### Extract terminology from a Java `Document` instances stream

{% highlight java %}
List<Document> documents = Lists.newArrayList();
Document document1 = new Document(lang, "url1", "L'énergie éolienne est l'énergie de demain.");
documents.add(document1);
Document document2 = new Document(lang, "url2", "Une éolienne produit de l'énergie.");
documents.add(document2);

TermIndex termIndex = TerminoExtractor.fromDocumentStream(Lang.FR, documents.stream(), 2)
	.setTreeTaggerHome("/path/to/treetagger")
	.execute();

{% endhighlight %}


#### Extract terminology from a Java `String`

{% highlight java %}
TermIndex termIndex = TerminoExtractor
	.fromTextString(Lang.FR, "L'énergie éolienne est une énergie d'avenir.")
	.setTreeTaggerHome("/path/to/treetagger")
	.execute();
{% endhighlight %}

#### Important: optimize terminology extraction with filtering

The term variant detection phase of the terminology extraction pipeline has a polynomial complexity. As a consequence, when input corpus are too big, the extraction phase may tend to be too long.

##### `TerminoExtractor#preFilter` (not advised)

One way to overcome this issue is to reduce the number of terms contained in the TermIndex before the term variant detection by placing a [term filterer](#filtering-terminologies) in the TerminoExtractor, as illustrated below:

{% highlight java %}
TermIndex termIndex = TerminoExtractor
	.fromTextString(Lang.FR, "L'énergie éolienne est une énergie d'avenir.")
	.setTreeTaggerHome("/path/to/treetagger")
  .preFilter(new TerminoFilterConfig().by(TermProperty.FREQUENCY).keepOverTh(2))
	.execute();
{% endhighlight %}


##### `TerminoExtractor#dynamicMaxSizeFilter` (advised)

The best way to overcome this issue is to filter the TermIndex dynamically during the term spotting phase by setting a maximum number of terms allowed in memory:

{% highlight java %}
TermIndex termIndex = TerminoExtractor
	.fromTextString(Lang.FR, "L'énergie éolienne est une énergie d'avenir.")
	.setTreeTaggerHome("/path/to/treetagger")
  .dynamicMaxSizeFilter(500000)
	.execute();
{% endhighlight %}

The TermIndex will then be cleaned by frequency every time the in-memory number of terms exceeds the parameter limit.


#### Cleaning the output terminology with `TerminoExtractor#postFilter`

An instance of `TerminoFilterConfig` (see Section [filtering terminologies](#filtering-terminologies)) can also be passed to TerminoExtractor by mean of the method `#postFilter` to clean the extracted terminology at the end of the pipeline: (Equivalent to using [TerminoFilterer#execute()](#filtering-terminologies) on the extracted terminology)

{% highlight java %}
TermIndex termIndex = TerminoExtractor
	.fromTextString(Lang.FR, "L'énergie éolienne est une énergie d'avenir.")
	.setTreeTaggerHome("/path/to/treetagger")
  .postFilter(new TerminoFilterConfig().by(TermProperty.FREQUENCY).keepOverTh(2))
	.execute();
{% endhighlight %}


### Terminology extraction: `TermSuitePipeline` (Advanced)
{:id="termsuite-pipeline"}

All features and configuration you need to run a terminology extraction pipeline with the Java API is provided by the `TermSuitePipeline` class. `TerminoExtractor` and `TermSuitePreprocessor` are just wrappers of this class.

 The typical terminology extraction pipeline using is configured and run as follows:

{% highlight java %}
TermIndex termIndex = TermSuitePipeline.create("en")
		.setResourceFilePath("/path/to/termsuite-resources.jar")
		.setCollection(TermSuiteCollection.TXT, "/path/to/corpus", "UTF-8")
		.aeWordTokenizer()
		.setTreeTaggerHome("/path/to/tree-tagger")
		.aeTreeTagger()
		.aeUrlFilter()
		.aeStemmer()
		.aeRegexSpotter()
		.aeSpecificityComputer()
		.aeCompostSplitter()
		.aePrefixSplitter()
		.aeSuffixDerivationDetector()
		.aeSyntacticVariantGatherer()
		.aeGraphicalVariantGatherer()
		.aeExtensionDetector()
		.aeScorer()
		.aeThresholdCleaner(TermProperty.FREQUENCY, 2)
		.setTsvShowScores(false)
		.setTsvShowHeaders(true)
		.setTsvExportProperties(
				TermProperty.GROUPING_KEY,
				TermProperty.FREQUENCY
			)
		.haeTsvExporter("termino.tsv")
		.haeJsonExporter("termino.json")
		.run()
		.getTermIndex();
{% endhighlight %}

A pipeline object is created by invoking the method :

{% highlight java %}
 `TermSuitePipeline.create(langCode)`
{% endhighlight %}

Then you need to invoke the mandatory configuration, i.e. the corpus path  (the root of a  corpus), type, and encoding, and the resource path:

{% highlight java %}
 .setResourcePath("/path/to/resource/pack")
 .setCollection(
		 TermSuiteCollection.TXT,
		 "/path/to/corpus", "UTF-8")
  {% endhighlight %}

After that, methods starting with `ae` are **primary** (or *kernel*) *analysis engines*. These are the analysis engines implementing the core features of terminology extraction : tokenization, stemming, tagging, multi-word term spotting, specificity computing, term variation detection, morphological analysis, etc. Methods starting with `hae` are **helper** *analysis engines*, they implement secondary functionalities: import, export, etc.

Methods starting with `set` or `enable` help configure the analysis engines. In such case, they must preceed the AE they configure in the pipeline chain. For example:

{% highlight java %}
.setTreeTaggerHome("/path/to/treetagger")
.aeTreeTagger()
{% endhighlight %}

Finally, the method `#run()` starts the pipeline processing of the corpus. At the end of the process, you can get the Java terminology (an object of class `TermIndex`) extracted with the method `#getTermIndex()`:

{% highlight java %}
TermIndex terminology = pipeline.getTermIndex();
{% endhighlight %}


#### Exhaustive list of Analysis Engines and configurations

IDE auto-completion will assist you in finding available methods to build your own pipelines. Otherwise, to see what you can do with  `TermSuitePipeline`, see the [Javadoc](http://www.javadoc.io/doc/fr.univ-nantes.termsuite/termsuite-core/{{site.termsuite.version}}).

### Filtering terminologies: `TerminoFilterer`
{:id= "filtering-terminologies"}

Cleaning and filtering terminologies (i.e. TermIndex instances) can be done with the `TerminoFilterer` launcher class. As showed by examples below, the main purpose of this class is to allow to pass a `TerminoFilterConfig` instance by mean of method `TerminoFilterer#configure`.

It is also possible, and often advised, to operate a filtering during the terminology extraction process by passing an instance of TerminoFilterConfig to `TerminoExtractor#preFilter` and `TerminoExtractor#postFilter`. See section [TerminoExtractor](#termino-extractor) for more details.

#### Configuring the filter with `TerminoFilterConfig`

There are two distinct mode of filtering in TermSuite:

 1. filtering by threshold, (method `#keepOverTh`)
 1. filtering by keeping first-n terms. (method `#keepTopN`)

 Both modes imply specifying a TermProperty on which the filter is based. This property is set by invoking method `#by`.

It is also possible to configure wether term variants must be filtered when they do not pass the filter.

##### Example 1: keep terms that occur at least 10 times

{% highlight java %}
TerminoFilterer.create(myTermIndex)
	.configure(new TerminoFilterConfig()
		.by(TermProperty.FREQUENCY)
		.keepOverTh(10))
	.execute();
{% endhighlight %}


##### Example 2: keep the 500 most specific terms and their variants

{% highlight java %}
TerminoFilterer.create(myTermIndex)
	.configure(new TerminoFilterConfig()
    .by(TermProperty.SPECIFICITY)
		.keepTopN(500)
		.keepVariants())
	.execute();
{% endhighlight %}

### Export/Import of a terminology

#### Export to `json`
{:id="export-json"}

`json` is the native format of TermSuite, .i. the only format from which terminology can be reimported.

{% highlight java %}
TermIndexIO.toJson(
  myTermIndex,
  new FileWriter("my-termino.json"),
  new JsonOptions()
);

{% endhighlight %}

The `JsonOptions` class configures the json export. Its parameters are:

<table class="table table-striped">
	<tbody>
  	<tr>
  		<td> withOccurrences </td>
  		<td> (default: <i>true</i>) wether to store occurrences of each term (very space-greedy) </td>
  	</tr>
    <tr>
  		<td> withContext </td>
  		<td> (default: <i>false</i>) wether to store context vectors of each term (extremely space-greedy, to use only in the case of [term alignment](#alignment)) </td>
  	</tr>
    <tr>
  		<td> metadataOnly </td>
  		<td> (default: <i>false</i>) wether to read only the metadata of the terminology </td>
  	</tr>
    <tr>
  		<td> embeddedOccurrences </td>
  		<td> (default: <i>true</i>) wether to store term occurrences in memory (`true`) or in an external [MongoDB](https://www.mongodb.com/) store (`false`, to use then in conjunction with `mongoDBOccStoreURI`)</td>
  	</tr>
    <tr>
  		<td> mongoDBOccStoreURI </td>
  		<td> (no default) the [MongoDB connection string](https://docs.mongodb.com/manual/reference/connection-string/) of the store where to write or read term occurrences</td>
  	</tr>
	</tbody>
</table>

#### Import from `json`

`json` is the only format from which Terminologies can be reimported into TermSuite.

{% highlight java %}
TermIndex termIndex = TermIndexIO.fromJson(
  "my-termino.json",
  new JsonOptions()
);
{% endhighlight %}

See the [Export to json](#export-json) section to see what are the `JsonOptions` parameters available.

#### Export to `tbx`

TermSuite Terminologies can be exported to [TBX](http://www.tbxinfo.net/) format (TermBase eXchange).

{% highlight java %}
TbxExporter.export(
  myTermIndex,
  new FileWriter("my-termino.tbx")
);
{% endhighlight %}

#### Export to `tsv`

TermSuite Terminologies can be exported to TSV (Tab-Separated Values) format. This format is very convenient because it can be imported in spreadsheet softwares like *Excel* and *Calc*. It is also a very human readable format in itself.

Terminologies are exported to tsv as follows:

{% highlight java %}
TsvExporter.export(
  myTermIndex,
  new FileWriter("my-termino.tsv"),
  new TsvOptions()
);
{% endhighlight %}

The `TsvOptions` class configures the TSV export. Its parameters are:

<table class="table table-striped">
	<tbody>
  	<tr>
  		<td> showHeaders </td>
  		<td> (default: <i>true</i>) print headers </td>
  	</tr>
    <tr>
  		<td> showScores </td>
  		<td> (default: <i>false</i>) print variation scores </td>
  	</tr>
    <tr>
  		<td> showVariants </td>
  		<td> (default: <i>true</i>) print term variants right after terms</td>
  	</tr>
    <tr>
  		<td> properties </td>
  		<td> (default: <i>groupingKey,frequency</i>) the columns of the output tsv file </td>
  	</tr>
	</tbody>
</table>

### Bilingual term alignment
{:id="alignment"}

Requirements:

 * a source terminology with context vectors computed,
 * a target terminology with context vectors computed,
 * a [bilingual dictionary](/documentation/resources/#dictionary).

#### Producing terminologies with context vectors

In order to run aligner successfully, you need to extract the terminologies with a context vector for each term:

{% highlight java %}
TermIndex termIndex = TerminoExtractor
    .fromTxtCorpus(Lang.EN, "/path/to/my/corpus", "**/*.txt", "UTF-8")
    .useContextualizer(3, ContextualizerMode.ON_SWT_TERMS)
    .setTreeTaggerHome("/path/to/treetagger")
    .execute();
{% endhighlight %}

And if you need to store extracted terminologies, the serialization of context vectors must be declared explicitely:

{% highlight java %}
TermIndexIO.toJson(
  sourceTermino,
  new FileWriter("source-termino.json"),
  new JsonOptions().withContexts(true)
);
{% endhighlight %}

And also at deserialization step:

{% highlight java %}
TermIndex sourceTermino = TermIndexIO.fromJson(
  "source-termino.json",
  new JsonOptions().withContexts(true)
);
{% endhighlight %}


#### Running the aligner: `BilingualAligner`

`BilingualAligner` is the launcher class for bilingual alignment. Use it as follows:

{% highlight java %}

/*
 * Create an aligner for the source and target terminologies.
 */
BilingualAligner aligner = TermSuiteAlignerBuilder.start()
		.setSourceTerminology(terminoEn)
		.setTargetTerminology(terminoFr)
		.setDicoPath("dico-EN-FR.txt")
		.create();

/*
 * The term to align.
 */
Term sourceTerm = terminoEn.getTermByGroupingKey("nn: wind power")

/*
 * Align the english term "nn: wind power" with english corpus
 * and retrieve 10 candidates. Force the co-terms to occur
 * at least 2 times in the target termino.
 */
 List<TranslationCandidate> results = aligner.align(sourceTerm, 10, 2);
 int i = 0;
 for (BilingualAligner.TranslationCandidate r : results) {
	 System.out.format("%2d %-10s [%.2f] %-15s%n",
			 i,
			 r.getMethod().getShortName(),
			 r.getScore(),
			 r.getTerm().getGroupingKey()
		 );
 }
{% endhighlight %}
