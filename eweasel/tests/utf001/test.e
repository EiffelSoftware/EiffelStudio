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
			test_utf_16_roundtrip
			test_utf_16_d834_dd1e
			test_utf_16_d834_d000
			test_utf_16_dc01_d834
		end

	test_utf_16_roundtrip
		local
			s: STRING_32
			u: UTF_CONVERTER
			l_upper: CELL [INTEGER_32]
			q: MANAGED_POINTER
			l_spec16: SPECIAL [NATURAL_16]
		do
			s := {STRING_32} "Manu"
			create q.make (s.count * 2 + 2)
			create l_upper.put (0)
			u.escaped_utf_32_substring_into_utf_16_0_pointer (s, 1, s.count, q, 0, l_upper)
			if not u.utf_16_0_pointer_to_escaped_string_32 (q).same_string (s) then
				io.put_string ("Not ok%N")
			end
			if not u.utf_16_0_subpointer_to_string_32 (q, 0, (l_upper.item // 2) - 1, False).same_string (s) then
				io.put_string ("Not ok%N")
			end

			l_spec16 := u.string_32_to_utf_16 (s)
			if
				not (l_spec16.item (0).to_character_8 = 'M' and l_spec16.item (1).to_character_8 = 'a' and
				l_spec16.item (2).to_character_8 = 'n' and l_spec16.item (3).to_character_8 = 'u')
			then
				io.put_string ("Not OK%N")
			end
		end

	test_utf_16_d834_dd1e
		local
			u: UTF_CONVERTER
			p, q: MANAGED_POINTER
			l_str: STRING_32
			l_ref: STRING_32
			l_utf16le: STRING_8
		do
				-- Let's create a valid Surrogate pair
			create p.make (6)
			p.put_natural_16 (0xD834, 0)
			p.put_natural_16 (0xDD1E, 2)
			p.put_natural_16 (0x0, 4)
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

				-- Now let's check that we roundtrip properly
				-- We preallocate a buffer for UTF-16 encoding that includes also the null character.
			create q.make ((l_ref.count + 1) * 2)
			u.escaped_utf_32_substring_into_utf_16_0_pointer (l_ref, 1, l_ref.count, q, 0, Void)
			if q /~ p then
				io.put_string ("Not Ok%N")
			end

			create q.make ((l_ref.count + 1) * 2)
			u.utf_32_substring_into_utf_16_0_pointer (l_ref, 1, l_ref.count, q, 0, Void)
			if q /~ p then
				io.put_string ("Not Ok%N")
			end
		end

	test_utf_16_d834_d000
		local
			u: UTF_CONVERTER
			p, q: MANAGED_POINTER
			l_str: STRING_32
			l_ref: STRING_32
			l_utf16le: STRING_8
		do
				-- Let's create an invalid valid Surrogate pair
			create p.make (6)
			p.put_natural_16 (0xD834, 0)
			p.put_natural_16 (0xD000, 2)
			p.put_natural_16 (0x0, 4)
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

				-- Now check with escape.
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

				-- Now let's check that we roundtrip properly
				-- We preallocate a buffer for UTF-16 encoding that includes also the null character.
			create q.make (2)
			u.escaped_utf_32_substring_into_utf_16_0_pointer (l_ref, 1, l_ref.count, q, 0, Void)
			if q /~ p then
				io.put_string ("Not Ok%N")
			end
		end

	test_utf_16_dc01_d834
		local
			u: UTF_CONVERTER
			p, q: MANAGED_POINTER
			l_str: STRING_32
			l_ref: STRING_32
			l_utf16le: STRING_8
		do
				-- Let's create an invalid valid Surrogate pair
			create p.make (6)
			p.put_natural_16 (0xDC01, 0)
			p.put_natural_16 (0xD834, 2)
			p.put_natural_16 (0x0, 4)
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

				-- Now let's check that we roundtrip properly
				-- We preallocate a buffer for UTF-16 encoding that includes also the null character.
			create q.make (2)
			u.escaped_utf_32_substring_into_utf_16_0_pointer (l_ref, 1, l_ref.count, q, 0, Void)
			if q /~ p then
				io.put_string ("Not Ok%N")
			end
		end

end

