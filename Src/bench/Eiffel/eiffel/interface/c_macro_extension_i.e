indexing
	description: "Encapsulation of a C macro extension."
	date: "$Date$"
	revision: "$Revision$"

class C_MACRO_EXTENSION_I

inherit
	C_EXTENSION_I
		redefine
			is_macro, 
			generate_header_files,
			has_standard_prototype, 
			generate_external_name
		end

feature

	is_macro: BOOLEAN is True

feature -- Code generation

	generate_header_files is
			-- Generate header files for the extension.
		do
			{C_EXTENSION_I} precursor
			if not shared_include_queue.has (special_file_name) then
				shared_include_queue.extend (special_file_name)
			end
		end

	generate_external_name (gen_file: INDENT_FILE; external_name: STRING
				e: POLY_TABLE [ENTRY]; type: CL_TYPE_I; ret_type: TYPE_C) is
			-- Generate the C name associated with the extension
		do
			gen_file.putchar ('(')
			gen_file.putstring (external_name)
		end

	has_standard_prototype: BOOLEAN is False

end -- class C_MACRO_EXTENSION_I
