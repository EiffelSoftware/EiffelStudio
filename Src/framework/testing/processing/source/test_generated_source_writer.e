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

	class_name: !STRING
			-- <Precursor>

	ancestor_names: !ARRAY [!STRING]
			-- <Precursor>
		do
			Result := << "EQA_GENERATED_TEST_SET" >>
		end

	root_feature_name: !STRING = ""
			-- <Precursor>

feature {NONE} -- Access

	test_writer: ?TEST_GENERATED_TEST_WRITER
			-- Writer printing AutoTest  results

feature -- Status setting

	prepare (a_file: !KI_TEXT_OUTPUT_STREAM; a_class_name: !STRING; a_system: !SYSTEM_I)
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
			stream.put_line ("indexing%N")
			stream.indent
			stream.put_line ("description: %"Automatically generated tests.%"")
			stream.put_line ("author: %"Testing tool%"")
			stream.put_line ("testing: %"type/generated%"")
			stream.dedent
			stream.put_line ("")
		end

invariant
	writing_implies_writer_attached: is_writing implies test_writer /= Void
	writing_implies_correct_stream: is_writing implies test_writer.output_stream = stream.output_stream

end
