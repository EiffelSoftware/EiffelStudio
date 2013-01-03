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
		local
			u: UTF_CONVERTER
			p: MANAGED_POINTER
			l_str: STRING_32
			l_ref: STRING_32
		do
				-- Let's create a valid Surrogate pair
			create p.make (4)
			p.put_natural_16 (0xD834, 0)
			p.put_natural_16 (0xDD1E, 2)

			create l_ref.make (1)
			l_ref.append_character ('%/119070/')

			l_str := u.utf_16_0_pointer_to_string_32 (p)
			if not l_str.same_string (l_ref) then
				io.put_string ("Not OK%N")
			end

			l_str := u.utf_16_0_pointer_to_escaped_string_32 (p)
			if not l_str.same_string (l_ref) then
				io.put_string ("Not OK%N")
			end


				-- Let's create an invalid valid Surrogate pair
			create p.make (4)
			p.put_natural_16 (0xD834, 0)
			p.put_natural_16 (0xD000, 2)

			create l_ref.make (1)
			l_ref.append_character ('%/115712/')

			l_str := u.utf_16_0_pointer_to_string_32 (p)
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
		end

end
