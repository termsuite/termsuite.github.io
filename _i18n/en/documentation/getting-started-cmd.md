
* TOC
{:toc}

### Option 1: manual installation
{:id="manual-installation"}

Create a directory where you will download all files required by TermSuite. In the following sections, we refer to this directory as `TERMSUITE_WORKSPACE`.

#### Java

Make sure you have Java installed on your OS (at least version 8), or follow the [official installation instructions](https://www.java.com/fr/download/).

To check if Java is installed properly and see its current version, open a command line prompt and type:

~~~
$ java -version
~~~

#### Install TreeTagger

TermSuite requires a POS Tagger and lemmatizer to run terminology extraction pipelines. In this guide, we install TreeTagger, but TermSuite also supports Mate. The tagger/lemmatizer must be installed apart from TermSuite, due to license concerns.

To install TreeTagger on your OS: (See the [install instructions](/documentation/pos-tagger-lemmatizer) for details)
1. Download TreeTagger from the [official site](http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/) and install it to `TERMSUITE_WORKSPACE/treetagger` with the help of official instructions.
2. Creates a subdirectory named `models` at `TERMSUITE_WORKSPACE/treetagger`.
3. Download to dir `models/` the english utf-8-encoded (very important) model from the [official site](http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/) and rename it to `english.par`.

<div class="alert alert-warning" role="alert">
Encoding and naming of TreeTagger models is important for TermSuite to run correctly. See [detailed instructions](/documentation/pos-tagger-lemmatizer) for all languages.  
</div>

#### Download TermSuite

Download the last stable version of TermSuite's jar for project `termsuite-core` from [Maven Central]({{site.termsuite.maven}}) to directory `TERMSUITE_WORKSPACE`.

Currently : [termsuite-core-{{site.termsuite.version}}.jar]({{site.termsuite.maven}}{{site.termsuite.version}}/termsuite-core-{{site.termsuite.version}}.jar)

#### Prepare your corpus
{:id="prepare-corpus"}

Download the example corpus [Wind Energy]({{site.corpus.we}}) to `TERMSUITE_WORKSPACE` and uncompress it.

Otherwise, you could prepare your own corpus in the form of a collection of `*.txt` files within a any directory.

#### Run terminology extraction

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
  treetagger/
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
$ java -cp termsuite-core-{{site.termsuite.version}}.jar fr.univnantes.termsuite.tools.TerminologyExtractorCLI \
  -t ./treetagger/ \
  -c ./wind-energy/English/txt/ \
  -l en \
  --tsv ./wind-energy-en.tsv
~~~

#### Understanding the TSV output
{:id="understanding-tsv"}

The `wind-energy-en.tsv` file produced by this command line, should look like the excerpt below. To understand the TSV format, please refer the [TSV output documentation](/documentation/terminology-tsv-output/)

Two other output formats are also available: `tbx` and `json`. See command line [options]({{site.production_url}}/documentation/command-line-api).

~~~
#	type	p	pilot	spec	f
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

#### Enjoy TermSuite

You can now run TermSuite on your own corpus.

See the full documentation of available features and options of terminology extraction from the command line at [command line API]({{site.production_url}}/documentation/terminology-extractor-cli), and its [examples]({{site.production_url}}/documentation/terminology-extractor-cli#examples).

You could also have chosen to run [PreprocessorCLI](/documentation/preprocessor-cli) instead of *TerminologyExtractorCLI* and apply only TermSuite's NLP preprocessings to your corpus without extracting the terminology. See also the  [preprocessing examples](/documentation/preprocessor-cli#examples).

You can also embed TermSuite directly into your Java project with [TermSuite's Java API](/documentation/java-terminology-extractor/).


### Option 2: docker container
{:id="docker"}

TermSuite's third-party dependency on *TreeTagger* or *Mate* might be discouraging, because it is one difficult step in installation process described above and also an external path to tagger's installation directory to specify explicitely at every single run.

To overcome this issue, we have made TermSuite work with *Docker* container technology.

Unfortunately, we cannot publish any TermSuite pre-built container image, for the same licensing reasons. Hoever, the docker image can be easily built once for all by the user with *Git* and *Docker*

Follow the guide below to launch TermSuite tools without installing nor configuring any POS tagger.

See [TermSuite's Docker project](https://github.com/termsuite/termsuite-docker.git) for more detailed instructions.

#### Prerequisites

 * Docker
 * Git

#### Clone TermSuite's docker project

```
$ git clone https://github.com/termsuite/termsuite-docker.git
```

#### Build the image

```
$ cd termsuite-docker
$ bin/build
```

#### Prepare your corpus

Same step as with manual installation. See [above](#prepare-corpus).

#### Run terminology extraction from the image

You can known run TermSuite tools (preprocessings, terminology extraction, and alignment) with `bin/termsuite` script. See [TermSuite's Docker project](https://github.com/termsuite/termsuite-docker.git) for more informtaion.

To extract the terminology from the

```
$ bin/termsuite extract
  -c ./wind-energy/English/txt/ \
  -l en \
  --tsv ./wind-energy-en.tsv
```

#### Understanding the TSV output

Same TSV output as with manual installation. See [above](#understanding-tsv) for details.

### See also

#### Preprocessing and extraction pipelines

See the [exhaustive list of analysis engines and linguistic resources](/documentation/termsuite-pipelines) that TermSuite uses for terminology extraction.

#### Bilingual alignment

TermSuite also supports terminology alignment, i.e. bilingual domain-specific term translation. See [how to extract your *source* and *target* terminologies for alignment](/documentation/terminology-extractor-cli/#extract-a-terminology-ready-for-alignment) and how to run the aligner [with command line](/documentation/aligner-cli/) or [with Java API](/documentation/java-aligner/).

See also [alignment architecture overview](/documentation/termsuite-pipelines#bilingual-alignment-step-3) and more [theoritical concerns on TermSuite alignment](/documentation/alignment/).

#### The Java API

TermSuite is a Java software and can easily be embedded into your Java projects as a [Maven or Gradle dependency](/documentation/developers/). There is a Java API for: (not exhaustive)

 * [NLP preprocessings](/documentation/java-preprocessor) only,
 * [Terminology extraction](/documentation/java-terminology-extractor),
 * Terminology and prepared corpus [inputs and outputs](/documentation/java-io),
 * [bilingual alignment](/documentation/java-aligner).


#### The graphical user interface (GUI)

Another way of running TermSuite is its [graphical user interface (GUI)](/gui). Note that the current version of TermSuite's GUI is `2.3`, while other API's current version is `3.0`. Be aware that you might not benefit from last TermSuite's features and improvements within the GUI.   
