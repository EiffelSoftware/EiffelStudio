indexing
	description	: "[
		Default widget for viewing and editing ARRAY preferences for which there must be only one selected value.
		]"
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
			reset
		end

create
	make,
	make_with_preference

feature -- Access
	
	change_item_widget: EV_GRID_COMBO_ITEM
			-- Widget to change the value of this preference.

	graphical_type: STRING is
			-- Graphical type identfier
		do
			Result := "COMBO"
		end	

feature -- Status Setting
	
	set_preference (new_preference: like preference) is
			-- Set the preference.
		require else
			preference_is_choice: new_preference.is_choice
		do
			Precursor (new_preference)
			check
				change_item_widget_created: change_item_widget /= Void
			end
		end

	show is
			-- Show the widget in its editable state
		do
			activate_combo
		end

feature {NONE} -- Command

	update_changes is
			-- Update the changes made in `change_item_widget' to `preference'.
		local
			l_value,
			l_item: STRING
			l_cnt: INTEGER
		do
			from
				create l_value.make_empty
				l_cnt := 1
			until
				l_cnt > preference.value.count
			loop
				l_item := preference.value.item (l_cnt)
				if change_item_widget.text.is_equal (l_item) then
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

	update_preference is
			--	Update preference.	
		do			
		end		

	reset is
			-- Reset.
		do
			Precursor {PREFERENCE_WIDGET}
			set_preference (preference)
		end		

feature {NONE} -- Implementation

	preference: ARRAY_PREFERENCE
			-- Actual preference.

	build_change_item_widget is
			-- Create and setup `change_item_widget'.
		do		
			create change_item_widget			
			change_item_widget.set_item_strings (preference.value)
			change_item_widget.set_text (preference.selected_value)			
			change_item_widget.pointer_button_press_actions.force_extend (agent activate_combo)		
			change_item_widget.deactivate_actions.extend (agent update_changes)
		end

	activate_combo is
			-- Activate the combo
		do
			if preference.selected_index > 0 then
				change_item_widget.activate
				change_item_widget.combo_box.focus_out_actions.block
				change_item_widget.combo_box.disable_edit
				change_item_widget.combo_box.focus_out_actions.resume
				change_item_widget.combo_box.set_focus
			end
		end

end -- class CHOICE_PREFERENCE_WIDGET
