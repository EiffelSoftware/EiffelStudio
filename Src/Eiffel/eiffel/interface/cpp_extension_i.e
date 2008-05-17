indexing
description: "Encapsulation of a C++ extension."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class CPP_EXTENSION_I

inherit
	EXTERNAL_EXT_I
		redefine
			same_as, is_cpp, generate_parameter_list
		end

	SHARED_CPP_CONSTANTS
		export
			{NONE} all
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

	same_as (other: like Current): BOOLEAN is
		do
			Result := Precursor {EXTERNAL_EXT_I} (other) and then
				(type = other.type and equal (class_name, other.class_name))
		end

feature -- Code generation

	generate_body (cpp_byte_code: EXT_BYTE_CODE; a_result: RESULT_B) is
			-- Generate encapsulation to C++ external which has `nb' parameters.
		local
			l_buffer: GENERATION_BUFFER
			l_ret_type: TYPE_A
		do
				-- Initialize generation buffer.
			l_buffer := Context.buffer

				-- Check for null pointer to C++ object in workbench mode
			if not Context.final_mode and not System.il_generation then
				inspect
					type
				when standard, data_member then
					l_buffer.put_string ("if ((")
					l_buffer.put_string (class_name)
					l_buffer.put_string ("*) arg1 == NULL)")
					l_buffer.put_new_line
					l_buffer.indent
					l_buffer.put_string ("RTET(%"")
					l_buffer.put_string (class_name)
					l_buffer.put_string ("::")
					l_buffer.put_string (cpp_byte_code.external_name)
					l_buffer.put_string ("%", EN_VOID);")
					l_buffer.put_new_line
					l_buffer.exdent
					l_buffer.put_new_line
				else
					-- Nothing to be done otherwise.
				end
			end

			l_ret_type := cpp_byte_code.result_type
			if not l_ret_type.is_void then
				a_result.print_register
				l_buffer.put_string (" = ")
				l_ret_type.c_type.generate_cast (l_buffer)
			end

			internal_generate (cpp_byte_code.external_name, Void, cpp_byte_code.argument_count,
				l_ret_type)

			l_buffer.put_character (';')
			l_buffer.put_new_line
		end

	generate_access (external_name: STRING; parameters: BYTE_LIST [EXPR_B]; a_ret_type: TYPE_A) is
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

	internal_generate (external_name: STRING; parameters: BYTE_LIST [EXPR_B]; nb: INTEGER; a_ret_type: TYPE_A) is
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
				buffer.put_string("EIF_TEST")
			end

			buffer.put_character ('(')

			inspect
				type
			when standard, data_member then
				buffer.put_character ('(')
				generate_cpp_object_access (parameters)
				buffer.put_string (")->")
				buffer.put_string (external_name);
			when static, static_data_member then
				buffer.put_string (class_name)
				buffer.put_string ("::")
				buffer.put_string (external_name);
			when new then
				buffer.put_string ("new ")
				buffer.put_string (class_name)
			when delete then
				buffer.put_string ("delete ((")
				buffer.put_string (class_name)
				buffer.put_string (" *) ")
				generate_cpp_object_access (parameters)
				buffer.put_character (')')
			end

			inspect
				type
			when delete, data_member, static_data_member then
					-- Nothing to generate
			when standard, static, new then
				buffer.put_character ('(')
				if parameters /= Void then
					generate_parameter_list (parameters, parameters.count, False)
				else
					generate_parameter_list (Void, nb, False)
				end
				buffer.put_character (')')
			end

			buffer.put_character (')')
		end

	generate_cpp_object_access (parameters: BYTE_LIST [EXPR_B]) is
			-- Generate the C++ access code.
		require
			parameters_valid: parameters /= Void implies parameters.count >= 1
		local
			buffer: GENERATION_BUFFER
		do
			buffer := Context.buffer
			buffer.put_character ('(')
			buffer.put_string (class_name)
			buffer.put_string ("*) ")
			generate_i_th_parameter (parameters, 1)
		end

	generate_parameter_list (parameters: BYTE_LIST [EXPR_B]; nb: INTEGER; a_protect_argument_for_macros: BOOLEAN) is
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
						buffer.put_character ('(')
						buffer.put_string (l_names_heap.item (arg_types.item (j)))
						buffer.put_character (')')
						buffer.put_character (' ')
						j := j + 1
					end
					generate_i_th_parameter (parameters, i)
					i := i + 1
					if i <= nb then
						buffer.put_string (gc_comma)
					end
				end
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class CPP_EXTENSION_I

