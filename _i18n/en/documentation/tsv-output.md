
TSV (Tab-Separated Values) is a human-readable format that is easy to reuse (Calc, Excel, R, or any program supporting CSV import) for terminology exportation. The terminology TSV output file produced by TermSuite contains all relevant information contained in a terminology:

 * the sorted list of all terms it contains,
 * the sorted list of variants of each terms,
 * the values of [terms' and variants' properties](/documentation/properties/).  

* TOC
{:toc}

### Exporting a terminology to TSV

To produce a `tsv` file out of a terminology with TermSuite, use:

 * option [`--tsv`](/documentation/terminology-extractor-cli/#TerminologyExtractorCLI-tsv) if you are operating with the [command line](/documentation/terminology-extractor-cli/),
 * *TsvExporter* if you are operating  with the [Java API](/java-io/#tsv),
 * *Export to TSV...* from the menu of the terminology editor if you are operating  with the [graphical user interface of TermSuite](/documentation/gui/),


### Understanding TSV output

Here is an excerpt of the TSV output.

```
#	type	pattern	pilot	spec	freq	dFreq
1	T	N	rotor	4,82	848	30
2	T	N N	wind turbine	4,56	1855	37
2	V[s]	N N N	wind turbine rotor	3,38	31	12
2	V[s]	A N N	offshore wind turbine	3,26	47	7
2	V[s]	N N N	wind turbine noise	3,53	43	3
2	V[s]+	N N N	wind turbine technology	3,34	28	10
2	V[s]	N N N	wind turbine system	3,40	32	7
2	V[s]	A N N	modern wind turbines	2,82	17	7
2	V[s]	N N N	wind turbine tower	3,07	15	9
2	V[s]	A N N	large wind turbines	3,12	17	10
2	V[s]	N N N	wind turbine power	2,89	10	6
3	T	N N	wind energy	4,51	414	32
3	V[s]	N N N	wind energy potential	3,07	15	5
3	V[s]	A N N	offshore wind energy	3,56	47	7
3	V[s]	N N N	wind energy development	3,29	25	5
4	T	N N	wind power	4,34	278	26
4	V[s]	N N N	wind turbine power	2,89	10	6
4	V[s]	N N N	Wind Power Plant	3,76	74	9
4	V[s]	A N N	offshore wind power	3,01	13	4
5	T	N	airfoil	4,26	236	8
```

#### Row type (T or V)

Each row having `T` as type (second column) is a term. The rank of the term is denoted as `#` (first column).

Each row having somthing like `V[*]` as type is a variant. To find wich is the base term of a variant, you need to look at the `#` (the rank, i.e. first column) of a variant. For example :

```
2	V[s]	A N N	offshore wind turbine	3,26	47	7
```

The line above indicates that `offshore wind turbine` is a variant of the term ranked `2`, i.e. `wind turbine`. Variants are usually listed directly under the term.

As a consequence, one single term like `wind turbine power` can appear several times as a variant (type `V[*]`) of other terms, here `wind turbine` (ranked `2`) and `wind power` (ranked `4`). On the contrary, one single term can appear only at most once as a term (type `T`) in the TSV. For example, `wind turbine power` appears as a term at line 122 of the same file:

```
122	T	A N N	offshore wind turbine	3,26	47	7
```


#### Type of variants V[\*]

A value of `V` for poperty `type` indicates a variants. This values can take one or more letters with brackets:

 * **s**: indicates that the variation is **syntagmatical** (the most basic variation type)  
 * **m**: indicates that the variation is **morphological**,
 * **g**: indicates that the variation is **graphical**,
 * **h**: indicates that the variation is **semantic**, see values of properties `isDico` and `isDistrib` to know wether the variant has been found from dictionary or by context vector comparison (or both),
 * **d**: indicates that the variation is a **derivate**,
 * **p**: indicates that the variation is a **prefix**,
 * **i**: indicates that the variation has been **infered** from another pair of saller-size terms. The **i** flag should always appear together with another flag.

 When the flad ends with +, like in `V[s]+`, it indicates that the variant also has its own variants. In other words, it means that is variation can expanded, and that the base term has order-2 variants.

##### Example 1

```
375	T	N	windpower	2,82	17	8
375	V[mg]+	N N	wind power	4,34	278	26
375	V[m]+	N P N	power of the wind	2,97	12	7
375	V[m]	N N N	wind turbine power	2,89	10	6
```

The line `V[mg]+	wind power` indicates that `wind power` is a both a morphological and graphical variant of term `windpower`, and that `wind power` also has its own variants. (Indeed, see at rank `4` above)

The line `V[m]+	power of the wind` indicates that `power of the wind` is a morphological variant of term `windpower`, and that `power of the wind` also has its own variants.

##### Example 2

```
25	T	turbine sound	80	3,80			
25	V[s]+	wind turbine sound	71	3,74			
25	V[h]+	turbine noise	52	3,61	0,65	0	1
```

The line `V[h]+	turbine noise` indicates that `turbine noise` is a semantic variant of term `turbine sound`, and that `turbine noise` also has its own variants.


### Configuring TSV output

TermSuite APIs allow to customize the TSV output file. Refer to the [documentation](/documentation/command-line-api/) of the API you are using.

#### Show/Hide headers

Wether TermSuite should write column names at the first line of TSV file.

#### Show/Hide variants

Wether TermSuite should filter variant rows from TSV file, i.e. lines whose type is in the form `V[*]`.

#### List of properties to show

The list of term or variant properties to show as columns of TSV file. Refer to [available properties](/documentation/properties/) for an exhaustive list of values allowed.

When the line to display in TSV is a variation, it is now possible to specify a term property prefixed with `source:`, e.g. `source:freq`, `source:pilot`... In that case, the value displayed for that column is the value of the property for the source (base) term of the variation. This feature may be useful when it comes to keeping only variations lines (for example by filtering within Excel) and still having the base term's properties on the same line.    
