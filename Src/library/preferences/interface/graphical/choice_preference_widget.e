indexing
	description	: "[
		Default widget for viewing and editing ARRAY resources for which there must be only one selected value.
		]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	CHOICE_PREFERENCE_WIDGET

inherit
	PREFERENCE_WIDGET
		redefine
			resource,
			set_resource,
			change_item_widget,
			update_changes,
			reset
		end

create
	make,
	make_with_resource

feature -- Access
	
	change_item_widget: EV_GRID_COMBO_ITEM
			-- Widget to change the value of this resource.

	graphical_type: STRING is
			-- Graphical type identfier
		do
			Result := "COMBO"
		end	

feature -- Status Setting
	
	set_resource (new_resource: like resource) is
			-- Set the resource.
		require else
			resource_is_choice: new_resource.is_choice
		do
			Precursor (new_resource)
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
			-- Update the changes made in `change_item_widget' to `resource'.
		local
			l_value,
			l_item: STRING
			l_cnt: INTEGER
		do
			from
				create l_value.make_empty
				l_cnt := 1
			until
				l_cnt > resource.value.count
			loop
				l_item := resource.value.item (l_cnt)
				if change_item_widget.text.is_equal (l_item) then
					l_value.append_character ('[')
					l_value.append (l_item)
					l_value.append_character (']')
					resource.set_selected_index (l_cnt)
				else
					l_value.append (l_item)
				end
				l_cnt := l_cnt + 1				
				l_value.append_character (';')
			end
			resource.set_value_from_string (l_value)			
			Precursor {PREFERENCE_WIDGET}
		end

	update_resource is
			--	Update resource.	
		do			
		end		

	reset is
			-- Reset.
		do
			Precursor {PREFERENCE_WIDGET}
			set_resource (resource)
		end		

feature {NONE} -- Implementation

	resource: ARRAY_PREFERENCE
			-- Actual resource.

	build_change_item_widget is
			-- Create and setup `change_item_widget'.
		do		
			create change_item_widget			
			change_item_widget.set_item_strings (resource.value)
			change_item_widget.set_text (resource.selected_value)			
			change_item_widget.pointer_button_press_actions.force_extend (agent activate_combo)		
			change_item_widget.deactivate_actions.extend (agent update_changes)
		end

	activate_combo is
			-- Activate the combo
		do
			if resource.selected_index > 0 then
				change_item_widget.activate
				change_item_widget.combo_box.focus_out_actions.block
				change_item_widget.combo_box.disable_edit
				change_item_widget.combo_box.focus_out_actions.resume
				change_item_widget.combo_box.set_focus
			end
		end

end -- class CHOICE_PREFERENCE_WIDGET
