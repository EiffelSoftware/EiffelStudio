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

	class_name: !STRING = "TEST_EVALUATOR_ROOT"
			-- <Precursor>

	ancestor_names: !ARRAY [!STRING]
			-- <Precursor>
		do
			Result := << "TEST_ROOT_APPLICATION" >>
		end

feature -- Basic operations

	write_source (a_file: !KI_TEXT_OUTPUT_STREAM; a_map: !EIFFEL_TEST_EVALUATOR_MAP) is
			-- Write interpreter root class to file
		require
			a_file_open_write: a_file.is_open_write
		do
			create stream.make (a_file)
			put_indexing
			put_class_header
			put_query ("is_valid_index", "BOOLEAN", a_map,
				agent (a_test: !EIFFEL_TEST_I; a_index: NATURAL)
					do
						stream.put_line ("Result := True")
					end)
			put_query ("test_set_instance", "!TEST_SET", a_map,
				agent (a_test: !EIFFEL_TEST_I; a_index: NATURAL)
					do
						stream.put_string ("Result := create {")
						stream.put_string (a_test.class_name)
						stream.put_line ("}")
					end)
			put_query ("test_procedure", "!PROCEDURE [ANY, TUPLE [TEST_SET]]", a_map,
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

	put_query (a_name: !STRING; a_result: !STRING; a_map: !EIFFEL_TEST_EVALUATOR_MAP; a_callback: !PROCEDURE [ANY, TUPLE [t: !EIFFEL_TEST_I; i: NATURAL]])
			-- Print `test_name' routine to `stream'.
		require
			stream_valid: is_stream_valid
		local
			l_cursor: DS_LINEAR_CURSOR [!EIFFEL_TEST_I]
			i: INTEGER
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
			from
				l_cursor := a_map.tests.new_cursor
				l_cursor.start
				i := 1
			until
				l_cursor.after
			loop
				stream.put_string ("when ")
				stream.put_integer (i)
				stream.put_line (" then")
				stream.indent
				a_callback.call ([l_cursor.item, a_map.index (l_cursor.item)])
				stream.dedent
				i := i + 1
				l_cursor.forth
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
