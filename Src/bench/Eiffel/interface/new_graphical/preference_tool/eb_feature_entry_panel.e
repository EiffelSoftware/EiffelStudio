indexing
	description: "Data panel used for capturing feature parameters."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_ENTRY_PANEL

inherit
	EB_ENTRY_PANEL
		redefine
			make
		end
	EB_FEATURE_TOOL_DATA
		rename
			Feature_resources as parameters
		export
			{NONE} all
		end
	NEW_EB_CONSTANTS

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER; a_tool: like tool) is
			--
		do
			Precursor (par, a_tool)

			create tool_width.make_with_resource (Current, parameters.tool_width)
			create tool_height.make_with_resource (Current, parameters.tool_height)
			create keep_toolbar.make_with_resource (Current, parameters.keep_toolbar)
			create double_line_toolbar.make_with_resource (Current, parameters.double_line_toolbar)
			create show_all_callers.make_with_resource (Current, parameters.show_all_callers)
			create do_flat_in_breakpoints.make_with_resource (Current, parameters.do_flat_in_breakpoints)

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

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.bm_Routine
		end

feature {NONE} -- Implementation

	tool_width, tool_height: EB_INTEGER_RESOURCE_DISPLAY
	keep_toolbar, double_line_toolbar,
	show_all_callers, do_flat_in_breakpoints: EB_BOOLEAN_RESOURCE_DISPLAY

end -- class EB_FEATURE_ENTRY_PANEL
