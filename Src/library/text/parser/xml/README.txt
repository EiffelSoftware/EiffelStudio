XML v2 libraries

= Description =
- XML parser: parser and callbacks components
- XML tree: document, elements, and nodes (and related visitors)

= What is the difference with previous set of XML libraries =
This set of libraries is a fork of previous set.
It adds unicode support.
As a consequence it manipulates instances of STRING_32, and not just STRING_8.
The various features signature uses (*)_STRING_32.

This is the main breaking change with previous XML libraries.
Users are encouraged to migrate to this new version, since previous version was handling only ASCII, and had trouble to unescape entities such as &#12345;  (which represents a unicode character).

In addition, it does not make sense to restrict XML to ASCII, and the XML specification is all about unicode.

= How to migrate to XML v2 =
- Update your configuration files  ( .ecf ) to use the new xml_*.ecf paths.
- Make sure the various descendant of XML_CALLBACKS uses the adapted signature. And thus manipulate STRING_32 and not just STRING_8.
- XML_nodes returns READABLE_STRING_32 objects, and not anymore just STRING_8
- check any implicit conversion from STRING_32 to STRING_8 that might truncate and break the semantic of your XML data.

= Future changes =

= Misc =

-- Date: 2012/oct/25
