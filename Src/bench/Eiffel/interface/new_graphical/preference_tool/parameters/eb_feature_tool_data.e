indexing
	description:
		"All shared attributes specific to the feature tool"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_TOOL_DATA

inherit
	SHARED_RESOURCES

feature -- Access

	feature_tool_width: INTEGER is
		do
			Result := resources.get_integer ("feature_tool_width", 600)
		end

	feature_tool_height: INTEGER is
		do
			Result := resources.get_integer ("feature_tool_height", 450)
		end

	feature_tool_command_bar: BOOLEAN is
		do
			Result := resources.get_boolean ("feature_tool_command_bar", True)
		end

	feature_tool_format_bar: BOOLEAN is
		do
			Result := resources.get_boolean ("feature_tool_format_bar", True)
		end

	show_all_callers: BOOLEAN is
		do
			Result := resources.get_boolean ("show_all_callers", False)
		end

	do_flat_in_breakpoints: BOOLEAN is
		do
			Result := resources.get_boolean ("do_flat_in_breakpoints", True)
		end

end -- class EB_FEATURE_TOOL_DATA
