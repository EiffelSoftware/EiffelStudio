note
	description: "Dialog display preferences as tree/grid view."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PREFERENCES_GRID_DIALOG

inherit
	EV_DIALOG

create
	make, make_with_hidden, make_with_control

feature {NONE} -- Initialization

	make (a_preferences: PREFERENCES)
			-- New view.
		do
			make_with_hidden (a_preferences, False)
		end

	make_with_hidden (a_preferences: PREFERENCES; a_show_hidden_flag: BOOLEAN)
		do
			make_with_control (create {like pref_control}.make_with_hidden (a_preferences, a_show_hidden_flag))
		end

	make_with_control (c: like pref_control)
			-- Initialize preferences dialog with preferences control `c'.
		do
			pref_control := c
			default_create
			pref_control.set_parent_window (Current)
			extend (pref_control.widget)
			show_actions.extend (agent pref_control.on_show)
			pref_control.set_close_button_action (agent on_close)
			set_default_cancel_button (pref_control.apply_or_close_button)
			set_size (640, 460)
			set_title (pref_control.preferences_title)
		ensure
			pref_control_set: pref_control = c
		end

feature -- Access

	set_show_hidden_preferences	(b: BOOLEAN)
		do
			pref_control.set_show_hidden_preferences (b)
		end

feature -- Status Setting

	set_show_full_preference_name (a_flag: BOOLEAN)
			-- Set 'show_full_preference_name'
		do
			pref_control.set_show_full_preference_name (a_flag)
		end

	set_root_icon (a_icon: EV_PIXMAP)
			-- Set the root node icon
		require
			icon_not_void: a_icon /= Void
		do
			pref_control.set_root_icon (a_icon)
		end

	set_folder_icon (a_icon: EV_PIXMAP)
			-- Set the folder node icon
		require
			icon_not_void: a_icon /= Void
		do
			pref_control.set_folder_icon (a_icon)
		end

	set_filter_icon_up (a_icon: EV_PIXMAP)
			-- Set the grid's header arrow up icon
		require
			icon_not_void: a_icon /= Void
		do
			pref_control.set_filter_icon_up (a_icon)
		end

	set_filter_icon_down (a_icon: EV_PIXMAP)
			-- Set the grid's header arrow down icon
		require
			icon_not_void: a_icon /= Void
		do
			pref_control.set_filter_icon_down (a_icon)
		end

feature {NONE} -- Implementation

	pref_control: PREFERENCES_GRID_CONTROL
			-- Preferences grid control.

	on_close
		do
			destroy
		end

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
