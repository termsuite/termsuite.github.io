This page guides you the steps to get TermSuite running and extracting the terminology from a short example corpus.

* TOC
{:toc}

### 1. Requirements


For the sake of simplicity, create a directory where you will download all files required by TermSuite. In the following sections, we refer to this directory as `TERMSUITE_WORKSPACE`.

#### Java

Make sure you have Java installed on your OS (at least version 8), or follow the [official installation instructions](https://www.java.com/fr/download/).

To check if Java is installed properly and see its current version, open a command line prompt and type:

~~~
$ java -version
~~~

### 2. Installation of TreeTagger

TermSuite requires a POS Tagger and lemmatizer to run terminology extraction pipelines. In this guide, we install TreeTagger, but TermSuite also supports Mate. TreeTagger must be installed apart from TermSuite, due to license concerns.

To install TreeTagger on your OS: (See the [install instructions](/documentation/pos-tagger-lemmatizer) for details)
1. Download TreeTagger from the [official site](http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/) to `TERMSUITE_WORKSPACE` and uncompress it.
2. Creates a subdirectory named `models` within the TreeTagger directory.
3. Download to dir `models/` the english utf-8-encoded (very important) model from the [official site](http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/) and rename it to `english.par`.

<div class="alert alert-warning" role="alert">
Encoding and naming of TreeTagger models is important for TermSuite to run correctly. See [detailed instructions](/documentation/pos-tagger-lemmatizer) for all languages.  
</div>

### 3. Download TermSuite

Download the last stable version of TermSuite's jar for project `termsuite-core` from [Maven Central]({{site.termsuite.maven}}) to directory `TERMSUITE_WORKSPACE`.

Currently : [termsuite-core-{{site.termsuite.version}}.jar]({{site.termsuite.maven}}{{site.termsuite.version}}/termsuite-core-{{site.termsuite.version}}.jar)

### 4. Prepare your corpus

Download the example multilingual corpus [Wind Energy]({{site.corpus.we}}) to `TERMSUITE_WORKSPACE` and uncompress it.

### 5. Run terminology extraction

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
~~~

Run the terminology extraction on the *Wind Energy* corpus and language `en`:

~~~
$ java -cp termsuite-core-{{site.termsuite.version}}.jar eu.project.ttc.tools.cli.TermSuiteTerminoCLI \
  -t ./tree-tagger/ \
  -c ./wind-energy/English/txt/ \
  -l en \
  --tsv ./wind-energy-en.tsv
~~~

### 6. Understanding the TSV output

TermSuite created the file `wind-energy-en.tsv` showed below.
* 1st column is the term id, or the base term id in case of a variant,
* 2nd column: `T` indicates a term, `V` indicates a variant,
* 3rd column: the term pilot,
* 4th column: the term frequency,
* 5th column: the term specificity (weirdness ratio logarithm).

~~~
baseId	type	p	pilot	wrlog	f
1	T	N N	wind turbine	5,16	1852
1	V	N N N	horizontal-axis wind turbines	3,52	42
1	V	A N N N	horizontal axis wind turbine	3,50	41
1	V	A N N N	vertical axis wind turbines	3,62	53
1	V	A N N N	modern horizontal-axis wind turbines	2,59	5
1	V	A N N	smaller-scale wind turbines	2,20	2
1	V	A N N	on-shore wind turbines	1,90	1
1	V	A N N	pre-manufactured wind turbine	1,90	1
1	V	A N N	repowred wind turbines	1,90	1
1	V	A N N N	conventional horizontal-axis wind turbines	1,90	1
1	V	A N N N	potential campus wind turbines	1,90	1
1	V	A N N N	typical horizontal-axis wind turbine	1,90	1
1	V	A N N N	unconventional horizontal-axis wind turbines	1,90	1
1	V	N N N N	hawts horizontal-axis wind turbines	1,90	1
1	V	N N N N	utility scale wind turbine	1,90	1
1	V	N N N N	lift type wind turbines	1,90	1
1	V	A N N	domestic wind turbines	3,35	29
1	V	N N N	wind turbine syndrome	3,21	21
[...]
2	T	N	rotor	4,82	848
3	T	N N	wind energy	4,51	414
3	V	A N N	californian wind energy	1,90	1
3	V	A N N	offshore wind energy	3,56	47
3	V	N N N	wind energy conversion	3,32	27
3	V	N N N	wind energy conf	2,59	5
3	V	A N N N	significant contribution wind energy	1,90	1
3	V	N N N N	activity plan wind energy	1,90	1
3	V	N N N N	title ge wind energy	1,90	1
3	V	N N N	wind energy easements	1,90	1
4	T	N N	wind speed	4,41	331
4	V	N P N	speed of the wind	2,50	4
4	V	N C N P N	speed and direction of the wind	1,90	1
4	V	N N N	integer wind speed	1,90	1
4	V	A N N	average wind speed	3,29	25
4	V	A N N	undisturbed wind speed	2,59	5
4	V	N N N	cutoff wind speed	2,37	3
4	V	N N N N	terrain score wind speed	1,90	1
4	V	N N N	wind speed cutoff	2,20	2
4	V	N N N	cut-out wind speed	2,50	4
4	V	N N N	cut-off wind speeds	1,90	1
4	V	N N N	incision wind speed	1,90	1
5	T	N N	wind power	4,34	278
5	V	N P N	power of the wind	2,97	12
5	V	N N N	wind turbine power	2,89	10
5	V	N N N	wind power plant	3,76	74
5	V	A N N	developable wind power	1,90	1
5	V	A N N N	environmental engineering wind power	1,90	1
5	V	N N N	wind power stations	3,27	24
6	T	N	airfoil	4,26	236
...
~~~

This output can be configured. `tbx` and `json` are also posssible. See command line [options]({{site.production_url}}/documentation/command-line-api).

### 8. Enjoy TermSuite

You can now run TermSuite on your own [corpus]({{site.production_url}}/documentation/corpus).

Full documentation of available features and options from the command line: [command line API]({{site.production_url}}/documentation/command-line-api).

Embed TermSuite directly to your Java project: [Java API](/documentation/command-line-api).
