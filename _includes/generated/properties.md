### Term properties

#### `rank` [Integer]
{: id="TermProperty-rank"}

 > The rank of the term assigned by TermSuite post-processor engine.

#### `isSingleWord`, `isSwt` [Boolean]
{: id="TermProperty-isSwt"}

 > Wether this term is single-word or not.

#### `documentFrequency`, `dFreq` [Integer]
{: id="TermProperty-dFreq"}

 > The number of documents in corpus in which the term is occurring.

#### `frequencyNorm`, `fNorm` [Double]
{: id="TermProperty-fNorm"}

 > The number of occurrences of the term in the corpus every 1000 words.

#### `generalFrequencyNorm`, `gfNorm` [Double]
{: id="TermProperty-gfNorm"}

 > The number of occurrences of the term in the general language corpus every 1000 words.

#### `specificity`, `spec` [Double]
{: id="TermProperty-spec"}

 > The weirdness ratio, i.e. the specificity of the term in the corpus in comparison to general language.

#### `frequency`, `freq` [Integer]
{: id="TermProperty-freq"}

 > The number of occurrences of the term in the corpus.

#### `OrthographicScore`, `ortho` [Double]
{: id="TermProperty-ortho"}

 > The probability for the covered text of the term for being an actual term assigned by TermSuite post-processor engine.

#### `IndependantFrequency`, `iFreq` [Integer]
{: id="TermProperty-iFreq"}

 > The number of times a term occurrs in corpus as it is, i.e. not as any of its variant forms, assigned by TermSuite post-processor engine.

#### `Independance`, `ind` [Double]
{: id="TermProperty-ind"}

 > The [`IndependantFrequency`]({{site.baseurl_root}}/documentation/properties/#TermProperty-iFreq) divided by [`frequency`]({{site.baseurl_root}}/documentation/properties/#TermProperty-freq), assigned by TermSuite post-processor engine.

#### `pilot` [String]
{: id="TermProperty-pilot"}

 > The most frequent form of the term.

#### `lemma` [String]
{: id="TermProperty-lemma"}

 > The concatenation of the term's word lemmas.

#### `tf-idf`, `tfIdf` [Double]
{: id="TermProperty-tfIdf"}

 > [`frequency`]({{site.baseurl_root}}/documentation/properties/#TermProperty-freq) divided by `DOCUMENT_FREQUENCY`.

#### `spec-idf`, `specIdf` [Double]
{: id="TermProperty-specIdf"}

 > [`specificity`]({{site.baseurl_root}}/documentation/properties/#TermProperty-spec) divided by `DOCUMENT_FREQUENCY`.

#### `groupingKey`, `key` [String]
{: id="TermProperty-key"}

 > The unique id of the term, built on its pattern and its lemma.

#### `pattern` [String]
{: id="TermProperty-pattern"}

 > The pattern of the term, i.e. the concatenation of syntactic labels of its words.

#### `spottingRule`, `rule` [String]
{: id="TermProperty-rule"}

 > The name of the UIMA Tokens Regex spotting rule that found the term in the corpus.

#### `isFixedExpression`, `isFixedExp` [Boolean]
{: id="TermProperty-isFixedExp"}

 > Wether the term is a fixed expression.

#### `SwtSize`, `swtSize` [Integer]
{: id="TermProperty-swtSize"}

 > The number of words composing the term that are single-words.

#### `Filtered`, `isFiltered` [Boolean]
{: id="TermProperty-isFiltered"}

 > Wether the term has been marked as filtered by TermSuite post-processor engine. Usually, such a term is not meant to be displayed.

#### `Depth`, `depth` [Integer]
{: id="TermProperty-depth"}

 > The minimum level of extensions of the term starting from a single-word term.



### Relation properties

#### `VariationRank`, `vRank` [Integer]
{: id="RelationProperty-vRank"}

 > The rank of the variation among all variations starting from the same source term, when the relation is a variation.

#### `VariationRule`, `vRules` [Set]
{: id="RelationProperty-vRules"}

 > The set of YAML variation rules that detected this pair of terms as a term variation, when the relation is a variation.

#### `DerivationType`, `derivType` [String]
{: id="RelationProperty-derivType"}

 > The derivation type of the variation, when the relation is a variation.

#### `GraphSimilarity`, `graphSim` [Double]
{: id="RelationProperty-graphSim"}

 > The edition distance between the two terms of the relation.

#### `Score`, `vScore` [Double]
{: id="RelationProperty-vScore"}

 > The global variation score of the relation assigned by TermSuite post-processor engine, when the relation if a variation.

#### `AffixGain`, `affGain` [Double]
{: id="RelationProperty-affGain"}

 > When the relation is a variation of type "extension", the FREQUENCY of the variant divided by the FREQUENCY of the affix term.

#### `AffixSpec`, `affSpec` [Double]
{: id="RelationProperty-affSpec"}

 > When the relation is a variation of type "extension", the SPECIFICITY of the affix term.

#### `AffixRatio`, `affRatio` [Double]
{: id="RelationProperty-affRatio"}

 > When the relation is a variation of type "extension", the FREQUENCY of the affix term divided by the FREQUENCY of the base term.

#### `AffixScore`, `affScore` [Double]
{: id="RelationProperty-affScore"}

 > When the relation is a variation of type "extension", the weighted average of `AFFIX_GAIN` and `AFFIX_RATIO`.

#### `NormalizedAffixScore`, `nAffScore` [Double]
{: id="RelationProperty-nAffScore"}

 > When the relation is a variation of type "extension", the min-max normalization of [`AffixScore`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-affScore).

#### `AffixOrthographicScore`, `affOrtho` [Double]
{: id="RelationProperty-affOrtho"}

 > When the relation is a variation of type "extension", the orthographic score of extension affix term.

#### `ExtensionScore`, `extScore` [Double]
{: id="RelationProperty-extScore"}

 > When the relation is a variation of type "extension", the score of the extension affix term (combines [`AffixGain`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-affGain) and [`AffixGain`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-affGain)).

#### `NormalizedExtensionScore`, `nExtScore` [Double]
{: id="RelationProperty-nExtScore"}

 > When the relation is a variation of type "extension", the min-max normalization of [`ExtensionScore`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-extScore).

#### `HasExtensionAffix`, `hasExtAffix` [Boolean]
{: id="RelationProperty-hasExtAffix"}

 > When the relation is a variation of type "extension", wether there is an affix term.

#### `IsExtension`, `isExt` [Boolean]
{: id="RelationProperty-isExt"}

 > Wether this relation is an extension.

#### `VariantBagFrequency`, `vBagFreq` [Integer]
{: id="RelationProperty-vBagFreq"}

 > When the relation is a variation, the total of number of occurrences of the variant term and of variant's variant terms (order-2 variants).

#### `SourceGain`, `srcGain` [Double]
{: id="RelationProperty-srcGain"}

 > When the relation is a variation, the log10 of [`VariantBagFrequency`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-vBagFreq) divided by the FREQUENCY of the base term.

#### `NormalizedSourceGain`, `nSrcGain` [Double]
{: id="RelationProperty-nSrcGain"}

 > When the relation is a variation of type "extension", the linear normalization of [`SourceGain`]({{site.baseurl_root}}/documentation/properties/#RelationProperty-srcGain).

#### `IsInfered`, `isInfered` [Boolean]
{: id="RelationProperty-isInfered"}

 > When the relation is a variation, wether it has been infered from two other base variations.

#### `IsGraphical`, `isGraph` [Boolean]
{: id="RelationProperty-isGraph"}

 > When the relation is a variation, wether there is a graphical similarity between the two terms.

#### `IsDerivation`, `isDeriv` [Boolean]
{: id="RelationProperty-isDeriv"}

 > When the relation is a variation, wether one term is the derivation of the other.

#### `IsPrefixation`, `isPref` [Boolean]
{: id="RelationProperty-isPref"}

 > When the relation is a variation, wether one term is the prefix of the other.

#### `IsSyntagmatic`, `isSyntag` [Boolean]
{: id="RelationProperty-isSyntag"}

 > When the relation is a variation, wether it is a syntagmatic variation.

#### `IsMorphological`, `isMorph` [Boolean]
{: id="RelationProperty-isMorph"}

 > When the relation is a variation, wether the variation implies morphosyntactic variations.

#### `IsSemantic`, `isSem` [Boolean]
{: id="RelationProperty-isSem"}

 > When the relation is a variation, wether there is a semantic similarity between the two terms.

#### `Distributional`, `isDistrib` [Boolean]
{: id="RelationProperty-isDistrib"}

 > When the relation is a semantic relation, wheter the relation is of type "distributional", i.e. the variation has been found by context vector alignment.

#### `SemanticSimilarity`, `semSim` [Double]
{: id="RelationProperty-semSim"}

 > When the relation is a semantic variation found by alignment, the similarity of the two context vectors of the two terms of the relation.

#### `Dico`, `isDico` [Boolean]
{: id="RelationProperty-isDico"}

 > When the relation is a semantic relation, wheter the relation is of type "dictionary", i.e. the variation has been found with a synonymic dico.

#### `SemanticScore`, `semScore` [Double]
{: id="RelationProperty-semScore"}

 > When the relation is a semantic variation, the score of pertinency of the variation. This property is set for all types of semantic variations, both from dico and distributional.
