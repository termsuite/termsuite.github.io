---
layout: documentation
title: Corpus directory structure for TermSuite
menu: Corpus directory structure
menu_cat: root
permalink: /documentation/corpus/
---

Because TermSuite has features like terminology alignment that operate on multilingual corpora, all corpora must satisfy a certain directory structure.

TermSuite currently supports two types of corpus: `tei` and `txt`.

A valid TermSuite corpus is a directory having the following directory structure:

 * first level : the corpus's root directory (the corpus name),
 * second level : the language-specific directory (full language name, with first letter capitalized),
 * third level : the collection type (currently `tei` or `txt`).
 * fourth level : the corpus's documents (the files), each having the right extension (`tei` or `txt`).

Example with the corpus `MyCorpus`:

```
MyCorpus/
  French/
    txt/
      file1.txt
      file2.txt
      file3.txt
  German/
    txt/
    file1.txt
    file2.txt
  English/
    tei/
      file1.tei
      file2.tei
      file3.tei
      file4.tei
```

<div class="alert alert-warning" role="alert">
**Warning**

Due to an unresolved issue, `tei` support is partially working. Terminology extraction will work fine, but occurrence offsets of terms are broken.
</div>
