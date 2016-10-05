TermSuite comes with two command line runners. One for [terminology extraction](#termino), one for [multilingual term alignment](#term-alignment).

* TOC
{:toc}

### Terminology Extraction
{:id="termino"}

Extract the terminology of a domain-specific corpus and [exports it](#export) to `tsv`, `tbx` or `json`.

~~~
$ java -Xms1g -Xmx2g -cp termsuite-core-{{site.termsuite.version}}.jar eu.project.ttc.tools.cli.TermSuiteTerminoCLI \
            -r /path/to/termsuite-resource-pack \
            -t /path/to/tagger-home-dir \
            -c /path/to/corpus/English/txt \
            -l en
~~~

By default, the POS tagger (and lemmatizer) used by this script is TreeTagger. If you need to use Mate instead, add the option `--mate` to command line (see below).

#### Mandatory options

| `-r` PATH  | Path to TermSuite's resource pack (a jar or a directory)   	|
| `-l` LANGUAGE   	| Language code of the corpus text: `en`, `fr`, etc.	|
| `-c` PATH   	| Path to the input corpus.	|
| `-t` PATH   	| Path to Tree Tagger's home directory or to Mate's resource directory. (See [[InstallingPOSTagger]])       	|
{: class="table table-striped"}

#### Logging options

| `--no-logging`  *(no arg)* 	| Disables console logging|
| `--info`  *(no arg)* 	|   Set logging level to `info` |
| `--debug`  *(no arg)* 	| Set logging level to `debug` |
| `--watch`  STRING 	|  Displays info (freq. spec. variants, etc) about all terms matching STRING at the end of pipeline |
| `--tags` *(no arg)* | Show POS tags in the output (works in inline mode only) |
{: class="table table-striped"}

#### Term filtering options

(See also [Periodic filtering options](#periodic-filtering-options))

| `--filter-property` STRING [=wrLog]	| See [TermProperty]({{site.javadoc}}) for available values      	|
| `--filter-th` INT [=2]	|  When filtering, the minimum value of for filtered property to be kept in the terminology |
| `--filter-top-n` INT 	| When filtering, the number of terms to keep in terminology after terms are sorted by `--filter-property` desc.         	|
| `--filter-variants` *(no arg)* 	| Also filters variants  |
{: class="table table-striped"}

To perform a term filtering, you need to provide the `--filter-property` option, and one of `--filter-th` or `--filter-top-n`. Allowed values for `--filter-property` are : (See [Javadoc]({{site.javadoc}}) for an up-to-date list)

{% for p in site.data.filtering-properties %}
  {% if p.filter %}
  * **{{p.name}}:** {%t p.description %}
  {% endif %}
{% endfor %}

By default, the terms are filtered on property **wrLog** with a **threshold value of 2**. See [Term Properties](/documentation/term-properties/) for specific information and explanation about term properties, especially [wrLog](/documentation/term-properties/#wr). See also [examples](#termino-examples) for an illustration. These options are not mandatory.

#### Periodic filtering options

It is also possible to cap the on-going terminology size in order to avoid memory issues (recommended
for big corpus). To activate the periodic filtering (terminology capping), you need to set the
following two options.

| `--periodic-filter-property` STRING	| See [TermProperty]({{site.javadoc}}) for available values      	|
| `--periodic-filter-max-size` INT	| When filtering, the minimum value of for filtered property to be kept in the terminology |
{: class="table table-striped"}

#### Compost options (morphosyntactic analysis)

See class [Lang]({{site.javadoc}}) for defaults.

| `--compost-coeff` STRING 	|  COMPOST alpha, beta, gamma and delta parameters, separated with a hyphen \"-\". Sum must be 1.    	|
| `--compost-similarity-threshold` FLOAT 	| The segment similarity threshold above which an existing string in COMPOST index is considered as recognized. |
| `--compost-score-threshold` FLOAT 	|   The segmentation score threshold of COMPOST algo.    	|
| `--compost-max-component-num` INT 	|   The maximum number of components that a compound can have    	|
| `--compost-min-component-size` INT 	|   The minimum size allowed for a component	|
{: class="table table-striped"}

#### Contextualizer options

| `--contextualize` *(no arg)* 	|  Computes context vectors for all single-word terms.  	|
| `--contextualize-all-terms` *(no arg)* 	|  Computes context vectors for ALL terms (single-word and multi-word terms).  	|
| `--allow-mwts-in-contexts` *(no arg)* 	|  Allow to set multi-word terms as co-occurrences in context vectors.  	|
| `--context-scope` INT 	|   The window size when capturing each term's context.    	|
{: class="table table-striped"}

#### Use 3rd party MongoDB store
{:id="mongodb"}

Sometimes when your corpus gets big (> 30 million words), you need to provide TermSuite
with an off-memory option so as to compute the complete corpus without memory error.
TermSuite supports MongoDB. You need to install MongoDB on your local system.

See the official [MongoDB install guide](https://docs.mongodb.org/manual/installation/). The installation of MongoDB is usually easy.

To activate the use of MongoDB as 3rd party storage, use the option:

| `--mongodb-store` String  |  The mongodb connection string to your database	|
{: class="table table-striped"}

By default, MongoDB is started after install and runs on port `27017`. So, the MongoDB connection
string is usually something like `mongodb://localhost:27017/nameofmydb`. This will create the MongoDB
database `nameofmydb` unless it already exists. See the full documentation of MongoDB [connection strings](https://docs.mongodb.org/manual/reference/connection-string/)
if you have chosen of more sophisticated installation configuration.


#### Other options (encoding, corpus, tagger, etc)

| `--encoding` ENCODING  [=UTF-8]|   Encoding of the corpus files      	|
| `--corpus-format` String [=txt] |   The file format in the input corpus. `txt` and `tei` supported    	|
| `--mate` *(no arg)* | Use Mate as TermSuite's POS tagger instead of TreeTagger      	|
| `--graphical-similarity-th` FLOAT 	|   false   	|         	|      The similarity threshold (a value between 0 and 1, 0.9 advised) for graphical variant gathering.   	|
{: class="table table-striped"}

#### Export options
{:id="export"}

| `--json` FILENAME 	| Export extract termino to given Json file |
| `--json-mongodb-soft-link`  *(no arg)*	| Use it only if option `--mongo-store` is set (see [3rd-party MongoDB](#mongodb)) in order to deactivate the occurrence serialization within the json (for big corpus) |
| `--tbx` FILENAME 	| Export extract termino to given TBX file	|
| `--tsv` FILENAME 	| Export extract termino to given TSV file |
| `--tsv-properties` PROPERTIES [="pilot,frequency"]	| `,`-separated list of term properties to export as a column in TSV file |
| `--tsv-show-scores` *(no arg)* | Show terms and variants' scores and subscores used by term ranking in tsv file |
{: class="table table-striped"}

Possible values option `--tsv-properties` are: (see [examples](#examples) for an illustration)

{% for p in site.data.filtering-properties %}
  * **{{p.name}}:** {%t p.description %}
{% endfor %}

See [Term Properties](/documentation/term-properties/) for specific information and explanation about term properties, especially [wrLog](/documentation/term-properties/#wr).

#### Examples
{:id="termino-examples"}


##### Extract terminology from `txt` corpus and export top 100 most frequent term to `tsv` and `json`:

Say we have :

 * a corpus of `txt` files at `/home/me/corpora/mycorpus`,
 * Tree Tagger installed at `/home/me/apps/TreeTagger`,
 * Our resource pack at `/home/me/data/termsuite-resources.jar`

The following command extracts the terminology of corpus *mycorpus* in english, using TreeTagger, selecting the first 100 terms by frequency, and exports them to tsv and json:

~~~
$ java -Xms1g -Xmx2g -cp termsuite-core-{{site.termsuite.version}}.jar eu.project.ttc.tools.cli.TermSuiteTerminoCLI \
            -r /home/me/data/termsuite-resources.jar \
            -t /home/me/apps/TreeTagger \
            -c /home/me/corpora/mycorpus/English/txt \
            -l en \
            --filter-property "frequency" \
            --filter-top-n 100 \
            --tsv "mytermino.tsv" \
            --tsv-properties "pattern,pilot,wrLog,frequency"
            --json "mytermino.json"
~~~

##### Spot multi-word term occurrences of a `tei` corpus and save UIMA annotations to `xmi` cas files

It produces one `xmi` file per input `tei` file :

~~~
TODO
~~~


#### The inline mode

You can also run a TermSuite termino pipeline on an inline string. In such case, there is no need to give a `-c` option (corpus path).

Inline mode from option `--text`:

~~~
$ java -Xms1g -Xmx2g -cp termsuite-core-x.x.jar eu.project.ttc.tools.cli.TermSuiteTerminoCLI \
            -r /path/to/termsuite-resource-pack \
            -t /path/to/tree-tagger-home \
            -l en \
            --text "Wind energy is the energy of tomorrow."
~~~

Inline mode from standard input:

~~~
$ echo "My test phrase." | java -Xms1g -Xmx2g -cp termsuite-core-x.x.jar \ eu.project.ttc.tools.cli.TermSuiteTerminoCLI \
            -r /path/to/termsuite-resource-pack \
            -t /path/to/tree-tagger-home \
            -l en
~~~


### Multilingual term alignment
{:id="term-alignment"}

The `TermSuiteAlignerCLI` script takes as input:

 * the two  terminologies (the *source* and the *target* terminologies extracted by TermSuite on two comparable corpora),
 * the [bilingual dictionary](/documentation/resources/#dictionary),
 * the list of terms to be translated.

#### The `TermSuiteAlignerCLI` script
{:id="aligner"}

The aligner takes as input :

 * two terminologies extracted by TermSuite from a multilingual comparable corpus, one in the *source language*, the other one in the *target language*,
 * a *source-to-target* bilingual dictionary, (See [/documentation/resources/](TermSuite Resources documentation))
 * a term, or list of term to align.

~~~
$ java -cp termsuite-core-{{site.termsuite.version}}.jar eu.project.ttc.tools.cli.TermSuiteAlignerCLI \
        --source-termino termino-fr.json \
        --target-termino termino-en.json \
        --dictionary dico.txt \
        --term "hydroélectricité"
~~~

#### Options
{:id="aligner-options"}

##### Mandatory options

| `--source-termino` FILENAME 	| Export extract termino to given Json file |
| `--target-termino` FILENAME 	| Export extract termino to given TBX file	|
| `--dictionary` FILENAME 	| Export extract termino to given TSV file (See [/documentation/resources/](TermSuite Resources documentation)) |

One of :

| `--term` STRING 	| The term to align |
| `--term-list` FILENAME 	| A file containing the list of terms to align. One per line. |
{: class="table table-striped"}

##### Other options

| `-n` INT 	| The number of translation candidates to display |
| `--distance` [cosine,jaccard] 	| The similarity measure used to compute the distance between two vectors |
| `--explain` *(no args)* 	| Also show the most influencial co-terms with the translation candidates |

#### Examples

The following aligns the french term *hydroélectricité* from the terminologies in french and in english of the corpus *Wind Energy*:

~~~
$ java -cp termsuite-core-{{site.termsuite.version}}.jar eu.project.ttc.tools.cli.TermSuiteAlignerCLI \
        --source-termino wind-energy-fr.json \
        --target-termino wind-energy-en.json \
        --dictionary FR-EN.txt \
        --term "hydroélectricité"
~~~

This commands outputs:

~~~
n: hydropower	0,524
n: source	0,066
n: roadmap	0,061
n: target	0,058
n: consumption	0,049
n: energy	0,049
a: renewable	0,049
a: grid-connected	0,048
n: undertaking	0,048
n: fight	0,048
~~~

What takes time for `TermSuiteAlignerCLI` is to load both terminologies. I you need to align several terms, it is better to have them in a file as follows:

~~~
rotor
éolienne
éolien
pale
turbine
dimensionnement
moyeu
calage
écoulement
générateur
nacelle
~~~

And run the aligner script on this file:

~~~
$ java -cp termsuite-core-{{site.termsuite.version}}.jar eu.project.ttc.tools.cli.TermSuiteAlignerCLI \
        --source-termino wind-energy-fr.json \
        --target-termino wind-energy-en.json \
        --dictionary FR-EN.txt \
        --term-list list.txt
~~~
