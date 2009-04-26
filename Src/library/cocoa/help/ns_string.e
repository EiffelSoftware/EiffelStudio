note
	description: "Summary description for {NS_STRING}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NS_STRING

inherit
	NS_OBJECT
		export {ANY} cocoa_object end

create
	make_shared,
	make_with_string,
	make_with_cstring

feature -- Creation

	make_with_cstring (a_c_string: C_STRING)
		do
			cocoa_object := nsstring_with_c_string (a_c_string.item)
		end

	make_with_string (a_string: STRING_GENERAL)
		local
			cstring: C_STRING
		do
			create cstring.make(a_string)
			make_with_cstring (cstring)
		end

feature -- Access

	size_with_attributes (a_attributes: NS_DICTIONARY): NS_SIZE
		do
			create Result.make
			nsstring_size_with_attributes (cocoa_object, a_attributes.cocoa_object, Result.item)
		end

	to_string: STRING
		local
			cstring: C_STRING
		do
			create cstring.make_shared_from_pointer (nsstring_c_string_using_encoding (cocoa_object))
			Result := cstring.string.as_string_32
		end

feature -- Drawing String Objects

	draw_at_point_with_attributes (a_point: NS_POINT; a_attributes: NS_DICTIONARY)
		do
			nsstring_draw_at_point_with_attributes (cocoa_object, a_point.item, a_attributes.cocoa_object)
		end

feature {NONE} -- Objective-C implementation

	frozen nsstring_with_c_string (a_c_string: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSString stringWithCString: $a_c_string encoding: NSUTF8StringEncoding];"
		end

	frozen nsstring_c_string_using_encoding (a_ns_string: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return (char*) [(NSString*)$a_ns_string cStringUsingEncoding: NSUTF8StringEncoding];"
		end

	frozen nsstring_size_with_attributes (a_ns_string: POINTER; a_attributes: POINTER; res: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[
				{
					NSSize size = [(NSString*)$a_ns_string sizeWithAttributes: $a_attributes];
					memcpy($res, &size, sizeof(NSSize));
				}
			]"
		end

	frozen nsstring_draw_at_point_with_attributes (a_ns_string: POINTER; a_point: POINTER; a_attributes: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSString*)$a_ns_string drawAtPoint: *(NSPoint*)$a_point withAttributes: $a_attributes];"
		end
end
