---
layout: documentation
title: Run terminology extraction from command line API
menu: Command line API
permalink: /documentation/command-line-api/
---

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
| `--profile`  *(no arg)* 	|  Displays variant examples and AE profiling info |
| `--watch`  STRING 	|  Displays info (freq. spec. variants, etc) about all terms matching STRING at the end of pipeline |
| `--nb-examples`  INT 	[=5] |  The number of examples to display for each profiling hit |
| `--tags` *(no arg)* | Show POS tags in the output (works in inline mode only) |
{: class="table table-striped"}

#### Term filtering options

| `--filter-property` STRING 	| See [TermProperty]({{site.javadoc}}) for available values      	|
| `--filter-th` INT [=1]	|  When filtering, the minimum value of for filtered property to be kept in the terminology |
| `--filter-top-n` INT 	| When filtering, the number of terms to keep in terminology after terms are sorted by `--filter-property` desc.         	|
{: class="table table-striped"}

To perform a term filtering, you need to provide the `--filter-property` option, and one of `--filter-th` or `--filter--top-n`. Allowed vlaues for `--filter-property` are : (See [Javadoc]({{site.javadoc}}) for an up-to-date list)

{% for p in site.data.filtering-properties %}
  {% if p.filter %}
  * **{{p.name}}:** {{p.description}}
  {% endif %}
{% endfor %}

See [examples](#termino-examples) for an illustration. These options are not mandatory. By default, the terms are not filtered.

#### Compost options (morphosyntactic analysis)

See class [Lang]({{site.javadoc}}) for defaults.

| `--compost-coeff` STRING 	|  COMPOST alpha, beta, gamma and delta parameters, separated with a hyphen \"-\". Sum must be 1.    	|
| `--compost-similarity-threshold` FLOAT 	| The segment similarity threshold above which an existing string in COMPOST index is considered as recognized. |
| `--compost-score-threshold` FLOAT 	|   The segmentation score threshold of COMPOST algo.    	|
| `--compost-max-component-num` INT 	|   The maximum number of components that a compound can have    	|
| `--compost-min-component-size` INT 	|   The minimum size allowed for a component	|
{: class="table table-striped"}

#### Other options (encoding, corpus, tagger, etc)

| `--encoding` ENCODING  [=UTF-8]|   Encoding of the corpus files      	|
| `--corpus-format` String [=txt] |   The file format in the input corpus. `txt` and `tei` supported    	|
| `--mate` *(no arg)* | Use Mate as TermSuite's POS tagger instead of TreeTagger      	|
| `--graphical-similarity-th` FLOAT 	|   false   	|         	|      The similarity threshold (a value between 0 and 1, 0.9 advised) for graphical variant gathering.   	|
{: class="table table-striped"}

#### Export specific options
{:id="export"}

| --tsv FILENAME 	| Export extract termino to given TSV file |
| --json FILENAME 	| Export extract termino to given Json file |
| --tbx FILENAME 	| Export extract termino to given TBX file	|
{: class="table table-striped"}

#### Examples
{:id="termino-examples"}


##### Extract terminology from `txt` corpus and export top 100 most frequent term to `tsv` and `json`:

Say we have :

 * a [valid corpus](/documentation/corpus) at `/home/me/corpora/mycorpus`,
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
