# Installation



# Les corpus TermSuite

Parce que TermSuite propose des fonctionnalités telles que l'alignement de la terminologie sur des corpora multilingue, tous les corpora doivent satisfaire une certaine structure.
Because TermSuite has features like terminology alignment that operate on multilingual corpora, all corpora must satisfy a certain directory structure.

TermSuite supporte actuellement deux types de corpus : 'tei' et 'txt'.
TermSuite currently supports two types of corpus: `tei` and `txt`.

Un corpus TermSuite valide est un répertoire ayant la structure suivante :
A valid TermSuite corpus is a directory having the following directory structure:

 * premier niveau : le répertoire racine du corpus (le nom du corpus),
 * deuxième niveau : le répertoire spécifique au langage (nom complet de la langue, avec la majuscule),
 * troisième niveau : le genre de la collection ('tei' ou 'txt') the collection type (currently `tei` or `txt`),
 * quatrième niveau : les documents du corpus (les fichiers), chacun ayant la bonne extension ('tei' ou 'txt').

Exemple avec le corpus 'MyCorpus' :

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
**Attention**
À cause d'un problème non résolu, l'extension 'tei' fonctionne partiellement. L'extraction de terminologie fonctionne, mais pas la compensation* des occurrences des termes.
</div>
