indexing
	description: "[
		Descendant of {AUT_TEST_CASE_PRINTER} that does not print any class header/footer.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_GENERATED_TEST_WRITER

inherit
	AUT_TEST_CASE_PRINTER
		redefine
			print_routine_name,
			print_header,
			print_footer
		end

create
	make

feature {NONE} -- Access

	counter: NATURAL
			-- Counter for `print_routine_name' (simple solution for now)

feature {NONE} -- Printing

	print_routine_name
			-- <Precursor>
		do
			counter := counter + 1
			output_stream.put_string ("generated_test_")
			output_stream.put_string (counter.out)
		end

	print_header
			-- <Precursor>
		do
		end

	print_footer
			-- <Precursor>
		do
		end

end
