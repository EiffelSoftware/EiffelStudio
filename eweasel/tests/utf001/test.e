class TEST

inherit
	NATIVE_STRING_HANDLER

create
	make
feature

	make
		do
			test_utf_16_surrogate
		end

	test_utf_16_surrogate
		do
			test_utf_16_d834_dd1e
			test_utf_16_d834_d000
			test_utf_16_dc01_d834
		end

	test_utf_16_d834_dd1e
		local
			u: UTF_CONVERTER
			p: MANAGED_POINTER
			l_str: STRING_32
			l_ref: STRING_32
			l_utf16le: STRING_8
		do
				-- Let's create a valid Surrogate pair
			create p.make (4)
			p.put_natural_16 (0xD834, 0)
			p.put_natural_16 (0xDD1E, 2)
			create l_utf16le.make (6)
			l_utf16le.append_character ('%/0x34/')
			l_utf16le.append_character ('%/0xD8/')
			l_utf16le.append_character ('%/0x1E/')
			l_utf16le.append_character ('%/0xDD/')

			create l_ref.make (1)
			l_ref.append_character ('%/119070/')

			l_str := u.utf_16_0_pointer_to_string_32 (p)
			if not l_str.same_string (l_ref) then
				io.put_string ("Not OK%N")
			end

			l_str := u.utf_16le_string_8_to_string_32 (l_utf16le)
			if not l_str.same_string (l_ref) then
				io.put_string ("Not OK%N")
			end

			l_str := u.utf_16_0_pointer_to_escaped_string_32 (p)
			if not l_str.same_string (l_ref) then
				io.put_string ("Not OK%N")
			end

			l_str := u.utf_16le_string_8_to_escaped_string_32 (l_utf16le)
			if not l_str.same_string (l_ref) then
				io.put_string ("Not OK%N")
			end
		end

	test_utf_16_d834_d000
		local
			u: UTF_CONVERTER
			p: MANAGED_POINTER
			l_str: STRING_32
			l_ref: STRING_32
			l_utf16le: STRING_8
		do
				-- Let's create an invalid valid Surrogate pair
			create p.make (4)
			p.put_natural_16 (0xD834, 0)
			p.put_natural_16 (0xD000, 2)
			create l_utf16le.make (6)
			l_utf16le.append_character ('%/0x34/')
			l_utf16le.append_character ('%/0xD8/')
			l_utf16le.append_character ('%/0x00/')
			l_utf16le.append_character ('%/0xD0/')

			create l_ref.make (1)
			l_ref.append_character ('%/115712/')

			l_str := u.utf_16_0_pointer_to_string_32 (p)
			if not l_str.same_string (l_ref) then
				io.put_string ("Not OK%N")
			end

			l_str := u.utf_16le_string_8_to_string_32 (l_utf16le)
			if not l_str.same_string (l_ref) then
				io.put_string ("Not OK%N")
			end

			create l_ref.make (7)
			l_ref.append_character ('%/65533/')
			l_ref.append_string_general ("uD834")
			l_ref.append_character ('%/53248/')

			l_str := u.utf_16_0_pointer_to_escaped_string_32 (p)
			if not l_str.same_string (l_ref) then
				io.put_string ("Not OK%N")
			end

			l_str := u.utf_16le_string_8_to_escaped_string_32 (l_utf16le)
			if not l_str.same_string (l_ref) then
				io.put_string ("Not OK%N")
			end
		end

	test_utf_16_dc01_d834
		local
			u: UTF_CONVERTER
			p: MANAGED_POINTER
			l_str: STRING_32
			l_ref: STRING_32
			l_utf16le: STRING_8
		do
				-- Let's create an invalid valid Surrogate pair
			create p.make (4)
			p.put_natural_16 (0xDC01, 0)
			p.put_natural_16 (0xD834, 2)
			create l_utf16le.make (6)
			l_utf16le.append_character ('%/0x01/')
			l_utf16le.append_character ('%/0xDC/')
			l_utf16le.append_character ('%/0x34/')
			l_utf16le.append_character ('%/0xD8/')

			create l_ref.make (1)
			l_ref.append_character ('%/1114164/')

			l_str := u.utf_16_0_pointer_to_string_32 (p)
			if not l_str.same_string (l_ref) then
				io.put_string ("Not OK%N")
			end

			l_str := u.utf_16le_string_8_to_string_32 (l_utf16le)
			if not l_str.same_string (l_ref) then
				io.put_string ("Not OK%N")
			end

			create l_ref.make (7)
			l_ref.append_character ('%/65533/')
			l_ref.append_string_general ("uDC01")
			l_ref.append_character ('%/65533/')
			l_ref.append_string_general ("uD834")

			l_str := u.utf_16_0_pointer_to_escaped_string_32 (p)
			if not l_str.same_string (l_ref) then
				io.put_string ("Not OK%N")
			end

			l_str := u.utf_16le_string_8_to_escaped_string_32 (l_utf16le)
			if not l_str.same_string (l_ref) then
				io.put_string ("Not OK%N")
			end
		end

end

