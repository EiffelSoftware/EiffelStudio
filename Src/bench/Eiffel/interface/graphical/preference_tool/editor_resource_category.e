indexing
	description: "Abstract notion of a category of resources.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EDITOR_RESOURCE_CATEGORY

inherit
	RESOURCE_CATEGORY

feature

	command_bar: BOOLEAN_RESOURCE
		-- Do we need to show the command bar?

	format_bar: BOOLEAN_RESOURCE
		-- Do we need to show the format bar?

	tool_width: INTEGER_RESOURCE
		-- Width of the tool.

	tool_height: INTEGER_RESOURCE
		-- Height of the tool.

end -- class EDITOR_RESOURCE_CATEGORY
