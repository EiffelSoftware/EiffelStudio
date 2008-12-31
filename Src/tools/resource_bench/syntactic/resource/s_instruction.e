note
	description: "xxx"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Instruction -> Resource | Define_statement | Include_statement | Undef_statement | If_statement
--                Ifdef_statement | Ifndef_statement | Pragma_statement

class S_INSTRUCTION

inherit
	RB_CHOICE

feature 

	construct_name: STRING
		once
			Result := "INSTRUCTION"
		end

feature

	production: LINKED_LIST [CONSTRUCT]
		local
			resource: RESOURCE
			define_statement: DEFINE_STATEMENT
			include_statement: INCLUDE_STATEMENT
			undef_statement: UNDEF_STATEMENT
			if_statement: IF_STATEMENT
			ifdef_statement: IFDEF_STATEMENT
			ifndef_statement: IFNDEF_STATEMENT
			pragma_statement: PRAGMA_STATEMENT
		once
			create Result.make
			Result.forth

			create resource.make
			put (resource)

			create define_statement.make
			put (define_statement)

			create include_statement.make
			put (include_statement)

			create undef_statement.make
			put (undef_statement)

			create if_statement.make
			put (if_statement)

			create ifdef_statement.make
			put (ifdef_statement)

			create ifndef_statement.make
			put (ifndef_statement)

			create pragma_statement.make
			put (pragma_statement)
		end

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
end -- class S_INSTRUCTION

