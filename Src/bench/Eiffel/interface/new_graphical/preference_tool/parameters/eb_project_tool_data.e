indexing
	description:
		"All shared attributes specific to the project tool"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROJECT_TOOL_DATA

inherit
	SHARED_RESOURCES

feature -- Access

	project_tool_x: INTEGER is
		do
			Result := resources.get_integer("project_tool_x", 0)
		end

	project_tool_y: INTEGER is
		do
			Result := resources.get_integer("project_tool_y", 0)
		end

	project_tool_width: INTEGER is
		do
			Result := resources.get_integer("project_tool_width", 481)
		end

	project_tool_height: INTEGER is
		do
			Result := resources.get_integer("project_tool_height", 340)
		end

	project_toolbar_visible: BOOLEAN is
		do
			Result := resources.get_boolean("project_tool_bar", True)
		end

	raise_on_error: BOOLEAN is
		do
			Result := resources.get_boolean("raise_on_error", True)
		end

	graphical_output_disabled: BOOLEAN is
		do
			Result := resources.get_boolean("graphical_output_disabled", False)
		end


end -- class EB_PROJECT_TOOL_DATA
