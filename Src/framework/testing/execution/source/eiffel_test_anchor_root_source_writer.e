indexing
	description: "[
		Source writer that creates a class referencing a list of classes.
		
		Note: this is used by testing framework to reference all existing test classes in system.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_TEST_ANCHOR_ROOT_SOURCE_WRITER

inherit
	EIFFEL_TEST_CLASS_SOURCE_WRITER

feature -- Access

	class_name: !STRING
			-- Name of class
		do
			Result := "TEST_CLASS_ANCHOR_ROOT"
		end

feature -- Basic operations

	write_source (a_file: !KI_TEXT_OUTPUT_STREAM; a_list: !DS_LINEAR [!EIFFEL_CLASS_I])
			-- Write anchor root class to file
		require
			a_file_open_write: a_file.is_open_write
		do
			create stream.make (a_file)
			put_indexing
			put_class_header
			put_anchor_routine (a_list)
			put_class_footer
		end

feature {NONE} -- Implementation

	put_anchor_routine (a_list: !DS_LINEAR [!EIFFEL_CLASS_I])
			--
		require
			stream_valid: is_stream_valid
		do
			stream.indent
			stream.put_line ("make")
			stream.indent
			stream.put_line ("local")
			stream.indent
			stream.put_line ("l_type: TYPE [ANY]")
			stream.dedent
			stream.put_line ("do")
			stream.indent
			a_list.do_all (agent (a_class: !EIFFEL_CLASS_I)
				do
					stream.put_string ("l_type := {")
					stream.put_string (a_class.name)
					stream.put_line ("}")
				end)
			stream.dedent
			stream.put_line ("end")
			stream.dedent
			stream.dedent
			stream.put_line ("")
		end

end
