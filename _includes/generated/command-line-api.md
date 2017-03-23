


### TerminologyExtractorCLI
{: id="TerminologyExtractorCLI"}

#### Usage

```
java [-Xms256m -Xmx8g] -cp termsuite-core-3.0.jar \
	 fr.univnantes.termsuite.tools.TerminologyExtractorCLI OPTIONS
```

#### Description

Extracts terminology from a domain-specific textual corpus (or preprocessed corpus).

#### Mandatory options



###### [`--from-prepared-corpus`](#TerminologyExtractorCLI-from-prepared-corpus), [`--from-text-corpus`](#TerminologyExtractorCLI-from-text-corpus)


<div class="alert alert-warning" role="alert">
Exactly one option in [`--from-prepared-corpus`](#TerminologyExtractorCLI-from-prepared-corpus), [`--from-text-corpus`](#TerminologyExtractorCLI-from-text-corpus) must be set.
</div>


###### [`--tbx`](#TerminologyExtractorCLI-tbx), [`--json`](#TerminologyExtractorCLI-json), [`--tsv`](#TerminologyExtractorCLI-tsv)


<div class="alert alert-warning" role="alert">
At least one option in [`--tbx`](#TerminologyExtractorCLI-tbx), [`--json`](#TerminologyExtractorCLI-json), [`--tsv`](#TerminologyExtractorCLI-tsv) must be set.
</div>



#### Other options

###### `--context-assoc-rate` INT or FLOAT
{: id="TerminologyExtractorCLI-context-assoc-rate"}


 > Association rate measure used to normalize context vectors. Allowed values are: `MutualInformation`, `LogLikelihood`


<div class="alert alert-warning" role="alert">
**Warning:** This option can only be set when option [`--contextualize`](#TerminologyExtractorCLI-contextualize) is already set.
</div>

###### `--context-coocc-th` INT or FLOAT
{: id="TerminologyExtractorCLI-context-coocc-th"}


 > Sets a minimum frequency threshold for co-terms to appear in context vectors


<div class="alert alert-warning" role="alert">
**Warning:** This option can only be set when option [`--contextualize`](#TerminologyExtractorCLI-contextualize) is already set.
</div>

###### `--context-scope` INT
{: id="TerminologyExtractorCLI-context-scope"}


 > Radius of single-word term window used during contextualization


<div class="alert alert-warning" role="alert">
**Warning:** This option can only be set when option [`--contextualize`](#TerminologyExtractorCLI-contextualize) is already set.
</div>

###### `--contextualize` *(no arg)*
{: id="TerminologyExtractorCLI-contextualize"}


 > Activates the contextualizer

###### `--disable-derivative-splitting` *(no arg)*
{: id="TerminologyExtractorCLI-disable-derivative-splitting"}


 > Disable morphological derivative splitting

###### `--disable-merging` *(no arg)*
{: id="TerminologyExtractorCLI-disable-merging"}


 > Disable graphical term merging

###### `--disable-morphology` *(no arg)*
{: id="TerminologyExtractorCLI-disable-morphology"}


 > Disable morphology analysis (native, prefix, derivation splitting)

###### `--disable-native-splitting` *(no arg)*
{: id="TerminologyExtractorCLI-disable-native-splitting"}


 > Disable morphological native splitting

###### `--disable-post-processing` *(no arg)*
{: id="TerminologyExtractorCLI-disable-post-processing"}


 > Disable post-gathering scoring and filtering processings

###### `--disable-prefix-splitting` *(no arg)*
{: id="TerminologyExtractorCLI-disable-prefix-splitting"}


 > Disable morphological prefix splitting

###### `--enable-semantic-gathering` *(no arg)*
{: id="TerminologyExtractorCLI-enable-semantic-gathering"}


 > Enable semantic term gathering (monolingual alignment)

###### `--encoding`, `-e` ENC
{: id="TerminologyExtractorCLI-encoding"}


 > Encoding of the input corpus

###### `--from-prepared-corpus` DIR
{: id="TerminologyExtractorCLI-from-prepared-corpus"}


 > A file or directory path. Starts the terminology extraction pipeline from an XMI corpus or an imported terminology json file instead of a txt corpus.


<div class="alert alert-warning" role="alert">
**Warning:** Exactly one option in [`--from-prepared-corpus`](#TerminologyExtractorCLI-from-prepared-corpus), [`--from-text-corpus`](#TerminologyExtractorCLI-from-text-corpus) must be set.
</div>

###### `--from-text-corpus`, `-c` DIR
{: id="TerminologyExtractorCLI-from-text-corpus"}


 > Directory to corpus (containing a list of .txt documents)


<div class="alert alert-warning" role="alert">
**Warning:** Exactly one option in [`--from-prepared-corpus`](#TerminologyExtractorCLI-from-prepared-corpus), [`--from-text-corpus`](#TerminologyExtractorCLI-from-text-corpus) must be set.
</div>

###### `--graphical-similarity-th` INT or FLOAT
{: id="TerminologyExtractorCLI-graphical-similarity-th"}


 > Graphical similarity threshold

###### `--json` FILE
{: id="TerminologyExtractorCLI-json"}


 > Outputs terminology to JSON file


<div class="alert alert-warning" role="alert">
**Warning:** At least one option in [`--tbx`](#TerminologyExtractorCLI-tbx), [`--json`](#TerminologyExtractorCLI-json), [`--tsv`](#TerminologyExtractorCLI-tsv) must be set.
</div>

###### `--language`, `-l` LANG
{: id="TerminologyExtractorCLI-language"}


 > Language of the input corpus

###### `--nb-semantic-candidates` INT
{: id="TerminologyExtractorCLI-nb-semantic-candidates"}


 > Max number of semantic variants for each terms


<div class="alert alert-warning" role="alert">
**Warning:** This option can only be set when option [`--enable-semantic-gathering`](#TerminologyExtractorCLI-enable-semantic-gathering) is already set.
</div>

###### `--post-filter-keep-variants` *(no arg)*
{: id="TerminologyExtractorCLI-post-filter-keep-variants"}


 > Keep variants during post-gathering filtering even if they are to be filtered


<div class="alert alert-warning" role="alert">
**Warning:** This option can only be set when option [`--post-filter-property`](#TerminologyExtractorCLI-post-filter-property) is already set.
</div>

###### `--post-filter-max-variants` INT
{: id="TerminologyExtractorCLI-post-filter-max-variants"}


 > The maximum number of variants to keep during post-gathering filtering


<div class="alert alert-warning" role="alert">
**Warning:** This option can only be set when option [`--post-filter-property`](#TerminologyExtractorCLI-post-filter-property) is already set.
</div>

###### `--post-filter-property` STRING
{: id="TerminologyExtractorCLI-post-filter-property"}


 > Enables post-gathering filtering based on given property.  Allowed values are: [`rank`]({{site.baseurl_root}}/documentation/properties/#TermProperty-rank), [`documentFrequency`]({{site.baseurl_root}}/documentation/properties/#TermProperty-dfreq), [`frequencyNorm`]({{site.baseurl_root}}/documentation/properties/#TermProperty-f_norm), [`generalFrequencyNorm`]({{site.baseurl_root}}/documentation/properties/#TermProperty-gf_norm), [`specificity`]({{site.baseurl_root}}/documentation/properties/#TermProperty-spec), [`frequency`]({{site.baseurl_root}}/documentation/properties/#TermProperty-freq), [`OrthographicScore`]({{site.baseurl_root}}/documentation/properties/#TermProperty-ortho), [`IndependantFrequency`]({{site.baseurl_root}}/documentation/properties/#TermProperty-ifreq), [`Independance`]({{site.baseurl_root}}/documentation/properties/#TermProperty-ind), [`tf-idf`]({{site.baseurl_root}}/documentation/properties/#TermProperty-tfidf), [`spec-idf`]({{site.baseurl_root}}/documentation/properties/#TermProperty-specidf), [`SwtSize`]({{site.baseurl_root}}/documentation/properties/#TermProperty-swtSize), [`Depth`]({{site.baseurl_root}}/documentation/properties/#TermProperty-depth)

###### `--post-filter-th` INT or FLOAT
{: id="TerminologyExtractorCLI-post-filter-th"}


 > Threshold value of post-gathering filter


<div class="alert alert-warning" role="alert">
**Warning:** This option can only be set when option [`--post-filter-property`](#TerminologyExtractorCLI-post-filter-property) is already set.
</div>


<div class="alert alert-warning" role="alert">
**Warning:** At most one option in [`--post-filter-th`](#TerminologyExtractorCLI-post-filter-th), [`--post-filter-top-n`](#TerminologyExtractorCLI-post-filter-top-n) must be set.
</div>

###### `--post-filter-top-n` INT
{: id="TerminologyExtractorCLI-post-filter-top-n"}


 > N value for post-gathering filtering over top N terms


<div class="alert alert-warning" role="alert">
**Warning:** This option can only be set when option [`--post-filter-property`](#TerminologyExtractorCLI-post-filter-property) is already set.
</div>


<div class="alert alert-warning" role="alert">
**Warning:** At most one option in [`--post-filter-th`](#TerminologyExtractorCLI-post-filter-th), [`--post-filter-top-n`](#TerminologyExtractorCLI-post-filter-top-n) must be set.
</div>

###### `--postproc-independance-th` INT or FLOAT
{: id="TerminologyExtractorCLI-postproc-independance-th"}


 > Term independance score threshold. Terms under threshold are filtered out.


<div class="alert alert-warning" role="alert">
**Warning:** This option **cannot be set** when option [`--disable-post-processing`](#TerminologyExtractorCLI-disable-post-processing) is already set.
</div>

###### `--postproc-variation-score-th` INT or FLOAT
{: id="TerminologyExtractorCLI-postproc-variation-score-th"}


 > Filters out variations with scores under given threshold


<div class="alert alert-warning" role="alert">
**Warning:** This option **cannot be set** when option [`--disable-post-processing`](#TerminologyExtractorCLI-disable-post-processing) is already set.
</div>

###### `--pre-filter-keep-variants` *(no arg)*
{: id="TerminologyExtractorCLI-pre-filter-keep-variants"}


 > Keep variants during pre-gathering filtering even if they are to be filtered


<div class="alert alert-warning" role="alert">
**Warning:** This option can only be set when option [`--pre-filter-property`](#TerminologyExtractorCLI-pre-filter-property) is already set.
</div>

###### `--pre-filter-max-variants` INT
{: id="TerminologyExtractorCLI-pre-filter-max-variants"}


 > The maximum number of variants to keep during pre-gathering filtering


<div class="alert alert-warning" role="alert">
**Warning:** This option can only be set when option [`--pre-filter-property`](#TerminologyExtractorCLI-pre-filter-property) is already set.
</div>

###### `--pre-filter-property` STRING
{: id="TerminologyExtractorCLI-pre-filter-property"}


 > Enables pre-gathering filtering based on given property. Allowed values are: [`rank`]({{site.baseurl_root}}/documentation/properties/#TermProperty-rank), [`documentFrequency`]({{site.baseurl_root}}/documentation/properties/#TermProperty-dfreq), [`frequencyNorm`]({{site.baseurl_root}}/documentation/properties/#TermProperty-f_norm), [`generalFrequencyNorm`]({{site.baseurl_root}}/documentation/properties/#TermProperty-gf_norm), [`specificity`]({{site.baseurl_root}}/documentation/properties/#TermProperty-spec), [`frequency`]({{site.baseurl_root}}/documentation/properties/#TermProperty-freq), [`OrthographicScore`]({{site.baseurl_root}}/documentation/properties/#TermProperty-ortho), [`IndependantFrequency`]({{site.baseurl_root}}/documentation/properties/#TermProperty-ifreq), [`Independance`]({{site.baseurl_root}}/documentation/properties/#TermProperty-ind), [`tf-idf`]({{site.baseurl_root}}/documentation/properties/#TermProperty-tfidf), [`spec-idf`]({{site.baseurl_root}}/documentation/properties/#TermProperty-specidf), [`SwtSize`]({{site.baseurl_root}}/documentation/properties/#TermProperty-swtSize), [`Depth`]({{site.baseurl_root}}/documentation/properties/#TermProperty-depth)

###### `--pre-filter-th` INT or FLOAT
{: id="TerminologyExtractorCLI-pre-filter-th"}


 > Threshold value of pre-gathering filter


<div class="alert alert-warning" role="alert">
**Warning:** This option can only be set when option [`--pre-filter-property`](#TerminologyExtractorCLI-pre-filter-property) is already set.
</div>


<div class="alert alert-warning" role="alert">
**Warning:** At most one option in [`--pre-filter-top-n`](#TerminologyExtractorCLI-pre-filter-top-n), [`--pre-filter-th`](#TerminologyExtractorCLI-pre-filter-th) must be set.
</div>

###### `--pre-filter-top-n` INT
{: id="TerminologyExtractorCLI-pre-filter-top-n"}


 > N value for pre-gathering filtering over top N terms


<div class="alert alert-warning" role="alert">
**Warning:** This option can only be set when option [`--pre-filter-property`](#TerminologyExtractorCLI-pre-filter-property) is already set.
</div>


<div class="alert alert-warning" role="alert">
**Warning:** At most one option in [`--pre-filter-top-n`](#TerminologyExtractorCLI-pre-filter-top-n), [`--pre-filter-th`](#TerminologyExtractorCLI-pre-filter-th) must be set.
</div>

###### `--ranking-asc` STRING
{: id="TerminologyExtractorCLI-ranking-asc"}


 > Sets the output ranking property in ASCENDING order.  Allowed values are: [`rank`]({{site.baseurl_root}}/documentation/properties/#TermProperty-rank), [`documentFrequency`]({{site.baseurl_root}}/documentation/properties/#TermProperty-dfreq), [`frequencyNorm`]({{site.baseurl_root}}/documentation/properties/#TermProperty-f_norm), [`generalFrequencyNorm`]({{site.baseurl_root}}/documentation/properties/#TermProperty-gf_norm), [`specificity`]({{site.baseurl_root}}/documentation/properties/#TermProperty-spec), [`frequency`]({{site.baseurl_root}}/documentation/properties/#TermProperty-freq), [`OrthographicScore`]({{site.baseurl_root}}/documentation/properties/#TermProperty-ortho), [`IndependantFrequency`]({{site.baseurl_root}}/documentation/properties/#TermProperty-ifreq), [`Independance`]({{site.baseurl_root}}/documentation/properties/#TermProperty-ind), [`tf-idf`]({{site.baseurl_root}}/documentation/properties/#TermProperty-tfidf), [`spec-idf`]({{site.baseurl_root}}/documentation/properties/#TermProperty-specidf), [`SwtSize`]({{site.baseurl_root}}/documentation/properties/#TermProperty-swtSize), [`Depth`]({{site.baseurl_root}}/documentation/properties/#TermProperty-depth)


<div class="alert alert-warning" role="alert">
**Warning:** At most one option in [`--ranking-desc`](#TerminologyExtractorCLI-ranking-desc), [`--ranking-asc`](#TerminologyExtractorCLI-ranking-asc) must be set.
</div>

###### `--ranking-desc` STRING
{: id="TerminologyExtractorCLI-ranking-desc"}


 > Sets the output ranking property in DESCENDING order.  Allowed values are: [`rank`]({{site.baseurl_root}}/documentation/properties/#TermProperty-rank), [`documentFrequency`]({{site.baseurl_root}}/documentation/properties/#TermProperty-dfreq), [`frequencyNorm`]({{site.baseurl_root}}/documentation/properties/#TermProperty-f_norm), [`generalFrequencyNorm`]({{site.baseurl_root}}/documentation/properties/#TermProperty-gf_norm), [`specificity`]({{site.baseurl_root}}/documentation/properties/#TermProperty-spec), [`frequency`]({{site.baseurl_root}}/documentation/properties/#TermProperty-freq), [`OrthographicScore`]({{site.baseurl_root}}/documentation/properties/#TermProperty-ortho), [`IndependantFrequency`]({{site.baseurl_root}}/documentation/properties/#TermProperty-ifreq), [`Independance`]({{site.baseurl_root}}/documentation/properties/#TermProperty-ind), [`tf-idf`]({{site.baseurl_root}}/documentation/properties/#TermProperty-tfidf), [`spec-idf`]({{site.baseurl_root}}/documentation/properties/#TermProperty-specidf), [`SwtSize`]({{site.baseurl_root}}/documentation/properties/#TermProperty-swtSize), [`Depth`]({{site.baseurl_root}}/documentation/properties/#TermProperty-depth)


<div class="alert alert-warning" role="alert">
**Warning:** At most one option in [`--ranking-desc`](#TerminologyExtractorCLI-ranking-desc), [`--ranking-asc`](#TerminologyExtractorCLI-ranking-asc) must be set.
</div>

###### `--resource-dir` DIR
{: id="TerminologyExtractorCLI-resource-dir"}


 > Custom resource directory

###### `--resource-jar` FILE
{: id="TerminologyExtractorCLI-resource-jar"}


 > Custom resource jar

###### `--resource-url-prefix` STRING
{: id="TerminologyExtractorCLI-resource-url-prefix"}


 > Custom resource url prefix

###### `--semantic-distance` INT or FLOAT
{: id="TerminologyExtractorCLI-semantic-distance"}


 > Similarity measure used for semantic alignment. Allowed values are: `Cosine`, `Jaccard`


<div class="alert alert-warning" role="alert">
**Warning:** This option can only be set when option [`--enable-semantic-gathering`](#TerminologyExtractorCLI-enable-semantic-gathering) is already set.
</div>

###### `--semantic-similarity-th` INT or FLOAT
{: id="TerminologyExtractorCLI-semantic-similarity-th"}


 > Minimum semantic similarity threshold for semantic gathering (monolingual alignment)


<div class="alert alert-warning" role="alert">
**Warning:** This option can only be set when option [`--enable-semantic-gathering`](#TerminologyExtractorCLI-enable-semantic-gathering) is already set.
</div>

###### `--tagger` STRING
{: id="TerminologyExtractorCLI-tagger"}


 > Which POS tagger to use. Allowed values are: `mate`, `tt`

###### `--tagger-home`, `-t` FILE
{: id="TerminologyExtractorCLI-tagger-home"}


 > Path to POS tagger's home


<div class="alert alert-warning" role="alert">
**Warning:** This option can only be set when option [`--from-text-corpus`](#TerminologyExtractorCLI-from-text-corpus) is already set.
</div>

###### `--tbx` FILE
{: id="TerminologyExtractorCLI-tbx"}


 > Outputs terminology to TBX file


<div class="alert alert-warning" role="alert">
**Warning:** At least one option in [`--tbx`](#TerminologyExtractorCLI-tbx), [`--json`](#TerminologyExtractorCLI-json), [`--tsv`](#TerminologyExtractorCLI-tsv) must be set.
</div>

###### `--tsv` FILE
{: id="TerminologyExtractorCLI-tsv"}


 > Outputs terminology to TSV file


<div class="alert alert-warning" role="alert">
**Warning:** At least one option in [`--tbx`](#TerminologyExtractorCLI-tbx), [`--json`](#TerminologyExtractorCLI-json), [`--tsv`](#TerminologyExtractorCLI-tsv) must be set.
</div>

###### `--tsv-hide-headers` *(no arg)*
{: id="TerminologyExtractorCLI-tsv-hide-headers"}


 > Hide column headers


<div class="alert alert-warning" role="alert">
**Warning:** This option can only be set when option [`--tsv`](#TerminologyExtractorCLI-tsv) is already set.
</div>

###### `--tsv-hide-variants` *(no arg)*
{: id="TerminologyExtractorCLI-tsv-hide-variants"}


 > Does no show the variants for each term


<div class="alert alert-warning" role="alert">
**Warning:** This option can only be set when option [`--tsv`](#TerminologyExtractorCLI-tsv) is already set.
</div>

###### `--tsv-properties` STRING
{: id="TerminologyExtractorCLI-tsv-properties"}


 > The comma-separated list columns of the tsv file. Allowed values are: [`rank`]({{site.baseurl_root}}/documentation/properties/#TermProperty-rank), [`isSingleWord`]({{site.baseurl_root}}/documentation/properties/#TermProperty-swt), [`documentFrequency`]({{site.baseurl_root}}/documentation/properties/#TermProperty-dfreq), [`frequencyNorm`]({{site.baseurl_root}}/documentation/properties/#TermProperty-f_norm), [`generalFrequencyNorm`]({{site.baseurl_root}}/documentation/properties/#TermProperty-gf_norm), [`specificity`]({{site.baseurl_root}}/documentation/properties/#TermProperty-spec), [`frequency`]({{site.baseurl_root}}/documentation/properties/#TermProperty-freq), [`OrthographicScore`]({{site.baseurl_root}}/documentation/properties/#TermProperty-ortho), [`IndependantFrequency`]({{site.baseurl_root}}/documentation/properties/#TermProperty-ifreq), [`Independance`]({{site.baseurl_root}}/documentation/properties/#TermProperty-ind), [`pilot`]({{site.baseurl_root}}/documentation/properties/#TermProperty-pilot), [`lemma`]({{site.baseurl_root}}/documentation/properties/#TermProperty-lemma), [`tf-idf`]({{site.baseurl_root}}/documentation/properties/#TermProperty-tfidf), [`spec-idf`]({{site.baseurl_root}}/documentation/properties/#TermProperty-specidf), [`groupingKey`]({{site.baseurl_root}}/documentation/properties/#TermProperty-key), [`pattern`]({{site.baseurl_root}}/documentation/properties/#TermProperty-pattern), [`spottingRule`]({{site.baseurl_root}}/documentation/properties/#TermProperty-rule), [`isFixedExpression`]({{site.baseurl_root}}/documentation/properties/#TermProperty-fixed_exp), [`SwtSize`]({{site.baseurl_root}}/documentation/properties/#TermProperty-swtSize), [`Filtered`]({{site.baseurl_root}}/documentation/properties/#TermProperty-filtered), [`Depth`]({{site.baseurl_root}}/documentation/properties/#TermProperty-depth), [`VariationRank`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-vrank), [`VariationRule`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-vrules), [`DerivationType`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-dtype), [`GraphSimilarity`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-graphSim), [`Score`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-vScore), [`AffixGain`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-affGain), [`AffixSpec`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-affSpec), [`AffixRatio`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-affRatio), [`AffixScore`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-affScore), [`NormalizedAffixScore`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-normAffScore), [`AffixOrthographicScore`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-affOrtho), [`ExtensionScore`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-extScore), [`NormalizedExtensionScore`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-normExtScore), [`HasExtensionAffix`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-hasExtAffix), [`IsExtension`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-isExt), [`VariantBagFrequency`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-vBagFreq), [`SourceGain`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-srcGain), [`NormalizedSourceGain`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-normSrcGain), [`IsInfered`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-isInfered), [`IsGraphical`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-isGraph), [`IsDerivation`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-isDeriv), [`IsPrefixation`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-isPref), [`IsSyntagmatic`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-isSyntag), [`IsMorphological`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-isMorph), [`IsSemantic`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-isSem), [`Distributional`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-distrib), [`SemanticSimilarity`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-semSim), [`Dico`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-isDico), [`SemanticScore`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-semScore)


<div class="alert alert-warning" role="alert">
**Warning:** This option can only be set when option [`--tsv`](#TerminologyExtractorCLI-tsv) is already set.
</div>

###### `--watch` TERM_LIST
{: id="TerminologyExtractorCLI-watch"}


 > List of terms (grouping keys or lemmas) to log to output




### PreprocessorCLI
{: id="PreprocessorCLI"}

#### Usage

```
java [-Xms256m -Xmx8g] -cp termsuite-core-3.0.jar \
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



###### [`--json`](#PreprocessorCLI-json), [`--tsv-anno`](#PreprocessorCLI-tsv-anno), [`--xmi-anno`](#PreprocessorCLI-xmi-anno), [`--json-anno`](#PreprocessorCLI-json-anno)


<div class="alert alert-warning" role="alert">
At least one option in [`--json`](#PreprocessorCLI-json), [`--tsv-anno`](#PreprocessorCLI-tsv-anno), [`--xmi-anno`](#PreprocessorCLI-xmi-anno), [`--json-anno`](#PreprocessorCLI-json-anno) must be set.
</div>



#### Other options

###### `--encoding`, `-e` ENC
{: id="PreprocessorCLI-encoding"}


 > Encoding of the input corpus

###### `--json` FILE
{: id="PreprocessorCLI-json"}


 > Path to JSON indexed corpus file where all occurrences are imported to


<div class="alert alert-warning" role="alert">
**Warning:** At least one option in [`--json`](#PreprocessorCLI-json), [`--tsv-anno`](#PreprocessorCLI-tsv-anno), [`--xmi-anno`](#PreprocessorCLI-xmi-anno), [`--json-anno`](#PreprocessorCLI-json-anno) must be set.
</div>

###### `--json-anno` DIR
{: id="PreprocessorCLI-json-anno"}


 > Path to JSON export directory of all spotted term annotations


<div class="alert alert-warning" role="alert">
**Warning:** At least one option in [`--json`](#PreprocessorCLI-json), [`--tsv-anno`](#PreprocessorCLI-tsv-anno), [`--xmi-anno`](#PreprocessorCLI-xmi-anno), [`--json-anno`](#PreprocessorCLI-json-anno) must be set.
</div>

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
**Warning:** At least one option in [`--json`](#PreprocessorCLI-json), [`--tsv-anno`](#PreprocessorCLI-tsv-anno), [`--xmi-anno`](#PreprocessorCLI-xmi-anno), [`--json-anno`](#PreprocessorCLI-json-anno) must be set.
</div>

###### `--watch` TERM_LIST
{: id="PreprocessorCLI-watch"}


 > List of terms (grouping keys or lemmas) to log to output

###### `--xmi-anno` DIR
{: id="PreprocessorCLI-xmi-anno"}


 > Path to XMI export directory of all spotted term annotations


<div class="alert alert-warning" role="alert">
**Warning:** At least one option in [`--json`](#PreprocessorCLI-json), [`--tsv-anno`](#PreprocessorCLI-tsv-anno), [`--xmi-anno`](#PreprocessorCLI-xmi-anno), [`--json-anno`](#PreprocessorCLI-json-anno) must be set.
</div>




### AlignerCLI
{: id="AlignerCLI"}

#### Usage

```
java [-Xms256m -Xmx8g] -cp termsuite-core-3.0.jar \
	 fr.univnantes.termsuite.tools.AlignerCLI OPTIONS
```

#### Description

Translates domain-specific terms in multiligual comparable corpora from given language to given target language.

#### Mandatory options

###### `--source-termino` FILE
{: id="AlignerCLI-source-termino"}


 > The source terminology (indexed corpus)

###### `--target-termino` FILE
{: id="AlignerCLI-target-termino"}


 > The source terminology (indexed corpus)

###### `--dictionary` FILE
{: id="AlignerCLI-dictionary"}


 > The path to the bilingual dictionary to use for bilingual alignment



###### [`--term`](#AlignerCLI-term), [`--term-list`](#AlignerCLI-term-list)


<div class="alert alert-warning" role="alert">
Exactly one option in [`--term`](#AlignerCLI-term), [`--term-list`](#AlignerCLI-term-list) must be set.
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
**Warning:** Exactly one option in [`--term`](#AlignerCLI-term), [`--term-list`](#AlignerCLI-term-list) must be set.
</div>

###### `--term-list` FILE
{: id="AlignerCLI-term-list"}


 > The path to a list of source terms (lemmas or grouping keys) to translate


<div class="alert alert-warning" role="alert">
**Warning:** Exactly one option in [`--term`](#AlignerCLI-term), [`--term-list`](#AlignerCLI-term-list) must be set.
</div>

###### `--tsv` FILE
{: id="AlignerCLI-tsv"}


 > A file path to write output of the bilingual aligner
