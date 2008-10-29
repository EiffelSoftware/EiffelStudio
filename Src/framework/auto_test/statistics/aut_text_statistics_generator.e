indexing

	description:

		"Generates a text page describing test statistics"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"


class AUT_TEXT_STATISTICS_GENERATOR

inherit

	AUT_STATISTICS_GENERATOR
		rename
			make as make_statistics_generator
		end

	AUT_SHARED_PATHNAMES
		export {NONE} all end

	AUT_SHARED_FILE_SYSTEM_ROUTINES
		export {NONE} all end

	UT_SHARED_TEMPLATE_EXPANDER
		export {NONE} all end

	KL_SHARED_FILE_SYSTEM
		export {NONE} all end

create

	make

feature {NONE} -- Initialization

	make (a_prefix: STRING; an_output_dirname: like output_dirname; a_system: like system; a_classes_under_test: like classes_under_test) is
			-- Create new html generator.
		require
			an_output_dirname_not_void: an_output_dirname /= Void
			a_system_not_void: a_system /= Void
			a_classes_under_test: a_classes_under_test /= Void
		do
			make_statistics_generator (an_output_dirname, a_system, a_classes_under_test)
			prefix_ := a_prefix
		ensure
			output_dirname_set: output_dirname = an_output_dirname
			system_set: system = a_system
			classes_under_test_set: classes_under_test = a_classes_under_test
			prefix_set: prefix_ = a_prefix
		end

feature -- Access

	absolute_index_filename: STRING is
			-- Absolute filename of text file
		do
			Result := file_system.pathname (output_dirname, prefix_ + "statistics.txt")
		end

	prefix_: STRING
			-- Prefix for output filename

feature -- Text generation

	generate (a_repository: AUT_TEST_CASE_RESULT_REPOSITORY) is
			-- Generate text file describing the results from `a_repository'.
		local
			output_file: KL_TEXT_OUTPUT_FILE
		do
			file_system.recursive_create_directory (output_dirname)
			create output_file.make (absolute_index_filename)
			output_file.open_write
			if not output_file.is_open_write then
				has_fatal_error := True
			else
				generate_summary (a_repository.results, output_file)
			end
			output_file.close
		end

feature {NONE} -- Implementation

	generate_summary (a_set: AUT_TEST_CASE_RESULT_SET; a_stream: KI_TEXT_OUTPUT_STREAM) is
			-- Generate summary for set `a_set' into `a_stream'.
		require
			a_set_not_void: a_set /= Void
			a_stream_not_void: a_stream /= Void
			a_stream_open_write: a_stream.is_open_write
		do
			a_stream.put_string ("test cases total: ")
			a_stream.put_integer (a_set.total_count)
			a_stream.put_new_line

			a_stream.put_string ("failures: ")
			a_stream.put_integer (a_set.fail_count)
			a_stream.put_new_line

			a_stream.put_string ("unique failures: ")
			a_stream.put_integer (a_set.unique_fail_count)
			a_stream.put_new_line

			a_stream.put_string ("bad response: ")
			a_stream.put_integer (a_set.bad_response_count)
			a_stream.put_new_line

			a_stream.put_string ("invalid test cases: ")
			a_stream.put_integer (a_set.invalid_count)
			a_stream.put_new_line
		end

invariant

	prefix_not_void: prefix_ /= Void

end
