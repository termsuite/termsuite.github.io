
* TOC
{:toc}

### Fréquence
{: id="frequency"}

La *fréquence des termes* est le nombre d'occurrences d'un term dans un corpus spécifique à un domaine. Cette mesure est à la fois très simple et très utile pour l'extraction de terminologie et le post-traitement.

Pour accéder à la fréquence des termes avec l'API Java :
{% highlight java %}
term.getFrequency();
{% endhighlight %}

### Fréquence normalisée
{: id="fnorm"}
La *fréquence normalisée* est le nombre moyen des occurrences d'un terme dans le **corpus d'un domaine spécifique tous les 1000 mots**. Cette valeur est un nombre décimal.
Pour accéder à la fréquence des termes avec l'API Java :
{% highlight java %}
term.getFrequencyNorm();
{% endhighlight %}

### La fréquence générale normalisée
{: id="generalFnorm"}
La **fréquence générale normalisée* est le nombre moyen des occurrences d'un terme dans le **corpus général de la langue tous les 1000 mots**. Cette valeur est un nombre décimal.
Pour accéder à la fréquence des termes avec l'API Java :
{% highlight java %}
term.getGeneralFrequencyNorm();
{% endhighlight %}
Le corpus général de la langue est un corpus basé sur les archives des journaux d'actualité. Si un terme en est absent, alors il est considéré comme apparaissant 0,5 fois. C'est la raison pour laquelle la méthode 'getGeneralFrequencyNorm()' ne répond pas une valeur zéro.

### Ratio d'étrangeté (`wr` et `wrLog`)
{: id="wr"}

#### Définition

Le *ratio d'étrangeté* (Weirness Ratio) est probablement la propriété utilisée par TermSuite pour mesurer la **spécificité d'un terme dans un corpus d'un domaine spécifique**. IL est défini en divisant la *fréquence normalisée* d'un terme par sa *fréquence générale normalisée*.

{% highlight java %}
double wr = term.getFrequencyNorm() / term.getGeneralFrequencyNorm();
{% endhighlight %}


#### `wr` et `wrLog`
Notre expérience avec le 'wr' est que le lien de spécificité le plus signifiant est la magnitude, i.e. le nombre de zéros qu'il a. C'est pourquoi nous introduisons le 'wrLog' :

{% highlight java %}
double wrLog = Math.log(1 + term.getFrequencyNorm() / term.getGeneralFrequencyNorm());
{% endhighlight %}

#### Java API
Pour accéder à la fréquence des termes avec l'API Java; vous devez obtenir la *mesure* de votre terminologie (l'objet 'TermIndex').
C'est pourquoi obtenir le Wr d'un terme est moins instrinctif que pour les propriétés *primitives* d'un terme (fréquence, fréquence normalisée, fréquence normalisée générale, et fréquence document).

{% highlight java %}
// Obtenir le WR d'un "terme"
termIndex.getWRMeasure().getValue(term);

// Obtenir le wrLog (log(1+WR)) d'un "terme"
termIndex.getWRLogMeasure().getValue(term);
{% endhighlight %}

Ce qui est pratique avec les mesures TermSuite, c'est que vous pouvez facilement obtenir la somme des valeurs sur le domaine spécifique :

{% highlight java %}
// Le WR moyen sur la terminologie
termIndex.getWRMeasure().getAvg();

// Le wrLog moyen sur la terminologie
termIndex.getWRLogMeasure().getAvg();
{% endhighlight %}

#### Distribution du Ratio d'étrangeté (en fait 'wrLog')

La distribution du Ratio d'étrangeté sur la figure 1 a été conçue sur notre corpus exemple Wind Energy. Elle montre que les valeurs 'wrLog' varient entre 0 et 5. Nous avons fait la même observation sur tous les corpora testés, y compris pour un corpus contenant 58 millions de mots, et plusieurs langues supportés par TermSuite.

<p class="text-center">
<img title="Distribution de wrLog sur le corpus Wind Energy" alt="Distribution de wrLog sur le corpus Wind Energy" width="500" src="/img/wrlog-distribution-th1.png">
<br />
Fig1. Distribution de wrLog sur le corpus Wind Energy
</p>

Fig. 1 montre cette distribution, et donne une couleur pour chaque valeur seuil de la propriété *fréquence*.
La zone jaune est la distribution des termes revenant plus d'une fois (i.e. tous les termes) ; la zone bleue est la distribution des termes revenant au moins deux fois, etc.
Une autre observation remarquable est la présence d'un groupe de termes à gauche du premier pic, proche de zéro.
Ce sont les termes qui apparaissent relativement souvent dans le corpus général de la langue.
Le pic jaune de la fig.1 montre une des préférence du Ratio d'Étrangeté.
Dans les faits, il y a un grand nombre de termes partageant exactement la même valeur que 'wr'.
Des termes apparaissant exactement une fois dans le corpus de domaine spécifique, et zéro fois dans le corpus général de la langue apparaissent sur le graphique.
Il y a également un certain nombre de termes apparaissant exactement deux fois dans le corpus de domaine spécifique et zéro fois dans le corpus général de la langue. Ils partagent tous la même valeur (le pic bleu noté th=2).


<p class="text-center">
<img title="Distrution du wrLog sur le corpus Wind Energy, après avoir filtré les termes par leur fréquence (fréquence  ≥ 3)" alt="Distrution du wrLog sur le corpus Wind Energy, après avoir filtré les termes par leur fréquence (fréquence  ≥ 3)" width="500" src="/img/wrlog-distribution-th3.png">
<br />
Fig2. Distrution du wrLog sur le corpus Wind Energy, après avoir filtré les termes par leur fréquence (fréquence  ≥ 3)
</p>

La figure 2 présente exactement la même distribution que la première, sauf que nous avons filtré la terminologie et gardé les termes présent au moins trois fois dans le corpus. Ce filtre permet un "zoom" sur les autres pics. Nous voyons qu'il y a une cime pour chaque fréquence jusqu'à 5 ou 6, puis la valeur 'wrLog' les mélange.

#### Un bon seuil pour le filtre 'wrLog'
Quand on filtre avec 'wrLog', la question à laquelle il faut répondre est 'quel pic dois-je filtrer ?'. Habituellement, pour l'extraction de terminologie, c'est un bon entraînement de régler le seuil après les premiers pics. Pour un corpus plus grand, il est recommandé de régler le seuil après le second, le troisième, le quatrième, ou le cinquième (pour un corpus très important) pic.

<div class="alert alert-success" role="alert">
Étant donné ce comportement, un bon **seuil par défaut pour 'wrLog' indépendant du langage et du corpus est 2**
</div>

### Fréquence du document
{: id="dfreq"}

La *fréquence du document* d'un terme est le nombre de documents (i.e. fichiers dans le corpus saisi) dans lequel le term apparaît.
En terminologie, c'est souvent un bon entraînement de filtrer le terme extrait sur cette propriété, pour s'assurer que les termes extraits n'apparaîtront pas dans un seul document.  

Pour accéder à la fréquence d'un terme avec l'API Java :
{% highlight java %}
term.getDocumentFrequency();
{% endhighlight %}

### Les autres propriétés

La liste exhaustive des propriété est :

{% for p in site.data.filtering-properties %}
  * **{{p.name}}:** {%t p.description %}
{% endfor %}
