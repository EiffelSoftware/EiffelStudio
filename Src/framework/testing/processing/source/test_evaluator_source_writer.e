note
	description: "[
			Objects that print evaluator root class for executing tests. All test classes in system shall be
			created through this class.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_EVALUATOR_SOURCE_WRITER

inherit
	TEST_CLASS_SOURCE_WRITER
		redefine
			ancestor_names
		end

feature -- Access

	class_name: !STRING = "EQA_EVALUATOR_ROOT"
			-- <Precursor>

	ancestor_names: !ARRAY [!STRING]
			-- <Precursor>
		do
			Result := << "EQA_EVALUATOR" >>
		end

	root_feature_name: !STRING = "make"
			-- <Precursor>

feature -- Basic operations

	write_source (a_file: !KI_TEXT_OUTPUT_STREAM; a_list: ?DS_LINEAR [!TEST_I])
			-- Write interpreter root class to file
		require
			a_file_open_write: a_file.is_open_write
		local
			l_type: !STRING
		do
			create stream.make (a_file)
			put_indexing
			put_class_header
			put_query ("is_valid_index", "BOOLEAN", a_list,
				agent (a_test: !TEST_I; a_index: NATURAL)
					do
						stream.put_line ("Result := True")
					end, True)
			create l_type.make_from_string ({TEST_CONSTANTS}.common_test_class_ancestor_name)
			put_query ("test_set_instance", l_type, a_list,
				agent (a_test: !TEST_I; a_index: NATURAL)
					do
						stream.put_string ("l_result := create {")
						stream.put_string (a_test.class_name)
						stream.put_line ("}")
					end, False)
			create l_type.make_from_string ("PROCEDURE [ANY, TUPLE [" + {TEST_CONSTANTS}.common_test_class_ancestor_name + "]]")
			put_query ("test_procedure", l_type, a_list,
				agent (a_test: !TEST_I; a_index: NATURAL)
					do
						stream.put_string ("l_result := agent {")
						stream.put_string (a_test.class_name)
						stream.put_string ("}.")
						stream.put_line (a_test.name)
					end, False)
			create l_type.make_from_string ("READABLE_STRING_8")
			put_query ("test_name", l_type, a_list,
				agent (a_test: !TEST_I; a_index: NATURAL)
					do
						stream.put_string ("l_result := %"")
						stream.put_string (a_test.name)
						stream.put_line ("%"")
					end, False)

			put_class_footer
			stream := Void
		end

feature {NONE} -- Implementation

	put_query (a_name: !STRING; a_result: !STRING; a_list: ?DS_LINEAR [!TEST_I]; a_callback: !PROCEDURE [ANY, TUPLE [t: !TEST_I; i: NATURAL]]; a_is_basic: BOOLEAN)
			-- Print `test_name' routine to `stream'.
		require
			stream_valid: is_writing
		local
			l_cursor: DS_LINEAR_CURSOR [!TEST_I]
			i: NATURAL
		do
			stream.indent
			stream.put_string (a_name)
			stream.put_string (" (a_index: NATURAL): ")
			if not a_is_basic then
				stream.put_string ("attached ")
			end
			stream.put_line (a_result)
			stream.indent
			if not a_is_basic then
				stream.put_line ("local")
				stream.indent
				stream.put_string ("l_result: detachable ")
				stream.put_line (a_result)
				stream.dedent
			end
			stream.put_line ("do")
			stream.indent
			stream.put_line ("inspect")
			stream.indent
			stream.put_line ("a_index")
			stream.dedent
			if a_list /= Void then
				from
					l_cursor := a_list.new_cursor
					l_cursor.start
					i := 1
				until
					l_cursor.after
				loop
					stream.put_string ("when ")
					stream.put_integer (i.to_integer_32)
					stream.put_line (" then")
					stream.indent
					a_callback.call ([l_cursor.item, i])
					stream.dedent
					i := i + 1
					l_cursor.forth
				end
			end
			stream.put_line ("else")
			stream.indent
			stream.put_line ("-- Invalid index")
			if not a_is_basic then
				stream.put_line ("check l_result /= Void end")
			end
			stream.dedent
			stream.put_line ("end")
			stream.dedent
			if not a_is_basic then
				stream.put_line ("Result := l_result")
			end
			stream.put_line ("end")
			stream.dedent
			stream.dedent
			stream.put_line ("")
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
