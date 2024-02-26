# Preface 

This document is a living document! As always read and try out the code to understand what's really going on.

## About the project 

The eJSON project was started by Javier Velilla in 2008. The aim was simply to
provide JSON support to Eiffel programmers. A couple of other people have been
involved to various extent since the start; Berend de Boer, Jocelyn Fiat and
Manu Stapf. In 2009 Paul Cohen joined the project as an active developer and
later Jocelyn Fiat.

The current active maintainers:
- Jocelyn Fiat
- Javier Velilla

The formal name of the project is "eJSON".

For questions regarding eJSON please contact
- <jfiat at eiffel.com>
- <javier.hector at gmail.com> 
- or directly on [
## Current version and status 

The latest release is 0.8.0. eJSON has been improved and cleaned.
The converters are now obsolete and are replaced by the "serialization" interfaces.


# Introduction 

## What is JSON? 

JSON (JavaScript Object Notation) is a lightweight computer data interchange format. It is a text-based, human-readable format for representing simple data structures and associative arrays (called objects). See the [http://en.wikipedia.org/wiki/JSON Wikipedia article on JSON](https://github.com/eiffelhub/json/issues]), [www.json.org](http://www.json.org) and [www.json.com](http://www.json.com) for more information.

The JSON format is specified in [IETF RFC 4627](http://www.ietf.org/rfc/rfc4627.txt) by Douglas Crockford. The official [Internet MIME media type](http://www.iana.org/assignments/media-types) for JSON is "application/json". The recommended file name extension for JSON files is ".json".

## Advantages 

1. Lightweight data-interchange format.
2. Easy for humans to read and write.
3. Enables easy integration with AJAX/JavaScript web applications. See the article [Speeding Up AJAX with JSON](http://www.developer.com/lang/jscript/article.php/3596836) for a good short discussion on this subject.
4. JSON data structures translate with ease into the native data structures universal to almost all programming languages used today.

## Use in Eiffel applications 

JSON can be used as a general serialization format for Eiffel objects. As such it could be used as a:

* Data representation format in REST-based web service applications written in Eiffel.
* Serialization format for Eiffel objects in persistence solutions.
* File format for configuration files in Eiffel systems.

## Prerequisites 

eJSON works today with EiffelStudio 17.05
There is an optional extension that requires the latest snapshot of the Gobo Eiffel libraries (a working snapshot is distributed with EiffelStudio). The depencencies on Gobo are on Gobo's unicode and regex libraries and for some of the extra features in eJSON, on Gobos structure classes `DS_HASH_TABLE` and `DS_LINKED_LIST`.

eJSON is intended to work with all ECMA compliant Eiffel compilers.

## Installation 

You can either download a given release and install on your machine or you can get the latest snapshot of the code.
To download latest source code: [master archive file](https://github.com/eiffelhub/json/archive/master.zip). 
To get the latest snapshot of the code do:

:   $ git clone https://github.com/eiffelhub/json.git json

*[download page](https://github.com/eiffelhub/json/releases)
*[github project](https://github.com/eiffelhub/json)

Note that the latest json release is also delivered with EiffelStudio installation under <code>$ISE_LIBRARY/contrib/library/text/parser/json</code>.


## Cluster and directory layout 

```
 	json/
 	  library/ (Root directory for eJSON library classes)
 		kernel/ (All classes in this cluster should eventually only depend on ECMA Eiffel and FreeELKS).
 		  json_array.e
 		  json_boolean.e
 		  json_null.e
 		  json_number.e
 		  json_object.e
 		  json_string.e
 		  json_value.e
		parser/
		  json_parser.e
		  json_parser_access.e
		  json_reader.e
		  json_tokens.e
		utility/
		  file/
		     json_file_reader.e
		  visitor/
			json_visitor.e
			json_iterator.e
			json_pretty_string_visitor.e
			print_json_visitor.e
		serialization/
		  deserializer/...
		  serializer/...
		  ...
	    converters/ (JSON core converter classes !OBSOLETE!)
	    gobo_converters/ (JSON core converter classes support for GOBO !OBSOLETE!)
 	  test/ (Contains autotest suite)
 		autotest/ (AutoTest based unit test).
 	  examples/ (Example code)
```

## Future development 

Here is a list of suggestions for future development of eJSON.
* Suggestion: Investigate performance and improve it if neccessary.
* Suggestion: Support JSON references. See [JSON Referencing Proposal and Library](http://www.json.com/2007/10/19/json-referencing-proposal-and-library) and [JSON referencing in Dojo](http://www.sitepen.com/blog/2008/06/17/json-referencing-in-dojo) for more information.
* Suggestion: Support JSON path. See [JSONPath - XPath for JSON](http://goessner.net/articles/JsonPath) for more information.
* Suggestion: Support JSON schema validation. See [JSON Schema Proposal](http://json-schema.org) for more information.
* Suggestion: Support RDF JSON serialization. See [RDF JSON Specification](http://n2.talis.com/wiki/RDF_JSON_Specification) for more information.
* Suggestion: Add support to JSON classes for conversion from Eiffel manifest values. So one can write things like:

# Mapping of JSON values to Eiffel values  

## JSON number 

JSON numbers are represented by the class `JSON_NUMBER`. JSON number values can be converted to/from `NATURAL_*`, `INTEGER_*` and `REAL_*` values. For floating point values `REAL_*` is used. The complete mapping is as follows:

JSON number ->  Eiffel:
* -128 <= n <= +127 -> INTEGER_8
* n can't be represented by INTEGER_8 and -32768 <= n <= +32767 ->  `INTEGER_16`
* n can't be represented by INTEGER_16 and -2147483648 <= n <= +2147483647 -> `INTEGER_32`
* n can't be represented by INTEGER_32 and -9223372036854775808 <= n <= +9223372036854775807 -> `INTEGER_64` 
* n can't be represented by INTEGER_64 and 9223372036854775808 <= n <= 18446744073709551615 -> `NATURAL_64`
* n has fractional dot '.' -> REAL_64.
* n -> eJSON exception if number can't be represented by a `INTEGER_64`, `NATURAL_64` or `REAL_64`.

Eiffel -> JSON number:
* `NATURAL_8`, `NATURAL_16`, `NATURAL_32`, `NATURAL_64`, `NATURAL` -> JSON number
* `INTEGER_8`, `INTEGER_16`, `INTEGER_32`, `INTEGER_64`, `INTEGER `-> JSON number
* `REAL_32`, `REAL_64`, `REAL` -> JSON number

You can use the following creation routines to create `JSON_NUMBER` instances:

* `JSON_NUMBER.make_integer`
* `JSON_NUMBER.make_real`
* `JSON_NUMBER.make_natural`

```
 	eiffel_to_json_number_representation is
 		local
 			i: INTEGER
 			r: REAL 
 			jn: JSON_NUMBER
 		do
 			print ("JSON representation of Eiffel INTEGER: '")
 			i := 123
 			create jn.make_integer (i)
 			print (jn.representation)
 			print ("'%N")
 			print ("JSON representation of Eiffel REAL: '")
 			r := 12.3
 			create jn.make_real (r)
 			print (jn.representation)
 			print ("'%N")
 		end
```

The output of the above code will be: 

 	JSON representation of Eiffel INTEGER: '123'
 	JSON representation of Eiffel REAL: '12.300000190734863'

## JSON boolean 

JSON boolean values are represented by the class `JSON_BOOLEAN`. The JSON boolean value "true" is converted to/from the `BOOLEAN` value "True" and the JSON boolean value "false is converted to/from the `BOOLEAN` value "False".

```
 	eiffel_to_json_boolean_representation is
 		local
 			b: BOOLEAN
 			jb: JSON_BOOLEAN
 		do
 			print ("JSON representation of Eiffel BOOLEAN: '")
 			b := True
 			create jb.make (b)
 			print (jb.representation)
 			print ("'%N")
 			print("JSON representation of Eiffel BOOLEAN: '")
 			b := False
 			create jb.make (b)
 			print (jb.representation)
 			print ("'%N")
 		end
```

The output of the above code will be: 

 	JSON representation of Eiffel BOOLEAN: 'true'
 	JSON representation of Eiffel BOOLEAN: 'false'

## JSON string 

JSON strings are represented by the class `JSON_STRING`. JSON string values can be converted to/from `STRING_32`, `STRING` and `CHARACTER` values. The complete mapping is as follows:

JSON string ->  Eiffel:
* All JSON strings -> `STRING` or `STRING_32`

Eiffel -> JSON string:
* `STRING_32` -> JSON string
* `STRING` -> JSON string
* `CHARACTER` -> JSON string

```	
 	eiffel_to_json_string_representation is
 		local
 			s: STRING
 			js: JSON_STRING
 		do
 			print ("JSON representation of Eiffel STRING: '")
 			s := "JSON rocks!"
 			create js.make_from_string (s)
 			print (js.representation)
 			print ("'%N")
 		end
```		

The output of the above code will be: 

 	JSON representation of Eiffel STRING: '"JSON rocks!"'

Note: JSON escape unicode characters, as well a other specific characters, to get the unescaped string value, use either 'unescaped_string_8' or 'unescaped_string_32'.

## JSON null 

The JSON null value is represented by the class `JSON_NULL`. The JSON null value can be converted to/from Void.

## JSON array 

JSON array is represented by the class `JSON_ARRAY`. 

## JSON object 

JSON object is represented by the class `JSON_OBJECT`. 


# The eJSON visitor pattern 

TBD. See examples.

# The eJSON file reader class 

TBD.

# The serialization interfaces 
- `JSON_SERIALIZER`: convert Eiffel object to JSON string
- `JSON_DESERIALIZER`: convert JSON string to Eiffel object 
- `JSON_SERIALIZATION`: convert in both way, serializer and deserializer
- JSON_*_CONTEXT: used to register custom (de)serializer, and set various settings.

