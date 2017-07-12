
* TOC
{:toc}

### Navigating the *IndexedCorpus*

#### What exactly is an *IndexedCorpus* ?

One interesting feature of TermSuite is its ability to index all terms it extracts from textual corpus. All occurrences of extracted terms are part of the data model.

The number of term occcurrences grows as the input textual corpus gets larger. Because the input corpus can be very big, term occurrences must be managed apart from the *Terminology*, in an object called the *OccurrenceStore*.  

The *IndexedCorpus* is nothing but a container for the *Terminology* and its *OccurrenceStore*:

{% highlight java %}
/*
 * Get the indexed corpus (either from a terminology
 * extraction pipeline or from ".json" deserialization)
 */  
IndexedCorpus indexedCorpus = ...;

// Get the terms and their variations
Terminology terminology = indexedCorpus.getTerminology();

// Get the occurrences
OccurrenceStore occStore = indexedCorpus.getOccurrenceStore();
{% endhighlight %}

#### Nativating the terminology with `TerminologyService`

If you try to navigate the terms of a terminology directly from the `Terminology` provided by *IndexedCorpus*, you might think it has very poor capabilities. Indeed, since version 3, *TermSuite*'s' inner representation for terminologies is a graph, *ie.* a collection of *Term*s (the nodes) and a collection of *Relation*s (the vertices), each term and relation having of set of properties. It is very harsh to navigate the information from this raw data model:

{% highlight java %}
Terminology termino = indexedCorpus.getTerminology();

// Get an sort the terms
List<Term> sortedTerms = new ArrayList<>();
sortedTerms.addAll(termino.getTerms().values());
Collections.sort(sortedTerms, TermProperty.SPECIFICITY.getComparator(true));

// navigate through the terms
for(Term term:sortedTerms) {
  System.out.format("%d. %-10s %s%n",
      term.get(TermProperty.RANK),
      term.get(TermProperty.PATTERN),
      term.get(TermProperty.PILOT));

  // navigation through the variations
  for(Relation variation:terminology.getRelations()) {
    if(variation.getType() != RelationType.VARIATION)
      continue;
    if(variation.getFrom().equals(term)) {
      System.out.format("\t%-25s%-10s %.2f %s%n",
          variation.getTo().get(TermProperty.GROUPING_KEY),
          variation.getType(),
          variation.get(RelationProperty.VARIANT_SCORE),
          variation.get(RelationProperty.VARIATION_RULES)
          );

    }
  }
}
{% endhighlight %}

It is easier and more elegant to navigate the terms and their variants with the help of a *TerminologyService*:

{% highlight java %}
Terminology termino = indexedCorpus.getTerminology();

// Get the service
TerminologyService terminologyService = TermSuite.getTerminologyService(termino);

// Navigate through the terms
terminologyService.terms(TermOrdering.natural()).forEach(t -> {
    System.out.format("%d. %-10s %s%n", t.getRank(), t.getPattern(), t.getPilot());

    // Navigate through the variations
    t.variations().forEach(v -> System.out.format("\t%-25s%-10s %.2f %s%n",
            v.getTo().getGroupingKey(),
            v.getType(),
            v.getVariantScore(),
            v.getVariationRules()
            )
      );
  });
{% endhighlight %}


#### Navigating the occurrences

The *OccurrenceStore* object provides all access methods needed to retrieve the occurrences of a term and the documents of the corpus they belong to:

{% highlight java %}
Term term = terminology.getTerms().get("nn: wind energy");

// Get all documents in which the term "nn: wind energy" occurs
store.getDocuments(term);

// Get all documents in which the term "nn: wind energy" occurs
for(TermOccurrence o:store.getOccurrences(term))
  System.out.format("Term %s has one occurrence in document %s at [%d,%d]%n",
      term.getGroupingKey(),
      o.getSourceDocument().getUrl(),
      o.getBegin(),
      o.getEnd());
{% endhighlight %}

`OccurrenceStore` also provides service method for managing all *forms* of a term:

{% highlight java %}
// Get all forms of term "nn: wind energy"
for(Form form:store.getForms(term))
  System.out.println(form.getText() + ": " + form.getCount());
{% endhighlight %}


### Understanding the *OccurrenceStore*

#### Types of occurrence stores

Depending on the size of the input corpus, the number of term occurrences to manage can be too big to be kept in memory. That is why there are three different implementation of an occurrence store:

 1. `MemoryOccurrenceStore`, which keeps all occurrences in memory,
 1. `XodusOccurrenceStore`, which stores the occurrences on the file system,
 1. `EmptyOccurrenceStore`, which does not store the occurrences.

The type of *OccurrenceStore* to use is set by the user at object creation from `TermSuiteFactory`:

{% highlight java %}
// creates an empty occurrence store
TermSuiteFactory.createEmptyOccurrenceStore(Lang.EN);

// creates a memory occurrence store
TermSuiteFactory.createMemoryOccurrenceStore(Lang.EN);

// creates a xodus occurrence store
TermSuiteFactory.createPersitentOccurrenceStore("my-occurrences.store", Lang.EN);
{% endhighlight %}

#### Running pipelines on custom occurrence store

By default, [running the preprocessor]({{site.baseurl}}/documentation/java-preprocessor/) would create an *IndexedCorpus* with a *memory* occurrence store:

{% highlight java %}
IndexedCorpus indexedCorpus = TermSuite.preprocessor()
  .setTaggerPath("path/to/tagger")
  .toIndexedCorpus(txtCorpus, 500000);
{% endhighlight %}

You can customize this behaviour and run the pipeline on a custom occurrence store as follows:

{% highlight java %}
// creates an IndexedCorpus with persistent occurrence store
IndexedCorpus corpus = TermSuiteFactory.createIndexedCorpus(
    TermSuiteFactory.createTerminology(Lang.EN, "My Termino"),
    TermSuiteFactory.createPersitentOccurrenceStore("my-occurrences.store", Lang.EN));

// the corpus indexed corpus can be passed to the Preprocessor
IndexedCorpus indexedCorpus = TermSuite.preprocessor()
    .setTaggerPath("path/to/tagger")
    .toIndexedCorpus(txtCorpus, 500000, corpus);
{% endhighlight %}
