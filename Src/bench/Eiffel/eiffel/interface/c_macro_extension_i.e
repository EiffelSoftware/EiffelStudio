indexing
	description: "Encapsulation of a C macro extension."
	date: "$Date$"
	revision: "$Revision$"

class MACRO_EXTENSION_I

inherit
	EXTERNAL_EXT_I
		redefine
			is_macro, is_equal, is_cpp
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

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		do	
			Result := same_type (other) and then
				return_type = other.return_type and then
				array_is_equal (argument_types, other.argument_types) and then
				array_is_equal (header_files, other.header_files)
		end

feature -- Code generation
		
	generate_body (macro_byte_code: EXT_BYTE_CODE; a_result: RESULT_B) is
			-- Generate encapsulation to C/C++ macro external `macro_byte_code'.
		local
			l_buffer: GENERATION_BUFFER
			l_ret_type: TYPE_I
			nb: INTEGER
		do
			l_ret_type := macro_byte_code.result_type
			l_buffer := Context.buffer
			if not l_ret_type.is_void then
				a_result.print_register
				l_buffer.putstring (" = ")
				l_ret_type.c_type.generate_cast (l_buffer)
			end
			
			nb := macro_byte_code.argument_count
			internal_generate_access (macro_byte_code.external_name, Void, nb, l_ret_type)
			l_buffer.putchar (';')
			l_buffer.new_line
		end

	generate_access (external_name: STRING; parameters: BYTE_LIST [EXPR_B]; a_ret_type: TYPE_I) is
			-- Generate inline C/C++ macro external.
		require
			external_name_not_void: external_name /= Void
			a_ret_type_not_void: a_ret_type /= Void
		do
			if parameters = Void then
				internal_generate_access (external_name, Void, 0, a_ret_type)
			else
				internal_generate_access (external_name, parameters, parameters.count, a_ret_type)
			end
		end

feature {NONE} -- Implementation

	internal_generate_access (external_name: STRING; parameters: BYTE_LIST [EXPR_B]; nb: INTEGER; a_ret_type: TYPE_I) is
			-- Generate inline C/C++ macro external.
		require
			external_name_not_void: external_name /= Void
			parameters_valid: parameters /= Void implies parameters.count = nb
			a_ret_type_not_void: a_ret_type /= Void
		local
			buffer: GENERATION_BUFFER
		do
			buffer := Context.buffer
			if is_cpp then
				context.set_has_cpp_externals_calls (True)
			end
			
			generate_header_files
			
			if a_ret_type.is_boolean then
					-- Only in case of a macro which is a function that we can generate paranthesis
					-- around `external_name', as a procedure might be a multiline macro.
				buffer.putstring ("EIF_TEST(")
			end
			buffer.putstring (external_name)
			if nb > 0 then
				buffer.putchar ('(')
				generate_parameter_list (parameters, nb)
				buffer.putchar (')')
			end
			if a_ret_type.is_boolean then
				buffer.putchar (')')
			end
		end

end -- class MACRO_EXTENSION_I
