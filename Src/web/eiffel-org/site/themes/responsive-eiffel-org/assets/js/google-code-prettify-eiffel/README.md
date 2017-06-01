# Google-code-prettify : Eiffel language plugin #

## Introduction ##

[Google-code-prettify] (https://code.google.com/p/google-code-prettify/) is 
a Javascript module and CSS file that allows syntax highlighting of source code snippets in an html page.

This plugin adds syntax highlighting for the [Eiffel](http://en.wikipedia.org/wiki/Eiffel_\(programming_language\)) language.

*status*: beta

## Content ##

	- Readme.md		this file
	+ src
		- lang-eiffel.js	prettify module, defining lexeme classes
	+ examples
		- eiffel.html		a sample file
	+ styles
		- lang-eiffel.css	sample stylesheet
		
## Using this module in your html ##

1. In the \<head\> portion, reference
	- your stylesheet, e.g: \<script src="http://mysite.com/styles/lang-eiffel.js"\>\</script\>
	- the prettify.js module e.g: \<script src="https://google-code-prettify.googlecode.com/svn/loader/prettify.js"\>\</script\>
	- the lang-eiffel.js module e.g: \<script src="http://mysite.com/scripts/lang-eiffel.js"\>\</script\>
	
2. Initialize the prettify module by calling 'prettyPrint()'
	- e.g: \<body onload="prettyPrint()"\>

3. Trigger pretty printing in your \<pre\> nodes
	- e.g: \<pre class="prettyprint lang-eiffel"\>
	- or with line numbering: \<pre class="prettyprint lang-eiffel linenums"\>
    
