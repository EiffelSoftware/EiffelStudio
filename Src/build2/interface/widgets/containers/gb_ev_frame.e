indexing
	description: "Objects that manipulate objects of type EV_FRAME"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_FRAME

inherit
	GB_EV_ANY
		redefine
			attribute_editor,
			ev_type
		end
		
	XML_UTILITIES
		undefine
			default_create
		end
		
	EV_FRAME_CONSTANTS
		undefine
			default_create
		end

feature -- Access

	ev_type: EV_FRAME
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_FRAME"
		-- String representation of object_type modifyable by `Current'.

	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		do
			Result := Precursor {GB_EV_ANY}
			create label.make_with_text ("Style")
			Result.extend (label)
			create combo_box
			Result.extend (combo_box)
			create item_lowered.make_with_text (Ev_frame_lowered_string)
			combo_box.extend (item_lowered)
			create item_raised.make_with_text (Ev_frame_raised_string)
			combo_box.extend (item_raised)
			create item_etched_in.make_with_text (Ev_frame_etched_in_string)
			combo_box.extend (item_etched_in)
			create item_etched_out.make_with_text (Ev_frame_etched_out_string)
			combo_box.extend (item_etched_out)
			combo_box.select_actions.extend (agent selection_changed)
			combo_box.select_actions.extend (agent update_editors)

			disable_all_items (Result)
			align_labels_left (Result)
		end
		
		update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			combo_box.select_actions.block
			inspect first.style
			when Ev_frame_lowered then
				item_lowered.enable_select
			when Ev_frame_raised then
				item_raised.enable_select
			when Ev_frame_etched_in then
				item_etched_in.enable_select
			when Ev_frame_etched_out then
				item_etched_out.enable_select
			else
				check
					Error: False
				end
			end

			combo_box.select_actions.resume
--			if first.is_sensitive then
--				check_button.enable_select
--			else
--				check_button.disable_select
--			end
--			check_button.select_actions.resume
		end

feature {GB_XML_STORE} -- Output

	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		do
			add_element_containing_integer (element, Style_string, objects.first.style)
		end
		
	modify_from_xml (element: XML_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (Style_string)
			check
				data_is_an_integer: element_info.data.is_integer
			end
			for_all_objects (agent {EV_FRAME}.set_style (element_info.data.to_integer))
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
			element_info := full_information @ (Style_string)
			Result := a_name + ".set_style (" + element_info.data + ")"
			Result := strip_leading_indent (Result)
		end

feature {NONE} -- Implementation

	selection_changed is
			-- Selection in `combo_box' changed.
		do
			for_all_objects (agent {EV_FRAME}.set_style (style_from_text (combo_box.selected_item.text)))
		end
		
		
	style_from_text (text: STRING): INTEGER is
			-- `Result' is value of Ev_frame_constants matching `text'.
		do
			if text.is_equal (Ev_frame_lowered_string) then
				Result := Ev_frame_lowered
			elseif text.is_equal (Ev_frame_raised_string) then
				Result := Ev_frame_raised
			elseif text.is_equal (Ev_frame_etched_in_string) then
				Result := Ev_frame_etched_in
			elseif text.is_equal (Ev_frame_etched_out_string) then
				Result := Ev_frame_etched_out
			else
				check
					False
				end
			end
		end

	combo_box: EV_COMBO_BOX
		-- Holds current selection.
		
	label: EV_LABEL
		-- Identifies `combo_box'.
		
	Style_string: STRING is "Style"
	
	Ev_frame_lowered_string: STRING is "Ev_frame_lowered"
	Ev_frame_raised_string: STRING is "Ev_frame_rasied"
	Ev_frame_etched_in_string: STRING is "Ev_frame_etched_in"
	Ev_frame_etched_out_string: STRING is "Ev_frame_etched_out"
	
	item_lowered, item_raised, item_etched_in, item_etched_out: EV_LIST_ITEM

end -- class GB_EV_FRAME
