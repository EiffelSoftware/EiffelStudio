indexing
	description: "Objects that provide access to the EiffelBuild resources."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_PREFERENCES

create
	make

feature -- Creation

	make (a_preferences: PREFERENCES) is
			-- Create `Current' using `a_preferences'
		do
			create dialog_data.make (a_preferences)			
			create code_generation_data.make (a_preferences)
			create global_data.make (a_preferences)
			preferences := a_preferences
		end

feature -- Access

	dialog_data: GB_DIALOG_DATA
		-- Preference data for vision and custom dialogs.
	
	code_generation_data: GB_CODE_GENERATION_DATA
		-- Preference data for the code generation.
		
	global_data: GB_GLOBAL_DATA
		-- Preference data for global information.		
	
	preferences: PREFERENCES
			-- Actual preferences.  Use only to get a preference which you do not know the type
			-- of at runtime through `get_resource'.	
	
feature -- Basic operations

	show_preference_window (a_window: EV_TITLED_WINDOW) is
			-- Ensure that `preference_window' is displayed.
		do				
			create preference_window.make (preferences, a_window)	
			preference_window.show_actions.extend (agent set_focus_to_preference_window_left_list)
			preference_window.show
		end

feature {NONE} -- Implementation

	set_focus_to_preference_window_left_list is
			-- Assign keyboard focus to `left_list' of `preference_window'.
		require
			preference_window_not_void: preference_window /= Void
		do
			preference_window.left_list.set_focus
		end
		
	preference_window: GB_PREFERENCES_WINDOW
			-- Preference window used to allow editing of the preferences.

invariant
	dialog_data_not_void: dialog_data /= Void	
	code_generation_data_not_void: code_generation_data /= Void
	global_data_not_void: global_data /= Void

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


end -- class GB_RESOURCES
