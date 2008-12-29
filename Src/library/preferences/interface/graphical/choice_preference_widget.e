note
	description	: "[
		Default widget for viewing and editing ARRAY preferences for which there must be only one selected value.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	CHOICE_PREFERENCE_WIDGET

inherit
	PREFERENCE_WIDGET
		redefine
			preference,
			set_preference,
			change_item_widget,
			update_changes,
			refresh
		end

create
	make,
	make_with_preference

feature -- Access

	change_item_widget: EV_GRID_CHOICE_ITEM
			-- Widget to change the value of this preference.

	graphical_type: STRING
			-- Graphical type identfier
		do
			Result := "COMBO"
		end

feature -- Status Setting

	set_preference (new_preference: like preference)
			-- Set the preference.
		require else
			preference_is_choice: new_preference.is_choice
		do
			Precursor (new_preference)
			check
				change_item_widget_created: change_item_widget /= Void
			end
		end

	show
			-- Show the widget in its editable state
		do
			activate_combo
		end

	set_displayed_value (a_mapping: like value_mapping)
			-- Set values for display.
			-- If values are not found, original ones are displayed.
		do
			value_mapping := a_mapping
			change_item_widget.set_item_strings (displayed_values)
			change_item_widget.set_text (displayed_selected_value)
		end

feature {NONE} -- Command

	update_changes
			-- Update the changes made in `change_item_widget' to `preference'.
		local
			l_value,
			l_item: STRING
			l_displayed_value: STRING_32
			l_cnt: INTEGER
		do
			from
				create l_value.make_empty
				l_cnt := 1
			until
				l_cnt > preference.value.count
			loop
				l_item := preference.value.item (l_cnt)
				l_displayed_value := Void
				if value_mapping /= Void and then not l_item.is_empty then
					l_displayed_value ?= value_mapping.item (l_item)
				end
				if l_displayed_value = Void then
					l_displayed_value := l_item
				end
				if change_item_widget.text.is_equal (l_displayed_value) then
					l_value.append_character ('[')
					l_value.append (l_item)
					l_value.append_character (']')
					preference.set_selected_index (l_cnt)
				else
					l_value.append (l_item)
				end
				l_cnt := l_cnt + 1
				l_value.append_character (';')
			end
			preference.set_value_from_string (l_value)
			Precursor {PREFERENCE_WIDGET}
		end

	update_preference
			--	Update preference.	
		do
		end

	refresh
			-- Reset.
		do
			Precursor {PREFERENCE_WIDGET}
			change_item_widget.set_text (displayed_selected_value)
		end

feature {NONE} -- Implementation

	preference: ARRAY_PREFERENCE
			-- Actual preference.

	build_change_item_widget
			-- Create and setup `change_item_widget'.
		do
			create change_item_widget
			change_item_widget.set_item_strings (displayed_values)
			change_item_widget.set_text (displayed_selected_value)
			change_item_widget.pointer_button_press_actions.force_extend (agent activate_combo)
			change_item_widget.deactivate_actions.extend (agent update_changes)
		end

	activate_combo
			-- Activate the combo
		do
			if preference.selected_index > 0 then
				change_item_widget.activate
			end
		end

	displayed_values: ARRAY [STRING_GENERAL]
			-- Displayed values
			-- If `value_mapping' is Void or empty, original values are used.
		local
			l_array: ARRAY [STRING]
			i: INTEGER
		do
			if value_mapping /= Void and not value_mapping.is_empty then
				l_array := preference.value
				create Result.make (l_array.lower, l_array.upper)
				from
					i := l_array.lower
				until
					i > l_array.upper
				loop
					if value_mapping.has_key (l_array.item (i)) then
						Result.put (value_mapping.found_item, i)
					else
						Result.put (l_array.item (i), i)
					end
					i := i + 1
				end
			else
				Result := preference.value
			end
		end

	displayed_selected_value: STRING_GENERAL
			-- Displayed value
		do
			if value_mapping /= Void then
				Result := value_mapping.item (preference.selected_value)
			end
			if Result = Void then
				Result := preference.selected_value
			end
		ensure
			Result_not_void: Result /= Void
		end

	value_mapping: HASH_TABLE [STRING_GENERAL, STRING];
			-- Key: values
			-- Item: strings displayed

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class CHOICE_PREFERENCE_WIDGET
