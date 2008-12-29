note
	description: "Constants for use with CLASS_FORMAT."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_FORMAT_CONSTANTS

inherit
	SHARED_BATCH_NAMES

feature -- Constants

	cf_Chart: INTEGER = 1
			-- Chart format. Textual descriptions of ancestors, constraints, etc.

	cf_Diagram: INTEGER = 2
			-- Diagram format. Graphical view.

	cf_Clickable: INTEGER = 3
			-- Clickable format.

	cf_Flat: INTEGER = 4
			-- Flat format.

	cf_Short: INTEGER = 5
			-- Short format.

	cf_Flatshort: INTEGER = 6
			-- Flat/short format.

feature -- Access

	all_class_formats: INTEGER_INTERVAL
			-- `cf_Chart' |..| `cf_Flatshort'.
		do
			Result := cf_Chart |..| cf_Flatshort
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

end -- class CLASS_FORMAT_CONSTANTS

