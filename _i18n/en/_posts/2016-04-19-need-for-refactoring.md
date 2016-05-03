---
layout: post
title:  "Need for TermSuite 3.0"
categories: news
date: 2016-04-19
author: Damien Cram
status: draft
excerpt: >
  Wish list of evolutions for TermSuite in 3.x architecture.
---

# TermSuite 2.x limitations

## Lots of useless AE

primary occurrence detector, term class, etc

## Needs for multi-threading during UIMA pipeline

## Separate service methods from data model

Needs Java beans in model

Ex: Term#addTermVariation

## Export and import term indexes without needing a UIMA AE

## Separate Token spotting (UIMA) from terminology extraction

Needs to create a separate framework for Terminology processing.

# New features and service required in 3.x

## Specification of Terminology data model (EMF ?)

## Specification of modular service-oeriented architecture

* Model service and maybe some core service to edit the term index
* all termino AE must be a separate plugin, contributing to the pipeline

## Easy I/O from xmi and json for UIMA tokens

## Easy I/O json for tbx for terminologies

## Needs for ability to work with persitant TermIndex (MongoDB)

## Needs for ability to have only incremental AE in the Termino Pipeline

## Needs for a complete end-user API for loading corpus and documents to the pipeline.

## Allow easy term refiltering and ranking

Needs an API for multiple successive filtering/ranking with a #getRank method
Needs the concept of TerminologyView
  
