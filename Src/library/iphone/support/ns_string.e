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
			{ANY} item
		end

create
	make_with_string,
	make_with_cstring,
	make_from_pointer

feature {NONE} -- Creation

	make_with_cstring (a_c_string: C_STRING)
		do
			share_from_pointer (nsstring_with_c_string (a_c_string.item))
		end

	make_with_string (a_string: READABLE_STRING_GENERAL)
		local
			cstring: C_STRING
		do
			create cstring.make (a_string)
			make_with_cstring (cstring)
		end

feature -- Access

	to_string: STRING_32
		local
			cstring: C_STRING
		do
			create cstring.make_shared_from_pointer (nsstring_c_string_using_encoding (item))
			Result := cstring.string.as_string_32
		ensure
			result_not_void: Result /= void
		end

feature {NONE} -- Objective-C implementation

	frozen nsstring_with_c_string (a_c_string: POINTER): POINTER
		external
			"C inline use <Foundation/NSString.h>"
		alias
			"return [NSString stringWithCString: $a_c_string encoding: NSUTF8StringEncoding];"
		end

	frozen nsstring_c_string_using_encoding (a_ns_string: POINTER): POINTER
		external
			"C inline use <Foundation/NSString.h>"
		alias
			"return (char*) [(NSString*)$a_ns_string cStringUsingEncoding: NSUTF8StringEncoding];"
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
