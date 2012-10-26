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

	set_displayed_value (a_mapping: HASH_TABLE [STRING_32, READABLE_STRING_GENERAL])
			-- Set values for display.
			-- If values are not found, original ones are displayed.
		local
			ht: like value_mapping
		do
			if attached {like value_mapping} a_mapping as vmap then
				value_mapping := vmap
			else
				create ht.make (a_mapping.count)
				across
					a_mapping as c
				loop
					ht.force (c.item, c.key.to_string_32)
				end
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
			l_cnt, nb_values: INTEGER
			l_value_mapping: like value_mapping
			s32: STRING_32
		do
			if attached preference.value as l_pref_value and change_item_widget /= Void then
				l_value_mapping := value_mapping
				from
					create l_value.make_empty
					l_cnt := 1
					nb_values := l_pref_value.count
				until
					l_cnt > nb_values
				loop
					if attached l_pref_value.item (l_cnt) as l_item then
						s32 := l_item.to_string_32
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
							l_value.append_string_general (l_item)
							l_value.append_character (']')
							preference.set_selected_index (l_cnt)
						else
							l_value.append_string_general (l_item)
						end
						l_cnt := l_cnt + 1
						if l_cnt <= nb_values then
							l_value.append_character (';')
						end
					end
				end
				preference.set_value_from_string (l_value)
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

	preference: ABSTRACT_ARRAY_PREFERENCE [READABLE_STRING_GENERAL]
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

	displayed_values: ARRAY [READABLE_STRING_GENERAL]
			-- Displayed values
			-- If `value_mapping' is Void or empty, original values are used.
		local
			i: INTEGER
			s32: STRING_32
		do
			if attached value_mapping as vmap and then not vmap.is_empty then
				if attached preference.value as l_array then
					create Result.make (l_array.lower, l_array.upper)
					from
						i := l_array.lower
					until
						i > l_array.upper
					loop
						if attached l_array.item (i) as s then
							s32 := s.to_string_32
							if vmap.has_key (s32) and then attached vmap.found_item as l_item then
								Result.put (l_item, i)
							else
								Result.put (s, i)
							end
						end
						i := i + 1
					end
				else
					check has_array_value: False end
					Result := preference.value
				end
			else
				Result := preference.value
			end
		end

	displayed_selected_value: STRING_32
			-- Displayed value
		local
			s32: STRING_32
		do
			if attached preference.selected_value as l_selected then
				s32 := l_selected.to_string_32
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

	value_mapping: detachable HASH_TABLE [STRING_32, STRING_32];
			-- Key: values
			-- Item: strings displayed

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class CHOICE_PREFERENCE_WIDGET
