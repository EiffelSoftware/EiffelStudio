note
	description: "Cycle error in file redirection."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_ERROR_CYCLE_IN_REDIRECTION

inherit
	CONF_ERROR

create
	make

feature {NONE} -- Initialization

	make (a_file: like file; a_files: LIST [PATH])
		require
			a_files_not_empty: not a_files.is_empty
		do
			file := a_file

			create files_associated_with_cycle.make (a_files.count)
			files_associated_with_cycle.append (a_files)
		end

feature -- Access

	file: READABLE_STRING_32
			-- File that could not be opened.

	files_associated_with_cycle: ARRAYED_LIST [PATH]
			-- Files associated with the cycle

	text: STRING_32
			-- error message.
		do
			create Result.make_from_string ({STRING_32} "Cycle in configuration file redirection:")

 			across
				files_associated_with_cycle as c
			loop
				Result.append_character ('%N')
				Result.append_character ('%T')
				Result.append (c.name)
 			end
		end

invariant
	file_attached: file /= Void
	has_files_associated_with_cycle: not files_associated_with_cycle.is_empty

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
