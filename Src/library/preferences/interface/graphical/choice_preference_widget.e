note
	description: "[
			Default widget for viewing and editing ARRAY preferences for which there must be only one selected value.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

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
			-- Graphical type identifier
		do
			Result := "COMBO"
		end

feature -- Status Setting

	set_preference (new_preference: like preference)
			-- Set the preference.
		require else
			preference_is_choice: attached {ABSTRACT_ARRAY_PREFERENCE [READABLE_STRING_GENERAL]} new_preference as ar implies ar.is_choice
		do
			Precursor (new_preference)
		end

	show
			-- Show the widget in its editable state
		do
			activate_combo
		end

	set_displayed_value (a_mapping: HASH_TABLE [STRING_32, READABLE_STRING_GENERAL])
			-- Set values for display.
			-- If values are not found, original ones are displayed.
		do
			if attached {like value_mapping} a_mapping as vmap then
				value_mapping := vmap
			else
				create value_mapping.make (a_mapping.count)
				⟳ m: a_mapping ¦ value_mapping.force (m, @ m.key) ⟲
			end
			change_item_widget.set_item_strings (displayed_values)
			change_item_widget.set_text (displayed_selected_value)
		end

feature {NONE} -- Command

	update_changes
			-- Update the changes made in `change_item_widget' to `preference'.
		local
			l_value,
			l_displayed_value: detachable STRING_32
			i, sel_index: INTEGER
			l_value_mapping: like value_mapping
			s32: STRING_32
		do
			if
				attached preference.value_as_list_of_text as l_pref_text_values and
				change_item_widget /= Void
			then
				l_value_mapping := value_mapping
				create l_value.make_empty
				i := 0
				across
					l_pref_text_values as c
				loop
					i := i + 1
					if not l_value.is_empty then
						l_value.append_character (';')
					end
					s32 := c
					if
						l_value_mapping /= Void and then
						not s32.is_empty and then
						attached {STRING_32} l_value_mapping.item (s32) as m_str32
					then
						l_displayed_value := m_str32
					else
						l_displayed_value := s32
					end
					if change_item_widget.text.same_string_general (l_displayed_value) then
						l_value.append_character ('[')
						l_value.append_string_general (preference.escaped_string (s32))
						l_value.append_character (']')
						sel_index := i
					else
						l_value.append_string_general (preference.escaped_string (s32))
					end
				end
				preference.set_value_from_string (l_value)
				check preference.selected_index = sel_index end
				preference.set_selected_index (sel_index)
			end
			Precursor {PREFERENCE_WIDGET}
		end

	refresh
			-- Reset.
		do
			Precursor {PREFERENCE_WIDGET}
			change_item_widget.set_text (displayed_selected_value)
		end

feature {NONE} -- Implementation

	preference: ABSTRACT_CHOICE_PREFERENCE [ANY]
			-- Actual preference.

	array_preference: detachable ABSTRACT_ARRAY_PREFERENCE [READABLE_STRING_GENERAL]
		do
			if attached {like array_preference} preference as p then
				Result := p
			end
		end

	choice_preference: detachable CHOICE_PREFERENCE [ANY]
		do
			if attached {like choice_preference} preference as p then
				Result := p
			end
		end

	build_change_item_widget
			-- Create and setup `change_item_widget'.
		local
			l_change_item_widget: like change_item_widget
		do
			create l_change_item_widget
			change_item_widget := l_change_item_widget
			l_change_item_widget.set_item_strings (displayed_values)
			l_change_item_widget.set_text (displayed_selected_value)
			l_change_item_widget.pointer_button_press_actions.extend
				(agent (x, y, b: INTEGER_32; x_tilt, y_tilt, pressure: REAL_64; screen_x, screen_y: INTEGER_32) do activate_combo end)
			l_change_item_widget.deactivate_actions.extend (agent update_changes)
		end

	activate_combo
			-- Activate the combo
		do
			if preference.selected_index > 0 and change_item_widget /= Void then
				change_item_widget.activate
			end
		end

	displayed_values: ARRAY [READABLE_STRING_GENERAL]
			-- Displayed values
			-- If `value_mapping' is Void or empty, original values are used.
		local
			i: INTEGER
			s32: STRING_32
			lst: LIST [STRING_32]
			vmap: like value_mapping
		do
			vmap := value_mapping
			if vmap /= Void and then vmap.is_empty then
				vmap := Void
			end
			lst := preference.value_as_list_of_text
			i := 1
			create Result.make_filled ({STRING_32} "", i, i + lst.count - 1)
			across
				lst as c
			loop
				s32 := c
				if
					vmap /= Void and then
					vmap.has_key (s32) and then attached vmap.found_item as l_item
				then
					Result.force (l_item, i)
				else
					Result.force (s32, i)
				end
				i := i + 1
			end
		end

	displayed_selected_value: STRING_32
			-- Displayed value
		do
			if attached preference.selected_value_as_text as s32 then
				if attached value_mapping as v and then attached v.item (s32) as l_found_item then
					Result := l_found_item
				else
					Result := s32
				end
			else
				Result := {STRING_32} ""
			end
		ensure
			Result_not_void: Result /= Void
		end

	value_mapping: detachable STRING_TABLE [STRING_32]
			-- Key: values
			-- Item: strings displayed
		note
			option: stable
		attribute
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
