indexing
	description: "Encapsulation of a C macro extension."
	date: "$Date$"
	revision: "$Revision$"

class STRUCT_EXTENSION_I

inherit
	EXTERNAL_EXT_I
		redefine
			is_struct, is_equal, is_cpp,
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

	field_name: STRING
			-- Name of struct.
			--| Can be empty if parsed through the old syntax

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		do	
			Result := same_type (other) and then
				equal (return_type, other.return_type) and then
				array_is_equal (argument_types, other.argument_types) and then
				array_is_equal (header_files, other.header_files) and then
				equal (field_name, other.field_name)
		end

feature -- Settings

	set_field_name (s: STRING) is
			-- Assign `s' to `field_name'.
		do
			field_name := s
		ensure
			field_name_set: field_name = s
		end

feature -- Code generation

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
			special_access: BOOLEAN
			name: STRING
			setter: BOOLEAN
			new_syntax: BOOLEAN
		do
			if is_cpp then
				context.set_has_cpp_externals_calls (True)
			end

			name := field_name
			if name = Void then
				name := external_name
			else
				new_syntax := True
			end

			setter := (new_syntax and then argument_types.count = 2)
					or else (not new_syntax and then not has_return_type)

			arg_types := argument_types
			if not setter then
				if name.item (1) = '&' and then name.count > 1 then
					buffer.putchar ('&')
					special_access := True
				end
				buffer.putstring ("(((")
				buffer.putstring (arg_types.item (1))
				buffer.putstring (" *)")
				parameters.first.print_register
				buffer.putstring (")->")
				if not special_access then
					buffer.putstring (name)
				else
					buffer.putstring (name.substring (2, name.count))
				end
			else
				parameters.start
				buffer.putstring ("(((")
				buffer.putstring (arg_types.item (1))
				buffer.putstring (" *)")
				parameters.item.print_register
				parameters.forth
				buffer.putstring (")->")
				buffer.putstring (name)
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

