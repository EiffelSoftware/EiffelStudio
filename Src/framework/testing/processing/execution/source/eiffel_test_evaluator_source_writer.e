indexing
	description: "[
			Objects that print evaluator root class for executing tests. All test classes in system shall be
			created through this class.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_TEST_EVALUATOR_SOURCE_WRITER

inherit
	EIFFEL_TEST_CLASS_SOURCE_WRITER
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

feature -- Basic operations

	write_source (a_file: !KI_TEXT_OUTPUT_STREAM; a_list: ?DS_LINEAR [!EIFFEL_TEST_I]) is
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
				agent (a_test: !EIFFEL_TEST_I; a_index: NATURAL)
					do
						stream.put_line ("Result := True")
					end)
			create l_type.make_from_string ("!" + {EIFFEL_TEST_CONSTANTS}.common_test_class_ancestor_name)
			put_query ("test_set_instance", l_type, a_list,
				agent (a_test: !EIFFEL_TEST_I; a_index: NATURAL)
					do
						stream.put_string ("Result := create {")
						stream.put_string (a_test.class_name)
						stream.put_line ("}")
					end)
			create l_type.make_from_string ("!PROCEDURE [ANY, TUPLE [" + {EIFFEL_TEST_CONSTANTS}.common_test_class_ancestor_name + "]]")
			put_query ("test_procedure", l_type, a_list,
				agent (a_test: !EIFFEL_TEST_I; a_index: NATURAL)
					do
						stream.put_string ("Result := agent {")
						stream.put_string (a_test.class_name)
						stream.put_string ("}.")
						stream.put_line (a_test.name)
					end)
			put_class_footer
		end

feature {NONE} -- Implementation

	put_query (a_name: !STRING; a_result: !STRING; a_list: ?DS_LINEAR [!EIFFEL_TEST_I]; a_callback: !PROCEDURE [ANY, TUPLE [t: !EIFFEL_TEST_I; i: NATURAL]])
			-- Print `test_name' routine to `stream'.
		require
			stream_valid: is_stream_valid
		local
			l_cursor: DS_LINEAR_CURSOR [!EIFFEL_TEST_I]
			i: NATURAL
		do
			stream.indent
			stream.put_string (a_name)
			stream.put_string (" (a_index: NATURAL): ")
			stream.put_line (a_result)
			stream.indent
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
			stream.dedent
			stream.put_line ("end")
			stream.dedent
			stream.put_line ("end")
			stream.dedent
			stream.dedent
			stream.put_line ("")
		end

end
