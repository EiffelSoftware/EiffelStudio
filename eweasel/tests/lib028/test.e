class TEST

inherit
	SYSTEM_ENCODINGS

create
	make

feature

	make is
		do
			test_convert (utf32, utf8, utf32_string, utf8_string)
			test_convert (utf8, utf32, utf8_string, utf32_string)
			test_convert (iso_8859_1, utf8, iso_8859_1_string, iso_8859_1_string)
			test_convert (utf8, iso_8859_1, iso_8859_1_string, iso_8859_1_string)
			test_convert (utf8, console_encoding, iso_8859_1_string, Void)
			test_convert (console_encoding, utf8, iso_8859_1_string, Void)
		end
	
	iso_8859_1_string: STRING is
		local
			i: NATURAL_32
		once
			create Result.make (128)
			from
				i := 1
			until
				i = 128
			loop
				Result.append_code (i)
				i := i + 1
			end
		end
		
	utf32_string: STRING_32 is
			-- Char of Chinese "earth".
		once
			create Result.make (1)
			Result.append_code (0x571F)
		end

	utf8_string: STRING_8 is
			-- Char of Chinese "earth".
		once
			create Result.make (3)
			Result.append_code (0xE5)
			Result.append_code (0x9C)
			Result.append_code (0x9F)
		end
		
	iso_8859_1: !ENCODING
			-- Encoding ISO-8859-1 encoding.
			-- TODO: This encoding should be eventually integrated
			-- into encoding library.
			-- (export status {NONE})
		once
			if {PLATFORM}.is_windows then
				create Result.make ("28591")
			else
				create Result.make ("ISO-8859-1")
			end
		end
		
	test_convert (a_from_encoding, a_to_encoding: ENCODING; a_str, a_expected_str: STRING_GENERAL) is
		local
			l_result: BOOLEAN
		do
			a_from_encoding.convert_to (a_to_encoding, a_str);
			l_result := (a_from_encoding.last_conversion_successful and then
				a_from_encoding.last_converted_string /= Void)
			if l_result and then a_expected_str /= Void then
				if not a_expected_str.is_equal (a_from_encoding.last_converted_string) then
					print_converting (a_from_encoding, a_to_encoding)
					print ("Conversion result does not match.%N")
				end
			end
			if not l_result then
				print_converting (a_from_encoding, a_to_encoding)
				print ("Conversion failed.%N")
			end
		end
		
	print_converting (a_from_encoding, a_to_encoding: ENCODING) is
		do
			print ("Converting string of ")
			print (a_from_encoding.code_page)
			print (" to ")
			print (a_to_encoding.code_page)
			io.put_new_line
		end

end
