
* TOC
{:toc}

### Introduction

The list of variation rules is the linguistic resource used by the [TermGatherer]({{site.baseurl}}/documentation/termsuite-pipelines/#term-gatherer) engine. The *TermGatherer* is composed of several sub-engines, each specialized in the gathering a special king of term variation: morphological variations, prefixations, etc.

All sub-engines used the same list of gathering rules as input, but each one selects in this list only the rules it is able to process. For example, the *PrefixationGatherer* takes as input only the [prefixation rules](#prefixation).


### Syntax of a variant rule
{:id="syntax"}

A *variant rule* is always composed of four parts:

 1. the *rule name*,
 1. the *source* pattern,
 1. the *target* pattern,
 1. the rule *expression*.

It must be written in [YAML](http://yaml.org/), *i.e.* as key-value tree structure using a sequence of two escape characters `  ` as nesting syntax. The variantion rule must use the following template:

```yaml
"rule name":
  source: ...
  target: ...
  rule: ...
```

Example:

```yaml
"S-R1Eg-AN-N":
  source: A N
  target: N N
  rule: s[0].stem==t[0].stem && s[1]==t[1]
```

The rule above is named `S-R1Eg-AN-N`. It describes the gathering of two terms whenever:

  * the first term (the *source* term) has the syntactic pattern *A N*, *i.e.* it must be an adjective followed by a noun. (See [patterns](#patterns) for more information about patterns)
  * The second term (the *target* term) has the pattern *N N*, *i.e.* it must be a noun followed by a noun.(See [patterns](#patterns) for more information about patterns)
  * the first words (`s[0]` and `t[0]`) of both terms have the same stem, and the second words of both terms (`s[1]` and `t[1]`) have the same lemma.

For example, this rule gathers the source term *thyroïdal cancer* with the target term *tyroid cancer*.


#### The syntactic patterns: `source`, `target`
{:id="patterns"}

The `source` (resp. `target`) key gives the list of syntactic patterns allowed for the source term (resp. target term). A syntactic pattern is a sequence of syntactic *labels* separated with a space. For example:

 * the pattern `A N` stands for a *adjective* followed by a *noun*, like in *thyroïdal cancer*.
 * the pattern `N` stands for just one *noun*, like *cancer*, *energy*.
 * the pattern `N P A N` stands for one *noun*, followed by one *preprosition*, followed by one *adjective*, followed by one *noun*, like *level of environmental noise*.
 * ...

In the case several *pattern* alternatives are allowed, they must be separated with a `,`. For example, `source: A N, N N` indicates that the source term can be either a *noun* or or an *adjective*, followed by a *noun*.

The list of *syntactic labels* (`N`, `A`, `P`...) allowed in *pattern* definition is directly dependent on the [muti-word term detection engine]({{site.baseurl}}/documentation/termsuite-pipelines/#term-spotter), which operates before variant gathering in the [terminology extraction pipeline]({{site.baseurl}}/documentation/termsuite-pipelines/), and more precisely on the linguistic resource used as input of this engine: the [*UIMA Tokens Regex* resource file](https://github.com/nantesnlp/uima-tokens-regex#the-uima-tokens-regex-resource-file). the list of available syntactic labels as the `matcher` names in this resource. For example in english (see the [english term spotting rules](https://github.com/termsuite/termsuite-core/blob/master/src/main/resources/fr/univnantes/termsuite/resources/en/english-multi-word-rule-system.regex)), the allowed labels are: `Prep`, `P1`, `P`, `A`, `N`, `C`, `R`, `D`.

Although the allowed labels can be different for each language, we tried to obey these conventions:

 * `P` stands for a *preposition*,
 * `A` stands for an *adjective*,
 * `N` stands for a *noun*,
 * `C` stands for a *coordination*, (*and*, *or*)
 * `R` stands for an *adverb*,
 * `D` stands for a *determiner*.

#### The tag `[compound]`
{:id="compound"}

The tag `[compound]` can be appended to the source (resp. target) pattern definition of [morphological rules](#morphological). This tag gives an indication to the gathering engine that the source term has to be a *compound*.

Appending this tag is optional in the sense that the gathering engine would do the job anyway, but it is strongly advised to append it whenever possible because it reduces the source search space to *compound* terms  only, which greatly improves the performance. It is almost mandatory for single-word terms because there are a lot of them.

For example:

```
"M-S-NN":
  source: N [compound]
  target: N N, A N
  rule: s[0][0]==t[0] && s[0][1]==t[1]
```

The rule above gathers `n: windmill` with `nn: wind mill`, `n: horizontal-axis` with `an: horizontal-axis`. See [Morphological rules](#morphological) for more information.

#### The expression `rule`
{:id="rule"}

The key `rule` defines a boolean expression that words in source and target terms must satisfy.

 * `s[i]` denotes the (i+1)th word in the source term. `t[i]` denotes the (i+1)th word in the target term.
 * When is a compound word, `s[i][j]` denotes the (j+1)th component of word *s[i]*. When *s[i]* is not a compound, invoking `s[i][j]` would just make the expression return *false*. Idem with `t[i][j]`.
 * The *lemma* of the word *s[i]* is denoted as `s[i].lemma`, but `s[i]` alone returns the value of *s[i].lemma* by default. Idem with `t[i].lemma`, but `t[i]`.
 * The *stem* of the word *s[i]* is denoted as `s[i].stem`, idem with `t[i].stem`.
 * `s[i].compound` returns *true* if *s[i]* is compound, idem with `t[i].compound`.

 Expression operators allowed are `==` (string equality) and `!=` (string inequality). Members of equality/inequality operators can ben either words (eg. s[i]), or words compounds (eg. s[i][j]), or pure string (eg. `"foo"`).

Boolean operators allowed are `&&` and `||`. Expressions can be composed with the help of parentheses `(` and `)`.

**Examples**

A rule gathering `Savonius rotor` with `rotor of type Savonius`:

```
"S-PI-NN-PN":
  source: N N
  target: N P N N, N P A N
  rule: s[0]==t[3] && ( s[1]==t[0] || s[1]==t[2] )
  ```


A rule gathering `generator voltage` with `voltage and frequency of generator`:

```
"S-PI-NN-CNP":
  source: N N
  target: N C N P N
  rule: s[0]==t[4] && s[1]==t[0] && t[3]=="of"
  ```

A rule gathering `thyroïdal cancer` with `thyroid cancer`:

```
"S-R1Eg-AN-N":
  source: A N
  target: N N
  rule: s[0].stem==t[0].stem && s[1]==t[1]
```

### Types of variant rule
{:id="rule-types"}

#### Basic rule
{:id="basic-rule"}

A *basic rule*, or *syntagmatic rule*, is such a rule defining constrains on the source and target terms with no other specific linguistics features.

#### Morphological rules
{:id="morphological"}

A *morphological rule* is a rule that makes use of either:

 * the tag [`[compound]`](#compound),
 * or any component's lemma with `s[i][j]` or `t[i][j]`.

Morphological rules are gathered by the [MorphologicalGatherer]({{site.baseurl}}/documentation/termsuite-pipelines/#term-gatherer) sub-engine.

**Example**

This rule gathers `n: windmill` with `nn: wind mill`:

```
"M-S-NN":
  source: N [compound]
  target: N N, A N
  rule: s[0][0]==t[0] && s[0][1]==t[1]
```

#### Prefixation rules
{:id="prefixation"}

A *prefixation rule* is a rule that makes use of the method `prefix(a,b)`. This method returns *true* if word *a* is a prefixation of word *b*.

Prefixation rules are gathered by the [PrefixationGatherer]({{site.baseurl}}/documentation/termsuite-pipelines/#term-gatherer) sub-engine.

**Example**

This rule gathers `an: synchronous machine` with `an: asynchronous machine`:

```
"AN-prefAN":
  source: A N
  target: A N
  rule: s[1]==t[1] && prefix(t[0], s[0])
```

#### Derivation rules
{:id="derivation"}

A *derivation rule* is a rule that makes use of the method `deriv(drule, a, b)`. This method returns *true* if word *a* derives into *b* according to derivation rule *drule*.


The derivation rule *drule* is a string made of two [syntactic labels](#patterns), *e.g.* `"A N"`, meaning the word *a* is an *adjective* that is derived into a *noun*. For each supported language, TermSuite knows that a word is a derivation of another word thanks to a list of suffix derivation rules. See the [list for french](https://github.com/termsuite/termsuite-core/blob/master/src/main/resources/fr/univnantes/termsuite/resources/fr/morphology/french-suffix-derivation-bank.txt). Such *atomic derivations*, *i.e.* derivations between simple words (not terms), are detected before the  [*TermGatherer*]({{site.baseurl}}/documentation/termsuite-pipelines/#term-gatherer) in the pipeline, by the [MorphologicalSplitter]({{site.baseurl}}/documentation/termsuite-pipelines/#morphological-splitter).

Derivation (between terms) are gathered by the [DerivationGatherer]({{site.baseurl}}/documentation/termsuite-pipelines/#term-gatherer) sub-engine.

**Example**

In french, the following rule gathers `npn: phase du stator` with `na: phase statorique`:

```
"S-R2D-NPN":
  source: N P N
  target: N A
  rule: s[0]==t[0] && deriv("N A", s[2], t[1])
```

#### Synonymic rules
{:id="synonyms"}

A *synonymic rule* is a rule that makes use of the method `synonym(a, b)`. This method returns *true* if word *a* is detected to be a synonym of word *b*.

A *synonymic rule* must satisfy the following structural constraints:

 1. the `source` pattern and `target` pattern's length must be *2*,
 2. the `source` pattern must be equal to the `target` pattern,
 2. the `rule` expression must have exactly one fixed part, *i.e.* `s[0]==t[0]` or `s[1]==t[1]`,
 2. the `rule` expression must have exactly one synonym part, *i.e.* `synonym(s[0],t[0])` or `synonym(s[1],t[1])`,

Semantic variations between terms are gathered by the [SemanticGatherer]({{site.baseurl}}/documentation/termsuite-pipelines/#term-gatherer) sub-engine.

Example:

This rule gathers `an: rotational speed` with `an: rotational velocity`:

```yaml
"AN-AsynN":
  source: A N
  target: A N
  rule: s[0]==t[0] && synonym(t[1],s[1])
```

### Examples of variant rules
{:id="examples"}

You can download and adapt the existing list of variant rules embedded in TermSuite for every supported languages.

<table class="table table-striped">
  <tbody>
	<tr>
    <td>	English	</td>
		<td>	<a href="https://github.com/termsuite/termsuite-core/blob/master/src/main/resources/fr/univnantes/termsuite/resources/en/english-variants.yaml" title="English variant rules">English variant rules</a>	</td>
	</tr>
  <tr>
    <td>	French	</td>
		<td>	<a href="https://github.com/termsuite/termsuite-core/blob/master/src/main/resources/fr/univnantes/termsuite/resources/fr/french-variants.yaml" title="French variant rules">French variant rules</a>	</td>
	</tr>
  <tr>
    <td>	German	</td>
		<td>	<a href="https://github.com/termsuite/termsuite-core/blob/master/src/main/resources/fr/univnantes/termsuite/resources/de/german-variants.yaml" title="English variant rules">German variant rules</a>	</td>
	</tr>
  <tr>
    <td>	Spanish	</td>
		<td>	<a href="https://github.com/termsuite/termsuite-core/blob/master/src/main/resources/fr/univnantes/termsuite/resources/es/spanish-variants.yaml" title="English variant rules">Spanish variant rules</a>	</td>
	</tr>
  <tr>
    <td>	Russian	</td>
		<td>	<a href="https://github.com/termsuite/termsuite-core/blob/master/src/main/resources/fr/univnantes/termsuite/resources/ru/russian-variants.yaml" title="Russian variant rules">Russian variant rules</a>	</td>
	</tr>
  <tr>
    <td>	Italian	</td>
		<td>	<a href="https://github.com/termsuite/termsuite-core/blob/master/src/main/resources/fr/univnantes/termsuite/resources/it/italian-variants.yaml" title="English variant rules">Italian variant rules</a>	</td>
	</tr>
</tbody>
</table>
