* TOC
{:toc}

This page lists and explains the most important term properties in TermSuite, and how they are used in the terminology extraction process.

### Frequency
{: id="frequency"}

The *term frequency* is the number of occurrences of a term within the domain-specific corpus. This is measure is both very simple and very useful for terminology extraction and post-processing.

To access get the term frequency with the Java API:
{% highlight java %}
term.getFrequency();
{% endhighlight %}

### Normalized frequency
{: id="fnorm"}

The *normalized frequency* is the average number of occurrences of a term with the **domain-specific corpus every 1000 words**. Its value is a decimal number.

To access get the term frequency with the Java API:
{% highlight java %}
term.getFrequencyNorm();
{% endhighlight %}

### Normalized general frequency
{: id="generalFnorm"}

The *normalized general frequency* is the avetsv-rage number of occurrences of a term with the **general language corpus every 1000 words**. Its value is a decimal number.

To access get the term frequency with the Java API:
{% highlight java %}
term.getGeneralFrequencyNorm();
{% endhighlight %}

The general language corpus usually is a corpus extracted from news paper archives. If a term is absent from the general language corpus, then it is considered as appearing 0,5 times. That is why the method `getGeneralFrequencyNorm()` still returns a non-zero value.

### Weirdness Ratio (`wr` and `wrLog`)
{: id="wr"}

#### Definition

The *weirdness ratio* (WR) is propably the property used by TermSuite to measure the **specificity of a term in the domain-specific corpus**. It is computed by dividing the *normalized frequency* of a term by its *normalized general frequency*:

{% highlight java %}
double wr = term.getFrequencyNorm() / term.getGeneralFrequencyNorm();
{% endhighlight %}


#### `wr` and `wrLog`

Our experience with the `wr` is that the most significant link to the specificity is the magnitude, i.e. the number of zeros it has. That is why we introduced the `wrLog`:

{% highlight java %}
double wrLog = Math.log(1 + term.getFrequencyNorm() / term.getGeneralFrequencyNorm());
{% endhighlight %}

#### Java API

To access get the term frequency with the Java API, you need to get from the terminology (the `TermIndex` object) what is called a *measure* in Java data model. That is why getting the WR of a term is a bit less instinctive than for *primitive* term properties (frequency, normalized frequency, normalized general frequency, and document frequency).

{% highlight java %}
// Get the WR of "term"
termIndex.getWRMeasure().getValue(term);

// Get the wrLog (log(1+WR)) of "term"
termIndex.getWRLogMeasure().getValue(term);
{% endhighlight %}

What is convenient with TermSuite's measures is that you can get their aggregate values over the domain-specific easily:

{% highlight java %}
// The average of WR over the terminology
termIndex.getWRMeasure().getAvg();

// The average of wrLog over the terminology
termIndex.getWRLogMeasure().getAvg();
{% endhighlight %}

#### Distribution of Weirdness Ratio (actually of `wrLog`)

The distribution of Weirdness Ratio on Fig. 1 was computed on our example corpus Wind Energy. It shows that `wrLog` values vary between 0 and around 5. We have made the same observation on all corpora we have tested, including for a corpus containing 58 million words, and on several languages supported by TermSuite.

<p class="text-center">
<img title="Distribution of wrLog over corpus Wind Energy" alt="Distribution of wrLog over corpus Wind Energy" width="500" src="/img/wrlog-distribution-th1.png">
<br />
Fig1. Distribution of wrLog over the corpus "Wind Energy"
</p>

Fig. 1 shows this distrubtion, and gives one color for each threshold value for the property *frequency*. The yellow area is the distribution of terms occurring at least once (i.e. all terms), the blue area is the distribution of terms occurring at least twice, etc.

Another noteworthy observation is the fact that there is a group of terms on the left of the first peak, near zero. These are the terms that appear relatively often in the general language corpus.

The yellow peak on Fig. 1 shows one of the main bias of the Weirdness Ratio. In facts, there are a big number of terms sharing exactly the same value of `wr`. Terms occurring exactly once in the domain-specific corpus and zero time in the general language corpus appear on the graph. There are also numerous terms occurring exactly twice in the domain-specific corpus and zero time in the general language corpus. They all share the same value (the blue peak denoted as th=2).


<p class="text-center">
<img title="Distribution of wrLog over the corpus Wind Energy, after filtering terms by frequency (frequency ≥ 3)" alt="Distribution of wrLog over the corpus Wind Energy, after filtering terms by frequency (frequency ≥ 3)" width="500" src="/img/wrlog-distribution-th3.png">
<br />
Fig2. Distribution of wrLog over the corpus "Wind Energy", after filtering terms by frequency (frequency ≥ 3)
</p>

Fig. 2 is exactly the same distribution as Fig. 1, except that we have filtered the terminology and kept terms occurring at least three times in the corpus. This filter allows to "zoom" on other peaks. We see that there is a peak for every frequency until 5 or 6, and then the `wrLog` values mix to each other.

#### A good threshold for `wrLog` filtering

When filtering on `wrLog`, the question to answer is "what peak should I filter". Usually, for terminology extraction, it is a good practice to set the threshold after the first peaks. For bigger corpus, it is better to set the threshold after the second, third, fourth or fifth (for huge corpus) peak.

<div class="alert alert-success" role="alert">
Considering this behavior, a good language-independent and corpus-independent **default threshold for `wrLog` is 2**.   
</div>

### Document Frequency
{: id="dfreq"}

The *document frequency* of a term is the number of documents (i.e. files in the input corpus) in which the term occurs. In terminology, it is often a good practice to filter the extracted term on this property, to ensure that extracted terms do not appear in only one document.  

To access get the term frequency with the Java API:
{% highlight java %}
term.getDocumentFrequency();
{% endhighlight %}

### Other properties

The exhaustive list of properties is:

{% for p in site.data.filtering-properties %}
  * **{{p.name}}:** {%t p.description %}
{% endfor %}
