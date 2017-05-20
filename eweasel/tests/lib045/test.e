class TEST
create
	make
feature
	make
		local
			h: HEXADECIMAL_STRING_TO_INTEGER_CONVERTER
		do
			io.put_string ("Test 1: ")
			create h.make
			h.parse_string_with_type ("-90", {NUMERIC_INFORMATION}.type_natural_32)
			if h.is_integral_integer then
				io.put_natural_32 (h.parsed_natural_32)
			else
				io.put_string ("OK")
			end
			io.put_new_line

			io.put_string ("Test 2: ")
			create h.make
			h.parse_string_with_type ("-x90", {NUMERIC_INFORMATION}.type_natural_32)
			if h.is_integral_integer then
				io.put_natural_32 (h.parsed_natural_32)
			else
				io.put_string ("OK")
			end
			io.put_new_line
		end
end