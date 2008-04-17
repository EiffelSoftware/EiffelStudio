indexing
	description: "User preferences used in the interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_COMPILER_PREFERENCES

feature -- Access

	preferences: COMPILER_PREFERENCES is
			-- All preferences for `ec'.
		do
			Result := preferences_cell.item
		ensure
			preferences_not_void: Result /= Void
		end

feature -- Settings

	set_preferences (p: like preferences) is
			-- Set `command_executor' with `c'.
		require
			c_not_void: p /= Void
		do
			preferences_cell.put (p)
		ensure
			preferences_set: preferences = p
		end

feature {NONE} -- Implementation

	preferences_cell: CELL [COMPILER_PREFERENCES] is
			-- Once cell.
		indexing
			once_status: global
		once
			create Result
			Result.put (create {COMPILER_PREFERENCES}.make (create {PREFERENCES}.make))
		ensure
			preferences_cell_not_void: Result /= Void
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
