indexing
	description: "Help section for EIS entries."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	HELP_SECTION_EIS_ENTRY

inherit
	HELP_CONTEXT_SECTION_I

	ES_EIS_SHARED
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_entry: like entry) is
			-- Initialization
		do
			entry := a_entry
		ensure
			entry_set: a_entry = entry
		end

feature -- Access

	section: !STRING_GENERAL is
			-- String representation of the section
		do
			if {lt_name: STRING_GENERAL}entry.name and then not lt_name.is_empty then
				Result := lt_name
			elseif {lt_name1: STRING_GENERAL}interface_names.l_unnamed and then not lt_name1.is_empty then
				Result := lt_name1
			else
				check empty_translation: False end
			end
		end

	entry: !EIS_ENTRY;
			-- The EIS entry

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
