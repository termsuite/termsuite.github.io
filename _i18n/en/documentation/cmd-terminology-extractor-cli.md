* TOC
{:toc}

### Prerequesites

 1. Java 8
 1. A [prepared corpus]({{site.baseurl}}/documentation/preprocessor-cli/) [an external POS tagger installed]({{site.baseurl}}/documentation/pos-tagger-lemmatizer/)


{% include generated/termino-extractor-api.md %}

### Examples

Example launcher scripts can be found at:

[https://github.com/termsuite/termsuite-core/tree/develop/examples/cmd](https://github.com/termsuite/termsuite-core/tree/develop/examples/cmd)

{% termsuite_example path: "cmd/2-extract/110-extract-termino-filtered-by-th.sh", branch: "master", lang: "bash", tsv_slices: "[[0,30],[-10,-1]]" %}


{% termsuite_example path: "cmd/2-extract/120-extract-termino-filtered-by-top-n.sh", branch: "master", lang: "bash", tsv_slices: "[[0,30],[-10,-1]]" %}

{% termsuite_example path: "cmd/2-extract/130-extract-termino-filtered-keeping-variants.sh", branch: "master", lang: "bash", tsv_slices: "[[0,30],[-10,-1]]" %}

{% termsuite_example path: "cmd/2-extract/210-extract-termino-custom-tsv-output.sh", branch: "master", lang: "bash", tsv_slices: "[[0,15]]" %}

{% termsuite_example path: "cmd/2-extract/300-extract-termino-for-alignment.sh", branch: "master", lang: "bash" %}


{% termsuite_example path: "cmd/2-extract/310-extract-termino-no-variant.sh", branch: "master", lang: "bash", tsv_slices: "[[0,30]]" %}


{% termsuite_example path: "cmd/2-extract/410-extract-termino-with-semantic-variants.sh", branch: "master", lang: "bash", tsv_slices: "[[0,30]]" %}

Semantic variants are denoted as `V[h]`. Consider filtering on values of properties `isDistrib` and `semScore` for better filtering.

{% termsuite_example path: "cmd/2-extract/420-extract-termino-with-semantic-variants-with-custom-dico.sh", branch: "master", lang: "bash" %}


{% termsuite_example path: "cmd/2-extract/430-extract-termino-with-semantic-variants-with-dico-only.sh", branch: "master", lang: "bash" %}

{% termsuite_example path: "cmd/2-extract/510-extract-termino-big-corpus-with-no-occurrence.sh", branch: "master", lang: "bash" %}

{% termsuite_example path: "cmd/2-extract/520-extract-termino-from-prepared-corpus.sh", branch: "master", lang: "bash" %}

{% termsuite_example path: "cmd/2-extract/530-extract-termino-with-custom-post-processing.sh", branch: "master", lang: "bash", tsv_slices: "[[0,30]]"  %}


{% termsuite_example path: "cmd/2-extract/540-extract-termino-filtered-before-gathering.sh", branch: "master", lang: "bash" %}


{% termsuite_example path: "cmd/2-extract/610-extract-termino-debugging.sh", branch: "master", lang: "bash" %}


{% termsuite_example path: "cmd/2-extract/620-extract-termino-with-customized-resources.sh", branch: "master", lang: "bash" %}
