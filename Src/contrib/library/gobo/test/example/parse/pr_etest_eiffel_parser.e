indexing

	description:

		"Test 'eiffel_parser' example"

	library: "Gobo Eiffel Parse Library"
	copyright: "Copyright (c) 2001, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class PR_ETEST_EIFFEL_PARSER

inherit

	EXAMPLE_TEST_CASE

create

	make_default

feature -- Access

	program_name: STRING is "eiffel_parser"
			-- Program name

	library_name: STRING is "parse"
			-- Library name of example

feature -- Test

	test_eiffel_parser is
			-- Test 'eiffel_parser' example.
		local
			eiffel_parser_exe: STRING
		do
			compile_program
				-- Run example.
			eiffel_parser_exe := program_exe
			assert_execute (eiffel_parser_exe + " 2 " + sample_e_filename + output_log)
			if file_system.file_count (output_log_filename) = 0 then
				assert ("no_output_log", True)
			elseif file_system.same_text_files (freeise_log_filename, output_log_filename) then
					-- Free version of ISE Eiffel?
				assert ("freeise_no_output_log", True)
			else
				assert_integers_equal ("no_output_log2", 0, file_system.file_count (output_log_filename))
			end
			assert_integers_equal ("no_error_log", 0, file_system.file_count (error_log_filename))
		end

feature {NONE} -- Implementation

	sample_dirname: STRING is
			-- Name of directory where sample files are located
		once
			Result := file_system.nested_pathname ("${GOBO}", <<"test", "example", "parse", "data">>)
			Result := Execution_environment.interpreted_string (Result)
		ensure
			sample_dirname_not_void: Result /= Void
			sample_dirname_not_empty: Result.count > 0
		end

	sample_e_filename: STRING is
			-- Name of sample Eiffel file
		once
			Result := file_system.pathname (sample_dirname, "sample.e")
		ensure
			sample_e_filename_not_void: Result /= Void
			sample_e_filename_not_empty: Result.count > 0
		end

end
