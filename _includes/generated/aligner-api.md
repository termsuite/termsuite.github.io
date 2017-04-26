


### AlignerCLI
{: id="AlignerCLI"}

#### Usage

```
java [-Xms256m -Xmx8g] -cp termsuite-core-3.0.2.jar \
	 fr.univnantes.termsuite.tools.AlignerCLI OPTIONS
```

#### Description

Translates domain-specific terms in multiligual comparable corpora from given language to given target language.

#### Mandatory options

###### `--dictionary` FILE
{: id="AlignerCLI-dictionary"}


 > The path to the bilingual dictionary to use for bilingual alignment

###### `--source-termino` FILE
{: id="AlignerCLI-source-termino"}


 > The source terminology (indexed corpus)

###### `--target-termino` FILE
{: id="AlignerCLI-target-termino"}


 > The source terminology (indexed corpus)



###### [`--term-list`](#AlignerCLI-term-list), [`--term`](#AlignerCLI-term)


<div class="alert alert-warning" role="alert">
Exactly one option in [`--term-list`](#AlignerCLI-term-list), [`--term`](#AlignerCLI-term) must be set.
</div>



#### Other options

###### `--distance` INT or FLOAT
{: id="AlignerCLI-distance"}


 > Similarity measure used for context vector alignment. Allowed values are: `Cosine`, `Jaccard`

###### `--explain` *(no arg)*
{: id="AlignerCLI-explain"}


 > Shows for each aligned term the most influencial co-terms

###### `--min-candidate-frequency` INT
{: id="AlignerCLI-min-candidate-frequency"}


 > The minimum frequency of target translation candidates

###### `--n`, `-n` INT
{: id="AlignerCLI-n"}


 > The number of translation candidates to show in the output

###### `--term` TERM_LIST
{: id="AlignerCLI-term"}


 > The source term (lemma or grouping key) to translate


<div class="alert alert-warning" role="alert">
**Warning:** Exactly one option in [`--term-list`](#AlignerCLI-term-list), [`--term`](#AlignerCLI-term) must be set.
</div>

###### `--term-list` FILE
{: id="AlignerCLI-term-list"}


 > The path to a list of source terms (lemmas or grouping keys) to translate


<div class="alert alert-warning" role="alert">
**Warning:** Exactly one option in [`--term-list`](#AlignerCLI-term-list), [`--term`](#AlignerCLI-term) must be set.
</div>

###### `--tsv` FILE
{: id="AlignerCLI-tsv"}


 > A file path to write output of the bilingual aligner
