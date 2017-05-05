---
layout: page
title: global.changelog
permalink: /changelog/
excerpt: excerpt.changelog
---

## Next version (3.0)

 * TermSuite will now require Java 8
 * Detection of synonimic variations
 * Improve multilingual alignment results for complex terms and compounds

## Version 2.3

Version 2.3 focuses on migrating to Java 8 and facilitation the use of TermSuite by simplifying the
Java API and improving the documentation of TermSuite in french and english.

 * Require Java 8,
 * Possibility to use TermSuite only as text preprocessor (tokenizer, tagger, lemmatizer, stemmer, filters),
 * New simplified Java API,
 * Linguistic resources are embedded by default,
 * Improved test coverage,
 * Extension of linguistic specification for derivates and prefix variation to `en`.


## Version 2.2

TermSuite 2.2 is the last version supporting Java 7. Next TermSuite version will require Java 8.

 * [#51](https://github.com/termsuite/termsuite-core/issues/51) Reorganized TermSuite resources (see [TermSuite Resources](https://github.com/termsuite/termsuite-resources) on Github)
 * [#48](https://github.com/termsuite/termsuite-core/issues/48) Support detection of derivative variations
 * [#49](https://github.com/termsuite/termsuite-core/issues/49) Implement prefix exceptions in prefix splitting
 * [#54](https://github.com/termsuite/termsuite-core/issues/54) Update variation rules with prefix detection and derivatives detection
 * [#46](https://github.com/termsuite/termsuite-core/issues/46) Possibility to add custom UIMA AE and CollectionReader to TermSuitePipeline
 * [#41](https://github.com/termsuite/termsuite-core/issues/41) Serialize and deserialize TermSuite tokens (the UIMA CAS) to `json` (thanks to Simon Méoni)
 * [#42](https://github.com/termsuite/termsuite-core/issues/42) Fixed expression detection
 * [#43](https://github.com/termsuite/termsuite-core/issues/43) Added support for [ISTEX API](https://api.istex.fr/documentation/) as a collection reader.
 * [#71](https://github.com/termsuite/termsuite-core/issues/71) Improved morphosyntactic analysis performances
  * Several bug fixes. See [issues](https://github.com/termsuite/termsuite-core/milestone/2?closed=1) on Github.

In TermSuite GUI:

 * Some bug fixes and minor UI improvements [issues](https://github.com/termsuite/termsuite-ui/issues?q=is%3Aissue+is%3Aclosed)
 * Improved alignment performances (improved response time and support for multi-word terms and compounds)

### Warnings

 * Version 2.2 has abandonned support of TEI corpus, due to [issue #24](https://github.com/termsuite/termsuite-core/issues/24)

## Version 2.1

 * Graphical User Interface
 * Observable pipelines
 * uima profiler dependency removed
 * Added a streaming-API (beta)
 * Exportable annotations to JSON
 * Support for compositional and semi-distributional aligner back
 * Morphosyntactic analysis: added lemmatization of components
 * Allow the capping of terminology from TermSuiteTerminoCLI with options `periodic-filter-property` `periodic-filter-max-size`.
 * Scalabilty : can now handle big corpus with MongoDB
 * Changed the IO API. See JsonTermIndexIO class
 * Removed term index measures
 * Added `specificity` term property
 * Added `rank` term property
 * Added ranker AE
 * Added Merger AE
 * Added Scorer AE (scores variations)

## Version 2.0

Version 2.0 is a major release.

<div class="alert alert-warning" role="alert">
  IMPORTANT 1: In 2.0, there is no more the distinction between the `Spotter` and the `Indexer` phases. They have been merged into one unique highly configurable `Termino` pipeline.  
</div>

#### Broken until 2.1

* Graphical User Interface

#### New Features

* Added support for Mate POS Tagger and Lemmatizer (`en` and `fr` only) in addition to TreeTagger.
* Major refactoring of TermSuite's data model. See [[TermSuiteDataModel]]
* Simplified TermSuite Type system (see [[TermSuiteDataModel]] for details)
* Dropped all UIMA XML resource description. Moved to uimaFit completely.
* Splitted the huge TermSuite's Gradle multi-project config into separate and independant Github/Maven projects.
* Published TermSuite and all its dependant subprojects as Maven artefacts.
* Moved source code and documentation to Github and Github's wiki.
* Added AE primary occurrence detector.
* Added AE for term class grouping.
* Added AE for producing tsv variant evaluation files.
* TSV Export AE made configurable. (you can select the Term properties you want to get in your TSV)
* Added Morphology analysis. (with CompostAE)
* Improved syntactic variant resources + supportfor morphosyntactic variants detection.
* Improved and debugged Weirdness Ratio (old specificity) computing (`GeneralLanguage.*` resources being retrained on larger corpus with new TermSuite standards)
* Migrated syntactic variant resources from `*.groovy` to `*.yaml` (beatter readability + improved rule indexing and more efficient rule matching detection)
* Added JSON Serializing for terminologies. Now terminologies can be saved into `*.json` and loaded from `*.JSON`.
* Terminology export in `*.xmi` format in not supported anymore. (`*.xmi` terminology files were too big, not human readable, and Exporter/Parser were too slow)
* Added several `JUnit` tests for several AEs and intelligent helper methods.

## Version 1.6

<div class="alert alert-warning" role="alert">
  IMPORTANT : The new default encoding for TreeTagger resource interpretation in TermSuite is UTF-8. Please make sure that all your TreeTagger models are UTF-8 encoded.
</div>

#### New features

* Clean UIMA multi-word terms based on a per-leanguage allowed characters list
* New UIMA AE for rule-based pattern detection : UIMA Tokens Regex (with tests and doc)
* New UIMA AE for term gathering : GroovyMultiWordGatherer
* Add script TermSuiteTerminoCLI for terminology extraction in TermSuite (with spotting and gathering rules as parameter)
* ADD CollectionReader and SimplePipeline TermSuite launchers.
* Debugged Txt collection reading : some annoying characters are replaced (annoying apostrophes, annoying unsual whitespaces, etc)
* ADD 2 collection readers : StringCollectionReader (for inline TerminoCLI) and TEI CollectionReader (for corpora in tei format)
More stats and examples about term spotting and gathering in TermSuite's logs.

#### Bug fixes/enhancements

###### Spotter

* Integration of uimaFit : all spotter AE refactored into uimaFit + uimaFit launcher for launcher
* Faster and multi-word term spotting with UIMA Tokens Regex for 4 languages : fr, en, de, ru
* Easier definition of multi-word term rules with UIMA Tokens Regex for 4 languages : fr, en, de, ru
* Faster AE for single word term spotting : eu.project.ttc.engines.SingleWordTermSpotter for all languages
* Easier definition of singler-word term rules with eu.project.ttc.engines.SingleWordTermSpotter for all languages

###### Indexer

* Faster and multi-word term gathering with UIMA Tokens Regex for two languages : fr, en
* Easier definition of multi-word term rules with UIMA Tokens Regex for two languages : fr, en

###### Aligner

* Debugged script TermSuiteAlignerCLI

## Version 1.5

2014/03/17: Updated of the UserGuide TermSuite 1.5

#### New features

* New GUI, improved wording and software architecture.
* Improved scalabilty, TermSuite can handle large corpora of several millions of words.
* Moved to gradle build tool.
* Moved to git based repository.

###### Spotter

* Added TSV output as an option
* List of occurrences with frequencies in TBX output
* Added menu for loading existing processed data on the spotter results view.

#### Bug fixes/enhancements

* Several small bugfixes and enhancements.
* New tabbed menus for parameters.

###### Indexer

* Several menus to distinguish between different parameters
* Variant detection parameters were separated for better comprehension

###### Aligner

* Separation of parameters in basic and advanced options.
* The different alignment methods were clearly separated in different options.

## Version 1.4

#### New features

* TSV output for spotter, indexer, aligner
* File parameters for input of CLI
* User manual (pdf format) to be downloaded
* Java program to prepare the directory of terms to be translated as input of the Aligner

###### Indexer

* Pilot form in TBX output
* List of occurrences with frequencies in TBX output

###### Aligner

* compositional and semi-compositional methods added for MWT alignment

#### Bug fixes/enhancements

###### Indexer


* Added the Chinese general lexicon required for specificity calculation
* Enhanced MWT recognition rules for Ru/Lv/Es
* Enhanced MWT conflation rules for Ru/Lv/Es

## Version 1.3

#### New features

* langSet identifier added in the XMI files

###### Indexer

* Dissociation of XMI files (input of the aligner) and TBX files (output of the monolingual terminology extraction)
* Detection of graphic variants for MWTs (Ignore Diacritics in Conflation settings)
* New diacritics-insensitive edit distance in Conflation settings
* Specifity score in TBX output
* Verbs and other categories removed from TBX output (unless Keep verbs and others is specified)
* Statistical filtering of monolingual candidates: by cut-off rank (e.g. top-100, top-250, etc.) or threshold.
* TBX candidates are ranked according to the filter criteria, or alphabetically if no filtering is done.

###### Aligner

* Bilingual TBX output following specifications
* Cut-off rank for translation candidates in bilingual output

#### Bug fixes/enhancements

* Progress bar color forced to green
* Windows shell CLI fixed

###### Indexer

* Parameter group support for indexer settings (Advanced settings/TBX settings)
* Added the Latvian and Spanish general lexicons required for specificity calculation (the Latvian lexicon needs to be cleaned)
* Enhanced MWT recognition rules for En/Fr/De
* Enhanced MWT conflation rules for En/Fr/De
* Fail-fast edit distances

## Version 1.2

* graphical interface improved
* Latvian processing improved
* Chinese processing improved

## Version 1.1

* compound and multi-word alignment compositional method improved
* term conflation improved (no more extensions)
* result displays refactorized in tabbed panels

## Version 1.0

* no more CPE and CR, only AE
* reshaping in Spotter, Indexer and Aligner

## Version 1.0-rc9

* added Relater for computing similarity distances between context vectors of a monolingual contextual terminology
* fixed issue 7

## Version 1.0-rc8

* Danish support for Tagger and Termer
* XML format for resources (tokenizer, tree-tagger, stop-word, rule-based term detection)
* neoclassical compound alignment

## Version 1.0-rc7

* refactoring taggers: a tagger button and one tagger engine per tab
* refactoring converters: a converter button and one converter engine per tab

## Version 1.0-rc6

* bug fix: the Indexer annotator was running as many times as there are index listeners and not only once
* bug fix: removing hapax both by filtering raw terms and by filtering their lemma
* bug fix: enabling term indexation according to their annotation types

## Version 1.0-rc5

* adding a Converter launcher for converting XMI files into other formats e.g. TSV
* sorting the terminology view of the Termer tool by frequencies

## Version 1.0-rc4

* adding a Stemmer for English, French, German, Russian and Spanish into the TreeTagger analysis engine

## Version 1.0-rc3

* adding Tilde Tagger for processing Latvian
* adding a term context result viewer for the Contextualizer tool

## Version 1.0-rc2

* splitting Ziggurat in 2 tools: Contextualizer and Aligner
* renaming Acabit in Termer

## Version 1.0-rc1

* CPE workflow split into 3 respectively called TreeTagger, Acabit and Ziggurat
* GUI refactoring: 1 tool by CPE
* version presented at IJCNLP

## Version 0.9.1

* TBX export bug fix

## Version 0.9.0

* Term Bank XMI serialization and deserialization removed after a "out of memory" exception thrown.
* Term Bank binary serialization and deserialization added instead.

## Version 0.8.2

* Term Context Indexer added.

## Version 0.8.1

* multi-word rules for Spanish, Latvian and Russian added.

## Version 0.8.0

* initial release of the new TTC TermSuite GUI and CLI interfaces
