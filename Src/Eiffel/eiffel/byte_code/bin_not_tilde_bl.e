indexing
	description: "Node for /~ equality operator for C code generation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	BIN_NOT_TILDE_BL

inherit
	BIN_NOT_TILDE_B
		undefine
			free_register, analyze, unanalyze,
			print_register, generate, generate_operator
		end

	BIN_TILDE_BL
		undefine
			process, enlarged
		redefine
			generate_operator,
			generate_boolean_constant,
			generate_negation
		end

create
	make

feature -- C code generation

	generate_operator (a_buffer: GENERATION_BUFFER) is
			-- Generate the operator
		do
			a_buffer.put_four_character (' ', '!', '=', ' ')
		end;

	generate_boolean_constant is
			-- Generate true constant
		do
			buffer.put_string ("EIF_TRUE");
		end;

	generate_negation is
			-- Generate negation of an equality test (if required).
		do
			buffer.put_character ('!')
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

end
