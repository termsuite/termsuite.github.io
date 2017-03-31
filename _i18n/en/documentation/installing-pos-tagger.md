You need to install a 3rd-party Part-Of-Speech tagger and lemmatizer when you run TermSuite for extracting the terminology of a corpus.

There are currently two POS Taggers and lemmatizers supported by TermSuite:
* `TreeTagger` (recommended): supports `fr`, `en`, `es`, `de`, `ru`, `da`
* `Mate`: supports `fr`, `en` (better POS tagging performances but slower)

* TOC
{:toc}

### Option 1 (recommended): Installing TreeTagger and its models

[TreeTagger](http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/) is a very fast POS tagger and lemmatizer having very acceptable performances on all TermSuite languages. Unfortunately, its [license](http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/Tagger-Licence) does not allow to ship it with TermSuite as a 3rd party dependency and needs to be install manually by end users.

Download and install TreeTagger to your OS following the [official instructions](http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/).

The TreeTagger home directory contains tree subdirectories: `bin`, `models`, and `lib`. The TreeTagger executable program should be in the `bin` sub-directory. Note that the TreeTagger executable program is called `tree-tagger` on Linux and `tree-tagger.exe` on Windows.

The language model parameter files for should be in the models sub-directory. If the parameter files are in the `lib` subdirectory, please create a symbolic link named `models` to this directory as follows:

~~~
$ cd /path/to/tree-tagger-home-directory
$ ln -s lib models
~~~

<div class="alert alert-danger" role="alert">

  **Pay attention to parameter file names and encoding !**

  In the `models` directory, TermSuite expects a specific file name for each language parameter file. Please name your parameter files as follows, and make them all be `utf-8` encoded:

</div>

| Language | Parameter File | Encoding |
|:--------|:-------|:--------:|
| English   | english.par   | utf-8   |
| French   | french.par   | utf-8   |
| Italian   | italian.par   | utf-8   |
| Spanish   | spanish.par   | utf-8   |
| German   | german.par   | utf-8   |
| Russian   | russian.par   | utf-8   |
| Danish   | danish.par   | utf-8   |
{: class="table table-striped"}

On Linux, you can check that TreeTagger is correctly installed by launching these two command lines:

~~~
$ cd tree-tagger-home-directory
$ ./bin/tree-tagger ./models/english.par
~~~

Exit the program by the keyboard short-cut Ctrl+D.

### Option 2: Installing Mate models

Mate has slightly better POS tagging performances than TreeTagger in the context of terminology extraction but also has a few disadvantages:
* only three languages models are public `en`, `de`, and `fr`,
* parsing language models is very slow and results in a quite long and constant loading time for each run,
* tagging and lemmatizing raw text is also very slow compared to TreeTagger.

The main advantage of Mate is that it is embedded into TermSuite. You do not need to install it on your OS. You just need to download (or train) the required language models. See the [official page](https://code.google.com/p/mate-tools/wiki/ParserAndModels) for models of these three languages:  `en`, `de`, and `fr`.

Mate requires two different for each languages. The *parser+tagger* model and the *lemmatizer* model.

<div class="alert alert-danger" role="alert">

  **Pay attention to parameter file names !**

  TermSuite expects a specific file name for each mate model. Please follow naming patterns below.

</div>

The models must follow this patterns : (where `xx` is the two-letter language code)

| Model | File name pattern |
|:--------|:-------|
| parser+tagger   | `mate-pos-xx.model`   |
| lemmatizer   | `mate-lemma-xx.model`   |
{: class="table table-striped"}
