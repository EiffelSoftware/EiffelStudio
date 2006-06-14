indexing
	description: "Represents an INI symbol AS node."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INI_SYMBOL_NODE

inherit
	INI_ATOMIC_NODE

create
	make

feature -- Access

	is_section_start_indicator: BOOLEAN is
			-- Does symbol represent start of a section?
		do
			Result := text.item (1) = {INI_SCANNER_SYMBOLS}.section_start_indicator
		end

	is_section_end_indicator: BOOLEAN is
			-- Does symbol represent end of a section?
		do
			Result := text.item (1) = {INI_SCANNER_SYMBOLS}.section_end_indicator
		end

	is_assigner_indicator: BOOLEAN is
			-- Does symbol represent an assigment symbol?
		do
			Result := text.item (1) = {INI_SCANNER_SYMBOLS}.assigner_indicator
		end

feature -- Visitation

	visit (a_visitor: INI_NODE_VISITOR) is
			-- Visit current node using vistor `a_vistor'
		do
			a_visitor.process_symbol (Current)
		end

invariant
	text_count_is_one: text.count = 1

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

end -- class {INI_SYMBOL_NODE}
