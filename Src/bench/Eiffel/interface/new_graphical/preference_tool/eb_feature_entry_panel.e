indexing
	description: "Data panel used for capturing feature parameters."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_ENTRY_PANEL

inherit
	NEW_EB_CONSTANTS
		rename
			Feature_resources as parameters
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
			--
		do
			Precursor (par, a_tool)

			Create tool_width.make_with_resource (Current, parameters.tool_width)
			Create tool_height.make_with_resource (Current, parameters.tool_height)
			Create keep_toolbar.make_with_resource (Current, parameters.keep_toolbar)
			Create double_line_toolbar.make_with_resource (Current, parameters.double_line_toolbar)
			Create show_all_callers.make_with_resource (Current, parameters.show_all_callers)
			Create do_flat_in_breakpoints.make_with_resource (Current, parameters.do_flat_in_breakpoints)

			resources.extend (tool_width)
			resources.extend (tool_height)
			resources.extend (keep_toolbar)
			resources.extend (double_line_toolbar)
			resources.extend (show_all_callers)
			resources.extend (do_flat_in_breakpoints)
		end

feature -- Access

	name: STRING is "Feature tool preferences"
			-- Current's name

	symbol: PIXMAP is
		once
			Result := Pixmaps.bm_Routine
		end;

feature {NONE} -- Implementation

	tool_width, tool_height: EB_INTEGER_RESOURCE_DISPLAY
	keep_toolbar, double_line_toolbar,
	show_all_callers, do_flat_in_breakpoints: EB_BOOLEAN_RESOURCE_DISPLAY

end -- class EB_FEATURE_ENTRY_PANEL
