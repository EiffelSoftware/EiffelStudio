indexing

	description:
		"Resource valid for the project tool.";
	date: "$Date$";
	revision: "$Revision$"

class PROJECT_CATEGORY

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
			!! tool_x.make ("project_tool_x", rt, 0);
			!! tool_y.make ("project_tool_y", rt, 0);
			!! tool_width.make ("project_tool_width", rt, 481);
			!! tool_height.make ("project_tool_height", rt, 340);
			!! command_bar.make ("project_tool_command_bar", rt, true);
			!! format_bar.make ("project_tool_format_bar", rt, True);
			!! debugger_feature_height.make ("debugger_feature_height", rt, 214);
			!! debugger_object_height.make ("debugger_object_height", rt, 214);
			!! debugger_show_all_callers.make 
				("debugger_show_all_callers", rt, False);
			!! debugger_do_flat_in_breakpoints.make 
				("debugger_do_flat_in_breakpoints", rt, True);
			!! interrupt_every_n_instructions.make
				("interrupt_every_n_instruction", rt, 500);
			!! bottom_offset.make ("bottom_offset", rt, 25);
			!! raise_on_error.make ("raise_on_error", rt, True);
			!! graphical_output_disabled.make ("graphical_output_disabled", 
					rt, False);
				-- True or False to have the selector at the beginning
--  			!! selector_window.make ("Selector_window", rt, False) 
			!! selector_window.make ("Selector_window", rt, True) 

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
	bottom_offset: INTEGER_RESOURCE;
	interrupt_every_n_instructions: INTEGER_RESOURCE;
	command_bar: BOOLEAN_RESOURCE;
	format_bar: BOOLEAN_RESOURCE;
	selector_window: BOOLEAN_RESOURCE;
	raise_on_error: BOOLEAN_RESOURCE;
	graphical_output_disabled: BOOLEAN_RESOURCE;

end -- class PROJECT_CATEGORY
