---
layout: documentation
title: "Tutorial: Getting Started"
menu: "Getting Started [Tutorial]"
permalink: /getting-started/
---

This page guides you the steps to get TermSuite running and extracting the terminology from a short example corpus.

* TOC
{:toc}

### 1. Requirements


For the sake of simplicity, create a directory where you will download all files required by TermSuite. In the following sections, we refer to this directory as `TERMSUITE_WORKSPACE`.

#### Java

Make sure you have Java installed on your OS (at least 1.7), or follow the [official installation instructions](https://www.java.com/fr/download/).

To check if Java is installed properly and see its current version, open a command line prompt and type:

~~~
$ java -version
~~~

### 2. Installation of TreeTagger

TermSuite requires a POS Tagger and lemmatizer to run terminology extraction pipelines. In this guide, we install TreeTagger, but TermSuite also supports Mate. TreeTagger must be installed apart from TermSuite, due to license concerns.

To install TreeTagger on your OS: (See the [install instructions](/documentation/pos-tagger-lemmatizer) for details)
1. Download TreeTagger from the [official site](http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/) to `TERMSUITE_WORKSPACE` and uncompress it.
2. Creates a subdirectory named `models` within the TreeTagger directory.
3. Download the english utf-8-encoded (very important) model from the [official site](www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/) and rename it to `english.par`.

<div class="alert alert-warning" role="alert">
Encoding and naming of TreeTagger models is important for TermSuite to run correctly. See [detailed instructions](/documentation/pos-tagger-lemmatizer) for all languages.  
</div>

### 3. Download TermSuite

Download the last stable version of TermSuite's jar for project `termsuite-core` from [Maven Central]({{site.termsuite.maven}}) to directory `TERMSUITE_WORKSPACE`.

Currently : [termsuite-core-{{site.termsuite.version}}.jar]({{site.termsuite.maven}}{{site.termsuite.version}}/termsuite-core-{{site.termsuite.version}}.jar)

### 4. Download (or create) a TermSuite language pack

Download a TermSuite resource pack to directory `TERMSUITE_WORKSPACE` and uncompress it.

For example, download the one publicly available on Github : [termsuite-resources.jar]({{site.resources.jar}})

{% include resource_warning.md %}

### 5. Prepare your corpus

Download the example [Meteoroids corpus]({{site.corpus.meteoroids}}) to `TERMSUITE_WORKSPACE` and uncompress it.

### 6. Run terminology extraction

Now your `TERMSUITE_WORKSPACE` folder should look like this: (non exhaustive)

~~~
TERMSUITE_WORKSPACE/
  Meteoroids/
    README.txt
    English/
      txt/
        file1.txt
        file2.txt
        file3.txt
  tree-tagger/
    bin/
      [...]
    lib/
      [...]
    models/
      english.par # Should be the `utf-8` model !
    [...]
  termsuite-core-{{site.termsuite.version}}.jar
  termsuite-resources.jar
~~~

Run the terminology extraction on the *Meteoroids* corpus and language `en`:

~~~
$ java -cp termsuite-core-{{site.termsuite.version}}.jar eu.project.ttc.tools.cli.TermSuiteTerminoCLI \
  -t ./tree-tagger/ \
  -c ./Meteoroids/English/txt/ \
  -l en \
  -r ./termsuite-resources.jar \
  --tsv ./meteoroids-en.tsv
~~~

### 7. Understanding the TSV output

TermSuite created the file `meteoroids-en.tsv` showed below.
* 1st column is the term id, or the base term id in case of a variant,
* 2nd column: `T` indicates a term, `V[...]` indicates a variant (and its variant scores within `[]`),
* 3rd column: the term pilot,
* 4th column: the term frequency,
* 5th column: the term specificity (weirdness ratio logarithm).

<div class="alert alert-warning" role="alert">
Once again, do not judge TermSuite on this example. You are using a truncated resource pack and this corpus is too small for variant detection.  
</div>


~~~
1       T       meteorites      72      19,48
2       T       meteor  38      18,84
3       T       meteoric        20      18,20
4       T       iowa county     18      18,09
4       V[S: 0,E:66(G:50/WR:100),F:100,V:75]    d609 iowa county        1       15,20
4       V[S: 0,E:41(G: 8/WR:81),F:100,V:56]     township iowa county    1       15,20
5       T       meteoric stones 7       17,15
5       V[S: 0,E:100(G:100/WR:100),F:100,V:100] porous meteoric stone   1       15,20
6       T       cosmical        6       16,99
7       T       terrestrial     6       16,99
8       T       county meteorites       6       16,99
...
~~~

This output can be configured. `tbx` and `json` are also posssible. See command line [options]({{site.production_url}}/documentation/command-line-api).

### 8. Enjoy TermSuite

You can now run TermSuite on your own [corpus]({{site.production_url}}/documentation/corpus).

Full documentation of available features and options from the command line: [command line API]({{site.production_url}}/documentation/command-line-api).

Embed TermSuite directly to your Java project: [Java API](/documentation/command-line-api).

Terminology alignment: [here](/documentation/alignment).
