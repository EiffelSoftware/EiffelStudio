indexing
	description: "Encapsulation of a C macro extension."
	date: "$Date$"
	revision: "$Revision$"

class MACRO_EXTENSION_I

inherit
	EXTERNAL_EXT_I
		redefine
			is_macro, is_equal, is_cpp,
			generate_header_files,
			has_standard_prototype, 
			generate_external_name
		end

create
	make

feature  -- Initialization

	make (is_cpp_macro: BOOLEAN) is
			-- Create Current object
			-- Set `is_cpp' to `is_cpp_macro'.
		do
			is_cpp := is_cpp_macro
		ensure
			is_cpp_set: is_cpp = is_cpp_macro
		end

feature -- Properties

	is_macro: BOOLEAN is True

	is_cpp: BOOLEAN
		-- Is Current macro a C++ one?

	special_file_name: STRING
			-- Special file name (dll or macro)

feature -- Initialization

	set_special_file_name (f: STRING) is
			-- Assign `f' to `special_file_name'.
		do
			special_file_name := f
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		do	
			Result := same_type (other) and then
				equal (return_type, other.return_type) and then
				array_is_equal (argument_types, other.argument_types) and then
				array_is_equal (header_files, other.header_files) and then
				equal (special_file_name, other.special_file_name)
		end

feature -- Code generation

	generate_header_files is
			-- Generate header files for the extension.
		do
			{EXTERNAL_EXT_I} Precursor
			if not shared_include_queue.has (special_file_name) then
				shared_include_queue.extend (special_file_name)
			end
		end

	generate_external_name (buffer: GENERATION_BUFFER; external_name: STRING
				type: CL_TYPE_I; ret_type: TYPE_C) is
			-- Generate the C name associated with the extension
		do
			if is_cpp then
				context.set_has_cpp_externals_calls (True)
			end
			buffer.putchar ('(')
			buffer.putstring (external_name)
		end

	has_standard_prototype: BOOLEAN is False

end -- class MACRO_EXTENSION_I
