indexing
	description: "[
			Abstraction for a particular graphical view of the preferences.  Implement this to
			provide a default view of preferences.  For an example see PREFERENCES_TREE_VIEW.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PREFERENCE_VIEW

feature -- Initialization

	make (a_preferences: like preferences; a_parent_window: like parent_window) is
			-- Create with `a_preferences'.
		require
			preferences_not_void: a_preferences /= Void
			parent_window_not_void: a_parent_window /= Void
		do
			preferences := a_preferences
			parent_window := a_parent_window
		ensure
			preferences_set: preferences = a_preferences
		end	

feature -- Access

	parent_window: EV_TITLED_WINDOW
			-- Parent window.  Used to display this view relative to.

feature {NONE} -- Implementation

	preferences: PREFERENCES
			-- Preferences
invariant
	has_preferences: preferences /= Void
	has_parent_window: parent_window /= Void
			
end -- class PREFERENCE_VIEW
