indexing

	description:
		"Resource vategory for the explain tool.";
	date: "$Date$";
	revision: "$Revision$"

class EXPLAIN_CATEGORY

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
			!! tool_width.make ("explain_tool_width", rt, 440);
			!! tool_height.make ("explain_tool_height", rt, 500);
			!! command_bar.make ("explain_tool_bar", rt, True);
		end

feature -- Validation

	valid (a_resource: RESOURCE): BOOLEAN is
			-- Is `a_resource' valid for Current?
		do
			Result := True
		end

end -- class EXPLAIN_CATEGORY
