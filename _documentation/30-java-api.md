---
layout: documentation
title: Use TermSuite's Java API
menu: Java API
permalink: /documentation/java-api/
---


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
