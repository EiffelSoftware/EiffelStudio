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
	make_from_pointer,
	share_from_pointer
convert
	make_with_string ({STRING_32, STRING_8, READABLE_STRING_GENERAL, STRING_GENERAL}),
	as_string_8: {STRING_8},
	as_string_32: {STRING_32}

feature {NONE} -- Creation

	make_with_cstring (a_c_string: C_STRING)
		do
			make_from_pointer ({NS_STRING_API}.create_with_c_string (a_c_string.item, {NS_STRING_API}.UTF8_string_encoding))
		end

	make_with_string (a_string: READABLE_STRING_GENERAL)
		local
			l_native_string: NATIVE_STRING
		do
			create l_native_string.make (a_string)
			make_from_pointer ({NS_STRING_API}.create_with_c_string (l_native_string.item, {NS_STRING_API}.UTF8_string_encoding))
		end

	make_empty
		local
			cstring: C_STRING
		do
			create cstring.make_empty (0)
			make_with_cstring (cstring)
		end

feature -- Access

	to_string: STRING
			-- Convert `Current' as a STRING.
		obsolete
			"Use to_string_8, to_string_32 or auto-conversion [2017-05-31]"
		do
			Result := to_string_8
		end

	as_string_8, to_string_8: STRING
			-- Convert `Current' as a STRING_8.
			-- In UTF-8 encoding.
		local
			cstring: C_STRING
		do
			create cstring.make_shared_from_pointer ({NS_STRING_API}.c_string_using_encoding (item, {NS_STRING_API}.UTF8_string_encoding))
			Result := cstring.string
		ensure
			result_not_void: Result /= void
		end

	as_string_32, to_string_32: STRING_32
			-- Convert `Current' as a STRING_32.
		local
			nstring: NATIVE_STRING
		do
			create nstring.make_from_pointer ({NS_STRING_API}.c_string_using_encoding (item, {NS_STRING_API}.UTF8_string_encoding))
			Result := nstring.string
		ensure
			result_not_void: Result /= void
		end

	character_at_index (a_index: like ns_uinteger): NATURAL_16
			-- Returns the character at a given array position.
		do
			Result := {NS_STRING_API}.character_at_index (item, a_index)
		end

feature -- Measurement

	count, length: like ns_uinteger
			-- Returns the number of Unicode characters.
		do
			Result := {NS_STRING_API}.length (item)
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
