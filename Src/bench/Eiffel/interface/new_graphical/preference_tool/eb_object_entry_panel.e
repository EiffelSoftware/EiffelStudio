indexing
	description: "Data panel used for capturing object tool parameters."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_OBJECT_ENTRY_PANEL

inherit
	NEW_EB_CONSTANTS
		rename
			Object_resources as parameters
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
			Create command_bar.make_with_resource (Current, parameters.command_bar)

			resources.extend (tool_width)
			resources.extend (tool_height)
			resources.extend (command_bar)
		end

feature -- Access

	name: STRING is "Object tool preferences"
			-- Current's name

	symbol: PIXMAP is
		once
			Result := Pixmaps.bm_Object
		end
	
feature {NONE} -- Implementation

	tool_width, tool_height: EB_INTEGER_RESOURCE_DISPLAY
	command_bar: EB_BOOLEAN_RESOURCE_DISPLAY


end -- class EB_OBJECT_ENTRY_PANEL
