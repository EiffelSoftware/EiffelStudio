indexing
	description: "Resource vategory for the feature tool.";
	date: "$Date$";
	revision: "$Revision$"

class ROUTINE_CATEGORY

inherit
	EDITOR_RESOURCE_CATEGORY
		export
			{NONE} command_bar, format_bar
		end

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
			!! keep_toolbar.make ("show_toolbar", rt, True)
			!! double_line_toolbar.make ("two_lines_toolbar", rt, False)
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

	show_all_callers: BOOLEAN_RESOURCE;
	do_flat_in_breakpoints: BOOLEAN_RESOURCE;
	double_line_toolbar, keep_toolbar: BOOLEAN_RESOURCE

end -- class ROUTINE_CATEGORY
