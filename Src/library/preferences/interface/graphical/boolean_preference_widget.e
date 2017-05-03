note
	description: "Default widget for viewing and editing boolean preferences.  A combo box with two values ('True' and 'False')"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$ and "

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
	make_with_preference

feature -- Access

	graphical_type: STRING
			-- Graphical type identifier.
		do
			Result := "BOOLEAN"
		end

	change_item_widget: EV_GRID_CHECKABLE_LABEL_ITEM

feature -- Status Setting

	update_changes
			-- Update the changes made in `change_item_widget' to `preference'.
		do
			preference.set_value (value_from_displayed)
			Precursor {PREFERENCE_WIDGET}
		end

	show
			-- Show the widget in its editable state
		do
			-- It is already editable as a checkbox
		end

	refresh
		do
			Precursor {PREFERENCE_WIDGET}
			change_item_widget.checked_changed_actions.block
			change_item_widget.set_is_checked (preference.value)
			change_item_widget.checked_changed_actions.resume
			change_item_widget.set_text (displayed_value (preference.value))
		end

	set_displayed_booleans (a_true, a_false: READABLE_STRING_GENERAL)
			-- Set booleans to display.
			-- {BOOLEAN}.out is used if void.
		do
			displayed_true := a_true.as_string_32
			displayed_false := a_false.as_string_32
			refresh
		end

feature {NONE} -- Implementation

	build_change_item_widget
			-- Create and setup `change_item_widget'.
		do
			create change_item_widget
			change_item_widget.set_spacing (4)
			change_item_widget.set_is_checked (preference.value)
			change_item_widget.set_text (displayed_value (preference.value))
			change_item_widget.checked_changed_actions.extend (agent checkbox_value_changed)
		end

	checkbox_value_changed (v: EV_GRID_CHECKABLE_LABEL_ITEM)
		do
			preference.set_value (v.is_checked)
			change_item_widget.set_text (displayed_value (preference.value))
			update_changes
		end

	preference: BOOLEAN_PREFERENCE
			-- Actual preference.	

	last_selected_value: BOOLEAN
			-- Last selected value in the combo widget.

	displayed_value (a_b: BOOLEAN): STRING_32
			-- Displayed value according to `a_b'
		local
			l_result: detachable STRING_32
		do
			if a_b then
				if displayed_true /= Void then
					l_result := displayed_true
				end
			else
				if displayed_false /= Void then
					l_result := displayed_false
				end
			end
			if l_result = Void then
				l_result := a_b.out
			end
			Result := l_result
			if a_b then
				last_displayed_true := Result
			else
				last_displayed_false := Result
			end
		ensure
			Result_not_void: Result /= Void
		end

	value_from_displayed: BOOLEAN
			-- Value from what have been displayed.
		do
			Result := attached last_displayed_true as ldt and then change_item_widget.text.is_equal (ldt.as_string_32)
		end

	displayed_true, displayed_false: detachable STRING_32

	last_displayed_true, last_displayed_false: detachable STRING_32;

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




end -- class BOOLEAN_PREFERENCE_WIDGET
