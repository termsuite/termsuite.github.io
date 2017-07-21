

* TOC
{:toc}


### Exporting a terminology to JSON

To produce a `json` file out of a terminology with TermSuite, use:

 * option [`--json`]({{site.baseurl}}/documentation/terminology-extractor-cli/#TerminologyExtractorCLI-json) if you are operating with the [command line]({{site.baseurl}}/documentation/terminology-extractor-cli/),
 * *JsonExporter* if you are operating  with the [Java API](/java-io/#json),
 * *Export to JSON...* from the menu of the terminology editor if you are operating  with the [graphical user interface of TermSuite]({{site.baseurl}}/documentation/gui/),

### File structure

#### Overview



```json
{
  "metadata" : { ... },
  "input_sources" : { ... },
  "words" : [ ... ],
  "terms" : [ ... ],
  "relations" : [ ... ],
  "occurrences" : [ ... ]
}
```

#### `metadata`

The key `metadata` holds general information about the current terminology:

```json
"metadata" : {
  "name" : "txt-en-2017-07-19_14-14-22",
  "lang" : "en",
  "occurrence_storage" : "embedded",
  "wordsNum" : 368322,
  "spottedTermsNum" : 226145
}
```

##### `occurrence_storage`

Two possible values:

 * *embedded*: means that the term occurrences are contained in the current JSON file at the key [`occurrences`](#occurrences),
 * *disk*: means that the term occurrences are contained in a separate file of the file system. The path to this path is given by the key `persistent_store_path`.

#### `input_sources`

The key `input_sources` maps all documents' pathes of the input corpus with a *id*:

Example:

```json
"input_sources" : {
  "1" : "/home/cram-d/Corpora/TS/wind-energy/English/txt/file-1.txt",
  "2" : "/home/cram-d/Corpora/TS/wind-energy/English/txt/file-2.txt",
  "3" : "/home/cram-d/Corpora/TS/wind-energy/English/txt/file-3.txt",
  "4" : "/home/cram-d/Corpora/TS/wind-energy/English/txt/file-4.txt",
  "5" : "/home/cram-d/Corpora/TS/wind-energy/English/txt/file-5.txt",
  ...
}
```

#### `words`

The key `words` is an array that contains all morphological information about words contained in *terms*. Words are identified with the unique key `lemma`. See [TermSuite data model]({{site.baseurl}}/documentation/data-model/#TerminologyDataModel) for more information on how *words* interact with *terms*.

Example with a word that is not a compound:

```json
{
  "lemma" : "energy",
  "stem" : "energi"
}
```

Example with a compound word:

```json
{
  "lemma" : "highspeed",
  "stem" : "highspe",
  "compound_type" : "NATIVE",
  "components" : [ {
    "lemma" : "high",
    "begin" : 0,
    "end" : 5,
    "substring" : "highs",
    "neoAffix" : false
  }, {
    "lemma" : "pe",
    "begin" : 5,
    "end" : 9,
    "substring" : "peed",
    "neoAffix" : false
  } ]
}
```

#### `terms`

The key `terms` is an array that holds all terms contained in the terminology. Terms are identified by their unique key `props.key`.

Example with term `nn: wind energy`:

```json
{
  "props" : {
    "rank" : 3,
    "dFreq" : 32,
    "fNorm" : 1.1240164855751218,
    "gfNorm" : 3.477238863707884E-5,
    "spec" : 4.509551591070845,
    "freq" : 414,
    "ortho" : 1.0,
    "iFreq" : 87,
    "ind" : 0.21014492753623187,
    "pilot" : "wind energy",
    "lemma" : "wind energy",
    "tfIdf" : 12.9375,
    "key" : "nn: wind energy",
    "pattern" : "N N",
    "rule" : "nn",
    "swtSize" : 2,
    "depth" : 2
  },
  "words" : [ {
    "syn" : "N",
    "swt" : true,
    "lemma" : "wind"
  }, {
    "syn" : "N",
    "swt" : true,
    "lemma" : "energy"
  } ]
}
```

 * The key `props` holds in an array all [properties]({{site.baseurl}}/documentation/properties/#term-properties) of the current term.
 * The key `words` give the sequence of words that the current term is made of.
   * The sub key `lemma` points to the word object in the [list of *words*](#words) and allows to retrieve the *stem* and the morphological composition of the word.
   * The sub key `syn` gives the syntactic label of the word for this term.
   * The sub key `swt` is *true* when the word taken with its syntactic label is a *single-word term*.

Example 1: the entry `{"syn" : "N", "swt" : true, "lemma" : "wind"}` is also a single-word term because there is a entry `n: wind` in the terminology.

Example 2: the term `npn: storage of hydrogen` has the following words:

```json
"words" : [ {
    "syn" : "N",
    "swt" : true,
    "lemma" : "storage"
  }, {
    "syn" : "P",
    "swt" : false,
    "lemma" : "of"
  }, {
    "syn" : "N",
    "swt" : true,
    "lemma" : "hydrogen"
  }
]
```

#### `relations`

The key `terms` is an array that holds all type of links between terms. All relations are directed.

Here is an example of relation:

```json
{
  "from" : "nn: pressure decrease",
  "to" : "npan: decrease of total pressure",
  "type" : "var",
  "props" : {
    "vRank" : 1,
    "vRules" : [ "S-PI-NN-PN" ],
    "vScore" : 0.99,
    "isExt" : false,
    "vBagFreq" : 2,
    "srcGain" : 0.0,
    "nSrcGain" : 1.0,
    "isInfered" : false,
    "isGraph" : false,
    "isDeriv" : false,
    "isPref" : false,
    "isSyntag" : true,
    "isMorph" : false,
    "isSem" : false
  }
}
```

 * the keys `from` and `to` are the term keys of the relation boundaries. They indicate that the relation starts from term `nn: pressure decrease` and goes to term `npan: decrease of total pressure`.
 * the key `type` gives the relation type. There are as many allowed values as there exists [relation types]({{site.baseurl}}/documentation/data-model/#RelationTypes) in the data model.
 * the key `props` holds in an array all [properties]({{site.baseurl}}/documentation/properties/#relation-properties) of the current relation.


 > **Note:** among all relations set by TermSuite between terms, the most interesting type of relations are the *variations*, *ie.* those relations having `type = "var"`.


#### `occurrences`

The key `occurrences`, when set (see key `occurrence_storage` in [metadata](#metadata)) holds the list of occurrences of all terms.

```json
"occurrences" : [ {
    "tid" : "nnn: turbine generator connection",
    "begin" : 2397,
    "end" : 2425,
    "file" : 17,
    "text" : "Turbine generator connection"
  }, {
    "tid" : "nnn: turbine generator connection",
    "begin" : 23234,
    "end" : 23262,
    "file" : 17,
    "text" : "Turbine generator connection"
  },
  ...
]
```

Each *occurrence* entry has five keys:

 * `tid`: the *term id* pointing to the value of *props.key* in the [term](#terms)'s entry,
 * `file`: the *file id* where the the occurrence has been spotted. See [input sources](#inputsources) to get the file url from the *file id*,
 * `begin`, `end`: the offsets of the occurrence within the file,
 * `text`: (optional) the plain text covered by the occurrence. It can be retrieved directly from the file url, *begin* and *end*.
