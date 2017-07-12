{% highlight java %}
// Create the corpus object
TXTCorpus corpus = new TXTCorpus(
    Lang.EN,
    Paths.get("wind-energy", "documents"));

// Do the NLP preprocessings
IndexedCorpus corpus = TermSuite.preprocessor()
    .setTaggerPath(Paths.get("path", "to", "treetagger"))
    .toIndexedCorpus(corpus, 500000);

// Extract the terminology
TermSuite.terminoExtractor().execute(corpus);

// Keep only top 1000 terms by specificity with their variants
TermSuite.terminologyFilterer()
    .by(TermProperty.SPECIFICITY)
    .keepTopN(1000).keepVariants()
    .filter(corpus);

// Export the terminology to TSV
TermSuiteFactory.createTsvExporter(new TsvOptions())
    .export(corpus, Paths.get("my-termino.tsv"));
{% endhighlight %}
