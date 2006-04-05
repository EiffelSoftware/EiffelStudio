indexing
	description: "Encapsulation of a C extension."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class C_EXTENSION_I

inherit
	EXTERNAL_EXT_I

feature -- Code generation

	generate_body (c_byte_code: EXT_BYTE_CODE; a_result: RESULT_B) is
			-- Generate encapsulation to C/C++ macro external `c_byte_code'.
		local
			l_ret_type: TYPE_I
			l_buffer: GENERATION_BUFFER
			l_args: ARRAY [STRING]
		do
			l_buffer := Context.buffer
			l_ret_type := c_byte_code.result_type
			if not l_ret_type.is_void then
				a_result.print_register
				l_buffer.put_string (" = ")
				l_ret_type.c_type.generate_cast (l_buffer)
			end

			if argument_types /= Void then
				l_args := Names_heap.convert_to_string_array (argument_types)
			else
				l_args := c_byte_code.argument_types
			end

			internal_generate_access (c_byte_code.external_name, Void, c_byte_code.argument_count, l_ret_type, l_args)
			l_buffer.put_character (';')
			l_buffer.put_new_line
		end

	generate_access (external_name: STRING; parameters: BYTE_LIST [EXPR_B]; a_args: ARRAY [STRING]; a_ret_type: TYPE_I) is
			-- Generate inline C external call.
		require
			external_name_not_void: external_name /= Void
		local
			l_args: ARRAY [STRING]
		do
			if argument_types /= Void then
				l_args := Names_heap.convert_to_string_array (argument_types)
			else
				l_args := a_args
			end
			if parameters = Void then
				internal_generate_access (external_name, Void, 0, a_ret_type, l_args)
			else
				internal_generate_access (external_name, parameters, parameters.count, a_ret_type, l_args)
			end
		end

feature {NONE} -- Implementation

	internal_generate_access (
			external_name: STRING; parameters: BYTE_LIST [EXPR_B]; nb: INTEGER;
			a_ret_type: TYPE_I; l_argument_types: ARRAY [STRING])
		is
			-- Generate inline C external call.
		require
			external_name_not_void: external_name /= Void
			parameters_valid: parameters /= Void implies parameters.count = nb
		local
			i, l_count: INTEGER
			l_header: like Header_generation_buffer
			l_buffer: GENERATION_BUFFER
		do
			l_header := Header_generation_buffer
			l_buffer := Context.buffer

			if has_include_list then
				generate_header_files
			else
				l_header.put_string ("extern ")
				if return_type > 0 then
					l_header.put_string (Names_heap.item (return_type))
					l_header.put_character (' ')
				else
					a_ret_type.c_type.generate (l_header)
				end

				l_header.put_string (external_name)
				l_header.put_character ('(')
				from
					i := l_argument_types.lower
					l_count := l_argument_types.upper
				until
					i > l_count
				loop
					l_header.put_string (l_argument_types.item (i))
					if i < l_count then
						l_header.put_string (", ")
					end
					i := i + 1
				end
				l_header.put_string (");")
				l_header.put_new_line
			end

			if a_ret_type.is_boolean then
				l_buffer.put_string ("EIF_TEST")
				l_buffer.put_character ('(')
			end
			l_buffer.put_string (external_name)
			l_buffer.put_character ('(')
			generate_parameter_list (parameters, nb)
			l_buffer.put_character (')')
			if a_ret_type.is_boolean then
				l_buffer.put_character (')')
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

end -- class C_EXTENSION_I
