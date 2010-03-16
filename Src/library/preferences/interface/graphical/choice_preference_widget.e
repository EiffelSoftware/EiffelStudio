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
			l_displayed_value: detachable STRING_GENERAL
			l_cnt, nb_values: INTEGER
			l_pref_value: detachable ARRAY [STRING]
			l_value_mapping: like value_mapping
		do
			l_pref_value := preference.value
			if l_pref_value /= Void and change_item_widget /= Void then
				l_value_mapping := value_mapping
				from
					create l_value.make_empty
					l_cnt := 1
					nb_values := l_pref_value.count
				until
					l_cnt > nb_values
				loop
					l_item := l_pref_value.item (l_cnt)
					l_displayed_value := Void
					if l_value_mapping /= Void and then not l_item.is_empty then
						l_displayed_value ?= l_value_mapping.item (l_item)
					end
					if l_displayed_value = Void then
						l_displayed_value := l_item
					end
					if change_item_widget.text.same_string_general (l_displayed_value) then
						l_value.append_character ('[')
						l_value.append (l_item)
						l_value.append_character (']')
						preference.set_selected_index (l_cnt)
					else
						l_value.append (l_item)
					end
					l_cnt := l_cnt + 1
					if l_cnt <= nb_values then
						l_value.append_character (';')
					end
				end
				preference.set_value_from_string (l_value)
			end
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
			if change_item_widget /= Void then
				change_item_widget.set_text (displayed_selected_value)
			end
		end

feature {NONE} -- Implementation

	preference: ARRAY_PREFERENCE
			-- Actual preference.

	build_change_item_widget
			-- Create and setup `change_item_widget'.
		local
			l_change_item_widget: like change_item_widget
		do
			create l_change_item_widget
			change_item_widget := l_change_item_widget
			l_change_item_widget.set_item_strings (displayed_values)
			l_change_item_widget.set_text (displayed_selected_value)
			l_change_item_widget.pointer_button_press_actions.force_extend (agent activate_combo)
			l_change_item_widget.deactivate_actions.extend (agent update_changes)
		end

	activate_combo
			-- Activate the combo
		do
			if preference.selected_index > 0 and change_item_widget /= Void then
				change_item_widget.activate
			end
		end

	displayed_values: ARRAY [STRING_GENERAL]
			-- Displayed values
			-- If `value_mapping' is Void or empty, original values are used.
		local
			l_array: ARRAY [STRING]
			i: INTEGER
			s: detachable STRING_GENERAL
		do
			if attached value_mapping as vmap and then not vmap.is_empty then
				l_array := preference.value
				create Result.make (l_array.lower, l_array.upper)
				from
					i := l_array.lower
				until
					i > l_array.upper
				loop
					if vmap.has_key (l_array.item (i)) then
						s := vmap.found_item
						check s /= Void end -- implied by `has_key'
						Result.put (s, i)
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
		local
			l_selected: detachable STRING
			s: detachable STRING_GENERAL
		do
			l_selected := preference.selected_value
			if attached value_mapping as v and l_selected /= Void then
				s := v.item (l_selected)
			end
			if s /= Void then
				Result := s
			else
				check l_selected /= Void end -- implied by ... ?
				Result := l_selected
			end
		ensure
			Result_not_void: Result /= Void
		end

	value_mapping: detachable HASH_TABLE [STRING_GENERAL, STRING];
			-- Key: values
			-- Item: strings displayed

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class CHOICE_PREFERENCE_WIDGET
