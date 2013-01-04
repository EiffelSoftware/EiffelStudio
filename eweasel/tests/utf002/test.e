class TEST

inherit
	NATIVE_STRING_HANDLER

create
	make
feature

	make
		do
			test_utf_8
		end

	test_utf_8
		do
			test_utf_8_roundtrip
		end

feature -- UTF-8 tests

	test_utf_8_roundtrip
		local
			s: STRING_32
			l_utf8: STRING_8
			u: UTF_CONVERTER
			l_upper: CELL [INTEGER_32]
			q: MANAGED_POINTER
		do
			create s.make (2)
			s.append_character ('%/112900/')
			s.append_character ('%U')
			s.append_character ('a')
			s.append_character ('%/119070/')

			l_utf8 := u.escaped_utf_32_string_to_utf_8_string_8 (s)
			if not l_utf8.same_string ("%/240/%/155/%/164/%/132/%Ua%/240/%/157/%/132/%/158/") then
				io.put_string ("Not Ok%N")
			end

				-- Various conversion using different initial size for `q' that will trigger
				-- some kind of resizing.
			create q.make (s.count + 1)
			create l_upper.put (0)
			u.escaped_utf_32_substring_into_utf_8_0_pointer (s, 1, s.count, q, 0, l_upper)
			if not u.utf_8_0_subpointer_to_escaped_string_32 (q, 0, l_upper.item - 1, False).same_string (s) then
				io.put_string ("Not Ok%N")
			end

			create q.make (s.count + 10)
			create l_upper.put (0)
			u.escaped_utf_32_substring_into_utf_8_0_pointer (s, 1, s.count, q, 0, l_upper)
			if not u.utf_8_0_subpointer_to_escaped_string_32 (q, 0, l_upper.item - 1, False).same_string (s) then
				io.put_string ("Not Ok%N")
			end

			create q.make (1)
			create l_upper.put (0)
			u.escaped_utf_32_substring_into_utf_8_0_pointer (s, 1, s.count, q, 0, l_upper)
			if not u.utf_8_0_subpointer_to_escaped_string_32 (q, 0, l_upper.item - 1, False).same_string (s) then
				io.put_string ("Not Ok%N")
			end


			create s.make (2)
			s.append_character ('%/112900/')
			s.append_character ('a')
			s.append_character ('%/119070/')
			create q.make (1)
			create l_upper.put (0)
			u.utf_32_string_into_utf_8_0_pointer (s, q, 0, l_upper)
			if not u.utf_8_0_pointer_to_escaped_string_32 (q).same_string (s) then
				io.put_string ("Not Ok%N")
			end
		end

end
