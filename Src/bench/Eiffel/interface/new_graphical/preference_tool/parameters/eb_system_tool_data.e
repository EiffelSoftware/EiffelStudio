indexing
	description: "All shared attributes specific to the system tool"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SYSTEM_TOOL_DATA

inherit
	SHARED_RESOURCES

feature -- Access

	system_tool_width: INTEGER is
		do
			Result := integer_resource_value ("system_tool_width", 440)
		end

	system_tool_height: INTEGER is
		do
			Result := integer_resource_value ("system_tool_height", 500)
		end

	system_tool_bar: BOOLEAN is
		do
			Result := boolean_resource_value ("system_tool_bar", True)
		end

	parse_ace_after_saving: BOOLEAN is
		do
			Result := boolean_resource_value ("parse_ace_after_saving", True)
		end

end -- class EB_SYSTEM_TOOL_DATA
