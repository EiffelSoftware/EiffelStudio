
indexing
	description: "Objects that manipulate objects of type EV_TEXTABLE"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_TEXTABLE

inherit
	GB_EV_ANY
		redefine
			attribute_editor,
			ev_type
		end
		
	GB_XML_UTILITIES
		undefine
			default_create
		end
		
	EV_FRAME_CONSTANTS
		undefine
			default_create
		end

feature -- Access

	ev_type: EV_TEXTABLE
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_TEXTABLE"
		-- String representation of object_type modifyable by `Current'.

	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		do
			Result := Precursor {GB_EV_ANY}
			create label.make_with_text (text_string)
			Result.extend (label)
			create text_entry
			Result.extend (text_entry)
			text_entry.change_actions.extend (agent set_text)
			text_entry.change_actions.extend (agent update_editors)

			
			create label.make_with_text ("Text alignment")
			Result.extend (label)
			create combo_box
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
			alignment: EV_TEXT_ALIGNMENT
		do
			text_entry.change_actions.block
			combo_box.select_actions.block
			
			text_entry.set_text (first.text)
			alignment := first.alignment
			if alignment.is_left_aligned then
				item_left.enable_select
			elseif alignment.is_center_aligned then
				item_center.enable_select
			elseif alignment.is_right_aligned then
				item_right.enable_select
			end
			
			
			combo_box.select_actions.resume
			text_entry.change_actions.resume
		end
		
feature {GB_XML_STORE} -- Output

	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			alignment: EV_TEXT_ALIGNMENT
			alignment_text: STRING
		do
			alignment := objects.first.alignment
			if alignment.is_left_aligned then
				alignment_text := Ev_textable_left_string
			elseif alignment.is_center_aligned then
				alignment_text := Ev_textable_center_string
			elseif alignment.is_right_aligned then
				alignment_text := Ev_textable_right_string
			end
			add_element_containing_string (element, text_alignment_string, alignment_text)
			
			if not objects.first.text.is_empty then
				add_element_containing_string (element, text_string, objects.first.text)	
			end
		end
		
	modify_from_xml (element: XML_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (text_string)
			if element_info /= Void and then element_info.data.count /= 0 then
				for_all_objects (agent {EV_TEXTABLE}.set_text (element_info.data))
			end
			element_info := full_information @ (text_alignment_string)
			if element_info.data.is_equal (Ev_textable_left_string) then
				for_all_objects (agent {EV_TEXTABLE}.align_text_left)
			elseif element_info.data.is_equal (Ev_textable_center_string) then
				for_all_objects (agent {EV_TEXTABLE}.align_text_center)
			elseif element_info.data.is_equal (Ev_textable_right_string) then
				for_all_objects (agent {EV_TEXTABLE}.align_text_right)
			end
		end
		
feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XML_ELEMENT; a_name: STRING; children_names: ARRAYED_LIST [STRING]): STRING is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			Result := ""
			full_information := get_unique_full_info (element)
			element_info := full_information @ (text_string)
			if element_info /= Void and then element_info.data.count /= 0 then
				Result := a_name + ".set_text (%"" + element_info.data + "%")"
			end
			element_info := full_information @ (text_alignment_string)
			if element_info.data.is_equal (Ev_textable_left_string) then
				Result := Result + indent + a_name + ".align_text_left"
			elseif element_info.data.is_equal (Ev_textable_center_string) then
				Result := Result + indent + a_name + ".align_text_center"
			elseif element_info.data.is_equal (Ev_textable_right_string) then
				Result := Result + indent + a_name + ".align_text_right"
			end
			Result := strip_leading_indent (Result)
		end

feature {NONE} -- Implementation

	selection_changed is
			-- Selection in `combo_box' changed.
		do
			if combo_box.selected_item.text.is_equal (Ev_textable_left_string) then
				for_all_objects (agent {EV_TEXTABLE}.align_text_left)
			elseif combo_box.selected_item.text.is_equal (Ev_textable_center_string) then
				for_all_objects (agent {EV_TEXTABLE}.align_text_center)
			elseif combo_box.selected_item.text.is_equal (Ev_textable_right_string) then
				for_all_objects (agent {EV_TEXTABLE}.align_text_right)
			else
				check
					Not_a_valid_alignment: False
				end
			end
		end
		
	set_text is
			--
		do
			for_all_objects (agent {EV_TEXTABLE}.set_text (text_entry.text))
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

end -- class GB_EV_TEXTABLE