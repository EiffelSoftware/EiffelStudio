indexing

	description:
		"Preference tool resources for the project window."
	date: "$Date$"
	revision: "$Revision$"

class EB_PROJECT_ENTRY_PANEL

inherit
	EB_ENTRY_PANEL
		redefine
			make
		end
	EB_PROJECT_TOOL_DATA
		rename
			Project_resources as parameters
		export
			{NONE} all
		end
	NEW_EB_CONSTANTS

creation
	make 

feature {NONE} -- Initialization

	make (par: EV_CONTAINER; a_tool: like tool) is
		do
			Precursor (par, a_tool)

			create tool_x.make_with_resource (Current, parameters.tool_x)
			create tool_y.make_with_resource (Current, parameters.tool_y)
			create tool_width.make_with_resource (Current, parameters.tool_width)
			create tool_height.make_with_resource (Current, parameters.tool_height)
			create command_bar.make_with_resource (Current, parameters.command_bar)
			create format_bar.make_with_resource (Current, parameters.format_bar)
--			create feature_window.make_with_resource (Current, parameters.feature_window)
--			create object_window.make_with_resource (Current, parameters.object_window)
			create selector_window.make_with_resource (Current, parameters.selector_window)
			create raise_on_error.make_with_resource (Current, parameters.raise_on_error)

			resources.extend (tool_x)
			resources.extend (tool_y)
			resources.extend (tool_width)
			resources.extend (tool_height)
			resources.extend (command_bar)
			resources.extend (format_bar)
--			resources.extend (feature_window)
--			resources.extend (object_window)
			resources.extend (selector_window)
			resources.extend (raise_on_error)
		end

feature -- Access

	name: STRING is "Project tool preferences"
			-- Current's name

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.bm_Preference_project
		end

feature {NONE} -- Implementation

	tool_x, tool_y,
	tool_width, tool_height: EB_INTEGER_RESOURCE_DISPLAY
	command_bar, format_bar, selector_window,
	feature_window, object_window,
	raise_on_error: EB_BOOLEAN_RESOURCE_DISPLAY

end -- class EB_PROJECT_ENTRY_PANEL
