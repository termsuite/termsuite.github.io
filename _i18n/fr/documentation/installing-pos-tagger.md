Lorsque vous lancerez TermSuite pour l'extraction de la terminologie d'un corpus, vous aurez besoin d'installer un étiqueteur grammatical et un lemmatiseur tierces.


Il y a actuellement deux étiqueteurs et lemmatiseurs supportés par TermSuite:

* 'TreeTagger' (recommandé) : supportant 'fr', 'en', 'es', 'de', 'ru', 'da'
* 'Mate' : supportant 'fr', 'en' (plus performant mais plus lent pour l'étiquetage grammatical)

* TOC
{:toc}

### Option 1 (recommandée): Installer TreeTagger et ses modèles.


[TreeTagger](http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/) est un étiqueteur grammatical (POS) très rapide, avec un lemmatiseur aux bonnes performances, et ce dans tous les langages TermSuite. Malheureusement, sa [licence](http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/Tagger-Licence) n'autorise pas son envoi conjoint à TermSuite en tant que tierce partie dépendante. De plus, TreeTagger a besoin d'être installé manuellement.

Téléchargez et installez TreeTagger sur votre système d'exploitation en suivant les [instructions officielles](http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/)
Le répertoire principal de TreeTagger contient trois sous-répertoires : 'bin', 'models', et 'lib'. Le programme executable TreeTagger devrait être dans votre sous-répertoire 'bin'. Notez que cet executable est appelé 'tree-tagger' sous Linux, et 'tree-tagger.exe' sous Windows.

Les fichiers paramétrant la langue doivent être placés dans le sous-répertoire 'models'.
Si les fichiers de paramètres sont dans le sous-répertoire 'lib', créez un lien symbolique vers le répertoire nommé 'models' comme suit :

~~~
$ cd /path/to/tree-tagger-home-directory
$ ln -s lib models
~~~

<div class="alert alert-danger" role="alert">

  **Attention aux noms des fichiers des paramètres et à l'encodement !**
Dans le répertoire 'models', TermSuite attend un fichier spécifiquement nommé pour chaque fichier paramétrant la langue. Nommez vos dossiers de paramètres comme suit, et faites en sorte qu'ils soient tous encodés en 'utf-8' :

</div>

| Language | Parameter File | Encoding |
|:--------|:-------|:--------:|
| English   | english.par   | utf-8   |
| French   | french.par   | utf-8   |
| Spanish   | spanish.par   | utf-8   |
| German   | german.par   | utf-8   |
| Russian   | russian.par   | utf-8   |
| Danish   | danish.par   | utf-8   |
{: class="table table-striped"}


Sous Linux, vous pouvez vérifier que TreeTagger est correctement installé en lançant ces deux lignes de commande :

~~~
$ cd tree-tagger-home-directory
$ ./bin/tree-tagger ./models/english.par
~~~

Quittez le programme avec le raccourci-clavier Ctrl+D.

### Option 2: Installer les modèles Mate

Mate est légèrement plus performant dans l'étiquetage grammatical que TreeTagger, surtout pour une procédure d'extraction de terminologie. Mais il a aussi quelques inconvénients :
* seuls trois modèles de langue sont publics : 'en', 'de', et 'fr',
* l'analyse grammaticale (parsing) des modèles de langue est très lent, et les résultats sont assez longs à obtenir,
* le marquage (tagging) et la lemmatisation de texte brut sont aussi très lents comparé à ce que propose TreeTagger.


L'avantage principal de Mate est qu'il est intégré à TermSuite.
Vous n'avez pas besoin de l'installer sur votre système d'exploitation. Vous avez simplement besoin de télécharger (ou d'entraîner) les modèles langagiers nécessaires.
Voir la [page officielle](https://code.google.com/p/mate-tools/wiki/ParserAndModels) pour les modèles de ces trois langues :  `en`, `de`, et `fr`.

Mate a besoin de modèles différents pour chaque langue. Le modèle *analyse+étiquetage* (*parser+tagger*) et le modèle *lemmatiseur*.

<div class="alert alert-danger" role="alert">

  **Attention aux noms des fichiers**
  TermSuite attend un nom spécifique pour chaque modèle Mate. Suivez le schéma de nominalisation ci-dessous.

</div>

Les modèles doivent suivre ces schémas : (où 'xx' est la langue de code à deux lettres)

| Model | File name pattern |
|:--------|:-------|
| parser+tagger   | `mate-pos-xx.model`   |
| lemmatizer   | `mate-lemma-xx.model`   |
{: class="table table-striped"}
