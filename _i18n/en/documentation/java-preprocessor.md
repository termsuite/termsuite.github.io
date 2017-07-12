Bilingual alignment features in TermSuite are provided by class `BilingualAlignmentService`. You can get an instance of that class from the `BilingualAligner` builder. See [TermSuite Javadoc](http://www.javadoc.io/doc/fr.univ-nantes.termsuite/termsuite-core/{{site.termsuite.version}}) for more information.  

* TOC
{:toc}

### Prerequesites

 1. Java 8
 1. [install an external POS tagger]({{site.baseurl}}/documentation/pos-tagger-lemmatizer/)

### Preprocessing

{% highlight java %}
TXTCorpus txtCorpus = new TXTCorpus(Lang.FR, Paths.get("path/to/corpus"));

IndexedCorpus indexedCorpus = TermSuite.preprocessor()
  .setTaggerPath("path/to/tagger")
  .toIndexedCorpus(txtCorpus, 500000);

Terminology terminology =  indexedCorpus.getTerminology();
{% endhighlight %}
