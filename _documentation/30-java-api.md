---
layout: documentation
title: TermSuite Java API
menu: Java API
permalink: /documentation/java-api/
---

TermSuite offers a convenient way of running terminology extraction and multilingual terminology alignment from its Java API. As expected, this way of running TermSuite allows a deeper control over the components than the [command line API](/documentation/command-line-api/) and the [graphical UI]().

* TOC
{:toc}

### Terminology extraction

#### The `TermSuitePipeline` helper class

All features and configuration you need to run a terminology extraction pipeline with the Java API is provided by the `TermSuitePipeline` class. The typical terminology extraction pipeline using is configured and run as follows:

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

A pipeline object is created by invoking the method :

{% highlight java %}
 `TermSuitePipeline.create(langCode)`
{% endhighlight %}

Then you need to invoke the mandatory configuration, i.e. the corpus path  (the root of a valid multilingual [TermSuite corpus](/documentation/corpus/)), type, and encoding, and the resource path:

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

Finally, the method `run` starts the pipeline processing of the corpus. At the end of the process, you can get the Java terminology (an object of class `TermIndex`) extracted with the method `getTermIndex()`:

{% highlight java %}
TermIndex terminology = pipeline.getTermIndex();
{% endhighlight %}

#### Run a pipeline from an existing terminology

`TermSuitePipeline` also allows you to run a pipeline from an existing Terminology. To do that, pass an existing terminology to the method `TermSuitePipeline.create()`, invoke `emptyCollection()`, and invoke the AE you want.

For example the following lines filter from the terminology all terms that occur less than twice:

{% highlight java %}
TermSuitePipeline.create(myTerminology)
		.emptyCollection()
		.aeThresholdCleaner(TermProperty.FREQUENCY, 2)
		.run();
{% endhighlight %}


#### Full list of Analysis Engines and configurations

IDE auto-completion will assist you in finding available methods to build your own pipelines. Otherwise, to see what you can do with  `TermSuitePipeline`, see the [Javadoc](http://www.javadoc.io/doc/fr.univ-nantes.termsuite/termsuite-core/{{site.termsuite.version}}).

### Export/Import `json` terminologies

#### Export

Terminologies can be exported directly from the pipeline by invoking the `jsonExporter()` AE. Other exporters (`tbx` and `tsv`) are also available from the pipeline, but they cannot be reimported afterwards. Only `json` terminologies can be imported.

You can also export a terminology object (instance of class `TermIndex`) in one line as follows:

{% highlight java %}
JSONTermIndexIO.save(
		new FileWriter(""),
		myTermino,
		true, 	// store all occurrences
		false); // do not store term contexts (very expensive)

{% endhighlight %}

#### Import


It is also possible to load terminologies that have been previously computed, in one line:

{% highlight java %}
TermIndex myTerminology = JSONTermIndexIO.load(
				new FileReader("myterminology.json"),
				false);
{% endhighlight %}

### multilingual term alignment

{% highlight java %}
{% endhighlight %}
