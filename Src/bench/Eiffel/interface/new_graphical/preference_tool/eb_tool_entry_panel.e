indexing
	description: "Data panel used for capturing tool parameters."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_TOOL_ENTRY_PANEL

inherit
	NEW_EB_CONSTANTS
		rename
			Tool_resources as parameters
		export
			{NONE} all
		end
	EB_ENTRY_PANEL
		redefine
			make
		end
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
			Create close_button.make_with_resource (Current, parameters.close_button)
			Create default_window_position.make_with_resource (Current, parameters.default_window_position)
			Create history_size.make_with_resource (Current, parameters.history_size)
			Create window_free_list_number.make_with_resource (Current, parameters.window_free_list_number)

			if Platform_constants.is_windows then
				resources.extend (regular_button)
			end
			resources.extend (close_button)
			resources.extend (default_window_position)
			resources.extend (history_size)
			resources.extend (window_free_list_number)
		end

feature -- Access

	name: STRING is "Tool preferences"
			-- Current's name

	symbol: PIXMAP is
		once
			Result := Pixmaps.bm_General
		end;

feature {NONE} -- Implementation

	regular_button, close_button,
	default_window_position: EB_BOOLEAN_RESOURCE_DISPLAY
	history_size: EB_INTEGER_RESOURCE_DISPLAY
	window_free_list_number: EB_INTEGER_RESOURCE_DISPLAY

end -- class EB_TOOL_ENTRY_PANEL
