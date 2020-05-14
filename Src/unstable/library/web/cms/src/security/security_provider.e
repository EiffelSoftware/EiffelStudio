note
	description: "Provides security routine helpers"
	date: "$Date$"
	revision: "$Revision$"

class
	SECURITY_PROVIDER

inherit

	REFACTORING_HELPER

feature -- Access

	token: STRING
			-- Cryptographic random base 64 string.
		do
			Result := salt_with_size (5)
				--	Remove trailing equal sign
			Result.keep_head (Result.count - 1)
		end

	salt: STRING
			-- Cryptographic random number of 16 bytes.
		do
			Result := salt_with_size (16)
		end

	password: STRING
			-- Cryptographic random password of 10 bytes.
		do
			Result := salt_with_size (10)
				--	Remove trailing equal signs
			Result.keep_head (Result.count - 2)
		end

	password_hash (a_password: READABLE_STRING_GENERAL; a_salt: READABLE_STRING_8): STRING
			-- Password hash based on password `a_password' and salt value `a_salt'.
		local
			utf: UTF_CONVERTER
			s: STRING
		do
			create s.make (a_password.count + a_salt.count)
			utf.utf_32_string_into_utf_8_string_8 (a_password, s)
			s.append (a_salt)
			Result := sha1_string (s)
		end

feature {NONE} -- Implementation

	salt_with_size (a_val: INTEGER): STRING
			-- Return a salt with size `a_val'.
		local
			l_salt: SALT_XOR_SHIFT_64_GENERATOR
			l_array: ARRAY [INTEGER_8]
			i: INTEGER
		do
			create l_salt.make (a_val)
			create l_array.make_empty
			i := 1
			across
				l_salt.new_sequence as c
			loop
				l_array.force (c.item.as_integer_8, i)
				i := i + 1
			end
			Result := encode_base_64 (l_array)
		end

	sha1_string (a_str: READABLE_STRING_8): STRING
			-- SHA1 diggest of `a_str'.
		do
			sha1.update_from_string (a_str)
			Result := sha1.digest_as_string
			sha1.reset
		end

	sha1: SHA1
			-- Create a SHA1 object.
		once
			create Result.make
		end

feature -- Encoding


	encode_base_64 (bytes: SPECIAL [INTEGER_8]): STRING_8
			-- Encodes a byte array into a STRING doing base64 encoding.
		local
			l_output: SPECIAL [INTEGER_8]
			l_remaining: INTEGER
			i, ptr: INTEGER
			char: CHARACTER
		do
			to_implement ("Check existing code to do that!!!.")
			create l_output.make_filled (0, ((bytes.count + 2) // 3) * 4)
			l_remaining := bytes.count
			from
				i := 0
				ptr := 0
			until
				l_remaining <= 3
			loop
				l_output [ptr] := encode_value (bytes [i] |>> 2)
				ptr := ptr + 1
				l_output [ptr] := encode_value (((bytes [i] & 0x3) |<< 4) | ((bytes [i + 1] |>> 4) & 0xF))
				ptr := ptr + 1
				l_output [ptr] := encode_value (((bytes [i + 1] & 0xF) |<< 2) | ((bytes [i + 2] |>> 6) & 0x3))
				ptr := ptr + 1
				l_output [ptr] := encode_value (bytes [i + 2] & 0x3F)
				ptr := ptr + 1
				l_remaining := l_remaining - 3
				i := i + 3
			end
				-- encode when exactly 1 element (left) to encode
			char := '='
			if l_remaining = 1 then
				l_output [ptr] := encode_value (bytes [i] |>> 2)
				ptr := ptr + 1
				l_output [ptr] := encode_value (((bytes [i]) & 0x3) |<< 4)
				ptr := ptr + 1
				l_output [ptr] := char.code.as_integer_8
				ptr := ptr + 1
				l_output [ptr] := char.code.as_integer_8
				ptr := ptr + 1
			end

				-- encode when exactly 2 elements (left) to encode
			if l_remaining = 2 then
				l_output [ptr] := encode_value (bytes [i] |>> 2)
				ptr := ptr + 1
				l_output [ptr] := encode_value (((bytes [i] & 0x3) |<< 4) | ((bytes [i + 1] |>> 4) & 0xF));
				ptr := ptr + 1
				l_output [ptr] := encode_value ((bytes [i + 1] & 0xF) |<< 2);
				ptr := ptr + 1
				l_output [ptr] := char.code.as_integer_8
				ptr := ptr + 1
			end
			Result := ""
			across
				l_output as elem
			loop
				Result.append_character (elem.item.to_character_8)
			end
		end

	base64_map: SPECIAL [CHARACTER_8]
			-- Table for Base64 encoding.
		once
			Result := ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/").area
		end

	encode_value (i: INTEGER_8): INTEGER_8
			-- Encode `i'.
		do
			Result := base64_map [i & 0x3F].code.as_integer_8
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
