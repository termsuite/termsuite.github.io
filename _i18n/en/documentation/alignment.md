In TermSuite, alignment is the process of grouping together terms that share the most similar contexts. There exist two sorts of alignment in TermSuite:

 * *monolingual alignment* is about finding synonyms of a term in a given terminology,
 * *bilingual alignment* is the translation tasks from one source language to another target language of finding best translation candidates of a source term based on its context.

* TOC
{:toc}

### Contextualization: building context vectors
{:id="contextualization"}

#### Context scope

The *scope* of a context for a term *T* is the number of words occurring just before *T* left and just after *T*.

Example with the following sentence:

 > *Data were acquired with the blades rotating at zero yaw, for a range of wind speeds.*

When the *scope* is *1*, the context of term "*wind*" is {range: 1, speed: 1}.

When the *scope* is *2*, the context of term "*wind*" is {yaw: 1, range: 1, speed: 1}.

**Note 1:** co-terms in context vector are lemmatized.

**Note 2:** determiners and propositions are skipped when computed context's scope.

#### Normalization of context vectors
{:id="normalization"}

The idea behind normalization is two lower the impact of co-terms that appear in multiple context vectors.

Given two terms *T1* and *T2*, having respectively *{co-term1: 2, co-term2: 1, co-term3: 2}* and *{co-term1: 1, co-term2: 1, co-term4: 3}* as their context vectors, we can observe that:

 * *co-term2* is not very specific to either *T1* nor *T2* as it appears in both contexts with the same distribution (*frequency=1*),
 * *co-term1* is a bit more specific to *T1* than *T2* as it appears twice in *T1*'s context and only once in *T2*'s,
 * *co-term3* is very specific to *T1* as it appears twice in its context and is absent of *T2*'s,
 * *co-term4* is even more specific to *T2* as it appears three times in its context and is absent of *T1*'s.

 Two normalization algorithms are available in TermSuite for context vector normalization:

  1. *LogLikelyhood*
  1. *MutualInformation*


### General alignment methods
{:id="general-alignment"}



Methods described in this section applies on [bilingual alignment](#bilingual-alignment) and [monolingual alignment](#monolingual-alignment).

In general, alignment requires:

 * at least one *terminology* where terms have been contextualized, (in the case of [bilingual alignment](#bilingual-alignment), there must be two terminologies)
 * a *dictionary* (a synonym dictionary for [monolingual alignment](#monolingual-alignment), a bilingual dictionary for [bilingual alignment](#bilingual-alignment)).

#### Distributional alignment
{:id="distributional"}

*Distributional alignment* is the process of computing the closeness of two terms based on the similarity of their [normalized](#normalization) context vectors.

*Distributional alignment* applies on single-word terms only, *ie.* on *length-1 terms*.

There are two context vector similarity measures currently implemented in TermSuite:

 * [**Jaccard**](https://en.wikipedia.org/wiki/Jaccard_index)
 * [**Cosine**](https://en.wikipedia.org/wiki/Cosine_similarity)

#### Compositional alignment
{:id="compositional"}

*Compositional alignment* applies on *length-2 terms*, *ie.* on terms composed of two words, like *wind energy*, *breast cancer*, *chemotherapy* (*chemo* + *therapy*, see the special case of [compound words](#compounds)), etc.

**Note:** Determiners and propositions are ignored when computing the term's length. For example, the term *energy of the wind* is length-2 because *of* and *the* are ignored.

Say the term to align is made of *word1* and *word2*. In TermSuite's compositional alignment algorithm:

 1. TermSuite gets *C1*, the set of all length-1 alignment candidates for *word1* from dictionary,
 2. TermSuite gets *C2*, the set of all length-1 alignment candidates for *word2* from dictionary,
 3. TermSuite combines all length-1 candidates from *C1* and *C2* to produce the set *C=C1xC2* of all length-2 alignment candidates that occur in target terminology,
 4. TermSuite scores and ranks the candidates in *C*.

The maximum number of alignment candidates is *|C1|x|C2|*. If any of *word1* or *word2* has no entry in dictionary, then there can be no alignment candidate and the compositional method fails.

** Example: ** Translation of term *wind power* from english to french with compositional method.

  1. word1=*wind*, C1={*vent*, *souffle*, *gaz*}
  2. word2=*power*, C2={*énergie*, *puissance*, *vertu*}
  3. The combination of *C1* and *C2* give *9* candidates but only *énergie du vent* and *puissance du vent* exist in target terminology. C={*énergie du vent*, *puissance du vent*}
  4. If candidates are ranked according to their target [frequency]({{site.baseurl}}/documentation/properties/#TermProperty-freq) or [specificity]({{site.baseurl}}/documentation/properties/#TermProperty-spec), then the best candidate is *énergie du vent*.

About target candidates ranking, see [this publication](http://atala.org/Methode-semi-compositionnelle-pour). Currently, the default target candidate ranking strategy is by *decreasing [specificity]({{site.baseurl}}/documentation/properties/#TermProperty-spec)*.  


#### Semi-distributional alignment
{:id="semi-distributional"}

Like [compositional alignment](#compositional), *semi-distributional alignment* applies on *length-2 terms* only. Semi-distributional alignment works in a very similar manner to *compositional alignment*.

The only difference lies at step 2, where alignment candidates for *word2* are computed with the [distributional](#distributional) method instead of from the dictionary. Step 1 (*word1* candidates computation), step 3 (combination), and step 4 (ranking) stay unchanged. Symmetrically, we could apply the *distributional* alignment on *word1* and leave steps 2, 3, and 4 unchanged.  

Usually, the distributionnal method has lower performances in terms of precision than the compositional method. It is invoked in TermSuite as a fallback when one of the two words is missing from the dictionary. When both term's words are missing from dictionary, it would be theoriticallay feasible to apply a *pure distributionnal* alignment, but the precision is too low. It is not implemented.  

#### Aligning longer terms (length > 2)
{:id="length-n"}

Longer terms are aligned recursively.

If **length is n**, the term is of the form *T=word1 word2 ... wordn*. There are n-1 alternatives for splitting T in two smaller-size terms:
  * alternative 1: *T'=word1* and *T"=word2 ... wordn*  
  * alternative 2: *T'=word1 word2* and *T"=word3 ... wordn*  
  * ...
  * alternative n-1: *T'=word1 word2 ... wordn-1* and *T"=wordn*.

For each splitting alternative *i*:
 1. TermSuite produces:
   * candidate set *C'* by aligning *T'* with the [compositional method](#compositional) or with the [semi-distributional method](#semi-distributional) if the compositional is not appliable.
   * candidate set *C"* from *T"* likewise.
 2. TermSuite produces candidate set *Ci* by combining *C'* and *C"* in a similar manner than [step 3 of compositional method](#compositional).

Finally, TermSuite produce the final candidate set *C = C1 U C1 U ... U Cn-1* and ranks *C* in a similar manner than [step 4 of compositional method](#compositional).


#### Aligning compound terms
{:id="compounds"}

A *compound term* is a single-word term composed of at least two different words. For example, the term *windpower* is composed of *wind+power*.

##### Size-2 compounds

Aligning a size-2 compound term like *windpower* is a four-step process:

 1. producing the candidate set *C1* by aligning *windpower* as a regular single-word term (ignoring its composition) with the help of the dictionary or with the [distributional][#distributional] method,
 1. producing the candidate set *C2* by aligning *windpower* as a length-2 term with word1=wind and word2=power, with the [compositional method](#compositional) or with the [semi-distributional method](#semi-distributional) as fallback.
 1. producing the candidate set *C=C1 U C2*,
 1. ranking *C* (cf. [step 4 of compositional method](#compositional)).

##### Size-n compounds, n>2
{:id="size-n-compounds"}

If the compound term is made of at least three words, as it often happens in german (*eg.* *windenergienutzung=wind+energie+nutzung*), the same principle applies on four different candidate set. For the sake of simplicity, we denote *T=A+B+C*, where *A*, *B*, and *C* are the sub-words:

 1. Candidate set *C1* obtained by aligning the term *T* as a single-word term.
 2. Candidate sets *C2'* and *C2"* obtained by aligning the term *ABC* as a size-2 compound as in previous section. *C2'* is obtained by assuming that T is made of the two words *A+BC*, *C2"* is obtained by assuming that T is made of the two words *AB+C*.
 3. Candidate set *C3* obtained by aligning the term *T* as a size-3 compound *A+B+C*, by applying the [alignment algorithm for *length-n* terms](#length-n) on word1=A, word2=B, and word3=C.

Finally, We make the union candidate set *C = C1 U C2' U C2" U C3* and rank it as usual.

The table below gives all the possible composition patterns for alignment depending on the actual composition size.  

<table class="table table-striped">
	<thead>
		<tr>
			<th>Composition size</th>
			<th>Actual composition pattern</th>
			<th>List of candidate composition patterns</th>
		</tr>
	</thead>
	<tbody>
	<tr>
		<td>	1	</td>
		<td>	A	</td>
		<td>	{A}	</td>
	</tr>
  <tr>
		<td>	2	</td>
		<td>	AB	</td>
		<td>	{AB, A+B}	</td>
	</tr>
  <tr>
		<td>	3	</td>
		<td>	ABC	</td>
		<td>	{ABC, AB+C, A+BC, A+B+C}	</td>
	</tr>
  <tr>
		<td>	4	</td>
		<td>	ABCD	</td>
		<td>	{ABCD, ABC+D, AB+CD, A+BCD, AB+C+D, A+BC+D, A+B+CD, A+B+C+D}	</td>
	</tr>
	</tbody>
</table>

#### Generalization to all types of terms of all lengthes

The most general and most difficult situation to handle is the case when the term to align has a length > 1 and at least of its words is a compound. For example *offshore windpower* is a length-2 term made of simple word *offshore* and compound word *wind+power*.

Suppose we have a length-3 term *A+B C D+E+F*, *ie* word1 is the compound *A+B*, word2 is the simple word *C*, and word3 is the compound word *D+E+F*.

As illustrated in the [table of candidates composition patterns](#size-n-compounds), we have to consider the following composition alternatives:

<table class="table table-striped">
	<thead>
		<tr>
      <th>#</th>
			<th>word1</th>
      <th>word2</th>
      <th>word3</th>
		</tr>
	</thead>
	<tbody>
	<tr>
    <td>	1	</td>
		<td>	AB	</td>
		<td>	C	</td>
		<td>	DEF	</td>
	</tr>
  <tr>
  <td>	2	</td>
		<td>	AB	</td>
		<td>	C	</td>
		<td>	DE+F	</td>
	</tr>
  <tr>
  <td>	3	</td>
		<td>	AB	</td>
		<td>	C	</td>
		<td>	D+EF	</td>
	</tr>
  <tr>
  <td>	4	</td>
		<td>	C	</td>
    <td>	AB	</td>
		<td>	D+E+F	</td>
	</tr>
  <tr>
  <td>	5	</td>
		<td>	A+B	</td>
		<td>	C	</td>
		<td>	DEF	</td>
	</tr>
  <tr>
  <td>	6	</td>
  <td>	A+B	</td>
		<td>	C	</td>
		<td>	DE+F	</td>
	</tr>
  <tr>
  <td>	7	</td>
		<td>	A+B	</td>
		<td>	C	</td>
		<td>	D+EF	</td>
	</tr>
  <tr>
  <td>	8	</td>
		<td>	A+B	</td>
		<td>	C	</td>
		<td>	D+E+F	</td>
	</tr>
	</tbody>
</table>

For each of these composition alternatives, we get all its components and apply [length-n algorithm][#length-n] on them, as if they would all form one regular length-n term (*ie.* having no compound words).

For example, with alternative 7, we consider we a length-5 term *T=A B C D EF*.

**Note:** The resulting complexity of this overall algorithm might look very expensive but in practice:

 1. every exepensive sub-alignment invocation can be cached and reused very quickly for other combinations,
 1. there are very few terms of interest with such length and complexity of composition.


### Bilingual alignment methods (term translation)
{:id="bilingual-alignment"}

Bilingual alignment is the process of finding the best translation candidates of a source term in a target language.

#### Requirements

It requires:

 * a *source terminology* where terms have been contextualized,
 * a *target terminology* where terms have been contextualized,
 * a *bilingual dictionary* from source language to target language.

#### Translation of source term's context vector

The translation of a source term into a target language works as [described in the general case](#general-alignment), but the similarity of the source and target vectors is not an easy problem since they contain words from different languages.

Let's denote:
 * *Ts* the source term to translate,
 * *V={co-term1: 2, co-term2: 5, co-term3: 1}* its context vector.

In order to be able to apply our [similarity measures](#distributional) on context vectors, we translate the source context vector *V* into *V'* as follows. For each co-term *t* in *V*, we get the set of all candidate translations *C* for *t* from the dictionary.

 * If *C* is empty, then the co-term could not be found in the dictionary and we skip it in *V'*.
 * If *C* has exactly one element *ct'*, we put *ct'* with the same frequency in *V'*.
 * If *C* has several elements, we use the [frequency]({{site.baseurl}}/documentation/properties/#TermProperty-freq) to distribute the original frequency of co-term *ct* among all candidate translations for this co-term.


**Example** Let's suppose that:

  * the source language is **en**,
  * the target language is **fr**,
  * the source context vector is *{wind: 3, blade:1, darius:2}*
  * the dictionary contains the following entries:

```
wind  vent
wind  gaz
wind  air
blade pâle
```

* the frequencies in target terminology are:

```
vent: 17
gaz:2
air:5
pâle: 12
```

Then the translation of context vector gives:

 * for co-term **wind**: *{vent: 3\*17/24, air: 3\*5/24, gaz: 3\*2/24}*
 * for co-term **blade**: *{pâle: 1\*12/12}*
 * for co-term **darius**: *{}*

The final translated source context vector is *{vent: 2.13, air: 0.25, gaz: 0.63, pâle: 1}*


### Monolingual alignment methods (synonym detection)
{:id="monolingual-alignment"}

Monolingual alignment is the process of finding the best candidate synonyms of a term in a terminology.

#### Requirements

It requires:

 * a *source terminology* where terms have been contextualized,
 * a dictionary of synonyms.

#### Synonym detection algorithm

Every methods [described in the general case](#general-alignment) could be applied on synonym detection but in order to reduce the time computation and increase the precision, we limit the search for synonyms to:

 * length-2 terms,
 * having the same syntactic pattern,
 * sharing at least one term in common.

To configure this process so as it adapts the best to each supported language, a language-specific list of [synonymic variant rules](/documentation/yaml-variants/#synonyms) is defined.


**Example:** The following rule finds length-2 synonyms having the pattern `A N` by fixing the first word (`s[0]==t[0]`) and looking for synonyms between the two second words (`synonym(t[1],s[1])`). The `A` is called the ***fixed part*** of the synonimic rule because it must be the same in the two terms and the `N` is called the ***synonimic part***.

```yaml
"AN-AsynN":
  source: A N
  target: A N
  rule: s[0]==t[0] && synonym(t[1],s[1])
```

For each synonymic rule defined, TermSuite applies the following algorithm:

 * select all terms having the syntactic pattern required (here: `A N`) into a set named *C1*,
 * group terms in *C1* by their *fixed part* (here we group the terms whenever they have the same first word because we have `s[0]==t[0]`),
 * in each group, *ie* set a synonym score to every pair of terms *(t1,t2)* in the group based on the *synonimic part*. In the example rule above, the synonimic part of the rule is the second word, so we compare for each pair their second words (their `N`). Let's name *w1* the second word of *t1* and *w2* the second word of *t2*:
      * compute the [distributional similarity](#distributional) between the context vector of *w1* and the context vector of *w2*,
      * add *0.5* to that score if the pair *w1-w2* is present in the dictionary.
  * finally, for all pairs in the group having a score above given threshold that depends on the language (see [language configuration file](https://github.com/termsuite/termsuite-core/blob/master/src/main/resources/fr/univnantes/termsuite/resources/en/english-extractor-config.json)), set a semantic variation.
