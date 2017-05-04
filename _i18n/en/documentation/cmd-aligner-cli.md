* TOC
{:toc}

{% include generated/aligner-api.md %}

### Examples

Example launcher scripts can be found at:

[https://github.com/termsuite/termsuite-core/tree/develop/examples/cmd](https://github.com/termsuite/termsuite-core/tree/develop/examples/cmd)

{% termsuite_example path: "cmd/3-align/100-align.sh", branch: "master", lang: "bash" %}

##### Result

```
1	énergie éolienne	wind energy	0,262	COMPOSITIONAL
2	énergie éolienne	wind power	0,252	COMPOSITIONAL
3	énergie éolienne	power of the wind	0,172	COMPOSITIONAL
4	énergie éolienne	Windpower	0,164	COMPOSITIONAL
5	énergie éolienne	Wind-Energy	0,150	COMPOSITIONAL
```

The output shows that the first translation candidate is `wind energy`. The flag `COMPOSITIONAL` indicates that it has been found by [compositional method](/documentation/alignment#compositional).
