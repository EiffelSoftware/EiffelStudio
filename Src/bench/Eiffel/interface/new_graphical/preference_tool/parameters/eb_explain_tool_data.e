indexing
	description:
		"All shared attributes specific to the explain tool"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXPLAIN_TOOL_DATA

inherit
	SHARED_RESOURCES

feature -- Access

	explain_tool_width: INTEGER is
		do
			Result := resources.get_integer ("explain_tool_width", 440)
		end

	explain_tool_height: INTEGER is
		do
			Result := resources.get_integer ("explain_tool_height", 500)
		end

	explain_tool_bar: BOOLEAN is
		do
			Result := resources.get_boolean ("explain_tool_bar", True)
		end

end -- class EB_EXPLAIN_TOOL_DATA
