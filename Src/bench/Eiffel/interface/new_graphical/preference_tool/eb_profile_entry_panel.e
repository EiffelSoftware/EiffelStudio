indexing
	description: "Data panel used for capturing profiler parameters."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROFILE_ENTRY_PANEL

inherit
	NEW_EB_CONSTANTS
		rename
			Profile_resources as parameters
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

			Create tool_width.make_with_resource (Current, parameters.tool_width)
			Create tool_height.make_with_resource (Current, parameters.tool_height)
			Create query_tool_width.make_with_resource (Current, parameters.query_tool_width)
			Create query_tool_height.make_with_resource (Current, parameters.query_tool_height)

			resources.extend (tool_width)
			resources.extend (tool_height)
			resources.extend (query_tool_width)
			resources.extend (query_tool_height)
		end

feature -- Access

	name: STRING is "Profile tool preferences"
			-- Current's name

	symbol: PIXMAP is
		once
			Result := Pixmaps.bm_Profiler
		end

feature {NONE} -- Implementation

	tool_width, tool_height,
	query_tool_width, query_tool_height: EB_INTEGER_RESOURCE_DISPLAY

end -- class EB_PROFILE_ENTRY_PANEL
