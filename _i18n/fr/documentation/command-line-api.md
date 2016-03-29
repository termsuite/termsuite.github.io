TermSuite offre deux executeurs de lignes de commande. Un pour l' [extraction de terminologie](#termino), et un autre pour [l'alignement multilingue](#term-alignment).

* TOC
{:toc}

### Extraction de terminologie
{:id="termino"}

Extraire la terminologie d'un corpus spécifique à un domaine et [l'exporter](#export) vers les formats 'tsv', 'tbx' ou 'json'.

~~~
$ java -Xms1g -Xmx2g -cp termsuite-core-{{site.termsuite.version}}.jar eu.project.ttc.tools.cli.TermSuiteTerminoCLI \
            -r /path/to/termsuite-resource-pack \
            -t /path/to/tagger-home-dir \
            -c /path/to/corpus/English/txt \
            -l en
~~~

Par défaut, l'étiqueteur grammatical (et le lemmatiseur) utilisé par le script est TreeTagger. Si vous avez plutôt besoin de Mate, ajoutez l'option '--mate' à la ligne de commande (voir ci-dessous).

#### Options imposées
| `-r` PATH  | Chemin vers le paquet de ressources de TermSuite (un fichier jar ou un répertoire)   	|
| `-l` LANGUAGE   	| Le code de la langue du corpus : 'en', 'fr', etc.	|
| `-c` PATH   	| Chemin de sortie des corpus. 	|
| `-t` PATH   	| Chemin vers le dossier racine de Tree Tagger, ou celui de Mate. (voir [[InstallingPOSTagger]])       	|
{: class="table table-striped"}

#### Options d'enregistrement

| `--no-logging`  *(no arg)* 	| Désactive l'enregistrement par console|
| `--info`  *(no arg)* 	|   Règle les relevés au niveau 'info' Set logging level to `info` |
| `--debug`  *(no arg)* 	| Règle les relevés au niveau 'débug' Set logging level to `debug` |
| `--profile`  *(no arg)* 	|  Affiche les différents exemples et les informations de l'AE (Applied Energistics) |
| `--watch`  STRING 	| Affiche les informations (freq. spec. variants, etc.) sur tous les termes correspondant à la fin de la chaîne de traitement |
| `--nb-examples`  INT 	[=5] |  Le nombre d'exemples à afficher pour chaque résultat profilé |
| `--tags` *(no arg)* | Montre les étiquettes grammaticales en sortie (fonctionne seulement en ligne) |
{: class="table table-striped"}

#### Options de filtrage des termes

| `--filter-property` STRING [=wrLog]	| Voir [TermProperty]({{site.javadoc}}) pour les valeurs disponibles      	|
| `--filter-th` INT [=2]	|  Au filtrage, la valeur minimum de la propriété filtrée à garder dans la terminologie* |
| `--filter-top-n` INT 	| Au filtrage, le nombre de termes à garder dans la terminologie après le triage des termes par '--filter-property'*. |
| `--filter-variants` *(no arg)* 	| Filtre également les variantes  |
{: class="table table-striped"}

Pour executer un filtrage de termes, vous avez besoin de préciser l'option '--filter-property', et une valeur '--filter-th' ou '--filter--top-n'.
Les différentes valeurs figurent sur : (documentation [Javadoc]({{site.javadoc}})).

{% for p in site.data.filtering-properties %}
  {% if p.filter %}
  * **{{p.name}}:** {%t p.description %}
  {% endif %}
{% endfor %}

Par défaut, les termes sont filtrés en fonction de leurs propriétés **wrlog** avec un valeur seuil de 2**. Voir les [propriétés des termes](/documentation/term-properties/) pour des informations spécifiques, et l'explication des propriétés ; en particulier [wrLog](/documentation/term-properties/#wr). Voir également les [exemples](#termino-examples) pour une illustration. Ces options ne sont pas obligatoires.

#### Options compost* (analyse morphosyntaxique)

Voir la classe [Lang]({{site.javadoc}}) pour les réglages par défaut.

| `--compost-coeff` STRING 	|  COMPOST les paramètres alpha, beta, gamma et delta, séparés par un trait d'union \"-\". La somme doit être 1. |
| `--compost-similarity-threshold` FLOAT 	| Le seuil supérieur d'une chaîne de l'index COMPOST ********
																				The segment similarity threshold above which an existing string in COMPOST index is considered as recognized. |
| `--compost-score-threshold` FLOAT 	|   The segmentation score threshold of COMPOST algo.    	|
																									Le résultat de la segmentation seuil de l'algorithme algo.
| `--compost-max-component-num` INT 	|   The maximum number of components that a compound can have    	|
																									Le nombre maximal de composants qu'une combinaison peut avoir
| `--compost-min-component-size` INT 	|   The minimum size allowed for a component	|
																						La taille minimum allouée à un composant
{: class="table table-striped"}


#### Autres options (encodage, corpus, étiquetteur, etc)

| `--encoding` ENCODING  [=UTF-8]|   Encode les fichiers du corpus      	|
| `--corpus-format` String [=txt] |   Le format de fichier dans le corpus entrant. 'txt' et 'tei' sont supportés  	|
| `--mate` *(no arg)* | Utilise Mate plutôt que TreeTagger comme l'étiqueteur grammatical de TermSuite    	|
| `--graphical-similarity-th` FLOAT 	|   false   	|         	|     Le seuil de similarité (une valeur entre 0 et 1, 0,9 conseillé) pour le recueil graphique des variantes.** 	|
{: class="table table-striped"}

#### Options d'exportation
{:id="export"}

| `--json` FILENAME 	| Exporte le termino extrait pour donner un fichier Json |
| `--tbx` FILENAME 	| Exporte le termino extrait pour donner un fichier TBX	|
| `--tsv` FILENAME 	| Exporte le termino extrait pour donner un fichier TSV |
| `--tsv-properties` PROPERTIES [="pilot,frequency"]	| liste des propriétés des termes séparée par des `,` pour les exporter en colonnes dans un fichier TSV |
| `--tsv-show-scores` *(no arg)* | Montre les résultats des termes et des variantes utilisés par le classifieur de terme dans un fichier TSV 	|
{: class="table table-striped"}

Les possibles valeurs de l'option '--tsv-properties' sont : (illustrées [ici](#exemples))

{% for p in site.data.filtering-properties %}
  * **{{p.name}}:** {%t p.description %}
{% endfor %}

Voir les [Propriétés des Termes](/documentation/fr/term-properties/) pour plus de détails, particulièrement [wrLog](/documentation/fr/term-properties/#wr).

#### Exemples
{:id="termino-exemples"}


##### Extraire la terminologie du corpus 'txt', et exporter les 100 termes les plus récurrents en 'tsv' et 'json' :

Disons que nous avons :

* un [corpus valide](/documentation/fr/corpus) dans `/home/moi/corpora/mycorpus`
* Tree Tagger installé dans `/home/moi/apps/TreeTagger`,
* notre pack de ressources `/home/moi/data/termsuite-resources.jar`

Les commandes suivantes extraient la terminologie du corpus *mycorpus* en anglais, en utilisant TreeTagger, en sélectionnant les 100 termes les plus fréquents, et en les exportant en '.tsv' et '.json' :

~~~
$ java -Xms1g -Xmx2g -cp termsuite-core-{{site.termsuite.version}}.jar eu.project.ttc.tools.cli.TermSuiteTerminoCLI \
            -r /home/me/data/termsuite-resources.jar \
            -t /home/me/apps/TreeTagger \
            -c /home/me/corpora/mycorpus/English/txt \
            -l en \
            --filter-property "frequency" \
            --filter-top-n 100 \
            --tsv "mytermino.tsv" \
            --tsv-properties "pattern,pilot,wrLog,frequency"
            --json "mytermino.json"
~~~

##### Repérer les occurrences de terme multi-mots* d'un corpus 'tei' et sauvegarder les annotations UIMA vers des fichiers 'xmi'.

Cela engendre un fichier 'xmi' par saisie dans le fichier 'tei' :

~~~
TODO
~~~


#### Le monde en ligne

Vous pouvez aussi executer la chaîne de traitement termino TermSuite sur une seule chaîne en ligne. Nul besoin de donner une option '-c' (chemin du corpus).

Le mode en ligne depuis l'option '--text' :

~~~
$ java -Xms1g -Xmx2g -cp termsuite-core-x.x.jar eu.project.ttc.tools.cli.TermSuiteTerminoCLI \
            -r /path/to/termsuite-resource-pack \
            -t /path/to/tree-tagger-home \
            -l en \
            --text "Wind energy is the energy of tomorrow."
~~~
Le mode en ligne depuis l'entrée standard :
~~~
$ echo "My test phrase." | java -Xms1g -Xmx2g -cp termsuite-core-x.x.jar \ eu.project.ttc.tools.cli.TermSuiteTerminoCLI \
            -r /path/to/termsuite-resource-pack \
            -t /path/to/tree-tagger-home \
            -l en
~~~

### L'alignement multilingue des termes.
{:id="term-alignment"}

Le script 'TermSuiteAlignerCLI' prend pour entrée :

 * les deux terminologies (la *source* et la *cible* extraites par TermSuite sur deux [corpora] comparables(/documentation/corpus)),tion/corpus)),
 * le [le dictionnaire bilngue],
 * la liste des termes à traduire.


#### Le script 'TermSuitealignerCLI'
{:id="aligner"}

L'aligneur prend pour entrée :
 * les deux terminologies extraites par TermSuite depuis un corpus multilngue comparable, l'un est dans la *langue source*, l'autre dans la *langue cible*
 * un terme, ou une liste de termes à aligner
~~~
$ java -cp termsuite-core-{{site.termsuite.version}}.jar eu.project.ttc.tools.cli.TermSuiteAlignerCLI \
        --source-termino termino-fr.json \
        --target-termino termino-en.json \
        --dictionary dico.txt \
        --term "hydroélectricité"
~~~

#### Options
{:id="aligner-options"}

##### Options obligatoires

| `--source-termino` FILENAME 	| Exporte et extrait le termino pour donner un fichier Json |
| `--target-termino` FILENAME 	| Exporte et extrait le termino pour donner un fichier TBX 	|
| `--dictionary` FILENAME 	| Exporte et extrait le termino pour donner un fichier TSV (voir [/documentation/fr/ressources/](TermSuite Resources documentation)) |

Un des :

| `--term` STRING 	| Le terme à aligner |
| `--term-list` FILENAME 	| Un fichier contenant la liste des termes à aligner. Un par ligne. |
{: class="table table-striped"}

##### Autres options

| `-n` INT 	| Le nomber de traductions possibles à afficher |
| `--distance` [cosine,jaccard] 	| La mesure de ressemblance utilisé pour calculer la distance entre deux vecteurs |
| `--show-explation` *(no args)* 	| Montre également les co-termes les plus influents et les traductions possibles |

#### Exemples

Ce qui suit aligne le terme français *hydroéléctricité* depuis les terminologies en français, et le corpus *Wind Energy* en anglais :

~~~
$ java -cp termsuite-core-{{site.termsuite.version}}.jar eu.project.ttc.tools.cli.TermSuiteAlignerCLI \
        --source-termino wind-energy-fr.json \
        --target-termino wind-energy-en.json \
        --dictionary FR-EN.txt \
        --term "hydroélectricité"
~~~
Donnant les résultats :
~~~
n: hydropower	0,524
n: source	0,066
n: roadmap	0,061
n: target	0,058
n: consumption	0,049
n: energy	0,049
a: renewable	0,049
a: grid-connected	0,048
n: undertaking	0,048
n: fight	0,048
~~~
Ce qui prend du temps pour 'TermSuiteAlignerCLI' est de charger les deux terminologies. Si vous avez besoin d'aligner plusieurs termes, il est recommandé de les avoir dans un fichier comme ci-dessous :
~~~
rotor
éolienne
éolien
pale
turbine
dimensionnement
moyeu
calage
écoulement
générateur
nacelle
~~~
Et d'executer le script d'alignement sur ce fichier :
~~~
$ java -cp termsuite-core-{{site.termsuite.version}}.jar eu.project.ttc.tools.cli.TermSuiteAlignerCLI \
        --source-termino wind-energy-fr.json \
        --target-termino wind-energy-en.json \
        --dictionary FR-EN.txt \
        --term-list list.txt
~~~
