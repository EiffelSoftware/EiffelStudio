indexing

	description:
		"Preference tool resources for the project window."
	date: "$Date$"
	revision: "$Revision$"

class EB_PROJECT_ENTRY_PANEL

inherit
	NEW_EB_CONSTANTS
		rename
			Project_resources as parameters
		export
			{NONE} all
		end
	EB_ENTRY_PANEL
		redefine
			make
		end

creation
	make 

feature {NONE} -- Initialization

	make (par: EV_CONTAINER; a_tool: like tool) is
		do
			Precursor (par, a_tool)

			Create tool_x.make_with_resource (Current, parameters.tool_x)
			Create tool_y.make_with_resource (Current, parameters.tool_y)
			Create tool_width.make_with_resource (Current, parameters.tool_width)
			Create tool_height.make_with_resource (Current, parameters.tool_height)
			Create command_bar.make_with_resource (Current, parameters.command_bar)
			Create format_bar.make_with_resource (Current, parameters.format_bar)
--			Create feature_window.make_with_resource (Current, parameters.feature_window)
--			Create object_window.make_with_resource (Current, parameters.object_window)
			Create selector_window.make_with_resource (Current, parameters.selector_window)
			Create raise_on_error.make_with_resource (Current, parameters.raise_on_error)
			Create graphical_output_disabled.make_with_resource (
				Current, parameters.graphical_output_disabled)

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
			resources.extend (graphical_output_disabled)
		end

feature -- Access

	name: STRING is "Project tool preferences"
			-- Current's name

	symbol: PIXMAP is
		once
			Result := Pixmaps.bm_Preference_project
		end

feature {NONE} -- Implementation

	tool_x, tool_y,
	tool_width, tool_height: EB_INTEGER_RESOURCE_DISPLAY
	command_bar, format_bar, selector_window,
	feature_window, object_window,
	raise_on_error: EB_BOOLEAN_RESOURCE_DISPLAY
	graphical_output_disabled: EB_BOOLEAN_RESOURCE_DISPLAY

end -- class EB_PROJECT_ENTRY_PANEL
