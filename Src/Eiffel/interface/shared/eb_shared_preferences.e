indexing
	description:
		"User preferences used in the interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision: "

class
	EB_SHARED_PREFERENCES

inherit
	EIFFEL_ENV

feature {ES, ES_GRAPHIC} -- Initialization

	initialize_preferences (a_preferences: PREFERENCES; gui_mode: BOOLEAN) is
		require
			preferences_not_void: a_preferences /= Void
			not_initialized: not preferences_initialized
		local
			l_prefs: like preferences
		once
			create l_prefs.make (a_preferences, gui_mode)
			preferences_cell.put (l_prefs)
		ensure
			preferences_not_void: preferences /= Void
			initialized: preferences_initialized
		end

feature -- Access

	preferences: EB_PREFERENCES is
			-- All preferences for EiffelStudio.				
		require
			initialized: preferences_initialized
		once
			Result := preferences_cell.item
		end

feature -- Query

	preferences_initialized: BOOLEAN is
			-- Have preferences been initialized?
		do
			Result := preferences_cell.item /= Void
		end

feature {NONE} -- Implementation

	preferences_cell: CELL [EB_PREFERENCES] is
			-- Once cell.
		once
			create Result
		end

invariant
	preferences_not_void: preferences /= Void
	initialized: preferences_initialized

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

end -- class EB_SHARED_PREFERENCES
