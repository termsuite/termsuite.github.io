---
layout: documentation
title: Getting Started
menu: Getting Started
permalink: /getting-started/
---

This page guides you the steps to get TermSuite running and extracting the terminology of a short example corpus.


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

These are the steps to install TreeTagger on your OS: (See the [install instructions](/documentation/pos-tagger-lemmatizer) for details)
1. Download TreeTagger from the [official site](http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/) to `TERMSUITE_WORKSPACE` and uncompress it.
2. Creates a subdirectory named `models` within the TreeTagger directory.
3. Download the english `utf-8`-encoded (very important) model from the [official site](www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/) and rename it to `english.par`.


### 3. Download TermSuite

Download the last stable version of TermSuite's jar for project `termsuite-core` from [Maven Central]({{site.termsuite.maven}}) to directory `TERMSUITE_WORKSPACE`.

Currently : [termsuite-core-{{site.termsuite.version}}.jar]({{site.termsuite.maven}}{{site.termsuite.version}}/termsuite-core-{{site.termsuite.version}}.jar)

### 4. Download (or create) a TermSuite language pack

Download a TermSuite resource pack to directory `TERMSUITE_WORKSPACE` and uncompress it.

For example, download the one publicly available on Github : [termsuite-resources.zip]({{site.resources.zip}})

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
  termsuite-resources-master/
    en/
    fr/
    [...]
~~~

Run the terminology extraction on the *Meteoroids* corpus and language `en`:

~~~
$ java -cp termsuite-core-{{site.termsuite.version}}.jar eu.project.ttc.tools.cli.TermSuiteTerminoCLI
  -t /tree-tagger
  -c /Meteoroids/English/txt
  -l en
  -r /termsuite-resources-master
  --tsv meteoroids-en.tsv
~~~

### 7. Enjoy TermSuite

Full documentation of available features and options from the command line: [command line API]({{site.production_url}}/documentation/command-line-api).

Embed TermSuite directly to your Java project: [Java API](/documentation/command-line-api).

Terminology alignment: [here](/documentation/alignment).
