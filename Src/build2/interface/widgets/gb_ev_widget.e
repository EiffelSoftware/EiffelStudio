indexing
	description: "Objects that manipulate objects of type EV_WIDGET"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_WIDGET
	
	-- The following properties from EV_WIDGET are manipulated by `Current'.
	-- User_can_resize - Performed on the real object and the display_object.
	-- Maximum_width - Performed on the real object and the display_object.

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

feature -- Access

	ev_type: EV_WIDGET
	
	type: STRING is "EV_WIDGET"
		-- String representation of object_type modifyable by `Current'.


	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		local
			label: EV_LABEL
		do
			Result := Precursor {GB_EV_ANY}
			create label.make_with_text (Minimum_width_string)
			Result.extend (label)
			create minimum_width
			Result.extend (minimum_width)
			minimum_width.return_actions.extend (agent set_minimum_width)
			minimum_width.return_actions.extend (agent update_editors)
			create label.make_with_text (Minimum_height_string)
			Result.extend (label)
			create minimum_height
			Result.extend (minimum_height)
			minimum_height.return_actions.extend (agent set_minimum_height)
			minimum_height.return_actions.extend (agent update_editors)
			
			update_attribute_editor
			
			disable_all_items (Result)
			align_labels_left (Result)
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `first'.
		do
			minimum_width.return_actions.block
			minimum_height.return_actions.block
		
			minimum_height.set_text (first.minimum_height.out)
			minimum_width.set_text (first.minimum_width.out)
		
			minimum_width.return_actions.resume
			minimum_height.return_actions.resume
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
			element_info := full_information @ (Minimum_width_string)
			Result := a_name + ".set_minimum_width (" + element_info.data + ")"
			
			element_info := full_information @ (Minimum_height_string)
			Result := Result + indent + a_name + ".set_minimum_height (" + element_info.data + ")"
			
			Result := strip_leading_indent (Result)
		end


feature {GB_XML_STORE} -- Output

	
	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		do
			--|FIXME
			add_element_containing_integer (element, Minimum_width_string, objects.first.minimum_width)
			add_element_containing_integer (element, Minimum_height_string, objects.first.minimum_height)
		end
		
	modify_from_xml (element: XML_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (Minimum_width_string)
			for_all_objects (agent {EV_WINDOW}.set_minimum_width(element_info.data.to_integer))
			
			element_info := full_information @ (Minimum_height_string)
			for_all_objects (agent {EV_WINDOW}.set_minimum_height(element_info.data.to_integer))
		end

feature {NONE} -- Implementation

	minimum_width, minimum_height: EV_TEXT_FIELD
		-- Entry fields for `attribute_editor'.
		
	set_minimum_height is
			-- Update property `minimum_height' on all items in `objects'.
		local
			value: INTEGER
		do
			if not minimum_height.text.is_empty and then minimum_height.text.is_integer then
				value := minimum_height.text.to_integer
				if value > 0 then
					for_all_objects (agent {EV_WINDOW}.set_minimum_height (value))
				end
			end
		end
		
	set_minimum_width is
			-- Update property `minimum_width' on all items in `objects'.
		local
			value: INTEGER
		do
			if not minimum_width.text.is_empty and then minimum_width.text.is_integer then
				value := minimum_width.text.to_integer
				if value > 0 then
					for_all_objects (agent {EV_WINDOW}.set_minimum_width (value))
				end
			end
		end

	Minimum_width_string: STRING is "Minimum_width"
	Minimum_height_string: STRING is "Minimum_height"

end -- class GB_EV_WINDOW