indexing

	description:
		"Resource vategory for the feature tool.";
	date: "$Date$";
	revision: "$Revision$"

class ROUTINE_CATEGORY

inherit
	RESOURCE_CATEGORY

creation
	make


feature {NONE} -- Initialization

	make is
			-- Initialize Current
		do
			!! users.make;
			!! modified_resources.make
		end

feature {TTY_RESOURCES} -- Initialization

	initialize (rt: RESOURCE_TABLE) is
			-- Initialize all resources valid for Current.
		do
			!! tool_width.make ("feature_tool_width", rt, 600);
			!! tool_height.make ("feature_tool_height", rt, 450);
			!! command_bar.make ("feature_tool_command_bar", rt, True);
			!! format_bar.make ("feature_tool_format_bar", rt, True)
			!! show_all_callers.make ("show_all_callers", rt, False)
			!! do_flat_in_breakpoints.make ("do_flat_in_breakpoints", rt, True)
		end

feature -- Validation

	valid (a_resource: RESOURCE): BOOLEAN is
			-- Is `a_resource' valid for Current?
		do
			Result := True
		end

feature -- Resources

	tool_width: INTEGER_RESOURCE;
	tool_height: INTEGER_RESOURCE;
	command_bar: BOOLEAN_RESOURCE;
	format_bar: BOOLEAN_RESOURCE
	show_all_callers: BOOLEAN_RESOURCE;
	do_flat_in_breakpoints: BOOLEAN_RESOURCE

end -- class ROUTINE_CATEGORY
