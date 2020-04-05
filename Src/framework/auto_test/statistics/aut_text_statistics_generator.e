note

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

	KL_SHARED_FILE_SYSTEM
		export {NONE} all end

create

	make

feature {NONE} -- Initialization

	make (a_prefix: STRING; an_output_dirname: like output_dirname; a_system: like system; a_classes_under_test: like classes_under_test)
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

	absolute_index_filename: STRING
			-- Absolute filename of text file
		do
			Result := file_system.pathname (output_dirname, prefix_ + "statistics.txt")
		end

	prefix_: STRING
			-- Prefix for output filename

feature -- Text generation

	generate (a_repository: AUT_TEST_CASE_RESULT_REPOSITORY)
			-- Generate text file describing the results from `a_repository'.
		local
			output_file: KL_TEXT_OUTPUT_FILE_32
		do
			{FILE_UTILITIES}.create_directory (output_dirname)
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

	generate_summary (a_set: AUT_TEST_CASE_RESULT_SET; a_stream: KI_TEXT_OUTPUT_STREAM)
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

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
