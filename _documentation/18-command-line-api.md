---
layout: documentation
title: Command line API
menu: Command line API
permalink: /documentation/command-line-api/
---

TermSuite comes with a command line runner for terminology extraction.

~~~
$ java -Xms1g -Xmx2g -cp termsuite-core-{{site.termsuite.version}}.jar eu.project.ttc.tools.cli.TermSuiteTerminoCLI \
            -r /path/to/termsuite-resource-pack \
            -t /path/to/tagger-home-dir \
            -c /path/to/corpus/English/txt \
            -l en
~~~

By default, the POS tagger (and lemmatizer) used by this script is TreeTagger. If you need to use Mate instead, add the option `--mate` to command line (see below).


### Options

|                	| Mandatory 	| Default 	| Comment 	|
| -r PATH   	|    true   	|         	|      Path to TermSuite's resource pack (a jar or a directory)   	|
| -l LANGUAGE   	|    true   	|         	|  Language code of the corpus text: `en`, `fr`, etc.	|
| -c PATH   	|    true   	|         	| Path to the input corpus.	|
| -t PATH   	|   true  	|         	| Path to Tree Tagger's home directory or to Mate's resource directory. (See [[InstallingPOSTagger]])       	|
| --mate *(no arg)*	|   false   	|         	|   Use Mate as TermSuite's POS tagger instead of TreeTagger      	|
| --encoding ENCODING   |    false   	| UTF-8	|   Encoding of the corpus files      	|
| --tsv FILENAME 	|   false   	|         	| Export extract termino to given TSV file |
| --json FILENAME 	|   false   	|         	| Export extract termino to given Json file |
| --tbx FILENAME 	|   false   	|         	| Export extract termino to given TBX file	|
| --profile  *(no arg)* 	|   false   	|         	|      Displays variant examples and AE profiling info |
| --watch  STRING 	|   false   	|         	|    Displays info (freq. spec. variants, etc) about all terms matching STRING at the end of pipeline |
| --no-logging  *(no arg)* 	|   false   	|         	|      Disables console logging|
| --info  *(no arg)* 	|   false   	|         	| Set logging level to `info` |
| --debug  *(no arg)* 	|   false   	|         	| Set logging level to `debug` |
| --nb-examples  INT 	|   false   	|         	|      The number of examples to display for each profiling hit |
| --filter-property STRING 	|   false   	|         	|   See TermProperty.class for available values      	|
| --filter-th INT 	|   false   	|         	| When filtering, the minimum value of for filtered property to be kept in the terminology |
| --filter-top-n INT 	|   false   	|         	|  When filtering, the number of terms to keep in terminology after terms are sorted by `--filter-property` desc.         	|
| --tags *(no arg)* |   false   	|         	|  Show POS tags in the output (works in inline mode only) |
| --graphical-similarity-th FLOAT 	|   false   	|         	|      The similarity threshold (a value between 0 and 1, 0.9 advised) for graphical variant gathering.   	|
| --corpus-format String 	|   false   	|    `txt`     	|     The file format in the input corpus. `txt` and `tei` supported    	|
| --compost-coeff STRING 	|   false   	|         	|     COMPOST alpha, beta, gamma and delta parameters, separated with a hyphen \"-\". Sum must be 1.    	|
| --compost-similarity-threshold FLOAT 	|   false   	|         	|   The segment similarity threshold above which an existing string in COMPOST index is considered as recognized.   |
| --compost-score-threshold FLOAT 	|   false   	|         	|     The segmentation score threshold of COMPOST algo.    	|
| --compost-max-component-num INT 	|   false   	|         	|     The maximum number of components that a compound can have    	|
| --compost-min-component-size INT 	|   false   	|         	| The minimum size allowed for a component	|
{: class="table table-striped"}

#### The inline mode

You can also run a TermSuite termino pipeline on an inline string. In such case, there is no need to give a `-c` option (corpus path).

###### Inline mode from option `--text`

~~~
$ java -Xms1g -Xmx2g -cp termsuite-core-x.x.jar eu.project.ttc.tools.cli.TermSuiteTerminoCLI
            -r /path/to/termsuite-resource-pack
            -t /path/to/tree-tagger-home
            -l en
            --text "Wind energy is the energy of tomorrow."
~~~

###### Inline mode from standard input

~~~
$ echo "My test phrase." | java -Xms1g -Xmx2g -cp termsuite-core-x.x.jar eu.project.ttc.tools.cli.TermSuiteTerminoCLI
            -r /path/to/termsuite-resource-pack
            -t /path/to/tree-tagger-home
            -l en
~~~


## Examples

###### Extract terminology from `txt` corpus and export top 100 most frequent term to `tsv` and `json`:

Say we have :
* a [valid corpus](/documentation/corpus) at `/home/me/corpora/mycorpus`,
* Tree Tagger installed at `/home/me/apps/TreeTagger`,
* Our resource pack at `/home/me/data/termsuite-resources.jar`

~~~
$ java -Xms1g -Xmx2g -cp termsuite-core-x.x.jar eu.project.ttc.tools.cli.TermSuiteTerminoCLI
            -r /home/me/data/termsuite-resources.jar
            -t /home/me/apps/TreeTagger
            -c /home/me/corpora/mycorpus/English/txt
            -l en
            --filter-property "frequency"
            --filter-top-n 100
            --tsv "mytermino.tsv"
            --json "mytermino.json"
~~~

###### Spot multi-word term occurrences of a `tei` corpus and save UIMA annotations to `xmi` cas files

It produces one `xmi` file per input `tei` file :

~~~
TODO
~~~
