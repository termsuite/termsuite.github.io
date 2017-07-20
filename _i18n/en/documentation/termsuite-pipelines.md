
TermSuite is a tool for working on domain-specific term. It implements two major features: **Terminology extraction** and **Bilingual alignment**. This page gives an overview of their architectures.

* TOC
{:toc}

### Terminology Extraction (Steps 1 and 2)
{:id=terminology-extraction}

Terminology extraction is the process of producing an exhaustive list of domain-specific
terms from a corpus of textual documents dealing with this domain.


![TermSuite general data flow](/img/flow-preprocessor-extractor.png)

As show by the figure above, terminology extraction is a two-step process:

 1. [**Step 1. Preprocessor****](#preprocessor): every textual document of the corpus is analyzed
by an UIMA-based NLP (*Natural Language Processing*) pipeline that spots all candidate terms
in the document.
 1. [**Step 2. TerminologyExtractor**](#terminology-extraction-step-2): spotted terms are analyzed, gathered, filtered,
and ranked by specificity to the domain.

The preprocessed documents produced by *Preprocessor* comes out as a corpus of [UIMA](http://uima.apache.org/) annotations, called a *prepared corpus*,  in [XMI](http://www.omg.org/spec/XMI/) or JSON. The *TerminologyExtractor* is a pipeline that operates on a terminology structure. The process of transforming a prepared corpus into a terminology is named [*term importation*](#term-importation) and consists in gathering all occurrences of the same term key into a single terminology structure.

#### Step 1: Preprocessor
{:id=preprocessor}

Preprocessing is the process of transforming a text, i.e. a *String* data, into a list of UIMA annotations, including term occurrences. It is a mandatory step before terminology extraction, but you can reuse TermSuite natural language preprocessings in any other application context (not only on terminology extraction).

![TermSuite preprocessor pipeline](/img/pipeline-preprocessor.png)

The framework used by TermSuite for its NLP pipeline is [UIMA](https://uima.apache.org/). See [TermSuite UIMA Type System]({{site.baseurl}}/documentation/data-model/#type-system) to get an idea on how the tokens (UIMA annotations) are modelled within TermSuite.


##### Word tokenizer

Transforms a text, i.e. a *String*, into a list of *tokens*, i.e. words and punctuations. TermSuite ships its own UIMA tokenizer.

{% termsuite_module title: "UIMA tokenizer", source: "https://github.com/JuleStar/uima-tokenizer", SegmentBank: "en/english-segment-bank.xml" %}

##### POS Tagger and Lemmatizer
 of a term,
The *POS Tagger* attributes a syntactic label to each token. The *Lemmatizer* sets the *lemma* of each word.

POS tagging and lemmatizing are often performed together in the same module. There are two POS taggers/lemmatizers supported by TermSuite:

 1. [TreeTagger](http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/), (default)
 2. [Mate](http://www.ims.uni-stuttgart.de/forschung/ressourcen/werkzeuge/matetools.html).

These bricks need to be installed apart from TermSuite. See [how to install POS tagger/lemmatizer]({{site.baseurl}}/documentation/postagger/) in TermSuite.

For TreeTagger:

{% termsuite_module title: "TreeTagger UIMA wrapper", source: "https://github.com/JuleStar/uima-tree-tagger-wrapper", TreeTaggerConfig: "en/tagging/tree-tagger/english-treetagger.xml" %}

For Mate:

{% termsuite_module title: "Mate UIMA wrapper", source: "https://github.com/termsuite/termsuite-core/blob/master/src/main/java/fr/univnantes/termsuite/uima/engines/preproc/MateLemmatizerTagger.java" %}

##### Tag normalization

*Normalizing* is the process of translating each POS tag into MULTEXT universel tag set.

When TreeTagger is used:

{% termsuite_module title: "TreeTagger UIMA normalizer", source: "https://github.com/JuleStar/uima-mapper", CategoryMapping: "en/tagging/tree-tagger/english-tt-category-mapping.xml", SubCategoryMapping: "en/tagging/tree-tagger/english-tt-subcategory-mapping.xml", TenseMapping: "en/tagging/tree-tagger/english-tt-tense-mapping.xml", MoodMapping: "en/tagging/tree-tagger/english-tt-mood-mapping.xml", GenderMapping: "en/tagging/tree-tagger/english-tt-gender-mapping.xml", NumberMapping: "en/tagging/tree-tagger/english-tt-number-mapping.xml", CaseMapping: "en/tagging/tree-tagger/english-tt-case-mapping.xml" %}

When Mate is used:

{% termsuite_module title: "Mate UIMA normalizer", source: "https://github.com/JuleStar/uima-mapper", CategoryMapping: "en/tagging/tree-tagger/english-mate-category-mapping.xml", SubCategoryMapping: "en/tagging/tree-tagger/english-mate-subcategory-mapping.xml", TenseMapping: "en/tagging/tree-tagger/english-mate-tense-mapping.xml", MoodMapping: "en/tagging/tree-tagger/english-mate-mood-mapping.xml", GenderMapping: "en/tagging/tree-tagger/english-mate-gender-mapping.xml", NumberMapping: "en/tagging/tree-tagger/english-mate-number-mapping.xml", CaseMapping: "en/tagging/tree-tagger/english-mate-case-mapping.xml" %}


##### Stemmer

*Stemming* is the process of extracting the stem form of each word. TermSuite ships its own UIMA stemmer, implementing [Snowball](http://snowball.tartarus.org/).

{% termsuite_module title: "UIMA Snowball Stemmer", source: "https://github.com/JuleStar/uima-stemmer" %}


##### Term Spotter
{:id=term-spotter}

*Term spotting* is the process of parsing a sequence of words and detecting wich subsequences are term occurrences. TermSuite performs pattern-based multi-word term spotting with the help of [UIMA Tokens Regex](https://github.com/JuleStar/uima-tokens-regex) engine and a list of regex rules on UIMA annotations. *UIMA Tokens Regex* is a generic regex rule system for sequential UIMA annotations. It has been designed and implemented especially with the goels of TermSuite in mind.  

{% termsuite_module title: "Term Spotter", source: "https://github.com/JuleStar/uima-tokens-regex", MultiWordRegexRules: "en/english-multi-word-rule-system.regex" %}

Multi-word term detection in TermSuite is rule-based, based on syntactic term patterns. Each supported language has its own exhaustive list of allowed term patterns. Read [UIMA Tokens Regex documentation](https://github.com/JuleStar/uima-tokens-regex) and [TermSuite demo paper at ACL](https://aclweb.org/anthology/P/P16/P16-4003.pdf) for more information about this process.

#### Importation of spotted terms into terminology
{:id=term-importation}

Once the preprocessor has operated on all documents of the corpus, all their spotted term occurrences must be grouped into one single place: the terminology. This step is called *Importation*.

The *importation* consists in iterating on all spotted term occurrences of all documents. Two different occurrences are said to belong to the same term if they share the same *grouping key*. The grouping key is defined as the concatenation of the syntactic *pattern* of the and its word *lemmas*. For example:

 * `n: blade`: possible forms of spotted occurrences for this term could be *blade*, *blades*, *Blade*, etc.
 * `nn: rotor blade`: possible forms of spotted occurrences for this term could be *rotor blade*, *rotor blades*, etc.
 * `npn: energy of wind`: possible forms of spotted occurrences for this term could be *energy of wind*, *energy of the wind*. As you can see, determiners like *the* are ignored when it comes to grouping occurrences under the same term pattern.

With [command line API]({{site.baseurl}}/documentation/command-line-api), this importation phase between preprocessing and terminology extraction is operated automatically either:

 1. at the end of the preprocessing phase when the user launches the `PreprocessorCLI` script with option `--json PATH`,
 2. or at the beginning of ther terminology extraction phase when the user launches the `TerminologyExtractorCLI` script with either option `--from-prepared-corpus PATH`, meaning that *PATH* points to a directory containing prepared documents files (`*.xmi` or `*.json`) that are the output of `PreprocessorCLI` when run with option `--xmi-anno PATH` or `--json-anno PATH`.   
 3. Or at the middle of the preprocessing+extraction phase when the user launches the `TerminologyExtractorCLI` with option `--from-text-corpus PATH`, meaning that TermSuite first runs a preprocessor internally, then import spotted occurrences to a terminology, and finally runs the terminology extraction process on that terminology.

With [Java API]({{site.baseurl}}/documentation/java-api), the importation phase can also be performed manually.


#### Step 2: Terminology extraction
{:id=terminology-extraction-step-2}

The *terminology extraction* consists in taking as input an [imported terminology](#term-importation) an applying the folowing pipeline:

![TermSuite terminology extractor pipeline](/img/pipeline-extractor.png)

This global extraction pipeline is implemented in class [TerminologyExtractorEngine](https://github.com/termsuite/termsuite-core/blob/master/src/main/java/fr/univnantes/termsuite/engines/TerminologyExtractorEngine.java).

##### Preparator
{:id=preparator}

The *Preparator* operates a series of simple actions on the terminology that are required for later steps of the terminology extraction:

 * validition of the input terminology,
 * computation of some term properties, including *specificity*, *lemma*, *pilot*, *document frequency*, *swtSize*,
 * computation of some term relations, including *extensions*, (see [Terminology Data Model]({{site.baseurl}}/documentation/data-model)).

{% termsuite_module title: "Terminology Preparator", source: "https://github.com/termsuite/termsuite-core/blob/master/src/main/java/fr/univnantes/termsuite/engines/prepare/TerminologyPreparator.java", GeneralLanguageResource: "https://github.com/termsuite/termsuite-core/blob/master/src/main/resources/fr/univnantes/termsuite/resources/en/english-general-language.txt" %}

##### Contextualizer
{:id=contextualizer}

The *Contextualizer* produces a context vector for each single-word term. It requires no linguistic resource. Term occurrences of each term are required for contextualization.

{% termsuite_module title: "Terminology Preparator", source: "https://github.com/termsuite/termsuite-core/blob/master/src/main/java/fr/univnantes/termsuite/engines/contextualizer/Contextualizer.java" %}

##### Pre-gathering cleaner
{:id=pre-gathering-cleaner}

The *Pre-gathering cleaner* is a hook allowing the user to configure a terminology filtering **before** the term gathering process is performed. The interest of filtering **before** the term variant gathering is that  

{% termsuite_module title: "TerminologyCleaner", source: "https://github.com/termsuite/termsuite-core/blob/master/src/main/java/fr/univnantes/termsuite/engines/cleaner/TerminologyCleaner.java" %}

See `--pre-filter-*` options of [command line API]({{site.baseurl}}/documentation/terminology-extractor-cli/) in order to configure the pre-gathering filter.

##### Morphological Splitter
{:id=morphological-splitter}

The **Morphological Splitter** analyzes the morphology of every single-word term and splits it when compound. The **Morphological Splitter** is an aggregation of several modules.

 * The *PrefixSplitter* detects prefixes and splits terms accordingly.

{% termsuite_module title: "PrefixSplitter", source: "https://github.com/termsuite/termsuite-core/blob/master/src/main/java/fr/univnantes/termsuite/engines/splitter/PrefixSplitter.java", PrefixBank: "fr/morphology/french-prefix-bank.txt", PrefixExceptions: "fr/morphology/french-prefix-exceptions.txt"%}

 * The *ManualSplitter* detects word composition based on a known list of word composition and splits terms accordingly.

{% termsuite_module title: "ManualPrefixSetter", source: "https://github.com/termsuite/termsuite-core/blob/master/src/main/java/fr/univnantes/termsuite/engines/splitter/PrefixSplitter.java", ManualCompositions: "fr/morphology/french-prefix-bank.txt", PrefixExceptions: "fr/morphology/french-manual-composition.txt"%}

 * The *SuffixDerivationDetecter* detects derivations based on list of language-specific derivation rules and splits terms accordingly:

 {% termsuite_module title: "PrefixSplitter", source: "https://github.com/termsuite/termsuite-core/blob/master/src/main/java/fr/univnantes/termsuite/engines/splitter/PrefixSplitter.java", SuffixDerivations: "fr/morphology/french-suffix-derivation-bank.txt", SuffixDerivations: "fr/morphology/french-suffix-derivation-bank.txt", SuffixDerivationExceptions: "fr/morphology/french-suffix-derivation-exceptions.txt" %}

 * The *NativeSplitter* detects derivations based on list of language-specific derivation rules and splits terms accordingly. It implements the method [ComPost](https://hal.archives-ouvertes.fr/hal-01116134/document). The *NativeSplitter* is the one responsible for detecting neoclassical compounds.

 {% termsuite_module title: "NativeSplitter", source: "https://github.com/termsuite/termsuite-core/blob/master/src/main/java/fr/univnantes/termsuite/engines/splitter/NativeSplitter.java", CompostInflectionRules: "fr/morphology/french-compost-inflection-rules.txt", CompostTransformationRules: "fr/morphology/french-compost-transformation-rules.txt", NeoclassicalPrefixes: "fr/morphology/french-neoclassical-prefixes.txt", CompostStopList: "fr/morphology/french-compost-stop-list.txt", CompostDico: "fr/french-dico.txt" %}

##### Term Gatherer
{:id=term-gatherer}

The **Term Gatherer** is in charge of grouping terms with their variants. It is based on a list of variation rules. The term gatherer is also an aggregated engine. It is composed of several subengines.

 * The *PrefixationGatherer* detects variations based on prefixes compositions of some terms (extracted at *Morphological Splitter* phase by *PrefixSplitter*)

{% termsuite_module title: "PrefixationGatherer", source: "https://github.com/termsuite/termsuite-core/blob/master/src/main/java/fr/univnantes/termsuite/engines/gatherer/PrefixationGatherer.java", YamlVariantionRules: "fr/french-variants.yaml" %}

* The *DerivationGatherer* detects variations based on derivation relations extracted by *DerivationSplitter*

{% termsuite_module title: "DerivationGatherer", source: "https://github.com/termsuite/termsuite-core/blob/master/src/main/java/fr/univnantes/termsuite/engines/gatherer/DerivationGatherer.java", YamlVariantionRules: "fr/french-variants.yaml" %}


* The *MorphologicalGatherer* detects variations based on native and neoclassical compositions (extracted at *Morphological Splitter* phase by *NativeSplitter*)

{% termsuite_module title: "MorphologicalGatherer", source: "https://github.com/termsuite/termsuite-core/blob/master/src/main/java/fr/univnantes/termsuite/engines/gatherer/MorphologicalGatherer.java", YamlVariantionRules: "fr/french-variants.yaml" %}

* The *SyntagmaticGatherer* detects all other type of syntagmatic variations that do not require special processing like prefixes, derivations, synonyms, and morphological compounds.

{% termsuite_module title: "SyntagmaticGatherer", source: "https://github.com/termsuite/termsuite-core/blob/master/src/main/java/fr/univnantes/termsuite/engines/gatherer/SyntagmaticGatherer.java", YamlVariantionRules: "fr/french-variants.yaml" %}


* The *SemanticGatherer* detects semantic variants from a list of synonymic rules based on both a distributional approach and a dictionary.

{% termsuite_module title: "SemanticGatherer", source: "https://github.com/termsuite/termsuite-core/blob/master/src/main/java/fr/univnantes/termsuite/engines/gatherer/SemanticGatherer.java", YamlVariantionRules: "fr/french-variants.yaml", Synonyms: "fr/french-synonyms.txt" %}

* The *ExtensionVariantGatherer* gather long terms with their variants using inference on term extensions and variations for shorter terms.

{% termsuite_module title: "ExtensionVariantGatherer", source: "https://github.com/termsuite/termsuite-core/blob/master/src/main/java/fr/univnantes/termsuite/engines/gatherer/ExtensionVariantGatherer.java"%}

* The *GraphicalGatherer* gathers terms having a small edition distance.

{% termsuite_module title: "GraphicalGatherer", source: "https://github.com/termsuite/termsuite-core/blob/master/src/main/java/fr/univnantes/termsuite/engines/gatherer/GraphicalGatherer.java"%}

* The *TermMerger* merges some terms with their variants each time the variation is not relevant. A variation is not relevant when its graphical similarity is 1 or when the variant's frequency is 1 or 2.

{% termsuite_module title: "GraphicalGatherer", source: "https://github.com/termsuite/termsuite-core/blob/master/src/main/java/fr/univnantes/termsuite/engines/gatherer/TermMerger.java"%}


##### Post-gathering cleaner
{:id=post-geathering-cleaner}

The *Post-gathering cleaner* is a hook allowing the user to configure a terminology filtering **after** the term gathering process has been performed. The interest of filtering after term gathering is to keep terms that would not pass the filter normally but that are variants of base terms that we want to keep.

{% termsuite_module title: "TerminologyCleaner", source: "https://github.com/termsuite/termsuite-core/blob/master/src/main/java/fr/univnantes/termsuite/engines/cleaner/TerminologyCleaner.java" %}

See `--post-filter-*` options of [command line API]({{site.baseurl}}/documentation/terminology-extractor-cli/) in order to configure the pre-gathering filter.

##### PostProcessor
{:id=post-processor}

The *post-processor* filters terms and variations based on information derived from the gathering process. It works with no linguistic resources. It is also an aggregated engine, composed of the following subengines.

 * [IndependanceScorer](https://github.com/termsuite/termsuite-core/blob/master/src/main/java/fr/univnantes/termsuite/engines/postproc/IndependanceScorer.java)
 * [OrthographicScorer](https://github.com/termsuite/termsuite-core/blob/master/src/main/java/fr/univnantes/termsuite/engines/postproc/OrthographicScorer.java)
 * [VariationScorer](https://github.com/termsuite/termsuite-core/blob/master/src/main/java/fr/univnantes/termsuite/engines/postproc/VariationScorer.java)
 * [ThresholdExtensionFilterer](https://github.com/termsuite/termsuite-core/blob/master/src/main/java/fr/univnantes/termsuite/engines/postproc/ThresholdExtensionFilterer.java)
 * [VariationFiltererByScore](https://github.com/termsuite/termsuite-core/blob/master/src/main/java/fr/univnantes/termsuite/engines/postproc/VariationFiltererByScore.java)
 * [TwoOrderVariationMerger](https://github.com/termsuite/termsuite-core/blob/master/src/main/java/fr/univnantes/termsuite/engines/postproc/TwoOrderVariationMerger.java)
 * [TermFiltererByScore](https://github.com/termsuite/termsuite-core/blob/master/src/main/java/fr/univnantes/termsuite/engines/postproc/TermFiltererByScore.java)
 * [VariationRanker](https://github.com/termsuite/termsuite-core/blob/master/src/main/java/fr/univnantes/termsuite/engines/postproc/VariationRanker.java)


### Bilingual Alignment (Step 3)
{:id=alignment}

Finding the best translation of a domain-specific *source term* into a *target* language is called *bilingual alignement*. Domain-specific bilingual alignement in TermSuite requires:

 * a **bilingual dictionary** from the *source* language to the *target* language,
 * a **source contextualized terminology**, i.e. a terminology extracted from a corpus of the domain in *source* language,
 * a **target contextualized terminology**, i.e. a terminology extracted from a corpus of the domain in *target* language.
 * a **source term** that will be translated into *target* language.

![TermSuite aligner data flow](/img/flow-aligner.png)

Bilingual alignement of *source term* in TermSuite is the result of a multi-part and hierarchical algorithm. The *source term* can be of several types: single-word term, multi-word term, compound term, neoclassical term, etc. Depending on this type, the [alignment method]({{site.baseurl}}/documentation/alignment/) invoked by TermSuite is not the same.

See also:

 * [aligner command line API]({{site.baseurl}}/documentation/aligner-cli/) to learn how to launch bilingual alignment,
 * [how to extract an alignment-ready terminology with TermSuite]({{site.baseurl}}/documentation/terminology-extractor-cli/#extract-a-terminology-ready-for-alignment),
 * [theoritical insights]({{site.baseurl}}/documentation/alignment/) on different bilingual alignment methods used by the algorithm,
 * an example of [bilingual dictionary]({{site.baseurl}}/documentation/bilingual-dictionary/) required for alignment.
