indexing
	description: "Data panel used for capturing tool parameters."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_TOOL_ENTRY_PANEL

inherit
	EB_ENTRY_PANEL
		redefine
			make
		end
	EB_TOOL_DATA
		rename
			Tool_resources as parameters
		export
			{NONE} all
		end
	NEW_EB_CONSTANTS
	SYSTEM_CONSTANTS

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER; a_tool: like tool) is
		do
			Precursor (par, a_tool)

			if Platform_constants.is_windows then
				Create regular_button.make_with_resource (Current, parameters.regular_button)
			end
			create close_button.make_with_resource (Current, parameters.close_button)
			create default_window_position.make_with_resource (Current, parameters.default_window_position)
			create history_size.make_with_resource (Current, parameters.history_size)

			if Platform_constants.is_windows then
				resources.extend (regular_button)
			end
			resources.extend (close_button)
			resources.extend (default_window_position)
			resources.extend (history_size)
		end

feature -- Access

	name: STRING is "Tool preferences"
			-- Current's name

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.bm_General
		end

feature {NONE} -- Implementation

	regular_button, close_button,
	default_window_position: EB_BOOLEAN_RESOURCE_DISPLAY
	history_size: EB_INTEGER_RESOURCE_DISPLAY

end -- class EB_TOOL_ENTRY_PANEL
