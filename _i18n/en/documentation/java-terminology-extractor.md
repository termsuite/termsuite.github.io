* TOC
{:toc}

### Extracting terminology

Say `corpus` is the *IndexedCorpus* object produced by the [NLP preprocessings]({{site.baseurl}}/documentation/java-preprocessor/) (see [pipelines]({{site.baseurl}}/documentation/termsuite-pipelines/) for explanations), the terminology extraction pipeline can launched with Java API with:

{% highlight java %}
TermSuite.terminoExtractor().execute(corpus);
{% endhighlight %}

The  `TermSuite.terminoExtractor()` creates a new *TerminoExtractor* object, which is a builder for the configuration of the terminology extraction pipeline. the method `execute()` runs this pipeline on the parameter corpus. After the pipeline has executed, the parameter `corpus` contains many term variations and other morphological informations and cleanings.


### Configuring terminology extraction

The terminology extraction process can be finely tuned by passing an *ExtractorOptions* options object to *TerminoExtractor*.

You can create a language-independant *ExtractorOptions* object from scratch, but it is not advised:

{% highlight java %}
// !!! Not advised !!!
ExtractorOptions extractorOptions = new ExtractorOptions();
{% endhighlight %}

But, it is better to creates a new *ExtractorOptions* object by cloning the language defaults: 

{% highlight java %}
// Clones the default configuration object for given language
ExtractorOptions extractorOptions = TermSuite.getDefaultExtractorConfig(lang);
{% endhighlight %}


Full example:

{% highlight java %}
// Clones the default configuration object for given language
ExtractorOptions extractorOptions = TermSuite.getDefaultExtractorConfig(lang);

// deactivates post-processing
extractorOptions.getPostProcessorConfig().setEnabled(false);

// activates semantic variant detection
extractorOptions.getGathererConfig().setSemanticEnabled(true);

// runs the pipeline
TermSuite.terminoExtractor()
  .setOptions(extractorOptions)
  .execute(corpus);

{% endhighlight %}

### Debugging terminology extraction

If you need to investigate why a term has came out of the terminology extraction process or why another term has not came out of the terminology extraction process, you can set a history to *TerminoExtractor*. The following example watch the term "wind energy"

{% highlight java %}
TermHistory history = new TermHistory();

// runs the pipeline
TermSuite.terminoExtractor()
      .setHistory(history)
      .watch("wind energy") // watch the term history
      .execute(corpus);

// Prints all events impacting term "wind energy"
System.out.println(history.toString("wind energy"));
{% endhighlight %}


### Getting statistics of pipeline executions

The `execute()` method always returns some stats about pipeline execution as an instance of type *PipelineStats*:

{% highlight java %}
// runs the pipeline
PipelineStats stats = TermSuite.terminoExtractor()
      .execute(corpus);
{% endhighlight %}
