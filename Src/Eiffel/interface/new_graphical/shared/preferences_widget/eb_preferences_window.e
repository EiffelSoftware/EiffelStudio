indexing
	description: "EiffelStudio preference window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PREFERENCES_WINDOW

inherit
	PREFERENCES_GRID_DIALOG
		rename
			make as view_make,
			make_with_hidden as view_make_with_hidden
		redefine
			hide,
			on_close,
			pref_control
		end

	EB_SHARED_PIXMAPS
		undefine
			copy,
			default_create
		end

	EB_SHARED_PREFERENCES
		undefine
			copy,
			default_create
		end

	SHARED_BENCH_NAMES
		undefine
			copy,
			default_create
		end

create
	make, make_with_hidden

feature -- Access

	make (a_preferences: PREFERENCES; a_obs_parent_window: EV_WINDOW) is
			-- New window.  Redefined to register EiffelStudio specific preference widgets for
			-- special preference types.
		do
			make_with_hidden (a_preferences, a_obs_parent_window, False)
		end

	make_with_hidden (a_preferences: PREFERENCES; a_obs_parent_window: EV_WINDOW; a_show_hidden_flag: BOOLEAN) is
			-- New window.  Redefined to register EiffelStudio specific preference widgets for
			-- special preference types.
		do
			view_make_with_hidden (a_preferences, a_show_hidden_flag)
			set_icon_pixmap (icon_pixmaps.tool_preferences_icon)
		end

	pref_control: EB_PREFERENCES_GRID_CONTROL

	on_close is
			-- Window was closed
		do
			hide
		end

	hide is
			-- Window was closed through cancel button
		do
			preferences.misc_data.preference_window_height_preference.set_value (height)
			preferences.misc_data.preference_window_width_preference.set_value (width)
			Precursor
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

end -- class EB_PREFERENCES_WINDOW
