indexing

	description:
		"Resource vategory for the object tool.";
	date: "$Date$";
	revision: "$Revision$"

class OBJECT_CATEGORY

inherit
	EDITOR_RESOURCE_CATEGORY

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
			create tool_width.make ("object_tool_width", rt, 440);
			create tool_height.make ("object_tool_height", rt, 500);
			create command_bar.make ("object_tool_bar", rt, True);
		end

feature -- Validation

	valid (a_resource: RESOURCE): BOOLEAN is
			-- Is `a_resource' valid for Current?
		do
			Result := True
		end

end -- class OBJECT_CATEGORY
