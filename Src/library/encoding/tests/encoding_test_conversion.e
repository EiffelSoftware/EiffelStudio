note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	ENCODING_TEST_CONVERSION

inherit
	EQA_TEST_SET

	SYSTEM_ENCODINGS

feature -- Test routines

	conversion
			-- New test routine
		do
			test
		end

feature {NONE}

	test
		do
			test_interconvert (counter, "UTF-16", "UTF-8", utf32_16_string)
			test_interconvert (counter, (create {CODE_PAGE_CONSTANTS}).utf32, (create {CODE_PAGE_CONSTANTS}).utf16, utf32_16_string)
			test_interconvert (counter, "UTF-32", "UTF-8", utf32_16_string)
			test_interconvert (counter, "UTF-8", chinese_encoding, utf8_string)
			test_interconvert (counter, "UTF-16", chinese_encoding, utf32_16_string)
			test_interconvert (counter, "UTF-32", chinese_encoding, utf32_16_string)
			test_interconvert (counter, "UTF-16", "UTF-7", utf32_16_string)
			test_interconvert (counter, "UTF-32", "UTF-16", ucs4_string)
			test_interconvert (counter, "UTF-32", "UTF-8", ucs4_string)

			test_interconvert (counter, "UTF-32LE", "UTF-32BE", ucs4_string)
			test_interconvert (counter, "UTF-16LE", "UTF-32BE", utf32_16_string)
			test_interconvert (counter, "UTF-32LE", "UTF-16BE", ucs4_string)
			test_interconvert (counter, "UTF-16BE", "UTF-8", utf16be_string)
			test_interconvert (counter, "UTF-16BE", chinese_encoding, utf16be_string)

				-- This conversion loses data. (Fixed?)
			test_interconvert (counter, "UTF-32BE", "UTF-8", utf32be_string)

			test_interconvert (counter, "UTF-8", "UTF-32", utf8_string)
			test_interconvert (counter, (create {CODE_PAGE_CONSTANTS}).utf32, (create {CODE_PAGE_CONSTANTS}).utf8, utf32_16_string)
			test_interconvert (counter, "UTf-8", "UtF-32", utf8_string) -- Test case insensitivity.

				-- Fails on Windows and Ubuntu. Direct conversion from BE not supported.
				-- Leave it here for reference.
			-- test_interconvert (counter, "UTF-32BE", chinese_encoding, utf32be_string)
		end

	test_interconvert (a_c: INTEGER; e1, e2: STRING; a_str: STRING_GENERAL)
		local
			l_encoding1, l_encoding2: ENCODING
			l_str: STRING_GENERAL
			i: INTEGER
		do
			create l_encoding1.make (e1)
			create l_encoding2.make (e2)
			print ("%N")
			print ("----------------start " + a_c.out + "------------------")
			print ("%N")
			print ("Original String: ")
			from
				i := 1
			until
				i > a_str.count
			loop
				print (a_str.code (i))
				i := i + 1
			end
			print ("%N")

			l_encoding1.convert_to (l_encoding2, a_str)
			l_str := l_encoding1.last_converted_string

			print ("%N")
			if l_encoding1.last_conversion_successful then
				print ("Forward Converted String: ")
				from
					i := 1
				until
					i > l_str.count
				loop
					print (l_str.code (i))
					i := i + 1
				end
				print ("%N")

				l_encoding2.convert_to (l_encoding1, l_str)
				l_str := l_encoding2.last_converted_string

				print ("%N")
				if l_encoding2.last_conversion_successful then
					print ("Backward Converted String: ")
					from
						i := 1
					until
						i > l_str.count
					loop
						print (l_str.code (i))
						i := i + 1
					end
					print ("%N")
				else
					assert ("The second conversion is failing.", False)
				end
				assert ("Converting result does not match the input.", l_str.is_equal (a_str))
				print (l_str.is_equal (a_str))
				print ("%N")
			else
				assert ("The first conversion is failing.", False)
			end
			print ("----------------end " + a_c.out + "------------------")
			print ("%N")
		end

	foo
		local
			l_encoding_from, l_encoding_to: ENCODING
			l_string_from: STRING_32
			l_output: STRING_GENERAL
		do
			create l_string_from.make (2)
			l_string_from.append_code (0x0E0041)
			l_string_from.append_string ("A")

			create l_encoding_from.make ((create {CODE_PAGE_CONSTANTS}).utf32)
			create l_encoding_to.make ((create {CODE_PAGE_CONSTANTS}).utf16)

			l_encoding_from.convert_to (l_encoding_to, l_string_from)
			l_output := l_encoding_from.last_converted_string
				-- l_string_from is now 0x000E0041 0x00000041.
				-- l_output is now 0x0000DB40 0x0000DC41 0x00000041.
		end

feature {NONE} -- Counter

	counter: INTEGER
		do
			internal_conter := internal_conter + 1
			Result := internal_conter
		end

	internal_conter: like counter

feature {NONE} -- Constants

	chinese_encoding: STRING
		once
			if {PLATFORM}.is_windows then
				Result := "936"
			else
				Result := "GB18030"
			end
		end

	ucs4_string: STRING_32
		once
			create Result.make (3)
			Result.append_code (0x233B4)
			--Result.append_code (0x0E0041)
			--Result.append_code (0xDC41)
			--Result.append_string ("A")
		end

	utf8_string: STRING_8
		once
			create Result.make (4)
			Result.append_code (0xE6)
			Result.append_code (0x89)
			Result.append_code (0x80)
			Result.append_code (0xE6)
			Result.append_code (0x9C)
			Result.append_code (0x89)
			Result.append_code (0xE7)
			Result.append_code (0xB1)
			Result.append_code (0xBB)
		end

	utf16be_string: STRING_32
		once
			utf32.convert_to (create {ENCODING}.make ("UTF-16BE"), utf32_16_string)
			Result := utf32.last_converted_string
		end

	utf32be_string: STRING_32
		once
			utf32.convert_to (create {ENCODING}.make ("UTF-32BE"), ucs4_string)
			Result := utf32.last_converted_string
		end

	utf32_16_string: STRING_32
		once
			create Result.make (3)
			Result.append_code (0x6240)
			Result.append_code (0x6709)
			Result.append_code (0x7C7B)
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end


