---
layout: documentation
title: Run terminology extraction using Java API
menu: Java API
permalink: /documentation/java-api/
---

* TOC
{:toc}

### TermSuitePipeline launcher for terminology extraction

#### Example

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

#### Javadoc

To see what you can do with  `TermSuitePipeline`, check the [Javadoc](http://www.javadoc.io/doc/fr.univ-nantes.termsuite/termsuite-core/{{site.termsuite.version}}).
