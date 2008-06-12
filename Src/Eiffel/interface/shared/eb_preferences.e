indexing
	description: "Preferences for EiffelStudio."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PREFERENCES

inherit
	EC_PREFERENCES
		rename
			make as make_batch
		end

	EB_GUI_PREFERENCES
		rename
			make as make_gui
		end

	DBG_PREFERENCES
		rename
			make as make_dbg
		end

create
	make

feature {NONE} -- Initialization

	make (a_preferences: PREFERENCES; gui_mode: BOOLEAN; dbg_mode: BOOLEAN) is
			-- Create `Current' using `a_preferences'
		require
			a_preferences_not_void: a_preferences /= Void
		do
			make_batch (a_preferences)
			if gui_mode then
				make_gui (a_preferences)
			end
			if dbg_mode then
				make_dbg (a_preferences)
			end
			preferences := a_preferences
		end

invariant
	preferences_not_void: preferences /= Void

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

end -- class EB_PREFERENCES
