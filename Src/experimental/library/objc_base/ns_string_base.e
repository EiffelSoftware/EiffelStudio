note
	description: "Wrapper for NSString."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_STRING_BASE

inherit
	NS_OBJECT

create
	make_with_string,
	make_with_cstring
create {NS_OBJECT}
	make_from_pointer

feature {NONE} -- Creation

	make_with_cstring (a_c_string: C_STRING)
		do
			make_from_pointer ({NS_STRING_API}.string_with_c_string (a_c_string.item))
		end

	make_with_string (a_string: STRING_GENERAL)
		local
			cstring: C_STRING
		do
			create cstring.make (a_string)
			make_with_cstring (cstring)
		end

feature -- Access

	to_string: STRING
		local
			cstring: C_STRING
		do
			create cstring.make_shared_from_pointer ({NS_STRING_API}.c_string_using_encoding (item))
			Result := cstring.string.as_string_32
		ensure
			result_not_void: Result /= void
		end

end
