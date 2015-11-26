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
3. Download the english utf-8-encoded (very important) model from the [official site](http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/) and rename it to `english.par`.

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

Download the example multilingual corpus [Wind Energy]({{site.corpus.we}}) to `TERMSUITE_WORKSPACE` and uncompress it.

### 6. Run terminology extraction

Now your `TERMSUITE_WORKSPACE` folder should look like this: (non exhaustive)

~~~
TERMSUITE_WORKSPACE/
  wind-energy/
    README.txt
    English/
      txt/
        file1.txt
        file3.txt
        [...]
        file38.txt
    French/
    [...]
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

Run the terminology extraction on the *Wind Energy* corpus and language `en`:

~~~
$ java -cp termsuite-core-{{site.termsuite.version}}.jar eu.project.ttc.tools.cli.TermSuiteTerminoCLI \
  -t ./tree-tagger/ \
  -c ./wind-energy/English/txt/ \
  -l en \
  -r ./termsuite-resources.jar \
  --tsv ./wind-energy-en.tsv
~~~

### 7. Understanding the TSV output

TermSuite created the file `wind-energy-en.tsv` showed below.
* 1st column is the term id, or the base term id in case of a variant,
* 2nd column: `T` indicates a term, `V` indicates a variant,
* 3rd column: the term pilot,
* 4th column: the term frequency,
* 5th column: the term specificity (weirdness ratio logarithm).

<div class="alert alert-warning" role="alert">
**Important warning!**

Once again, do not judge TermSuite on this example. You are using a truncated resource pack and this corpus is too small for variant detection.

For example, with the full resource pack, you would get :

 * the wrong variant *axis wind turbine* disappear from the extracted list (while given as variant with partial resource pack, see below).
 * the terms *horizontal axis wind turbine* and *vertical axis wind turbine* appear as variants of the term *wind turbine*,
 * all morphosyntactic variants of the term *wind turbine*, like *windpack turbine*     
</div>


~~~
baseId  type    p       pilot   wrlog   f
1       T       N N     wind turbine    5,16    1852
1       V       N N     wind tubine     1,90    1
1       V       N N N   axis wind turbine       3,87    95
1       V       A N N   offshore wind turbines  3,55    46
2       T       N       rotor   4,82    848
3       T       N N     wind energy     4,51    414
3       V       N P N   energy of the wind      1,90    1
3       V       A N N   offshore wind energy    3,56    47
3       V       A N N   european wind energy    3,25    23
4       T       N N     wind speed      4,41    331
4       V       N P N   speed of the wind       2,50    4
4       V       A N N   average wind speed      3,29    25
5       T       N N     wind power      4,34    278
5       V       N P N   power of the wind       2,97    12
5       V       A N N   high-performance wind power     3,34    28
6       T       A N     offshore wind   4,27    241
6       V       A A N   future offshore wind    2,89    10
7       T       N       airfoil 4,26    236
8       T       N       voltage 4,22    214
...
~~~

This output can be configured. `tbx` and `json` are also posssible. See command line [options]({{site.production_url}}/documentation/command-line-api).

### 8. Enjoy TermSuite

You can now run TermSuite on your own [corpus]({{site.production_url}}/documentation/corpus).

Full documentation of available features and options from the command line: [command line API]({{site.production_url}}/documentation/command-line-api).

Embed TermSuite directly to your Java project: [Java API](/documentation/command-line-api).

Terminology alignment: [here](/documentation/alignment).
