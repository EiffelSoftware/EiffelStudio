indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROJECT_PARAMETERS

inherit
	EB_PARAMETERS

creation
	make

feature {TTY_RESOURCES} -- Initialization

	initialize (rt: RESOURCE_TABLE) is
			-- Initialize all resources valid for Current.
		do
			create tool_x.make ("project_tool_x", rt, 0)
			create tool_y.make ("project_tool_y", rt, 0)
			create tool_width.make ("project_tool_width", rt, 481)
			create tool_height.make ("project_tool_height", rt, 340)
			create command_bar.make ("project_tool_command_bar", rt, True)
			create format_bar.make ("project_tool_format_bar", rt, True)
			create raise_on_error.make ("raise_on_error", rt, True)
			create graphical_output_disabled.make ("graphical_output_disabled", rt, False)
			-- create selector_window.make ("selector_window", rt, True) 
			-- create feature_window.make ("feature_window", rt, True) 
			-- create object_window.make ("object_window", rt, True) 
		end

feature -- Access

	tool_x: EB_INTEGER_RESOURCE
	tool_y: EB_INTEGER_RESOURCE 
	tool_width: EB_INTEGER_RESOURCE
	tool_height: EB_INTEGER_RESOURCE
	command_bar: EB_BOOLEAN_RESOURCE
	format_bar: EB_BOOLEAN_RESOURCE
	selector_window: EB_BOOLEAN_RESOURCE
	raise_on_error: EB_BOOLEAN_RESOURCE
	graphical_output_disabled: EB_BOOLEAN_RESOURCE

end -- class EB_PROJECT_PARAMETERS
