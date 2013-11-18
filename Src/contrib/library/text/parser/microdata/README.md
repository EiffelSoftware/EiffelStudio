HTML5 and microdata

This library provides a way to extract MicroData from HTML5 content.

As currently this is implemented redefining the implementation of the XML parser, this is not compliant with all kind of html.
It accepts attribute without value (hopefully to support itemscope ...).
It accepts attribute value with single quote, double quote or no quote at all.
It may have trouble with tag without end-tag such as <dd>...<dd>... and so on.

This will be improved progressively, but for now, this could be used with html5 code you generate yourself.

