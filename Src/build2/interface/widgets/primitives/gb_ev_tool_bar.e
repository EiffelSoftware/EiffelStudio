indexing
	description: "Objects that manipulate objects of type EV_TOOL_BAR."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_TOOL_BAR
	
	-- The following properties from EV_TOOL_BAR are manipulated by `Current'.
	-- Is_sensitive - Performed on the real object only. Not the display object.

inherit
	GB_EV_ANY
		undefine
			attribute_editor
		end
		
	GB_EV_TOOL_BAR_EDITOR_CONSTRUCTOR
	
	DEFAULT_OBJECT_STATE_CHECKER
		export
			{NONE} all
		undefine
			default_create
		end

feature {GB_XML_STORE} -- Output

	generate_xml (element: XM_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
			-- Note that we must query the _I, as there is no way to know
			-- if the widget was really disabled by the user, or by its
			-- parent except in the interface.
		local
			tool_bar: EV_TOOL_BAR
		do
			tool_bar ?= default_object_by_type (class_name (first))
			if not tool_bar.has_vertical_button_style = first.has_vertical_button_style then
				add_element_containing_boolean (element, has_vertical_button_style_string, first.has_vertical_button_style)
			end
		end

	modify_from_xml (element: XM_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (Has_vertical_button_style_string)
			if element_info /= Void then
				if element_info.data.is_equal (True_string) then
					for_all_objects (agent {EV_TOOL_BAR}.enable_vertical_button_style)
				else
					for_all_objects (agent {EV_TOOL_BAR}.disable_vertical_button_style)
				end
			end
		end
		
	generate_code (element: XM_ELEMENT; info: GB_GENERATED_INFO): ARRAYED_LIST [STRING] is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			element_info: ELEMENT_INFORMATION
		do
			create Result.make (1)
			full_information := get_unique_full_info (element)
			element_info := full_information @ (Has_vertical_button_style_string)
			if element_info /= Void then
				if element_info.data.is_equal (True_string) then
					Result.extend (info.name + ".enable_vertical_button_style")
				else
					Result.extend (info.name + ".disable_vertical_button_style")
				end
			end
		end

end -- class GB_EV_TOOL_BAR
