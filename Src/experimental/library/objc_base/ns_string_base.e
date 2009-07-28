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
convert
	make_with_string ({STRING_32, STRING_8, STRING_GENERAL}),
	as_string_8: {STRING_8},
	as_string_32: {STRING_32}

feature {NONE} -- Creation

	make_with_cstring (a_c_string: C_STRING)
		do
			make_from_pointer ({NS_STRING_API}.string_with_c_string (a_c_string.item, {NS_STRING_API}.UTF8_string_encoding))
		end

	make_with_string (a_string: READABLE_STRING_GENERAL)
		local
			cstring: C_STRING
--			cstring32: MANAGED_POINTER
--			i: INTEGER
		do
--			Not yet working as expected. Strings get cut off early for some reason
--			if attached {STRING_32} a_string as string32 then
--				create cstring32.make ((string32.count + 1) * {PLATFORM}.character_32_bytes)
--				from
--					i := 0
--				until
--					i >= string32.count
--				loop
--					cstring32.put_integer_32 (string32.item_code (i + 1), i * {PLATFORM}.character_32_bytes)
--					i := i + 1
--				end
--				make_from_pointer ({NS_STRING_API}.string_with_characters (cstring32.item, string32.count.as_natural_32))
--			else
				create cstring.make (a_string)
				make_with_cstring (cstring)
--			end
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
			"Use to_string_8, to_string_32 or auto-conversion"
		do
			Result := to_string_8
		end

	as_string_8, to_string_8: STRING
			-- Convert `Current' as a STRING_8.
		local
			cstring: C_STRING
		do
			create cstring.make_shared_from_pointer ({NS_STRING_API}.c_string_using_encoding (item, {NS_STRING_API}.UTF8_string_encoding))
			Result := cstring.string.as_string_8
		ensure
			result_not_void: Result /= void
		end

	as_string_32, to_string_32: STRING_32
			-- Convert `Current' as a STRING_32.
		local
			cstring: C_STRING
		do
			create cstring.make_shared_from_pointer ({NS_STRING_API}.c_string_using_encoding (item, {NS_STRING_API}.UTF8_string_encoding))
			Result := cstring.string.as_string_32
		ensure
			result_not_void: Result /= void
		end
end
