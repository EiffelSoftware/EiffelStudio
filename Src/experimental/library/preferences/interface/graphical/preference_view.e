note
	description: "[
			Abstraction for a particular graphical view of the preferences.  Implement this to
			provide a default view of preferences.  For an example see PREFERENCES_WINDOW.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PREFERENCE_VIEW

inherit
	PREFERENCE_EXPORTER

feature -- Initialization

	make (a_preferences: like preferences)
			-- Create with `a_preferences'.
		require
			preferences_not_void: a_preferences /= Void
		do
			preferences := a_preferences
		ensure
			preferences_set: preferences = a_preferences
		end

	make_with_hidden (a_preferences: like preferences; a_show_hidden_flag: BOOLEAN)
			-- Create with `a_preferences'
			-- and show hidden preferences if `a_show_hidden_flag' is True.
		require
			preferences_not_void: a_preferences /= Void
		do
			show_hidden_preferences := a_show_hidden_flag
			make (a_preferences)
		ensure
			preferences_set: preferences = a_preferences
			hidden_set: show_hidden_preferences = a_show_hidden_flag
		end

feature -- Access

	show_dialog_modal (w: EV_ANY)
			-- Show `dlg' modal to `parent_window' if not Void
		require
			w_is_a_dialog: attached {EV_STANDARD_DIALOG} w or attached {EV_DIALOG} w
		local
			p: like parent_window
		do
			p := parent_window
			if attached {EV_DIALOG} w as dlg then
				if p /= Void then
					dlg.show_modal_to_window (p)
				else
					dlg.show
				end
			elseif p /= Void and then attached {EV_STANDARD_DIALOG} w as sdlg then
				sdlg.show_modal_to_window (p)
			end
		end

	parent_window: detachable EV_WINDOW
			-- Parent window.  Used to display this view relative to.
		deferred
		end

feature -- Query

	show_hidden_preferences: BOOLEAN
			-- Should preferences marked as hidden by visible in this view?		

feature -- Status Setting

	set_show_hidden_preferences (a_flag: BOOLEAN)
			-- Set `show_hidden_preferences'.
		do
			show_hidden_preferences := a_flag
		ensure
			value_set: show_hidden_preferences = a_flag
		end

feature {NONE} -- Implementation

	preferences: PREFERENCES
			-- Preferences
invariant
	has_preferences: preferences /= Void
--	has_parent_window: parent_window /= Void

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
