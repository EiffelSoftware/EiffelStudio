indexing
	description: "All shared attributes specific to the class tool"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEVELOPMENT_TOOL_DATA

inherit
	SHARED_RESOURCES

	EB_FLAT_SHORT_DATA

feature -- Access

	class_tool_width: INTEGER is
		do
			Result := integer_resource_value ("class_tool_width", 490)
		end

	class_tool_height: INTEGER is
		do
			Result := integer_resource_value ("class_tool_height", 500)
		end

	class_tool_command_bar: BOOLEAN is
		do
			Result := boolean_resource_value ("class_tool_command_bar", True)
		end

	class_tool_format_bar: BOOLEAN is
		do
			Result := boolean_resource_value ("class_tool_format_bar", True)
		end

	development_tool__show_general_toolbar: BOOLEAN is
			-- Show the general toolbar (New, Save, Cut, ...)?
		do
			Result := boolean_resource_value ("development_tool__show_general_toolbar", True)
		end

	development_tool__show_address_toolbar: BOOLEAN is
			-- Show the address toolbar (Back, Forward, Class, Feature, ...)?
		do
			Result := boolean_resource_value ("development_tool__show_address_toolbar", True)
		end

	development_tool__left_panel_view: INTEGER is
			-- Left panel view (255 for none, 0 for features, ...)
		do
			Result := integer_resource_value ("development_tool__left_panel_view", 0)
		end

	development_tool__right_panel_view: INTEGER is
			-- Right panel view
		do
			Result := integer_resource_value ("development_tool__right_panel_view", 0)
		end

	parse_class_after_saving: BOOLEAN is
		do
			Result := boolean_resource_value ("parse_class_after_saving", True)
		end

end -- class EB_DEVELOPMENT_TOOL_DATA
