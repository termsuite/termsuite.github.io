


### PreprocessorCLI
{: id="PreprocessorCLI"}

#### Usage

```
java [-Xms256m -Xmx8g] -cp termsuite-core-3.0.2.jar \
	 fr.univnantes.termsuite.tools.PreprocessorCLI OPTIONS
```

#### Description

Applies TermSuite's preprocessings to given text corpus.

#### Mandatory options

###### `--tagger-home`, `-t` FILE
{: id="PreprocessorCLI-tagger-home"}


 > Path to POS tagger's home

###### `--from-text-corpus`, `-c` DIR
{: id="PreprocessorCLI-from-text-corpus"}


 > Directory to corpus (containing a list of .txt documents)

###### `--language`, `-l` LANG
{: id="PreprocessorCLI-language"}


 > Language of the input corpus



###### [`--json-anno`](#PreprocessorCLI-json-anno), [`--tsv-anno`](#PreprocessorCLI-tsv-anno), [`--json`](#PreprocessorCLI-json), [`--xmi-anno`](#PreprocessorCLI-xmi-anno)


<div class="alert alert-warning" role="alert">
At least one option in [`--json-anno`](#PreprocessorCLI-json-anno), [`--tsv-anno`](#PreprocessorCLI-tsv-anno), [`--json`](#PreprocessorCLI-json), [`--xmi-anno`](#PreprocessorCLI-xmi-anno) must be set.
</div>



#### Other options

###### `--capped-size` INT
{: id="PreprocessorCLI-capped-size"}


 > The maximum number of terms to keep in memory while spotting. Allows to process bigger volumes of input text.

###### `--encoding`, `-e` ENC
{: id="PreprocessorCLI-encoding"}


 > Encoding of the input corpus

###### `--json` FILE
{: id="PreprocessorCLI-json"}


 > Path to JSON indexed corpus file where all occurrences are imported to


<div class="alert alert-warning" role="alert">
**Warning:** At least one option in [`--json-anno`](#PreprocessorCLI-json-anno), [`--tsv-anno`](#PreprocessorCLI-tsv-anno), [`--json`](#PreprocessorCLI-json), [`--xmi-anno`](#PreprocessorCLI-xmi-anno) must be set.
</div>

###### `--json-anno` DIR
{: id="PreprocessorCLI-json-anno"}


 > Path to JSON export directory of all spotted term annotations


<div class="alert alert-warning" role="alert">
**Warning:** At least one option in [`--json-anno`](#PreprocessorCLI-json-anno), [`--tsv-anno`](#PreprocessorCLI-tsv-anno), [`--json`](#PreprocessorCLI-json), [`--xmi-anno`](#PreprocessorCLI-xmi-anno) must be set.
</div>

###### `--no-occurrence` *(no arg)*
{: id="PreprocessorCLI-no-occurrence"}


 > Do not store occurrence offsets in memory while spotting. Allows to process bigger volumes of input text.

###### `--resource-dir` DIR
{: id="PreprocessorCLI-resource-dir"}


 > Custom resource directory

###### `--resource-jar` FILE
{: id="PreprocessorCLI-resource-jar"}


 > Custom resource jar

###### `--resource-url-prefix` STRING
{: id="PreprocessorCLI-resource-url-prefix"}


 > Custom resource url prefix

###### `--tagger` STRING
{: id="PreprocessorCLI-tagger"}


 > Which POS tagger to use. Allowed values are: `mate`, `tt`

###### `--tsv-anno` DIR
{: id="PreprocessorCLI-tsv-anno"}


 > Path to TSV export directory of all spotted term annotations


<div class="alert alert-warning" role="alert">
**Warning:** At least one option in [`--json-anno`](#PreprocessorCLI-json-anno), [`--tsv-anno`](#PreprocessorCLI-tsv-anno), [`--json`](#PreprocessorCLI-json), [`--xmi-anno`](#PreprocessorCLI-xmi-anno) must be set.
</div>

###### `--watch` TERM_LIST
{: id="PreprocessorCLI-watch"}


 > List of terms (grouping keys or lemmas) to log to output

###### `--xmi-anno` DIR
{: id="PreprocessorCLI-xmi-anno"}


 > Path to XMI export directory of all spotted term annotations


<div class="alert alert-warning" role="alert">
**Warning:** At least one option in [`--json-anno`](#PreprocessorCLI-json-anno), [`--tsv-anno`](#PreprocessorCLI-tsv-anno), [`--json`](#PreprocessorCLI-json), [`--xmi-anno`](#PreprocessorCLI-xmi-anno) must be set.
</div>
