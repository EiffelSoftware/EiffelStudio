indexing
	description: "Encapsulation of a C macro extension."
	date: "$Date$"
	revision: "$Revision$"

class STRUCT_EXTENSION_I

inherit
	EXTERNAL_EXT_I
		redefine
			is_struct, is_equal, is_cpp,
			generate_header_files,
			has_standard_prototype, 
			generate_external_name
		end

create
	make

feature -- Initialization

	make (is_cpp_struct: BOOLEAN) is
			-- Create Current object
			-- Set `is_cpp' to `is_cpp_struct.
		do
			is_cpp := is_cpp_struct
		ensure
			is_cpp_set: is_cpp = is_cpp_struct
		end

feature -- Properties

	is_struct: BOOLEAN is True

	is_cpp: BOOLEAN
		-- Is Current struct a C++ one?

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

	generate_external_name (buffer: GENERATION_BUFFER; external_name: STRING;
				type: CL_TYPE_I; ret_type: TYPE_C) is
			-- Generate the C name associated with the extension
		do
			if is_cpp then
				context.set_has_cpp_externals_calls (True)
			end
			check
				final_mode: Context.final_mode
			end
		end
	
	generate_struct_access (buffer: GENERATION_BUFFER; external_name: STRING;
						parameters: BYTE_LIST [EXPR_B]) is
			-- Generate access to C structure
		local
			arg_types: ARRAY [STRING]
		do
			if is_cpp then
				context.set_has_cpp_externals_calls (True)
			end

			arg_types := argument_types
			if has_return_type then
				buffer.putstring ("(((")
				buffer.putstring (arg_types.item (1))
				buffer.putstring (" *)")
				parameters.first.print_register
				buffer.putstring (")->")
				buffer.putstring (external_name)
			else
				parameters.start
				buffer.putstring ("(((")
				buffer.putstring (arg_types.item (1))
				buffer.putstring (" *)")
				parameters.item.print_register
				parameters.forth
				buffer.putstring (")->")
				buffer.putstring (external_name)
				buffer.putstring (" = (")
				buffer.putstring (arg_types.item (2))
				buffer.putstring (")(")
				parameters.item.print_register
				buffer.putchar (')')
			end
			buffer.putchar (')')
		end

	has_standard_prototype: BOOLEAN is False

end -- class STRUCT_EXTENSION_I

