indexing
	description: "Objects that manipulate objects of type EV_TEXT_ALIGNABLE"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_TEXT_ALIGNABLE
	
	-- The following properties from EV_TEXT_ALIGNABLE are manipulated by `Current'.
	-- Text_alignment - Performed on the real object and the display_object child

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
		
	EV_ANY_HANDLER
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
			Result := Precursor {GB_EV_ANY}
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
		
feature {GB_XML_STORE} -- Output

	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			alignment: INTEGER
			alignment_text: STRING
			textable: EV_TEXT_ALIGNABLE
			default_alignment: INTEGER
		do
			textable ?= new_instance_of (dynamic_type_from_string (class_name (first)))
			textable.default_create
			default_alignment := textable.text_alignment
			alignment := first.text_alignment
			if not alignment.is_equal (default_alignment) then

			inspect alignment
			when feature {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_left then
				alignment_text := Ev_textable_left_string
			when feature {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_center then
				alignment_text := Ev_textable_center_string
			when feature {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_right then
				alignment_text := Ev_textable_right_string
			else
				check
					error: False					
				end
			end
			add_element_containing_string (element, text_alignment_string, alignment_text)
			end
		end
		
	modify_from_xml (element: XML_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (text_alignment_string)
			if element_info /= Void then
				if element_info.data.is_equal (Ev_textable_left_string) then
					for_all_objects (agent {EV_TEXT_ALIGNABLE}.align_text_left)
				elseif element_info.data.is_equal (Ev_textable_center_string) then
					for_all_objects (agent {EV_TEXT_ALIGNABLE}.align_text_center)
				elseif element_info.data.is_equal (Ev_textable_right_string) then
					for_all_objects (agent {EV_TEXT_ALIGNABLE}.align_text_right)
				end
			end
		end
		
feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XML_ELEMENT; a_name, a_type: STRING; children_names: ARRAYED_LIST [STRING]): STRING is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			Result := ""
			full_information := get_unique_full_info (element)
			element_info := full_information @ (text_alignment_string)
			if element_info /= Void then
				if element_info.data.is_equal (Ev_textable_left_string) then
					Result := Result + indent + a_name + ".align_text_left"
				elseif element_info.data.is_equal (Ev_textable_center_string) then
					Result := Result + indent + a_name + ".align_text_center"
				elseif element_info.data.is_equal (Ev_textable_right_string) then
					Result := Result + indent + a_name + ".align_text_right"
				end
			end
			Result := strip_leading_indent (Result)
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

end -- class GB_EV_TEXT_ALIGNABLE
