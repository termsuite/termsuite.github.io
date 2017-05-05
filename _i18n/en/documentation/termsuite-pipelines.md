
TermSuite is a tool for working on domain-specific term. It implements two major features: **Terminology extraction** and **Bilingual alignment**. This page gives an overview of their architectures.

* TOC
{:toc}

### Terminology Extraction (Steps 1 and 2)
{:id=terminology-extraction}

Terminology extraction is the process of producing an exhaustive list of domain-specific
terms from a corpus of textual documents dealing with this domain.


![TermSuite general data flow](/img/flow-preprocessor-extractor.png)

As show by the figure above, terminology extraction is a two-step process:

 1. **Step 1. Preprocessor**: every textual document of the corpus is analyzed
by an UIMA-based NLP (*Natural Language Processing*) pipeline that spots all candidate terms
in the document.
 1. **Step 2. TerminologyExtractor**: spotted terms are analyzed, gathered, filtered,
and ranked by specificity to the domain.

The preprocessed documents produced by *Preprocessor* comes out as a corpus of [UIMA](http://uima.apache.org/) annotations, called a *prepared corpus*,  in [XMI](http://www.omg.org/spec/XMI/) or JSON. The *TerminologyExtractor* is a pipeline that operates on a terminology structure. The process of transforming a prepared corpus into a terminology is named [*term importation*](#term-importation) and consists in gathering all occurrences of the same term key into a single terminology structure.

#### Step 1: Preprocessor
{:id=preprocessor}

Preprocessing is the process of transforming a text, i.e. a *String* data, into a list of UIMA annotations, including term occurrences. It is a mandatory step before terminology extraction, but you can reuse TermSuite natural language preprocessings in any other application context (not only on terminology extraction).

![TermSuite preprocessor pipeline](/img/pipeline-preprocessor.png)

The framework used by TermSuite for its NLP pipeline is [UIMA](https://uima.apache.org/). See [TermSuite UIMA Type System](/documentation/data-model/#type-system) to get an idea on how the tokens (UIMA annotations) are modelled within TermSuite.


##### Word tokenizer

Transforms a text, i.e. a *String*, into a list of *tokens*, i.e. words and punctuations. TermSuite ships its own UIMA tokenizer.

{% termsuite_module title: "UIMA tokenizer", source: "https://github.com/JuleStar/uima-tokenizer", SegmentBank: "en/english-segment-bank.xml" %}

##### POS Tagger and Lemmatizer
 of a term,
The *POS Tagger* attributes a syntactic label to each token. The *Lemmatizer* sets the *lemma* of each word.

POS tagging and lemmatizing are often performed together in the same module. There are two POS taggers/lemmatizers supported by TermSuite:

 1. [TreeTagger](http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/), (default)
 2. [Mate](http://www.ims.uni-stuttgart.de/forschung/ressourcen/werkzeuge/matetools.html).

These bricks need to be installed apart from TermSuite. See [how to install POS tagger/lemmatizer](/documentation/postagger/) in TermSuite.

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




#### Step 2: Terminology extraction
{:id=terminology-extraction-step-2}

![TermSuite terminology extractor pipeline](/img/pipeline-extractor.png)


### Bilingual Alignment (Step 3)
{:id=alignment}

![TermSuite aligner data flow](/img/flow-aligner.png)

[Alignment](/documentation/alignment/)
