indexing
	description	: "Command to close a window."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CLOSE_WINDOW_COMMAND

inherit
	EB_WINDOW_COMMAND

create
	make

feature {NONE} -- Initialization

	initialize is
			-- Initialize default values.
		do
			-- No values to initialize.
		end

feature -- Command execution

	execute is
			-- Execute Current
		do
				-- Destroy the window.
			target.window.destroy
		end

end -- class EB_CLOSE_WINDOW_COMMAND
