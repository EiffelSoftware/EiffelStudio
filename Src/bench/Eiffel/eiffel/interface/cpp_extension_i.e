indexing
description: "Encapsulation of a C++ extension.";
	date: "$Date$";
	revision: "$Revision$"

class CPP_EXTENSION_I

inherit
	EXTERNAL_EXT_I
		redefine
			is_equal, is_cpp, generate_parameter_list
		end

	SHARED_CPP_CONSTANTS
		undefine
			is_equal
		end

feature -- Properties

	class_name: STRING

	type: INTEGER

feature -- Convenience

	is_cpp: BOOLEAN is True

	set_class_name (n: STRING) is
			-- Assign `n' to `class_name'.
		do
			class_name := n
		end

	set_type (t: INTEGER) is
			-- Assing `t' to `type'.
		do
			type := t
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		do
			Result := same_type (other) and then
				return_type = other.return_type and then
				array_is_equal (argument_types, other.argument_types) and then
				array_is_equal (header_files, other.header_files) and then
				class_name.is_equal (other.class_name) and then
				type = other.type
		end

feature -- Code generation

	generate_body (cpp_byte_code: EXT_BYTE_CODE; a_result: RESULT_B) is
			-- Generate encapsulation to C++ external which has `nb' parameters.
		local
			l_buffer: GENERATION_BUFFER
			l_ret_type: TYPE_I
		do
				-- Initialize generation buffer.
			l_buffer := Context.buffer
			
				-- Check for null pointer to C++ object in workbench mode
			if not Context.final_mode and not System.il_generation then
				inspect
					type
				when standard, data_member then
					l_buffer.putstring ("if ((")
					l_buffer.putstring (class_name)
					l_buffer.putstring ("*) arg1 == NULL)")
					l_buffer.new_line
					l_buffer.indent
					l_buffer.putstring ("RTET(%"")
					l_buffer.putstring (class_name)
					l_buffer.putstring ("::")
					l_buffer.putstring (cpp_byte_code.external_name)
					l_buffer.putstring ("%", EN_VOID);")
					l_buffer.new_line
					l_buffer.exdent
					l_buffer.new_line
				else
					-- Nothing to be done otherwise.
				end
			end

			l_ret_type := cpp_byte_code.result_type
			if not l_ret_type.is_void then
				a_result.print_register
				l_buffer.putstring (" = ")
				l_ret_type.c_type.generate_cast (l_buffer)
			end

			internal_generate (cpp_byte_code.external_name, Void, cpp_byte_code.argument_count,
				l_ret_type)

			l_buffer.putchar (';')
			l_buffer.new_line
		end

	generate_access (external_name: STRING; parameters: BYTE_LIST [EXPR_B]; a_ret_type: TYPE_I) is
			-- Generate inline call to C++ external.
		require
			external_name_not_void: external_name /= Void
			a_ret_type_not_void: a_ret_type /= Void
		do
			check
				final_mode: Context.final_mode
			end
			if parameters /= Void then
				internal_generate (external_name, parameters, parameters.count, a_ret_type)
			else
				internal_generate (external_name, Void, 0, a_ret_type)
			end
		end

feature {NONE} -- Code generation

	internal_generate (external_name: STRING; parameters: BYTE_LIST [EXPR_B]; nb: INTEGER; a_ret_type: TYPE_I) is
		require
			external_name_not_void: external_name /= Void
			nb_nonnegative: nb >= 0
			parameters_valid: parameters /= Void implies parameters.count = nb
			a_ret_type_not_void: a_ret_type /= Void
		local
			buffer: GENERATION_BUFFER
		do
			buffer := Context.buffer

			generate_header_files

				-- Set `has_cpp_externals_calls' of BYTE_CONTEXT to True since
				-- we are currently generating one.
			context.set_has_cpp_externals_calls (True)
			
			if a_ret_type.is_boolean then
				buffer.putstring("EIF_TEST")
			end

			buffer.putchar ('(')

			inspect
				type
			when standard, data_member then
				buffer.putchar ('(')
				generate_cpp_object_access (parameters)
				buffer.putstring (")->")
				buffer.putstring (external_name);
			when static, static_data_member then
				buffer.putstring (class_name)
				buffer.putstring ("::")
				buffer.putstring (external_name);
			when new then
				buffer.putstring ("new ")
				buffer.putstring (class_name)
			when delete then
				buffer.putstring ("delete ((")
				buffer.putstring (class_name)
				buffer.putstring (" *) ")
				generate_cpp_object_access (parameters)
				buffer.putchar (')')
			end

			inspect
				type
			when delete, data_member, static_data_member then
					-- Nothing to generate
			when standard, static, new then
				buffer.putchar ('(')
				if parameters /= Void then
					generate_parameter_list (parameters, parameters.count)
				else
					generate_parameter_list (Void, nb)
				end
				buffer.putchar (')')
			end
 
			buffer.putchar (')')
		end
	
	generate_cpp_object_access (parameters: BYTE_LIST [EXPR_B]) is
			-- Generate the C++ access code.
		require
			parameters_valid: parameters /= Void implies parameters.count >= 1
		local
			buffer: GENERATION_BUFFER
		do
			buffer := Context.buffer
			buffer.putchar ('(')
			buffer.putstring (class_name)
			buffer.putstring ("*) ")
			generate_i_th_parameter (parameters, 1)
		end

	generate_parameter_list (parameters: BYTE_LIST [EXPR_B]; nb: INTEGER) is
			-- Generate the arguments to the C++ call
		local
			i, j: INTEGER
			has_cast: BOOLEAN
			arg_types: like argument_types
			buffer: GENERATION_BUFFER
			l_names_heap: like Names_heap
		do
			if parameters /= Void or nb > 0then
				from
					buffer := Context.buffer
					if has_arg_list then
						has_cast := True
						arg_types := argument_types
						l_names_heap := Names_heap
						j := arg_types.lower
					end
					if type = standard then
							-- First argument is the pointer to the C++ object
						i := 2
					else
							-- constructor or call to static routine
						i := 1
					end
				until
					i > nb
				loop
					if has_cast then
						buffer.putchar ('(')
						buffer.putstring (l_names_heap.item (arg_types.item (j)))
						buffer.putchar (')')
						buffer.putchar (' ')
						j := j + 1
					end
					generate_i_th_parameter (parameters, i)
					i := i + 1
					if i <= nb then
						buffer.putstring (gc_comma)
					end
				end
			end
		end

end -- class CPP_EXTENSION_I

