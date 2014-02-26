# Smarty template engine for Eiffel

# Overview
This smarty library is a template engine inspired by smarty php template engine.
It provides a parser and the engine execution itself in order to generate for instance html output.
However it can be used to generate any kind of output (xml, json, html, ...).

The syntax is similar to http://www.smarty.net/ , so for now have a look at their documentation, but as quick documentation, please see following documentation by example.

As any template engine, the input includes 
- the template files themselves.
- and data, the data are mainly Eiffel objects associated with name, then it is possible to access the attributes value, and additional functions (see the "inspector" section).

# Quick documentation
## Instructions and related syntax
### Current implementation:
* actions: assign, include, if, unless, foreach, nl2br, htmlentities, literal
* condition: condition, isempty, isset
See below for details

### How to use a value associated with name "foo"?
>   {$foo/}

### How to use expression foo.bar ?
>   {$foo.bar/}

note: `bar' has to be an attribute, or declared via the "inspector" mechanism (see related section)

### How to assign a variable named "title" with a value? (or associate a value with a name "title")
>   {assign name="title" value="a new title"/}

### How to assign a variable named "title" with an expression $foo.bar?
>   {assign name="title" expression="$foo.bar"/}

### What about if, then, else, end conditional instructions?
####**keyword: if**
  - pseudo code using a variable:
     `if var_enabled then blockA end`
>    {if condition="$var_enabled"}blockA{/if}

  - pseudo code using an expression: 
     `if foo.is_valid then blockA end`
>    {if condition="$foo.is_valid"}blockA{/if}

  - pseudo code testing if expression is set (i.e registered or not Void):
     `if foo.bar /= Void then blockA end`
>    {if isset="$foo.bar"}blockA{/if}

  - pseudo code testing if expression is empty:
     `if foo.bar.is_empty then blockA end`
>    {if isempty="$foo.bar"}blockA{/if}

####**keyword: unless**
  - pseudo code using the negation of expression: 
     `if not foo.is_valid then blockA end`
>    {unless condition="$foo.is_valid"}blockA{/unless}

####**keywords: if,unless to mimic if then else end**
 - pseudo code with else part:
     `if foo.is_valid then blockA else blockB end`
     (note: there is no "else" implementation yet)
>    {if isempty="$foo.is_valid"}blockA{/if}
>    {unless isempty="$foo.is_valid"}blockB{/unless}

     for performance, one can use a variable
>    {assign name="condition_foo_is_valid" expression="$foo.is_valid"/}
>    {if condition="$condition_foo_is_valid"}blockA{/if}
>    {unless isempty="$condition_foo_is_valid"}blockB{/unless}

### How to process an instruction for each item of a collection?
  **keyword: foreach**
  - traversing an iterable structure (as a LIST)
>     {foreach item="the_value" from="$list"}{$the_value/}{/foreach}

  - traversing an iterable table (as a HASH_TABLE)
>     {foreach item="the_value" key="the_name" from="$table"}{$the_name/}={$the_value/} , {/foreach}

### How to include another template file?
  **keyword: include**
  - include template file "bar.tpl"
>    {include file="bar.tpl" /}

  - include template file, and assign variable valid only in the scope of the included file
>    {include file="bar.tpl"}{assign name="data" expression="foo-$index" /}{/include}

  - include the content of a file without processing it as template
>    {include file="bar.tpl" literal="true" /}

### How to easily encode text for html output?
  **keyword: htmlentities**
>    {htmlentities}5 > 3{/htmlentities}

     This will generate  `"5 &gt; 3"`

### How to easily convert space into html space?
  **keyword: nl2br**
  - Convert new lines into <br/> html tags
>    {nl2br}line 1 %Nline 2 %Nline 3{/nl2br}

     This will generate  `"line 1 <br/>line 2 <br/>line 3"`

  - Convert new lines into <br/> html tags, and tabs with 4 spaces &nbsp;
>    {nl2br}line%T1 %Nline%T2{/nl2br}
	 
     This will generate  `"line&nbsp;&nbsp;&nbsp;&nbsp;1 <br/>line&nbsp;&nbsp;&nbsp;&nbsp;2"`

### How to exclude text from template processing?
  **keyword: literal**
  - Keep the following text "{$abc/}" unchanged
>    {literal}{$abc/}{/literal}
	 
     This will generate "{$abc/}" unchanged. This can be useful to display text that has curly braces.

## Expression and inspector
### Definition  The expressions can be
  - manifest string as  `this is a text`
  - manifest string with variable  `this is a text, var={$var/}`
  - a variable `{$var/}`
  - an expression related to call foo.bar.var `{$foo.bar.var/}`

### Restrictions
  - when an expression can not be evaluated (due to unknown variable or call), `${abc.out.bad}` will be converted as an error message displayed usually like `{!! Invalid name !!}`
  - by default, the calls in expression can only access attribute value, for instance `{$foo.out.count/}` will not be what could be expected, since `out` for instance is not an attribute.

### Solutions for attribute restrictions
  - If ever, you want to be able to call `${foo.new_bar}` where `class FOO feature new_bar: BAR do .. end end`, by default this will not be accepted, but using the mechanism of the `TEMPLATE_INSPECTOR`, this is now possible. This is pretty simple:
  * create for instance a new class FOO_TEMPLATE_INSPECTOR
>  class FOO_TEMPLATE_INSPECTOR 
>  inherit
>      TEMPLATE_INSPECTOR 
>         redefine internal_data end
>  
>  create register
>  
>  feature -- Internal data
>	internal_data (fn: STRING; obj: detachable FOO): detachable CELL [detachable ANY]
>		local
>			l_fn: STRING
>		do
>			if obj /= Void then
>				if fn.is_case_insensitive_equal ("new_bar") then
>					Result := obj.new_bar
>				end
>			end
>		end
>  end

  * Register this inspector in the code, before executing the template execution with
>   local inspector: TEMPLATE_INSPECTOR do
>   create {FOO_TEMPLATE_INSPECTOR} inspector.register (({detachable FOO}).out)

## How to use this template engine ?
 - Examples: check the examples folder to learn from the code. (The tests folder can also be helpful)
 - otherwise, below a simple code

>  class 
>  	APP
>  
>  inherit 
>  	SHARED_TEMPLATE_CONTEXT
>  
>  create
>  	make
>  
>  feature -- Initialization
>  	make
>  		local
>  			l_foo_object: FOO
>  			template: TEMPLATE_FILE
>  			l_inspector: TEMPLATE_INSPECTOR
>  		do
>  				-- Initialize data
>  			create l_foo_object.make ("An object FOO")
>  
>  				-- The template files are inside folder "tpl"
>  			template_context.set_template_folder ("tpl")
>  
>  				-- Register the eventual template inspectors (see related section for help)
>  			create {FOO_TEMPLATE_INSPECTOR} l_inspector.register ("detachable FOO")
>  
>  				-- The template file to process is "test.tpl"
>  			create template.make_from_file ("test.tpl")
>  
>  				-- Associate data with name
>  			template.add_value (l_foo_object, "foo")
>  			template.add_value ("A nice title", "title")
>  
>  				-- Then analyze and generate output as expected
>  			template.analyze
>  			template.get_output
>  
>  				-- Print the result
>  			print (template.output)
>  		end
>  
>  end

## Future evolutions
  - Allow  `${foo}`  without the ending slash, for now it is required to write `${foo/}`
  - Add implementation for `{else}`
  - Add other instructions if needed.
  - separate the template representation from the template execution
  - inspector:
    - review the inspector design, and use TYPE instead of string for registration
    - avoid use of once functions, so that templates do not share the same inspector for the whole application

# Project Status

- **Status**: NEED-IMPROVEMENT, NEED-CLEANING
- **Goal**: build template library inspired by the php smarty template engine
- **reference**: http://www.smarty.net/
- **project**: https://github.com/eiffelhub/template-smarty

    copyright: "2011-2013, Jocelyn Fiat, Javier Velilla and EiffelSoftware"
    
    license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
    
    source: "[
                 Jocelyn Fiat
                 Contact: http://about.jocelynfiat.net/
         ]"

