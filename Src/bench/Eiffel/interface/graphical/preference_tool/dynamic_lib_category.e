indexing
	description: "";
	date: "$Date$";
	revision: "$Revision$"

class
	DYNAMIC_LIB_CATEGORY

inherit
	EDITOR_RESOURCE_CATEGORY

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
			!! tool_width.make ("system_tool_width", rt, 440)
			!! tool_height.make ("system_tool_height", rt, 500)
			!! command_bar.make ("system_tool_command_bar", rt, true)
			!! format_bar.make ("system_tool_format_bar", rt, true)
--			!! parse_ace_after_saving.make ("parse_ace_after_saving", rt, True)
		end

feature -- Validation

	valid (a_resource: RESOURCE): BOOLEAN is
			-- Is `a_resource' valid for Current?
		do
			Result := True
		end

feature -- Resources

--	parse_ace_after_saving: BOOLEAN_RESOURCE

end -- class DYNAMIC_LIB_CATEGORY
