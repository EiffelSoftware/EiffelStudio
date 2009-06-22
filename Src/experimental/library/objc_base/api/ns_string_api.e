note
	description: "Summary description for {NS_STRING_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_STRING_API

inherit
	NS_OBJECT_BASIC_TYPE

feature -- Creating and Initializing Strings

	frozen string_with_c_string (a_c_string: POINTER; a_encoding: INTEGER): POINTER
		external
			"C inline use <Foundation/NSString.h>"
		alias
			"return [NSString stringWithCString: $a_c_string encoding: $a_encoding];"
		end

	frozen c_string_using_encoding (a_ns_string: POINTER; a_encoding: INTEGER): POINTER
		external
			"C inline use <Foundation/NSString.h>"
		alias
			"return (char*) [(NSString*)$a_ns_string cStringUsingEncoding: $a_encoding];"
		end

	frozen string_with_characters (a_characters: POINTER; a_length: like ns_uinteger): POINTER
			-- - (id)stringWithCharacters:(const unichar *)characters length:(NSUInteger)length
		external
			"C inline use <Foundation/NSString.h>"
		alias
			"return [NSString stringWithCharacters: $a_characters length: $a_length];"
		end


 feature -- Creating and Initializing a String from a File

 feature -- Creating and Initializing a String from an URL

 feature -- Writing to a File or URL

 feature -- Getting a String's Length

 feature -- Getting Characters and Bytes

 feature -- Getting C Strings

 feature -- Combining Strings

 feature -- Dividing Strings

 feature -- Finding Characters and Substrings

 feature -- Replacing Substrings

 feature -- Determining Line and Paragraph Ranges

 feature -- Determining Composed Character Sequences

 feature -- Converting String Contents Into a Property List

 feature -- Identifying and Comparing Strings

 feature -- Folding Strings

 feature -- Getting a Shared Prefix

 feature -- Changing Case

 feature -- Getting Strings with Mapping

 feature -- Getting Numeric Values

 feature -- Working with Encodings

 feature -- Working with Paths

 feature -- Working with URLs

end
