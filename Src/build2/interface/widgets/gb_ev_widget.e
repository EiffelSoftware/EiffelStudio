indexing
	description: "Objects that manipulate objects of type EV_WIDGET"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_WIDGET
	
	-- The following properties from EV_WIDGET are manipulated by `Current'.
	-- Minimum_width - Performed on the real object only. Not the display object
	-- Minimum_height - Performed on the real object only. Not the display_object

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

feature -- Access

	ev_type: EV_WIDGET
	
	type: STRING is "EV_WIDGET"
		-- String representation of object_type modifyable by `Current'.


	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		do
			Result := Precursor {GB_EV_ANY}
			create minimum_width_entry.make (Current, Result, "Minimum_width", agent set_minimum_width (?), agent valid_minimum_dimension (?))
			create minimum_height_entry.make (Current, Result, "Minimum_height", agent set_minimum_height (?), agent valid_minimum_dimension (?))
			
			update_attribute_editor
			
			disable_all_items (Result)
			align_labels_left (Result)
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `first'.
		do
			minimum_height_entry.set_text (first.minimum_height.out)
			minimum_width_entry.set_text (first.minimum_width.out)
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
			if element_info /= Void then
				Result := a_name + ".set_minimum_width (" + element_info.data + ")"
			end
			element_info := full_information @ (Minimum_height_string)
			if element_info /= Void then
				Result := Result + indent + a_name + ".set_minimum_height (" + element_info.data + ")"
			end
			Result := strip_leading_indent (Result)
		end


feature {GB_XML_STORE} -- Output

	
	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		do
			if objects.first.minimum_width_set_by_user then
				add_element_containing_integer (element, Minimum_width_string, objects.first.minimum_width)	
			end
			if objects.first.minimum_height_set_by_user then
				add_element_containing_integer (element, Minimum_height_string, objects.first.minimum_height)
			end
		end
		
	modify_from_xml (element: XML_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (Minimum_width_string)
			if element_info /= Void then
				for_first_object (agent {EV_WIDGET}.set_minimum_height (element_info.data.to_integer))
			end
			
			element_info := full_information @ (Minimum_height_string)
			if element_info /= Void then
				for_first_object (agent {EV_WIDGET}.set_minimum_height (element_info.data.to_integer))
			end
		end

feature {NONE} -- Implementation

	minimum_width_entry, minimum_height_entry: GB_INTEGER_INPUT_FIELD
		-- Input widgets for `minimum_width' and `minimum_height'.
		
	set_minimum_width (integer: INTEGER) is
			-- Update property `minimum_width' on the first of `objects'.
		require
			first_not_void: first /= Void
		do
			for_first_object (agent {EV_WIDGET}.set_minimum_width (integer))
		end
		
	valid_minimum_dimension (value: INTEGER): BOOLEAN is
			-- Is `value' a valid minimum_width or minimum_height?
		do
			Result := value >= 0
		end
		
	set_minimum_height (integer: INTEGER) is
			-- Update property `minimum_height' on first of `objects'.
		require
			first_not_void: first /= Void
		do
			for_first_object (agent {EV_WIDGET}.set_minimum_height (integer))
		end

	Minimum_width_string: STRING is "Minimum_width"
	Minimum_height_string: STRING is "Minimum_height"

end -- class GB_EV_WINDOW