[![Build Status](https://travis-ci.org/eiffelhub/json.svg?branch=master)](https://travis-ci.org/eiffelhub/json)

Readme file for eJSON
=====================

- team: "Jocelyn Fiat, Javier Velilla"
- previous contributors: "Paul Cohen"
- date: "2018-sept-19"

## Introduction

eJSON stands for Eiffel JSON library and is a small Eiffel library for dealing
with the JSON format. This library provides a JSON parser and visitors,
including a pretty printer.

The "serialization" interfaces replace the obsolete converters interfaces.

## Legal stuff

eJSON is copyrighted by the authors Jocelyn Fiat, Javier Velilla, and others. It is licensed under the MIT License. See the file license.txt in the same directory as this readme file.

## Versioning scheme

eJSON version numbers has the form: `"major number"."minor number"."patch level" `

eJSON will retain the major number 0 as long as it has beta status. A change in major number indicates that a release is not backward compatible. A change in minor number indicates that a release is backward compatible (within that major
number) but that new useful features may have been added. A change in patch level simply indicates that the release contains bug fixes for the previous release. Note that as long as eJSON is in beta status (0.Y.Z) backward compatibility is not guranteed for changes in minor numbers!

## Documentation

Currently the only documentation on eJSON is available at: `https://github.com/eiffelhub/json/blob/master/doc/user_guide.md`

## Requirements and installation

EJSON requires that you have:

One of the following compiler combinations installed:
   * ISE Eiffel 17.05 or later.
   * gec [try to test]

eJSON probably works fine with other versions of the above compilers.
There are no known platform dependencies (Windows, Linux).

To install eJSON simply extract the ejson-X.Y.Z.zip file to some appropriate place on your hard disk. There are no requirements on environment variables or registry variables. 
Note eJSON is also delivered within EiffelStudio release, under `$ISE_LIBRARY/contrib/library/text/parser/json`

To verify that everything works you should compile the example programs and/or
the test program.

## Contents of eJSON

All directory names below are relative to the root directory of your ejson installation. 

- doc:         Contains documentation file.
- examples:    Contains example codes.
- library:     Contains the actual eJSON library classes.
- test:        Contains test suite for eJSON.

## Contacting the Team

Contact the team: https://github.com/eiffelhub/json/issues

## Releases

```
Version Date            Description
------- ----            -----------
0.11.0 2019-02-08	REAL NaN, Negative and Positive Infinity values are serialized as "null" 
					(as JSON has no support for such values).
0.10.0 2018-11-14	Improved parsing performance (speed and memory).
					Allow to change default size for json array and object created during parsing.
0.9.0  2018-09-19	Added basic serialization
					Updated the serialization example to demonstrate the use of custom (de)serializers.
					Added JSON_VALUE.chained_item (a_key): JSON_VALUE to be able to access
					  `json@"person"@"address"@"city"` and return associated JSON value if any, 
					   otherwise JSON_NULL.

0.8.0  2018-09-13	Ensure the `JSON_STRING`.item is really UTF-8 encoded (even for characters between 128 and 255)!
					Properly encode null character as \u0000 .
					Unescape escaped unicode in unescape_to_string_8 when it represents a valid `CHARACTER_8` value.
					Fixed parsing of integer 64 value
0.7.1   2017-03-20	Added `JSON_VALUE.is_string` ... `is_null` boolean query for convenience.
0.7.1   2017-03-20	Added `JSON_VALUE.is_string` ... `is_null` boolean query for convenience.
0.7.0   2016-08-01	New JSON serialization implementation (to replace the obsolete converters).
0.6.0   2014-11-17	Fixed various issue with parsing string (such as \t and related),
					Implemented escaping of slash '/' only in case of '</' to avoid 
					  potential issue with javascript and </script>
					Many feature renaming to match Eiffel style and naming convention, 
					  kept previous feature as obsolete.
					Restructured the library to make easy extraction of "converter" 
					classes if needed in the future.
					Marked converters classes as obsolete.
0.5.0   2013-11-31	Added `JSON_ITERATOR`, simplified `JSON_OBJECT`
0.4.0   2012-12-12	Updated documentation URI
0.3.0   2011-07-06	JSON Factory Converters
0.2.0   2010-02-07	Adapted to EiffelStudio 6.4 or later, supports void-safety
0.1.0   2010-02-07	First release, Adapted to SmartEiffel 1.2r7 and EiffelStudio 6.2 or previous
```

