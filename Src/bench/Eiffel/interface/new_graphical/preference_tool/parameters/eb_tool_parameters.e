indexing
	description: "Parameters common to all tools"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_TOOL_PARAMETERS

inherit
	EB_PARAMETERS
	EIFFEL_ENV

creation
	make

feature {TTY_RESOURCES} -- Initialization

	initialize (rt: RESOURCE_TABLE) is
			-- Initialize all resources valid for Current.
		do
			if Platform_constants.is_windows then
				create regular_button.make ("regular_button_in_toolbar", rt, False)
			end
			create close_button.make ("close_button_in_every_tool", rt, False)
			create history_size.make ("history_size", rt, 10)
			create default_window_position.make ("default_window_position", rt, False);
		end


feature -- Access

	regular_button: EB_BOOLEAN_RESOURCE
	close_button: EB_BOOLEAN_RESOURCE
	history_size: EB_INTEGER_RESOURCE
	default_window_position: EB_BOOLEAN_RESOURCE

end -- class EB_TOOL_PARAMETERS
