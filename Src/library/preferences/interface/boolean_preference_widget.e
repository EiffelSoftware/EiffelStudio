indexing
	description	: "Default widget for viewing and editing boolean preferences.  A combo box with two values ('True' and 'False')"
	date		: "$Date$"
	revision	: "$Revision$ and "	

class
	BOOLEAN_PREFERENCE_WIDGET

inherit
	PREFERENCE_WIDGET
		redefine
			preference,
			change_item_widget,
			update_changes
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

	change_item_widget: EV_GRID_COMBO_ITEM

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
			activate_combo
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
			change_item_widget.deactivate_actions.extend (agent update_changes)
			change_item_widget.set_item_strings (<<"True", "False">>)
			change_item_widget.set_text (preference.value.out)
			change_item_widget.pointer_button_press_actions.force_extend (agent activate_combo)
		end

	activate_combo is
			-- Activate the combo
		do
			change_item_widget.activate		
			change_item_widget.combo_box.focus_out_actions.block
			change_item_widget.combo_box.disable_edit
			change_item_widget.combo_box.focus_out_actions.resume
			change_item_widget.combo_box.select_actions.block
			if preference.value then
				change_item_widget.combo_box.i_th (1).enable_select		
			else
				change_item_widget.combo_box.i_th (2).enable_select	
			end			
			change_item_widget.combo_box.select_actions.resume
			change_item_widget.combo_box.set_focus
		end

	preference: BOOLEAN_PREFERENCE
			-- Actual preference.	
	
	last_selected_value: BOOLEAN
			-- Last selected value in the combo widget.
	
end -- class BOOLEAN_PREFERENCE_WIDGET
