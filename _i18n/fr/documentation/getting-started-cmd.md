<div class="alert alert-danger" role="alert">
<strong>Avertissement: </strong> Cette page de documentation est obsolète. Certaines parties de son contenu peuvent ne pas s'appliquer à la version actuelle de TermSuite : {{site.termsuite.version}}
</div>


Cette page vous montre les étapes pour faire fonctionner TermSuite et extraire la terminologie d'un petit corpus.

* TOC
{:toc}

### 1. Pré-requis

Pour plus de simplicité, créez un répertoire où vous téléchargerez tous les fichiers requis par TermSuite. Dans les sections qui suivent, nous nous réfererons à ce répertoire comme étant `TERMSUITE_WORKSPACE`.       

#### Java

Assurez-vous que Java est installé sur votre système d'exploitation (version 8 minimum), ou bien suivez les [instructions officielles d'installation](https://www.java.com/fr/download/).

Pour vérifier si Java est installé correctement, et vérifier votre version, ouvrez une interface en ligne de commandes et tapez :

~~~
$ java -version
~~~

### 2. Installation de TreeTagger

TermSuite a besoin d'un étiquetteur grammatical (POS Tagger) et d'un lemmatiseur pour executer les chaînes de traitement (pipelines). Dans ce manuel, nous installons TreeTagger, mais TermSuite peut également gérer Mate. TreeTagger doit être installé séparément de TermSuite, du fait de leurs licences.

Pour installer TreeTagger sur votre système d'exploitation : (Voir les [Instructions d'installation]({{site.baseurl}}/documentation/fr/pos-tagger-lemmatizer)).

1. Téléchargez TreeTagger depuis le [site officiel]((http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/) vers "TERMSUITE_WORKSPACE" et décompressez-le.
2. Créez un sous-répertoire nommé "models" dans le répertoire TreeTagger.
3. Téléchargez le modèle anglais utf-8-encoded (très important) depuis le [site officiel]((http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/)) et renommez-le par "english.par".

<div class="alert alert-warning" role="alert">
Enconder et nommer les modèles de TreeTagger est important pour le bon fonctionnement de TermSuite. Voir les [instructions détaillées] ({{site.baseurl}}/documentation/fr/pos-tagger-lemmatizer) pour toutes les langues.
</div>

### 3. Téléchargez TermSuite

Téléchargez la dernière version stable du projet "termsuite-core" depuis [Maven Central]({{site.termsuite.maven}}) vers le répertoire "TERMSUITE_WORKSPACE".

Actuellement : [termsuite-core-{{site.termsuite.version}}.jar]({{site.termsuite.maven}}{{site.termsuite.version}}/termsuite-core-{{site.termsuite.version}}.jar)

### 5. Préparez votre corpus

Téléchargez le corpus multilingue exemple [Wind Energy]({{site.corpus.we}}) dans "TERMSUITE_WORKSPACE" et décompressez-le.

### 6. Executez l'extraction de terminologie
Maintenant, votre 'TERMSUITE_WORKSPACE' devrait ressembler à ceci : (non exhaustif)

~~~
TERMSUITE_WORKSPACE/
  wind-energy/
    README.txt
    English/
      txt/
        file1.txt
        file3.txt
        [...]
        file38.txt
    French/
    [...]
  tree-tagger/
    bin/
      [...]
    lib/
      [...]
    models/
      english.par # Should be the `utf-8` model !
    [...]
  termsuite-core-{{site.termsuite.version}}.jar
~~~

Executez l'extraction de terminologie sur le corpus *Wind Energy* en langue "en" :

~~~
$ java -cp termsuite-core-{{site.termsuite.version}}.jar eu.project.ttc.tools.cli.TermSuiteTerminoCLI \
  -t ./tree-tagger/ \
  -c ./wind-energy/English/txt/ \
  -l en \
  --tsv ./wind-energy-en.tsv
~~~

### 7. Comprendre la sortie TSV (TSV output)

TermSuite a créé le fichier 'wind-energy-en.tsv' montré plus bas.
* 1ère colonne : correspond à l'identification du term, ou la base de son identifiant s'il s'agit d'une variante.
* 2ème colonne : 'T' indique un terme, 'V' indique une variante.
* 3ème colonne : le terme pilote.
* 4ème colonne : la fréquence du terme.
* 5ème colonne : la spécificité du terme.

~~~
baseId	type	p	pilot	wrlog	f
1	T	N N	wind turbine	5,16	1852
1	V	N N N	horizontal-axis wind turbines	3,52	42
1	V	A N N N	horizontal axis wind turbine	3,50	41
1	V	A N N N	vertical axis wind turbines	3,62	53
1	V	A N N N	modern horizontal-axis wind turbines	2,59	5
1	V	A N N	smaller-scale wind turbines	2,20	2
1	V	A N N	on-shore wind turbines	1,90	1
1	V	A N N	pre-manufactured wind turbine	1,90	1
1	V	A N N	repowred wind turbines	1,90	1
1	V	A N N N	conventional horizontal-axis wind turbines	1,90	1
1	V	A N N N	potential campus wind turbines	1,90	1
1	V	A N N N	typical horizontal-axis wind turbine	1,90	1
1	V	A N N N	unconventional horizontal-axis wind turbines	1,90	1
1	V	N N N N	hawts horizontal-axis wind turbines	1,90	1
1	V	N N N N	utility scale wind turbine	1,90	1
1	V	N N N N	lift type wind turbines	1,90	1
1	V	A N N	domestic wind turbines	3,35	29
1	V	N N N	wind turbine syndrome	3,21	21
[...]
2	T	N	rotor	4,82	848
3	T	N N	wind energy	4,51	414
3	V	A N N	californian wind energy	1,90	1
3	V	A N N	offshore wind energy	3,56	47
3	V	N N N	wind energy conversion	3,32	27
3	V	N N N	wind energy conf	2,59	5
3	V	A N N N	significant contribution wind energy	1,90	1
3	V	N N N N	activity plan wind energy	1,90	1
3	V	N N N N	title ge wind energy	1,90	1
3	V	N N N	wind energy easements	1,90	1
4	T	N N	wind speed	4,41	331
4	V	N P N	speed of the wind	2,50	4
4	V	N C N P N	speed and direction of the wind	1,90	1
4	V	N N N	integer wind speed	1,90	1
4	V	A N N	average wind speed	3,29	25
4	V	A N N	undisturbed wind speed	2,59	5
4	V	N N N	cutoff wind speed	2,37	3
4	V	N N N N	terrain score wind speed	1,90	1
4	V	N N N	wind speed cutoff	2,20	2
4	V	N N N	cut-out wind speed	2,50	4
4	V	N N N	cut-off wind speeds	1,90	1
4	V	N N N	incision wind speed	1,90	1
5	T	N N	wind power	4,34	278
5	V	N P N	power of the wind	2,97	12
5	V	N N N	wind turbine power	2,89	10
5	V	N N N	wind power plant	3,76	74
5	V	A N N	developable wind power	1,90	1
5	V	A N N N	environmental engineering wind power	1,90	1
5	V	N N N	wind power stations	3,27	24
6	T	N	airfoil	4,26	236
...
~~~

Ce format de sortie peut être configuré. 'tbx' et 'json' sont également possibles. Voir la ligne de commande [options]({{site.production_url}}/documentation/fr/command-line-api).

### 8. Profitez de TermSuite

Vous pouvez désormais executer TermSuite sur votre propre corpus.

La documentation complète des options et possibilités des lignes de commandes : [command line API]({{site.production_url}}/documentation/fr/command-line-api).

Pour intégrer TermSuite directement à votre projet Java : [Java API]({{site.baseurl}}/documentation/fr/command-line-api).
