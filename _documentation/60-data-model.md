---
layout: documentation
title: Termonilogy data model of TermSuite
menu: Termonilogy data model
status: draft
permalink: /documentation/data-model/
---

* TOC
{:toc}

# TermSuite UIMA Type System

There are three types in TermSuite's type system :

###### org.apache.uima.examples.SourceDocumentInformation

* `uri:String`
* `offsetInSource:Integer`
* `lastSegment:Boolean`
* `documentSize:Integer`

###### eu.project.ttc.types.WordAnnotation

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


###### eu.project.ttc.types.TermOccAnnotation

* `category:String`
* `frequency:Double`
* `langset:String`
* `lemma:String`
* `pattern:StringArray` (an array of UIMA Tokens Regex labels)
* `ruleId:String` (the name of the UIMA Tokens Regex rule that spotted this term)
* `specifity:Double` (The Weirdness Ratio of this term @Deprecated)

# TermSuite Java Data Model


TODO: draw a schema of this data model.

###### TermIndex

###### Term

###### TermOccurrence

###### Word

###### TermWord

###### TermProperty

###### Document
