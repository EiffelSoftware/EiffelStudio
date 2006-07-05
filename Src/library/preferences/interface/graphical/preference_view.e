indexing
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

	make_with_hidden (a_preferences: like preferences; a_parent_window: like parent_window; a_show_hidden_flag: BOOLEAN) is
			-- Create with `a_preferences' 
			-- and show hidden preferences if `a_show_hidden_flag' is True.
		require
			preferences_not_void: a_preferences /= Void
			parent_window_not_void: a_parent_window /= Void
		do
			show_hidden_preferences := a_show_hidden_flag
			make (a_preferences, a_parent_window)
		ensure
			preferences_set: preferences = a_preferences
			hidden_set: show_hidden_preferences = a_show_hidden_flag
		end

feature -- Access

	parent_window: EV_WINDOW
			-- Parent window.  Used to display this view relative to.

	preference_widget (a_preference: PREFERENCE): PREFERENCE_WIDGET is
			-- Return the widget required to display `a_preference'.
		require
			preference_not_void: a_preference /= Void
		do
			if preference_widgets.has (a_preference.generating_preference_type) then
				Result := preference_widgets.item (a_preference.generating_preference_type)
				Result.set_preference (a_preference)
			end
		ensure
			has_result_if_known: preference_widgets.has (a_preference.generating_preference_type) implies Result /= Void
		end

feature -- Query

	show_hidden_preferences: BOOLEAN
			-- Should preferences marked as hidden by visible in this view?		

feature -- Status Setting

	set_show_hidden_preferences (a_flag: BOOLEAN) is
			-- Set `show_hidden_preferences'.
		do
			show_hidden_preferences := a_flag
		ensure
			value_set: show_hidden_preferences = a_flag
		end

feature -- Commands

	register_preference_widget (a_preference_widget: PREFERENCE_WIDGET) is
			-- Register `a_preference_widget'.
		require
			preference_widget_not_void: a_preference_widget /= Void
		do
			if not preference_widgets.has (a_preference_widget.graphical_type) then
				preference_widgets.put (a_preference_widget, a_preference_widget.graphical_type)
			end
		ensure
			is_registered: preference_widgets.has (a_preference_widget.graphical_type)
		end

feature {NONE} -- Implementation

	preference_widgets: HASH_TABLE [PREFERENCE_WIDGET, STRING] is
			-- Hash table of preference widgets identified by the type of preference associated with the widget.
		local
			l_brw: BOOLEAN_PREFERENCE_WIDGET
			l_srw: STRING_PREFERENCE_WIDGET
			l_frw: FONT_PREFERENCE_WIDGET
			l_crw: COLOR_PREFERENCE_WIDGET
			l_cw: CHOICE_PREFERENCE_WIDGET
		once
			create Result.make (4)
			Result.compare_objects
			create l_brw.make
			create l_srw.make
			create l_frw.make
			create l_crw.make
			create l_cw.make
			Result.put (l_brw, l_brw.graphical_type)
			Result.put (l_srw, l_srw.graphical_type)
			Result.put (l_frw, l_frw.graphical_type)
			Result.put (l_crw, l_crw.graphical_type)
			Result.put (l_cw, l_cw.graphical_type)
		ensure
			preference_widgets_not_void: Result /= Void
		end

	preferences: PREFERENCES
			-- Preferences
invariant
	has_preferences: preferences /= Void
	has_parent_window: parent_window /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class PREFERENCE_VIEW
