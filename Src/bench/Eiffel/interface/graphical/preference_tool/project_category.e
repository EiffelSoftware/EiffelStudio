indexing

	description:
		"Resource valid for the project tool.";
	date: "$Date$";
	revision: "$Revision$"

class PROJECT_CATEGORY

inherit
	RESOURCE_CATEGORY

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize Current
		do
			create users.make;
			create modified_resources.make
		end

feature {TTY_RESOURCES} -- Initialization

	initialize (rt: RESOURCE_TABLE) is
			-- Initialize all resources valid for Current.
		do
			create tool_x.make ("project_tool_x", rt, 0);
			create tool_y.make ("project_tool_y", rt, 0);
			create tool_width.make ("project_tool_width", rt, 481);
			create tool_height.make ("project_tool_height", rt, 340);
			create command_bar.make ("project_tool_command_bar", rt, true);
			create format_bar.make ("project_tool_format_bar", rt, True);
			create debugger_feature_height.make ("debugger_feature_height", rt, 214);
			create debugger_object_height.make ("debugger_object_height", rt, 214);
			create debugger_show_all_callers.make ("debugger_show_all_callers", rt, False);
			create debugger_do_flat_in_breakpoints.make ("debugger_do_flat_in_breakpoints", rt, True);
			create interrupt_every_n_instructions.make ("interrupt_every_n_instruction", rt, 500);
			create raise_on_error.make ("raise_on_error", rt, True);
			create graphical_output_disabled.make ("graphical_output_disabled", rt, False);
			create selector_window.make ("selector_window", rt, True) 
			create feature_window.make ("feature_window", rt, True) 
			create object_window.make ("object_window", rt, True) 
		end

feature -- Validation

	valid (a_resource: RESOURCE): BOOLEAN is
			-- Is `a_resource' valid for Current?
		do
			Result := True
		end

feature -- Resources

	tool_x: INTEGER_RESOURCE;
	tool_y: INTEGER_RESOURCE;
	tool_width: INTEGER_RESOURCE;
	tool_height: INTEGER_RESOURCE;
	debugger_feature_height: INTEGER_RESOURCE;
	debugger_object_height: INTEGER_RESOURCE;
	debugger_show_all_callers: BOOLEAN_RESOURCE;
	debugger_do_flat_in_breakpoints: BOOLEAN_RESOURCE;
	interrupt_every_n_instructions: INTEGER_RESOURCE;
	command_bar: BOOLEAN_RESOURCE;
	format_bar: BOOLEAN_RESOURCE;
	selector_window: BOOLEAN_RESOURCE;
	feature_window, object_window: BOOLEAN_RESOURCE
	raise_on_error: BOOLEAN_RESOURCE;
	graphical_output_disabled: BOOLEAN_RESOURCE;

end -- class PROJECT_CATEGORY
