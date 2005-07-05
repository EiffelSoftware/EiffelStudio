indexing
	description: "[
			Abstraction for a particular graphical view of the preferences.  Implement this to
			provide a default view of preferences.  For an example see PREFERENCES_WINDOW.
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

	resource_widget (a_resource: PREFERENCE): PREFERENCE_WIDGET is
			-- Return the widget required to display `a_resource'.
		require
			resource_not_void: a_resource /= Void
		do
			if resource_widgets.has (a_resource.generating_resource_type) then				
				Result := resource_widgets.item (a_resource.generating_resource_type)					
				Result.set_resource (a_resource)
			end
		ensure
			has_result_if_known: resource_widgets.has (a_resource.generating_resource_type) implies Result /= Void
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

	register_resource_widget (a_resource_widget: PREFERENCE_WIDGET) is
			-- Register `a_resource_widget'.
		require
			resource_widget_not_void: a_resource_widget /= Void
		do
			if not resource_widgets.has (a_resource_widget.graphical_type) then				
				resource_widgets.put (a_resource_widget, a_resource_widget.graphical_type)	
			end
		ensure
			is_registered: resource_widgets.has (a_resource_widget.graphical_type)
		end	

feature {NONE} -- Implementation

	resource_widgets: HASH_TABLE [PREFERENCE_WIDGET, STRING] is
			-- Hash table of resource widgets identified by the type of resource associated with the widget.
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
			resource_widgets_not_void: Result /= Void
		end	

	preferences: PREFERENCES
			-- Preferences
invariant
	has_preferences: preferences /= Void
	has_parent_window: parent_window /= Void
			
end -- class PREFERENCE_VIEW
