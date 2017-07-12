Bilingual alignment features in TermSuite are provided by class `BilingualAlignmentService`. You can get an instance of that class from the `BilingualAligner` builder. See [TermSuite Javadoc](http://www.javadoc.io/doc/fr.univ-nantes.termsuite/termsuite-core/{{site.termsuite.version}}) for more information.  

* TOC
{:toc}

### Prerequesites

 1. Java 8
 1. two terminologies extracted with term contexts
 1. a bilingual dictionary


### Creating the aligner service


{% highlight java %}
Terminology frTermino = IndexedCorpusIO.fromJson("fr-termino.json").getTerminology();
Terminology enTermino = IndexedCorpusIO.fromJson("en-termino.json").getTerminology();

BilingualAlignmentService aligner = TermSuite.bilingualAligner()
    .setSourceTerminology(frTermino)
    .setTargetTerminology(enTermino)
    .setDicoPath("path/to/dico/FR-EN.txt")
    .setDistanceCosine()
    .create();
{% endhighlight %}


### Running alignment

#### Single-word term alignment

{% highlight java %}
Term term = frTermino.getTerms().get("n: énergie");

// Aligning source term "n: énergie" and produce
// 3 translations candidates. Sets 2 as the min frequency
// for translation candidate
List<TranslationCandidate> results = aligner.align(term, 3, 2);

for(TranslationCandidate c:results) {
  System.out.format("%d. %.3f %-20s %s %n",
      c.getRank(),
      c.getScore(),
      c.getTerm().getGroupingKey(),
      c.getMethod()
      );
}
{% endhighlight %}

Outputs:

```
1. 0,554 n: power             DICTIONARY
2. 0,315 n: energy            DICTIONARY
3. 0,131 n: motor             DISTRIBUTIONAL
```

#### Multi-word term alignment

{% highlight java %}
Term term = frTermino.getTerms().get("npna: production de énergie électrique");

// Aligning source term "n: énergie" and produce
// 3 translations candidates. Sets 2 as the min frequency
// for translation candidate
List<TranslationCandidate> results = aligner.align(term, 3, 2);

for(TranslationCandidate c:results) {
  System.out.format("%d. %.3f %-20s %s %n",
      c.getRank(),
      c.getScore(),
      c.getTerm().getGroupingKey(),
      c.getMethod()
      );
}
{% endhighlight %}

Outputs: (only one candidate found)

```
1. 1,000 ann: electrical energy production COMPOSITIONAL
```


#### Neoclassical term alignment

{% highlight java %}
Term term = frTermino.getTerms().get("a: aérodynamique");

// Aligning source term "n: énergie" and produce
// 3 translations candidates. Sets 2 as the min frequency
// for translation candidate
List<TranslationCandidate> results = aligner.align(term, 3, 2);

for(TranslationCandidate c:results) {
  System.out.format("%d. %.3f %-20s %s %n",
      c.getRank(),
      c.getScore(),
      c.getTerm().getGroupingKey(),
      c.getMethod()
      );
}
{% endhighlight %}

Outputs:

```
1. 0,353 a: aerodynamic       NEOCLASSICAL
2. 0,324 n: aerodynamics      NEOCLASSICAL
3. 0,324 r: aerodynamically   NEOCLASSICAL
```


### Configuring the alignment

Yan can configure with similarity measure to use for context vector alignment with builder's `#setDistanceCosine()` (default) and `#setDistanceJaccard()` methods.

### Alignment methods and algorithms

For more theoritical information about bilingual alignment in TermSuite, refer to the [alignment pipeline](/documentation/termsuite-pipelines/#bilingual-alignment-step-3).
