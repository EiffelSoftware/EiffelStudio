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
			print_routine_header,
			print_header,
			print_footer
		end

create
	make

feature {NONE} -- Access

	counter: NATURAL
			-- Counter for `print_routine_name' (simple solution for now)

	current_result: ?AUT_TEST_CASE_RESULT assign set_current_result
			-- Result for which test is currently printed

feature -- Status setting

	set_current_result (a_result: like current_result)
			-- Set `current_result' to `a_result'.
		do
			current_result := a_result
		ensure
			current_result_set: current_result = a_result
		end

feature {NONE} -- Printing

	print_routine_header
			-- <Precursor>
		local
			l_feature: FEATURE_I
		do
			indent
			print_indentation
			counter := counter + 1
			output_stream.put_string ("generated_test_")
			output_stream.put_line (counter.out)

			if current_result /= Void then
				indent
				print_indentation
				output_stream.put_line ("indexing")
				indent
				print_indentation
				output_stream.put_string ("testing: %"covers/{")
				output_stream.put_string (current_result.class_.name)
				output_stream.put_string ("}")
				l_feature := current_result.feature_
				if not (l_feature.is_prefix or l_feature.is_infix) then
					output_stream.put_string (".")
					output_stream.put_string (l_feature.feature_name)
				end
				output_stream.put_line ("%"")
				dedent
				dedent
			end
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
