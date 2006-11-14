indexing
	description	: "Default widget for viewing and editing boolean preferences.  A combo box with two values ('True' and 'False')"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$ and "

class
	BOOLEAN_PREFERENCE_WIDGET

inherit
	PREFERENCE_WIDGET
		redefine
			preference,
			change_item_widget,
			update_changes,
			refresh
		end

create
	make,
	make_with_preference

feature -- Access

	graphical_type: STRING is
			-- Graphical type identifier.
		do
			Result := "BOOLEAN"
		end

	change_item_widget: EV_GRID_CHECKABLE_LABEL_ITEM

feature -- Status Setting

	update_changes is
			-- Update the changes made in `change_item_widget' to `preference'.
		do
			preference.set_value_from_string (change_item_widget.text)
			Precursor {PREFERENCE_WIDGET}
		end

	show is
			-- Show the widget in its editable state
		do
			-- It is already editable as a checkbox
		end

	refresh is
		do
			Precursor {PREFERENCE_WIDGET}
			change_item_widget.set_text (preference.string_value)
			change_item_widget.checked_changed_actions.block
			change_item_widget.set_is_checked (preference.value)
			change_item_widget.checked_changed_actions.resume
		end

feature {NONE} -- Implementation

	update_preference is
			-- Updates preference.
		do
		end

	build_change_item_widget is
			-- Create and setup `change_item_widget'.
		do
			create change_item_widget
			change_item_widget.set_spacing (4)
			change_item_widget.set_text (preference.string_value)
			change_item_widget.set_is_checked (preference.value)
			change_item_widget.checked_changed_actions.extend (agent checkbox_value_changed)
		end

	checkbox_value_changed (v: EV_GRID_CHECKABLE_LABEL_ITEM) is
		do
			preference.set_value (v.is_checked)
			change_item_widget.set_text (preference.string_value)
			update_changes
		end

	preference: BOOLEAN_PREFERENCE
			-- Actual preference.	

	last_selected_value: BOOLEAN;
			-- Last selected value in the combo widget.

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




end -- class BOOLEAN_PREFERENCE_WIDGET
