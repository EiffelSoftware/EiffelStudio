indexing
	description:
		"Data panel used for capturing object tool parameters."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_OBJECT_ENTRY_PANEL

inherit
	EB_ENTRY_PANEL
		redefine
			make
		end
	EB_OBJECT_TOOL_DATA
		rename
			Object_resources as parameters
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
			create command_bar.make_with_resource (Current, parameters.command_bar)

			resources.extend (tool_width)
			resources.extend (tool_height)
			resources.extend (command_bar)
		end

feature -- Access

	name: STRING is "Object tool preferences"
			-- Current's name

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.bm_Object
		end
	
feature {NONE} -- Implementation

	tool_width, tool_height: EB_INTEGER_RESOURCE_DISPLAY
	command_bar: EB_BOOLEAN_RESOURCE_DISPLAY


end -- class EB_OBJECT_ENTRY_PANEL
