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
			make_from_pointer ({NS_STRING_API}.string_with_c_string (a_c_string.item, UTF8_string_encoding))
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
		local
			cstring: C_STRING
		do
			create cstring.make_shared_from_pointer ({NS_STRING_API}.c_string_using_encoding (item, UTF8_string_encoding))
			Result := cstring.string.as_string_32
		ensure
			result_not_void: Result /= void
		end

feature {NONE} -- String Encoding Constants

	frozen UTF8_string_encoding: INTEGER
			-- NSUTF8StringEncoding
			-- An 8-bit representation of Unicode characters, suitable for transmission or storage by ASCII-based systems.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSUTF8StringEncoding"
		end

	frozen UTF32_string_encoding: INTEGER
			-- NSUTF32StringEncoding
			-- 32-bit UTF encoding.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSUTF32StringEncoding"
		end

	frozen UTF32_big_endian_string_encoding: INTEGER
			-- NSUTF32BigEndianStringEncoding
			-- NSUTF32StringEncoding encoding with explicit endianness specified.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSUTF32BigEndianStringEncoding"
		end

	frozen UTF32_little_endian_string_encoding: INTEGER
			-- NSUTF32LittleEndianStringEncoding
			-- NSUTF32StringEncoding encoding with explicit endianness specified.
		external
			"C macro use <Cocoa/Cocoa.h>"
		alias
			"NSUTF32LittleEndianStringEncoding"
		end

end
