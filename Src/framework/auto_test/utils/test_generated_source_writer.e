note
	description: "Summary description for {TEST_GENERATED_SOURCE_WRITER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_GENERATED_SOURCE_WRITER

inherit
	TEST_CLASS_SOURCE_WRITER
		redefine
			ancestor_names,
			put_indexing
		end

feature -- Access

	class_name: attached READABLE_STRING_32
			-- <Precursor>

	ancestor_names: attached ARRAY [attached STRING]
			-- <Precursor>
		do
			Result := << generated_ancestor_name >>
		end

	root_feature_name: attached STRING = ""
			-- <Precursor>

	last_test_routine_name: STRING
			-- Name of test last printed to file
		require
			writing: is_writing
		do
			Result := test_writer.last_test_routine_name
		end

feature {NONE} -- Access

	test_writer: detachable TEST_GENERATED_TEST_WRITER
			-- Writer printing AutoTest  results

feature -- Status setting

	prepare (a_file: KI_TEXT_OUTPUT_STREAM; a_class_name: READABLE_STRING_32; a_system: SYSTEM_I)
			-- Prepare printing a new axtracted application state to `a_file'.
		require
			not_writing: not is_writing
			a_file_open_write: a_file.is_open_write
		do
			create stream.make (a_file)
			create test_writer.make (a_system, a_file)
			class_name := a_class_name
			put_indexing
			put_class_header
		end

	print_test_routine (a_result: AUT_TEST_CASE_RESULT)
			-- Print test routine for given request list and variable list.
		require
			writing: is_writing
		do
			test_writer.set_current_result (a_result)
			test_writer.print_test_case (a_result.witness.request_list, a_result.witness.used_vars)
			test_writer.set_current_result (Void)
		end

	finish
			-- Finish source text
		require
			writing: is_writing
		do
			put_class_footer
			test_writer := Void
			stream := Void
		end

feature {NONE} -- Output

	put_indexing
			-- Append indexing clause.
		do
			put_indexing_keyword
			stream.indent
			stream.put_line ("description: %"Generated tests created by AutoTest.%"")
			stream.put_line ("author: %"Testing tool%"")
			stream.dedent
			stream.put_line ("")
		end

feature {NONE} -- Constants

	generated_ancestor_name: attached STRING = "EQA_GENERATED_TEST_SET"

invariant
	writing_implies_writer_attached: is_writing implies test_writer /= Void
	writing_implies_correct_stream: is_writing implies test_writer.output_stream = stream.output_stream

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
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
