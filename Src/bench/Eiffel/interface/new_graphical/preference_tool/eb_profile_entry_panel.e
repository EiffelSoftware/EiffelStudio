indexing
	description:
		"Data panel used for capturing profiler parameters."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROFILE_ENTRY_PANEL

inherit
	EB_ENTRY_PANEL
		redefine
			make
		end

	EB_PROFILE_TOOL_DATA
		rename
			Profile_resources as parameters
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

			create tool_width.make_with_resource (Current, parameters.tool_width)
			create tool_height.make_with_resource (Current, parameters.tool_height)
			create query_tool_width.make_with_resource (Current, parameters.query_tool_width)
			create query_tool_height.make_with_resource (Current, parameters.query_tool_height)

			resources.extend (tool_width)
			resources.extend (tool_height)
			resources.extend (query_tool_width)
			resources.extend (query_tool_height)
		end

feature -- Access

	name: STRING is "Profile tool preferences"
			-- Current's name

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.bm_Profiler
		end

feature {NONE} -- Implementation

	tool_width, tool_height,
	query_tool_width, query_tool_height: EB_INTEGER_RESOURCE_DISPLAY

end -- class EB_PROFILE_ENTRY_PANEL
