indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_PARAMETERS

inherit
	EB_PARAMETERS

creation
	make

feature {TTY_RESOURCES} -- Initialization

	initialize (rt: RESOURCE_TABLE) is
			-- Initialize all resources valid for Current.
		do
			create tool_width.make ("feature_tool_width", rt, 600);
			create tool_height.make ("feature_tool_height", rt, 450);
			create keep_toolbar.make ("show_toolbar", rt, True)
			create double_line_toolbar.make ("two_lines_toolbar", rt, False)
			create show_all_callers.make ("show_all_callers", rt, False)
			create do_flat_in_breakpoints.make ("do_flat_in_breakpoints", rt, True)
		end

feature -- Access

	tool_width: EB_INTEGER_RESOURCE
	tool_height: EB_INTEGER_RESOURCE
	keep_toolbar: EB_BOOLEAN_RESOURCE
	double_line_toolbar: EB_BOOLEAN_RESOURCE
	show_all_callers: EB_BOOLEAN_RESOURCE
	do_flat_in_breakpoints: EB_BOOLEAN_RESOURCE

end -- class EB_FEATURE_PARAMETERS
