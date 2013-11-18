CONNEG is a library that provides utilities to select the best repesentation of a resource for a client where there are multiple representations available.

Using this library you can retrieve the best variant for media type, language preference, charset, and enconding/compression.

Take into account that the library is under development so is expected that the API change.

The library contains utilities that deal with content negotiation (server driven negotiation).This utility class
is based on ideas taken from the Book Restful WebServices Cookbook

The class SERVER_CONTENT_NEGOTIATION contains several features that helps to write different types of negotiation (media type, language,
charset and compression).
So for each of the following questions, you will have a corresponding method to help in the solution.

-  How to implement Media type negotiation?
	Hint: Use SERVER_CONTENT_NEGOTIATION.media_type_preference 
	       or SERVER_MEDIA_TYPE_NEGOTIATION.preference 

-  How to implement Language Negotiation?
	Hint: Use SERVER_CONTENT_NEGOTIATION.language_preference
	       or SERVER_LANGUAGE_NEGOTIATION.preference 

-  How to implement Character Negotiation?
	Hint: Use SERVER_CONTENT_NEGOTIATION.charset_preference
	       or SERVER_CHARSET_NEGOTIATION.preference 

-  How to implement Encoding Negotiation?
	Hint: Use SERVER_CONTENT_NEGOTIATION.encoding_preference
	       or SERVER_ENCODING_NEGOTIATION.preference 

There is also a  [test case](test/conneg_server_side_test.e "conneg_server_side_test") where you can check how to use this class.

