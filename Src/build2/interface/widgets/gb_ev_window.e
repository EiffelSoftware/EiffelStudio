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
	
	GB_GENERAL_UTILITIES
		undefine
			default_create
		end
		
	CDATA_HANDLER
		undefine
			default_create
		end
		
	DEFAULT_OBJECT_STATE_CHECKER
		undefine
			default_create
		end
		
	GB_CONSTANTS
		undefine
			default_create
		end

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
			create user_can_resize.make_with_text (gb_ev_window_user_can_resize)
			user_can_resize.set_tooltip (gb_ev_window_user_can_resize_tooltip)
			Result.extend (user_can_resize)
			user_can_resize.select_actions.extend (agent update_user_can_resize)
			user_can_resize.select_actions.extend (agent update_editors)
			
				-- Set up maximum_width and maximum_height.
			
			create maximum_width_input.make (Current, Result, Maximum_width_string ,gb_ev_window_maximum_width, gb_ev_window_maximum_width_tooltip,
				agent set_maximum_width (?), agent valid_maximum_width (?))
			create maximum_height_input.make (Current, Result, Maximum_height_string, gb_ev_window_maximum_height,gb_ev_window_maximum_height_tooltip,
				agent set_maximum_height (?), agent valid_maximum_height (?))
			
			create title_entry.make (Current, Result, title_string, Gb_ev_window_title, Gb_ev_window_title_tooltip,
				agent set_title (?), agent validate_true (?), Single_line_entry)	
			
			update_attribute_editor
			
			disable_all_items (Result)
			align_labels_left (Result)
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			user_can_resize.select_actions.block
			
			if first.user_can_resize then
				user_can_resize.enable_select
			else
				user_can_resize.disable_select
			end
			maximum_width_input.set_text (first.maximum_width.out)
			maximum_height_input.set_text (first.maximum_height.out)
			title_entry.set_text (first.title)
			
			user_can_resize.select_actions.resume
		end
		
feature {GB_XML_STORE} -- Output

	
	generate_xml (element: XM_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			window: EV_WINDOW
		do
			window ?= default_object_by_type (class_name (first))
			if window.user_can_resize /= first.user_can_resize then
				add_element_containing_boolean (element, User_can_resize_string, first.user_can_resize)
			end
			if window.maximum_width /= first.maximum_width or uses_constant (Maximum_width_string) then
				add_integer_element (element, Maximum_width_string, first.maximum_width)
			end
			if window.maximum_height /= first.maximum_height or uses_constant (Maximum_height_string) then
				add_integer_element (element, Maximum_height_string, first.maximum_height)
			end
			if (window.title /= first.title and not objects.first.title.is_empty) or uses_constant (Title_string) then
				add_string_element (element, Title_string, enclose_in_cdata (first.title))
			end
		end
		
	modify_from_xml (element: XM_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			element_info: ELEMENT_INFORMATION
			stripped_text: STRING
		do
			full_information := get_unique_full_info (element)
			
			element_info := full_information @ (User_can_resize_string)
			if element_info /= Void then
				if element_info.data.is_equal (True_string) then
					for_first_object (agent {EV_WINDOW}.enable_user_resize)
				else
					for_first_object (agent {EV_WINDOW}.disable_user_resize)
				end
			end
			
			if full_information @ (Maximum_width_string) /= Void then
				for_first_object (agent {EV_WINDOW}.set_maximum_width(retrieve_and_set_integer_value (Maximum_width_string)))
			end
			
			if full_information @ (Maximum_height_string) /= Void then
				for_first_object (agent {EV_WINDOW}.set_maximum_height(retrieve_and_set_integer_value (Maximum_height_string)))
			end
			
			if full_information @ (title_string) /= Void then
				for_first_object (agent {EV_WINDOW}.set_title (strip_cdata (retrieve_and_set_string_value (title_string))))
			end
		end
		
	generate_code (element: XM_ELEMENT; info: GB_GENERATED_INFO): STRING is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			element_info: ELEMENT_INFORMATION
			escaped_text: STRING
		do
			Result := ""
			full_information := get_unique_full_info (element)
			element_info := full_information @ (User_can_resize_string)
			if element_info /= Void then
				if element_info.data.is_equal (True_string) then
					Result := info.name + ".enable_user_resize"
				else
					Result := info.name + ".disable_user_resize"
				end
			end
		
			element_info := full_information @ (Maximum_width_string)
			if element_info /= Void then
				Result := Result + indent + info.name + ".set_maximum_width (" + element_info.data + ")"
			end
				
			element_info := full_information @ (Maximum_height_string)
			if element_info /= Void then
				Result := Result + indent + info.name + ".set_maximum_height (" + element_info.data + ")"
			end
			
			element_info := full_information @ (Title_string)
			if element_info /= Void then
				escaped_text := escape_special_characters (strip_cdata (element_info.data))
				Result := Result + indent + info.name + ".set_title (%"" + escaped_text + "%")"
			end

			Result := strip_leading_indent (Result)
		end

feature {NONE} -- Implementation

	user_can_resize: EV_CHECK_BUTTON
		-- Check button controlling to user_can_resize attribute.
	
	maximum_width_input, maximum_height_input: GB_INTEGER_INPUT_FIELD
		-- Input widgets for `maximum_width' and `maximum_height'.
		
	title_entry: GB_STRING_INPUT_FIELD

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
			Result := value > 0 and value >= first.minimum_width and
				value <= first.Maximum_dimension
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
			Result := value > 0 and value >= first.minimum_height and
				value <= first.Maximum_dimension
		end
		
	set_title (a_title: STRING) is
			-- Update property `title' on all items in `objects'.
		do
			for_first_object (agent {EV_WINDOW}.set_title (a_title))
		end

	validate_true (s: STRING): BOOLEAN is
			-- Always return `True', no matter what the contents of `s'
			-- are. Used when no validation is required on a string.
		do
			Result := True
		end

	User_can_resize_string: STRING is "User_can_resize"
	Maximum_width_string: STRING is "Maximum_width"
	Maximum_height_string: STRING is "Maximum_height"
	Title_string: STRING is "Title"

end -- class GB_EV_WINDOW
