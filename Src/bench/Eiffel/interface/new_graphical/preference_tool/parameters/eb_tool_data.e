indexing
	description: "All attributes shared by all tools"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_TOOL_DATA

inherit
	SHARED_RESOURCES

feature -- Access

	regular_button: BOOLEAN is
		do
			Result := resources.get_boolean ("regular_button_in_toolbar", False)
		end

	close_button_in_every_tool: BOOLEAN is
		do
			Result := resources.get_boolean ("close_button_in_every_tool", False)
		end

	editor_history_size: INTEGER is
		do
			Result := resources.get_integer ("history_size", 10)
		end

	default_window_position: BOOLEAN is
		do
			Result := resources.get_boolean ("default_window_position", False);
		end

end -- class EB_TOOL_DATA
