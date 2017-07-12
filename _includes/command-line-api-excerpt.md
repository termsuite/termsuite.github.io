{% highlight bash %}
$ java -cp termsuite-core-{{site.termsuite.version}}.jar \
        fr.univnantes.termsuite.tools.TerminologyExtractorCLI \
            -t /path/to/treetagger/ \
            -c /path/to/corpus/ \
            -l en \
            --tsv my-termino.tsv \
{% endhighlight %}
