note
	description: "Constants used for creating a method body."
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_MD_METHOD_CONSTANTS


feature -- Access

	tiny_format: INTEGER_8 = 0x02
	fat_format: INTEGER_8 = 0x03
			-- Type of method header.

	more_sections: INTEGER_8 = 0x08
	init_locals: INTEGER_8 = 0x10
			-- Flags on method header.

	section_ehtable: INTEGER_8 = 0x01
	section_fat_format: INTEGER_8 = 0x40
	section_more_sections: INTEGER_8 = 0x80
			-- Flags for method data section header.

	clause_exception: INTEGER_16 = 0x0000
			-- A typed exception clause.

	clause_filter: INTEGER_16 = 0x0001
			-- An exception filter and handler clause.

	clause_finally: INTEGER_16 = 0x0002
			-- A finally clause.

	clause_fault: INTEGER_16 = 0x0004;
			-- A fault clause (finally that is called on exception
			-- only)

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

end -- class CIL_MD_METHOD_CONSTANTS
