* TOC
{:toc}


### Exporting terminologies

#### JSON

**Option 1**

{% highlight java %}
TermSuiteFactory
    .createJsonExporter()
    .export(indexedCorpus, Paths.get("path/to/termino.json"));
{% endhighlight %}

With custom JSON options:

{% highlight java %}
TermSuiteFactory
    .createJsonExporter(new JsonOptions().withOccurrences(false))
    .export(indexedCorpus, Paths.get("path/to/termino.json"));
{% endhighlight %}


**Option 2**

{% highlight java %}
IndexedCorpusIO.toJson(
  indexedCorpus,
  new FileWriter("path/to/termino.json"), new JsonOptions());
{% endhighlight %}


#### TSV

{% highlight java %}
TermSuiteFactory
    .createTsvExporter()
    .export(indexedCorpus, Paths.get("path/to/termino.tsv"));
{% endhighlight %}

With custom TSV options:

{% highlight java %}
TermSuiteFactory
    .createTsvExporter(
      new TsvOptions()
        .properties(
          TermProperty.PILOT,
          TermProperty.FREQ,
          TermProperty.INDEPENDANCE,
          TermProperty.DOCUMENT_FREQUENCY
    ))
    .export(indexedCorpus, Paths.get("path/to/termino.tsv"));
{% endhighlight %}



#### TBX

See [TBX Specifications](http://www.ttt.org/oscarstandards/tbx/) for more information.

{% highlight java %}
TermSuiteFactory
    .createTbxExporter()
    .export(indexedCorpus, Paths.get("path/to/termino.tbx"));
{% endhighlight %}

### Importing terminologies

#### JSON

{% highlight java %}
IndexedCorpus indexedCorpus = IndexedCorpusIO.fromJson(Paths.get("path/to/termino.json"));
Terminology terminology = indexedCorpus.getTerminology();
{% endhighlight %}
