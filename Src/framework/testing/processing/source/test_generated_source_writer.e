indexing
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

	class_name: !STRING
			-- <Precursor>

	ancestor_names: !ARRAY [!STRING]
			-- <Precursor>
		do
			Result := << "EQA_TEST_SET" >>
		end

	root_feature_name: !STRING = ""
			-- <Precursor>

feature {NONE} -- Access

	test_writer: ?TEST_GENERATED_TEST_WRITER
			-- Writer printing AutoTest  results

	class_under_test: ?STRING

feature -- Status setting

	prepare (a_file: !KI_TEXT_OUTPUT_STREAM; a_class_name: !STRING; a_system: !SYSTEM_I; a_class_under_test: !like class_under_test)
			-- Prepare printing a new axtracted application state to `a_file'.
		require
			not_writing: not is_writing
			a_file_open_write: a_file.is_open_write
		do
			create stream.make (a_file)
			create test_writer.make (a_system, a_file)
			class_name := a_class_name
			class_under_test := a_class_under_test
			put_indexing
			put_class_header
		end

	print_test_routine (a_request_list: DS_LINEAR [AUT_REQUEST]; a_var_list: DS_HASH_TABLE [TUPLE [STRING, BOOLEAN], ITP_VARIABLE])
			-- Print test routine for given request list and variable list.
		require
			writing: is_writing
			a_request_list_not_void: a_request_list /= Void
			no_request_void: not a_request_list.has (Void)
		do
				-- For now we do not print the test if the locals are missing
			if a_var_list /= Void then
				test_writer.print_test_case (a_request_list, a_var_list)
			end
		end

	finish
			-- Finish source text
		require
			writing: is_writing
		do
			put_class_footer
			test_writer := Void
			stream := Void
			class_under_test := Void
		end

feature {NONE} -- Output

	put_indexing is
			-- Append indexing clause.
		do
			stream.put_line ("indexing%N")
			stream.indent
			stream.put_line ("description: %"Automatically generated tests.%"")
			stream.put_line ("author: %"Testing tool%"")
			stream.put_string ("testing: %"covers/{")
			stream.put_string (class_under_test)
			stream.put_line ("}%"")
			stream.dedent
			stream.put_line ("")
		end

invariant
	writing_implies_writer_attached: is_writing implies test_writer /= Void
	writing_implies_correct_stream: is_writing implies test_writer.output_stream = stream.output_stream

end
