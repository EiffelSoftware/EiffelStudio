indexing
	description: "All shared attributes specific to the object tool"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_OBJECT_TOOL_DATA

inherit
	SHARED_RESOURCES

feature -- Access

	object_tool_width: INTEGER is
		do
			Result := resources.get_integer ("object_tool_width", 440)
		end

	object_tool_height: INTEGER is
		do
			Result := resources.get_integer ("object_tool_height", 500)
		end

	object_tool_bar: BOOLEAN is
		do
			Result := resources.get_boolean ("object_tool_bar", True)
		end

end -- class EB_OBJECT_TOOL_DATA
