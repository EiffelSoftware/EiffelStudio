indexing
	description: "Given a constant value provides its associated VALUE_I instance"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_VALUE_I_GENERATOR

inherit
	AST_NULL_VISITOR
		redefine
			process_bit_const_as,
			process_bool_as,
			process_char_as,
			process_real_as,
			process_integer_as,
			process_string_as,
			process_verbatim_string_as
		end

feature -- Access
	
	value_i (a_node: ATOMIC_AS): VALUE_I is
			-- Associated VALUE_I instance of `a_node'
		require
			a_node_not_void: a_node /= Void
		do
			a_node.process (Current)
			Result := last_value
			last_value := Void
		end

feature {NONE} -- Implementation

	last_value: VALUE_I
			-- Last computed value

	process_bit_const_as (l_as: BIT_CONST_AS) is
		do
			create {BIT_VALUE_I} last_value.make (l_as.value)
		end
		
	process_bool_as (a_bool: BOOL_AS) is
		do
			create {BOOL_VALUE_I} last_value.make (a_bool.value)
		end

	process_char_as (a_char: CHAR_AS) is
		do
			create {CHAR_VALUE_I} last_value.make (a_char.value)
		end

	process_integer_as (a_int: INTEGER_CONSTANT) is
		do
			last_value := a_int.twin
		end

	process_real_as (a_real: REAL_AS) is
		do
			create {REAL_VALUE_I} last_value.make_real_64 (a_real.value.to_double)
		end

	process_string_as (a_string: STRING_AS) is
		do
			create {STRING_VALUE_I} last_value.make (a_string.value, False)
		end

	process_verbatim_string_as (a_string: VERBATIM_STRING_AS) is
		do
			create {STRING_VALUE_I} last_value.make (a_string.value, False)
		end
		
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end
