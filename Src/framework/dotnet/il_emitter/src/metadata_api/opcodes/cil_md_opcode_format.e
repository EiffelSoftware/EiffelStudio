note
	description: "How opcodes are formatted?"
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_MD_OPCODE_FORMAT


feature -- Access

	no_arg: INTEGER = 1
	variable_arg: INTEGER = 2
	i_arg: INTEGER = 3
	r_arg: INTEGER = 4
	i8_arg: INTEGER = 5
	short_variable_arg: INTEGER = 6
	short_i_arg: INTEGER = 7
	short_r_arg: INTEGER = 8
	method_arg: INTEGER = 9
	field_arg: INTEGER = 10
	type_arg: INTEGER = 11
	signature_arg: INTEGER = 12
	string_arg: INTEGER = 13
	token_arg: INTEGER = 14
	branch_target_arg: INTEGER = 15
	switch_arg: INTEGER = 16
	short_branch_target_arg: INTEGER = 17;

note
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

end -- class CIL_MD_OPCODE_USAGE
