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

feature {RESOURCES} -- Initialization

	initialize (rt: RESOURCE_TABLE) is
			-- Initialize all resources valid for Current.
		do
			!! tool_x.make ("project_tool_x", rt.get_integer ("project_tool_x", 0));
			!! tool_y.make ("project_tool_y", rt.get_integer ("project_tool_y", 0));
			!! tool_width.make ("project_tool_width", rt.get_integer ("project_tool_width", 481));
			!! tool_height.make ("project_tool_height", rt.get_integer ("project_tool_height", 340));
			!! debugger_feature_height.make ("debugger_feature_height", rt.get_integer ("debugger_feature_height", 214));
			!! debugger_object_height.make ("debugger_object_height", rt.get_integer ("debugger_object_height", 214));
			!! bottom_offset.make ("bottom_offset", rt.get_integer ("bottom_offset", 25));
			!! command_bar.make ("project_tool_command_bar", rt.get_boolean ("project_tool_command_bar", true));
			!! format_bar.make ("project_tool_format_bar", rt.get_boolean ("project_tool_format_bar", True));
			!! raise_on_error.make ("raise_on_error", rt.get_boolean ("raise_on_error", True))
			!! debugger_show_all_callers.make ("debugger_show_all_callers",
					rt.get_boolean ("debugger_show_all_callers", False))
			!! debugger_do_flat_in_breakpoints.make ("debugger_do_flat_in_breakpoints",
					rt.get_boolean ("debugger_do_flat_in_breakpoints", True))
		end

feature -- Validation

	valid (a_resource: RESOURCE): BOOLEAN is
			-- Is `a_resource' valid for Current?
		do
			Result := True
		end

feature -- Access

	linear_representation: LINKED_LIST [RESOURCE] is
			-- All resources within Current
		do
			!! Result.make;
			Result.extend (tool_x);
			Result.extend (tool_y);
			Result.extend (tool_width);
			Result.extend (tool_height);
			Result.extend (debugger_feature_height);
			Result.extend (debugger_object_height);
			Result.extend (debugger_show_all_callers);
			Result.extend (debugger_do_flat_in_breakpoints);
			Result.extend (bottom_offset);
			Result.extend (command_bar);
			Result.extend (format_bar);
			Result.extend (raise_on_error)
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
	command_bar: BOOLEAN_RESOURCE;
	format_bar: BOOLEAN_RESOURCE;
	raise_on_error: BOOLEAN_RESOURCE;


end -- class PROJECT_CATEGORY
