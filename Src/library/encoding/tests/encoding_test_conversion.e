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

	test is
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

			if not {PLATFORM}.is_windows then
					-- Fails on Windows.
				test_interconvert (counter, "UTF-32BE", chinese_encoding, utf32be_string)
			end
		end

	test_interconvert (a_c: INTEGER; e1, e2: STRING; a_str: STRING_GENERAL) is
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

	foo is
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

	ucs4_string: STRING_32 is
		once
			create Result.make (3)
			Result.append_code (0x233B4)
			--Result.append_code (0x0E0041)
			--Result.append_code (0xDC41)
			--Result.append_string ("A")
		end

	utf8_string: STRING_8 is
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

indexing
	correct_result_2008_8_15:
"[
----------------start 1------------------
Original String: 251522637731867

Forward Converted String: 230137128230156137231177187

Backward Converted String: 251522637731867
True
----------------end 1------------------

----------------start 2------------------
Original String: 251522637731867

Forward Converted String: 251522637731867

Backward Converted String: 251522637731867
True
----------------end 2------------------

----------------start 3------------------
Original String: 251522637731867

Forward Converted String: 230137128230156137231177187

Backward Converted String: 251522637731867
True
----------------end 3------------------

----------------start 4------------------
Original String: 230137128230156137231177187

Forward Converted String: 203249211208192224

Backward Converted String: 230137128230156137231177187
True
----------------end 4------------------

----------------start 5------------------
Original String: 251522637731867

Forward Converted String: 203249211208192224

Backward Converted String: 251522637731867
True
----------------end 5------------------

----------------start 6------------------
Original String: 251522637731867

Forward Converted String: 203249211208192224

Backward Converted String: 251522637731867
True
----------------end 6------------------

----------------start 7------------------
Original String: 251522637731867

Forward Converted String: 43891076611067881205545

Backward Converted String: 251522637731867
True
----------------end 7------------------

----------------start 8------------------
Original String: 144308

Forward Converted String: 5537257268

Backward Converted String: 144308
True
----------------end 8------------------

----------------start 9------------------
Original String: 144308

Forward Converted String: 240163142180

Backward Converted String: 144308
True
----------------end 9------------------

----------------start 10------------------
Original String: 144308

Forward Converted String: 3023241728

Backward Converted String: 144308
True
----------------end 10------------------

----------------start 11------------------
Original String: 251522637731867

Forward Converted String: 10801643521577451522071724032

Backward Converted String: 251522637731867
True
----------------end 11------------------

----------------start 12------------------
Original String: 144308

Forward Converted String: 1967246303

Backward Converted String: 144308
True
----------------end 12------------------

----------------start 13------------------
Original String: 16482240731612

Forward Converted String: 230137128230156137231177187

Backward Converted String: 16482240731612
True
----------------end 13------------------

----------------start 14------------------
Original String: 16482240731612

Forward Converted String: 203249211208192224

Backward Converted String: 16482240731612
True
----------------end 14------------------

----------------start 15------------------
Original String: 3023241728

Forward Converted String: 6363

Backward Converted String: 10569646081056964608
False
----------------end 15------------------

----------------start 16------------------
Original String: 3023241728

Forward Converted String: 240163142180

Backward Converted String: 3023241728
True
----------------end 16------------------

----------------start 17------------------
Original String: 240163190180

Forward Converted String: 147380

Backward Converted String: 240163190180
True
----------------end 17------------------

----------------start 18------------------
Original String: 251522637731867

Forward Converted String: 230137128230156137231177187

Backward Converted String: 251522637731867
True
----------------end 18------------------
]"
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


