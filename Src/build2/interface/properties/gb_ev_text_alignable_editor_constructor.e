indexing
	description: "Builds an attrribute editor for modification of objects of type EV_TEXT_ALIGNABLE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_TEXT_ALIGNABLE_EDITOR_CONSTRUCTOR
	
inherit
	GB_EV_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end
		
feature -- Access

	ev_type: EV_TEXT_ALIGNABLE
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_TEXT_ALIGNABLE"
		-- String representation of object_type modifyable by `Current'.

	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		do	
			create Result
			initialize_attribute_editor (Result)
			create label.make_with_text (gb_ev_text_alignable)
			label.set_tooltip (gb_ev_text_alignable_tooltip)
			Result.extend (label)
			create combo_box
			combo_box.set_tooltip (gb_ev_text_alignable_tooltip)
			Result.extend (combo_box)
			combo_box.disable_edit
			create item_left.make_with_text (Ev_textable_left_string)
			combo_box.extend (item_left)
			create item_center.make_with_text (Ev_textable_center_string)
			combo_box.extend (item_center)
			create item_right.make_with_text (Ev_textable_right_string)
			combo_box.extend (item_right)
			combo_box.select_actions.extend (agent selection_changed)
			combo_box.select_actions.extend (agent update_editors)

			update_attribute_editor

			disable_all_items (Result)
			align_labels_left (Result)
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		local
			alignment: INTEGER
		do
			combo_box.select_actions.block

			alignment := first.text_alignment
			inspect alignment
			when feature {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_left then
				item_left.enable_select
			when feature {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_center then
				item_center.enable_select
			when feature {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_right then
				item_right.enable_select	
			else
				check
					error: False					
				end
			end
			combo_box.select_actions.resume
		end
		
feature {NONE} -- Implementation

	selection_changed is
			-- Selection in `combo_box' changed.
		do
			if combo_box.selected_item.text.is_equal (Ev_textable_left_string) then
				for_all_objects (agent {EV_TEXT_ALIGNABLE}.align_text_left)
			elseif combo_box.selected_item.text.is_equal (Ev_textable_center_string) then
				for_all_objects (agent {EV_TEXT_ALIGNABLE}.align_text_center)
			elseif combo_box.selected_item.text.is_equal (Ev_textable_right_string) then
				for_all_objects (agent {EV_TEXT_ALIGNABLE}.align_text_right)
			else
				check
					Not_a_valid_alignment: False
				end
			end
		end

	item_left, item_center, item_right: EV_LIST_ITEM

	combo_box: EV_COMBO_BOX
		-- Holds current selection.
		
	label: EV_LABEL
		-- Identifies `combo_box'.
		
	text_entry: EV_TEXT_FIELD

	Text_string: STRING is "Text"
	Text_alignment_string: STRING is "Text_alignment"
	
	Ev_textable_left_string: STRING is "Left"
	Ev_textable_center_string: STRING is "Center"
	Ev_textable_right_string: STRING is "Right"

end -- class GB_EV_TEXT_ALIGNABLE_EDITOR_CONSTRUCTOR
