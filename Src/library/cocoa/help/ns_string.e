note
	description: "Wrapper for NSString."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_STRING

inherit
	NS_OBJECT
		export
			{NS_OBJECT, NS_OUTLINE_VIEW_DATA_SOURCE} item
		end

create
	make_with_string,
	make_with_cstring
create {NS_OBJECT, NS_IMAGE_CONSTANTS}
	make_shared

feature {NONE} -- Creation

	make_with_cstring (a_c_string: C_STRING)
		do
			make_shared (nsstring_with_c_string (a_c_string.item))
		end

	make_with_string (a_string: STRING_GENERAL)
		local
			cstring: C_STRING
		do
			create cstring.make (a_string)
			make_with_cstring (cstring)
		end

feature -- Access

	size_with_attributes (a_attributes: NS_DICTIONARY): NS_SIZE
		require
			attributes_not_void: a_attributes /= void -- May nil be passed?
		do
			create Result.make
			nsstring_size_with_attributes (item, a_attributes.item, Result.item)
		ensure
			result_not_void: Result /= void
		end

	to_string: STRING
		local
			cstring: C_STRING
		do
			create cstring.make_shared_from_pointer (nsstring_c_string_using_encoding (item))
			Result := cstring.string.as_string_32
		ensure
			result_not_void: Result /= void
		end

feature -- Drawing String Objects

	draw_at_point_with_attributes (a_point: NS_POINT; a_attributes: NS_DICTIONARY)
		do
			nsstring_draw_at_point_with_attributes (item, a_point.item, a_attributes.item)
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
