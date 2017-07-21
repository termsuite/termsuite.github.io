* TOC
{:toc}

### TermSuite UIMA Type System
{:id="type-system"}

The *Type System* is the schema of UIMA annotations contained in the CAS (*Common Abstract Structure*) passed to all analysis engines of the UIMA pipeline. This section presents the *Type System* used by [TermSuite Preprocessor pipeline]({{site.baseurl}}/documentation/termsuite-pipelines/#preprocessor), i.e. our data model at Step 1 of terminology extraction.

There are three annotation types in TermSuite. See [TermSuite Type System XML file](https://github.com/termsuite/termsuite-core/blob/master/src/main/resources/TermSuite_TS.xml) for an up-to-date view of the type system.

 * [`SourceDocumentInformation`](#SourceDocumentInformation): exactly one per document, i.e. per CAS, containing all metadata needed about the current textual document being processed,
 * [`WordAnnotation`](#WordAnnotation): a word, or a punctuation element,
 * [`TermOccAnnotation`](#TermOccAnnotation): a term occurrence detected by [Term Spotter]({{site.baseurl}}/documentation/termsuite-pipelines/#term-spotter).



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

#### fr.univnantes.termsuite.types.WordAnnotation
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


#### fr.univnantes.termsuite.types.TermOccAnnotation
{:id="TermOccAnnotation"}

* `termKey:String`
* `word:WordAnnotation[]`
* `pattern:StringArray` (an array of UIMA Tokens Regex labels)
* `spottingRuleName:String` (the name of the UIMA Tokens Regex rule that spotted this term)

### Terminology Data Model
{:id="TerminologyDataModel"}

This section presents the data model used by [TermSuite terminology extractor pipeline]({{site.baseurl}}/documentation/termsuite-pipelines/#terminology-extraction-step-2) and [TermSuite Java API]({{site.baseurl}}/documentation/java-preprocessor/), i.e. our data model at Step 2 of [terminology extraction]({{site.baseurl}}/documentation/termsuite-pipelines/#terminology-extraction).

#### Class diagram

![Terminology class diagram](/img/data-model/class-diagram.png)

As any graph structure, a *Terminology* is a container for a collection of *Terms* (the nodes) and a collection of *Relations* (the edges). Both *Terms* and *Relations* are *PropertyHolders*, *ie.* every term and relation has a set of [properties]({{site.baseurl}}/documentation/properties/) held in a *key-value* store.

As *TermSuite* has the ability to keep track of all terms occurrences while they are spotted and gathered. This is the purpose of the *OccurrenceStore*, which holds a collection of *Documents* and *TermOccurrences*.

The *IndexedCorpus* simply is a container for the *Terminology* and  its *OccurrenceStore*.


#### Relation types
{:id="RelationTypes"}

As illustrated in class diagram above, *relations* are typed. There are currently four types of relation:

 * `VARIATION`: this is the most probably the only relation type interesting for terminology explotation. At the time of writing, all other relation types are mostly intended to analysis engines of the terminology extraction process. For example, information about term derivation, term prefixation, and term extensions are reified in relations of type *VARIATION* as properties (see [isDeriv]({{site.baseurl}}/documentation/properties/#RelationProperty-isDeriv), [isPref]({{site.baseurl}}/documentation/properties/#RelationProperty-isPref), and [isExt]({{site.baseurl}}/documentation/properties/#RelationProperty-isExt))
 * `DERIVES_INTO`: This relation is set between two single-word terms whenever an atomic derivation has been detected by the *DerivationGatherer* (see [term gatherer]({{site.baseurl}}/documentation/termsuite-pipelines/#term-gatherer)).
 * `IS_PREFIX_OF`: This relation is set between two single-word terms whenever an atomic prefixation has been detected by the *PrefixationGatherer* (see [term gatherer]({{site.baseurl}}/documentation/termsuite-pipelines/#term-gatherer)).
 * `HAS_EXTENSION`: This relation is set between two terms whenever an extension has been detected by the *DerivationGatherer* (see [preparator]({{site.baseurl}}/documentation/termsuite-pipelines/#preparator)). The `HAS_EXTENSION` is purely an inclusion of sequences (the sequence of term's words) between two terms. It is "*variant agnostic*" in the sense there can be a *HAS_EXTENSION* relation between two terms even though there are not variants.
