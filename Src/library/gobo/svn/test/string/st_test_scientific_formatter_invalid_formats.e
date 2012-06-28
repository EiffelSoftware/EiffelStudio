indexing

	description:

		"Test invalid formats in class ST_SCIENTIFIC_FORMATTER"

	library: "Gobo Eiffel String Library"
	copyright: "Copyright (c) 2004, Berend de Boer and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ST_TEST_SCIENTIFIC_FORMATTER_INVALID_FORMATS

inherit

	TS_TEST_CASE

	ST_FORMATTING_ROUTINES
		export {NONE} all end

create

	make_default

feature -- Test

	test_bad_type_char is
			-- Test wrong type character.
		do
			assert ("test1", not valid_format_and_parameters ("$Q", Void))
		end

	test_number_of_parameters is
			-- Test if exactly required number of parameters is detected.
		do
			assert ("test1", not valid_format_and_parameters ("$s", Void))
			assert ("test2", not valid_format_and_parameters ("$s", <<"1", "2">>))
		end

	test_bad_width is
			-- Test width not present or not an integer.
		do
			assert ("test1", not valid_format_and_parameters ("$*i", <<integer_cell (1), double_cell (1.5)>>))
			assert ("test2", not valid_format_and_parameters ("$*i", <<double_cell (1.5), integer_cell (1)>>))
			assert ("test3", not valid_format_and_parameters ("$**i", <<integer_cell (1)>>))
		end

	test_bad_precision is
			-- Test precision not present or not an integer.
		do
			assert ("test1", not valid_format_and_parameters ("$*i", <<integer_cell (1), double_cell (1.5)>>))
			assert ("test2", not valid_format_and_parameters ("$.i", <<integer_cell (1)>>))
			assert ("test3", not valid_format_and_parameters ("$.!i", <<integer_cell (1)>>))
			assert ("test4", not valid_format_and_parameters ("$10.e", <<double_cell (1.2)>>))
			assert ("test5", not valid_format_and_parameters ("$10.f", <<double_cell (1.2)>>))
		end

	test_bad_flags is
			-- Test invalid combination of flags.
		do
			assert ("test1", not valid_format_and_parameters ("$0-i", <<integer_cell (1)>>))
			assert ("test2", not valid_format_and_parameters ("$^-i", <<integer_cell (1)>>))
			assert ("test3", not valid_format_and_parameters ("$^^i", <<integer_cell (1)>>))
		end

end
