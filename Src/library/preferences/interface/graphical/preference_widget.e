indexing
	description	: "Abstaction for a widget representing a particular preference.%
		%Used for reading and writing preference values.  Actual interface is `change_item_widget'. To%
		%create an custom interface redefine this."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	PREFERENCE_WIDGET

feature {NONE} -- Initialization

	make is
			-- Create			
		do
			create change_actions
		end

	make_with_preference (a_preference: like preference) is
			-- Make with values from `a_preference'.
		require
			preference_not_void: a_preference /= Void
		do
			set_preference (a_preference)
			make
		ensure
			has_preference: preference /= Void
		end

feature -- Access

	change_item_widget: EV_GRID_ITEM
			-- Widget to change the item.

	caller: PREFERENCE_VIEW
			-- Caller view to which this preference widget currently belongs.

	preference: PREFERENCE
			-- Actual preference associated to the widget.

	graphical_type: STRING is
			-- Graphical type identifier.
		deferred
		end

feature -- Basic operations

	set_preference (new_preference: like preference) is
			-- Set the preference.
		require
			preference_not_void: new_preference /= Void
		do
			preference := new_preference

			if change_item_widget = Void then
				build_change_item_widget
			end
		ensure
			preference_set: preference = new_preference
		end

	set_caller (a_caller: like caller) is
			-- Set the view this widget belongs to.
		require
			caller_not_void: a_caller /= Void
		do
			caller := a_caller
		ensure
			caller_set: caller = a_caller
		end

	destroy is
			-- Destroy all graphical objects.
		do
			if change_item_widget /= Void then
				change_item_widget.destroy
			end
		end

	update_changes is
			-- Update the changes made in `change_item_widget' to `preference'.
		do
			change_actions.call ([preference])
		end

	update_preference is
			-- Update the changes made in `change_item_widget' to `preference'.
		deferred
		end

	refresh is
			-- Refresh preference widget to current value
		do
		end

	show is
			-- Show the widget in its editable state
		deferred
		end

feature -- Actions

	change_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when `preference' changes, after call to `update_changes'.		

feature {NONE} -- Implementation

	build_change_item_widget is
				-- Create and setup `change_item_widget'.
		deferred
		ensure
			widget_created: change_item_widget /= Void
		end

invariant
	has_widget: change_item_widget /= Void

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




end -- class PREFERENCE_WIDGET
