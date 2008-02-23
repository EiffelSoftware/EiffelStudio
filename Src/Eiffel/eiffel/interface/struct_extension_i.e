indexing
	description: "Encapsulation of a C macro extension."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class STRUCT_EXTENSION_I

inherit
	EXTERNAL_EXT_I
		redefine
			is_struct, is_equal, is_cpp
		end

create
	make

feature -- Initialization

	make (a_fn: INTEGER; is_cpp_struct: BOOLEAN) is
			-- Create Current object
			-- Set `is_cpp' to `is_cpp_struct.
			-- Set `field_name_id' to `a_fn'.
		do
			field_name_id := a_fn
			is_cpp := is_cpp_struct
		ensure
			field_name_id_set: field_name_id = a_fn
			is_cpp_set: is_cpp = is_cpp_struct
		end

feature -- Properties

	is_struct: BOOLEAN is True

	is_cpp: BOOLEAN
		-- Is Current struct a C++ one?

	field_name_id: INTEGER
			-- Name ID of struct.
			--| Can be empty if parsed through the old syntax

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		do
			Result := same_type (other) and then
				return_type = other.return_type and then
				array_is_equal (argument_types, other.argument_types) and then
				array_is_equal (header_files, other.header_files) and then
				field_name_id = other.field_name_id
		end

feature -- Code generation

	generate_body (struct_byte_code: EXT_BYTE_CODE; a_result: RESULT_B) is
			-- Generate encapsulation to C/C++ struct external `struct_byte_code'.
		local
			l_buffer: GENERATION_BUFFER
			l_ret_type: TYPE_A
		do
			l_buffer := Context.buffer
			l_ret_type := struct_byte_code.result_type
			if not l_ret_type.is_void then
				a_result.print_register
				l_buffer.put_string (" = ")
				l_ret_type.c_type.generate_cast (l_buffer)
			end
			internal_generate (struct_byte_code.external_name, Void, l_ret_type)
			l_buffer.put_character (';')
			l_buffer.put_new_line
		end

	generate_access (external_name: STRING; parameters: BYTE_LIST [EXPR_B]; a_ret_type: TYPE_A) is
			-- Generate inline C/C++ struct external.
		require
			external_name_not_void: external_name /= Void
			external_name_not_empty: not external_name.is_empty
			parameters_not_void: parameters /= Void
			a_ret_type_not_void: a_ret_type /= Void
		do
			internal_generate (external_name, parameters, a_ret_type)
		end

feature {NONE} -- Code generation helper

	internal_generate (external_name: STRING; parameters: BYTE_LIST [EXPR_B]; a_ret_type: TYPE_A) is
			-- Generate access to C/C++ struct external.
		require
			external_name_not_void: external_name /= Void
			external_name_not_empty: not external_name.is_empty
			a_ret_type_not_void: a_ret_type /= Void
		local
			arg_types: like argument_types
			special_access: BOOLEAN
			name: STRING
			setter: BOOLEAN
			new_syntax: BOOLEAN
			l_names_heap: like Names_heap
			l_buffer: GENERATION_BUFFER
		do
			l_buffer := Context.buffer
			if is_cpp then
				context.set_has_cpp_externals_calls (True)
			end

			generate_header_files

			l_names_heap := Names_heap
			name := l_names_heap.item (field_name_id)
			if name = Void then
				name := external_name
			else
				new_syntax := True
			end

			setter := (new_syntax and then argument_types.count = 2)
					or else (not new_syntax and then not has_return_type)

			arg_types := argument_types
			if not setter then
				if a_ret_type.is_boolean then
					l_buffer.put_string ("EIF_TEST")
				elseif name.item (1) = '&' and then name.count > 1 then
						-- It cannot be of type `BOOLEAN' and be retrieving the
						-- address of a struct.
					l_buffer.put_character ('&')
					special_access := True
				end
					--| External structure access will be generated as:
					--| (type_2) (((type_1 *) arg1)->alias_name);
				l_buffer.put_string ("(((")
				l_buffer.put_string (l_names_heap.item (arg_types.item (1)))
				l_buffer.put_string (" *)")
				generate_i_th_parameter (parameters, 1)
				l_buffer.put_string (")->")
				if not special_access then
					l_buffer.put_string (name)
				else
					l_buffer.put_string (name.substring (2, name.count))
				end
				l_buffer.put_character (')')
			else
					--| External structure setting will be generated as:
					--| ((type_1 *) arg1)->alias_name = (type_2) (arg2);
				l_buffer.put_string ("(((")
				l_buffer.put_string (l_names_heap.item (arg_types.item (1)))
				l_buffer.put_string (" *)")
				generate_i_th_parameter (parameters, 1)
				l_buffer.put_string (")->")
				l_buffer.put_string (name)
				l_buffer.put_string (" = (")
				l_buffer.put_string (l_names_heap.item (arg_types.item (2)))
				l_buffer.put_string (")(")
				generate_i_th_parameter (parameters, 2)
				l_buffer.put_character (')')
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

end -- class STRUCT_EXTENSION_I

