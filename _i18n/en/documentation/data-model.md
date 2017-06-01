* TOC
{:toc}

### TermSuite UIMA Type System
{:id="type-system"}

The *Type System* is the schema of UIMA annotations contained in the CAS (*Common Abstract Structure*) passed to all analysis engines of the UIMA pipeline. This section presents the *Type System* used by [TermSuite Preprocessor pipeline](/documentation/termsuite-pipelines/#preprocessor), i.e. our data model at Step 1 of terminology extraction.

There are three annotation types in TermSuite. See [TermSuite Type System XML file](https://github.com/termsuite/termsuite-core/blob/master/src/main/resources/TermSuite_TS.xml) for an up-to-date view of the type system.

 * [`SourceDocumentInformation`](#SourceDocumentInformation): exactly one per document, i.e. per CAS, containing all metadata needed about the current textual document being processed,
 * [`WordAnnotation`](#WordAnnotation): a word, or a punctuation element,
 * [`TermOccAnnotation`](#TermOccAnnotation): a term occurrence detected by [Term Spotter](/documentation/termsuite-pipelines/#term-spotter).



#### org.apache.uima.examples.SourceDocumentInformation
{:id="SourceDocumentInformation"}

* `uri:String`
* `offsetInSource:Integer`
* `lastSegment:Boolean`
* `documentSize:Integer`
* `corpusSize:Integer`
* `cumulatedDocumentSize:Integer`
* `documentIndex:Integer`
* `nbDocuments:Integer`

#### eu.project.ttc.types.WordAnnotation
{:id="WordAnnotation"}

* `stem:String`
* `lemma:String`
* `gender:String`
* `case:String`
* `mood:String`
* `tense:String`
* `tag:String`
* `formation:String`
* `degree:String`
* `category:String`
* `subCategory:String`
* `person:String`
* `possessor:String`
* `regexLabel:String`
* `labels:String`


#### eu.project.ttc.types.TermOccAnnotation
{:id="TermOccAnnotation"}

* `termKey:String`
* `word:WordAnnotation[]`
* `pattern:StringArray` (an array of UIMA Tokens Regex labels)
* `spottingRuleName:String` (the name of the UIMA Tokens Regex rule that spotted this term)

### Terminology Data Model
{:id="TerminologyDataModel"}

This section presents the data model of a Terminology used by [TermSuite terminology extractor pipeline](/documentation/termsuite-pipelines/#terminology-extraction-step-2), i.e. our data model at Step 2 of [terminology extraction](/documentation/termsuite-pipelines/#terminology-extraction).

#### Relation types
{:id="RelationTypes"}

(to come)
