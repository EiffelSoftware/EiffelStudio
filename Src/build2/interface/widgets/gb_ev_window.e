indexing
	description: "Objects that manipulate objects of type EV_WINDOW"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_WINDOW
	
	-- The following properties from EV_WINDOW are manipulated by `Current'.
	-- User_can_resize - Performed on the real object only. Not the display_object.
	-- Maximum_width - Performed on the real object only. Not the display object.
	-- Maximum_height - Performed on the real object only. Not the display object.
	-- Title_string - Performed on the real object only. Not the display object.

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
		
	GB_CONSTANTS

feature -- Access

	ev_type: EV_WINDOW
		-- Vision2 type represented by `Current'.
		
	type: STRING is
			-- String representation of object_type modifyable by `Current'.
		once
			Result := Ev_window_string
		end
		
	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		do
			Result := Precursor {GB_EV_ANY}
				-- Set up `user_can_resize'.
			create user_can_resize.make_with_text ("User can resize?")
			Result.extend (user_can_resize)
			user_can_resize.select_actions.extend (agent update_user_can_resize)
			user_can_resize.select_actions.extend (agent update_editors)
			
				-- Set up maximum_width and maximum_height.
			
			create maximum_width_input.make (Current, Result, "Maximum_width", agent set_maximum_width (?), agent valid_maximum_width (?))
			create maximum_height_input.make (Current, Result, "Maximum_height", agent set_maximum_height (?), agent valid_maximum_height (?))
			
				-- Set up title.
			create title_label.make_with_text ("Title")
			Result.extend (title_label)
			create title
			Result.extend (title)
			title.change_actions.extend (agent set_title)
			title.change_actions.extend (agent update_editors)
			
			update_attribute_editor
			
			disable_all_items (Result)
			align_labels_left (Result)
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			user_can_resize.select_actions.block
			title.change_actions.block
			
			if first.user_can_resize then
				user_can_resize.enable_select
			else
				user_can_resize.disable_select
			end
			maximum_width_input.set_text (first.maximum_width.out)
			maximum_height_input.set_text (first.maximum_height.out)
			title.set_text (first.title)
			
			user_can_resize.select_actions.resume
			title.change_actions.resume
		end
		
feature {GB_XML_STORE} -- Output

	
	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		do
			add_element_containing_boolean (element, User_can_resize_string, objects.first.user_can_resize)
			add_element_containing_integer (element, Maximum_width_string, objects.first.maximum_width)
			add_element_containing_integer (element, Maximum_height_string, objects.first.maximum_height)
			add_element_containing_string (element, Title_string, objects.first.title)
		end
		
	modify_from_xml (element: XML_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			
			element_info := full_information @ (User_can_resize_string)
			if element_info.data.is_equal (True_string) then
				for_first_object (agent {EV_WINDOW}.enable_user_resize)
			else
				for_first_object (agent {EV_WINDOW}.disable_user_resize)
			end
			
			element_info := full_information @ (Maximum_width_string)
			for_first_object (agent {EV_WINDOW}.set_maximum_width(element_info.data.to_integer))
			
			element_info := full_information @ (Maximum_height_string)
			for_first_object (agent {EV_WINDOW}.set_maximum_height(element_info.data.to_integer))
			
			element_info := full_information @ (title_string)
			for_first_object (agent {EV_WINDOW}.set_title (element_info.data))
		end
		
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
			element_info := full_information @ (User_can_resize_string)
			if element_info.data.is_equal (True_string) then
				Result := a_name + ".enable_user_resize"
			else
				Result := a_name + ".disable_user_resize"
			end
		
			element_info := full_information @ (Maximum_width_string)
			Result := Result + indent + a_name + ".set_maximum_width (" + element_info.data + ")"
			
			element_info := full_information @ (Maximum_height_string)
			Result := Result + indent + a_name + ".set_maximum_height (" + element_info.data + ")"
			
			element_info := full_information @ (Title_string)
			Result := Result + indent + a_name + ".set_title (%"" + element_info.data + "%")"
		
		
			Result := strip_leading_indent (Result)
		end

feature {NONE} -- Implementation

	user_can_resize: EV_CHECK_BUTTON
		-- Check button controlling to user_can_resize attribute.
	
	maximum_width_input, maximum_height_input: GB_INTEGER_INPUT_FIELD
		-- Input widgets for `maximum_width' and `maximum_height'.

	title: EV_TEXT_FIELD
		-- Entry fields for `attribute_editor'.
		
	maximum_width_label, maximum_height_label, title_label: EV_LABEL
		-- Labels for `attribute_editor'.

	update_user_can_resize is
			-- Update property `user_can_resize' on all items in `objects'.
		do
			if user_can_resize.is_selected then
				for_first_object (agent {EV_WINDOW}.enable_user_resize)
			else
				for_first_object (agent {EV_WINDOW}.disable_user_resize)
			end
		end

	set_maximum_width (integer: INTEGER) is
			-- Update property `maximum_width' on all items in `objects'.
		require
			first_not_void: first /= Void
		do
			for_first_object (agent {EV_WINDOW}.set_maximum_width (integer))
		end
		
	valid_maximum_width (value: INTEGER): BOOLEAN is
			-- Is `value' a valid maximum_width?
		do
			Result := value > 0 and value >= first.minimum_width
		end
		
	set_maximum_height (integer: INTEGER) is
			-- Update property `maximum_width' on all items in `objects'.
		require
			first_not_void: first /= Void
		do
			for_first_object (agent {EV_WINDOW}.set_maximum_height (integer))
		end
		
	valid_maximum_height (value: INTEGER): BOOLEAN is
			-- Is `value' a valid maximum_height?
		do
			Result := value > 0 and value >= first.minimum_height
		end
		
	set_title is
			-- Update property `title' on all items in `objects'.
		do
			if title.text /= Void then
				for_first_object (agent {EV_WINDOW}.set_title (title.text))
			end
		end

		
	User_can_resize_string: STRING is "User_can_resize"
	Maximum_width_string: STRING is "Maximum_width"
	Maximum_height_string: STRING is "Maximum_height"
	Title_string: STRING is "Title"

end -- class GB_EV_WINDOW
