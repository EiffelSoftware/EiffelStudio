indexing
	description: "Command to exit tool"
	author: "Parker Abercrombie"
	date: "$Date$"

class
	CANCEL_COMMAND

inherit
	EV_COMMAND

create
	default_create

feature -- Basic Operations

	execute (window: EV_ARGUMENT1 [EV_WINDOW]; data: EV_EVENT_DATA) is
			-- Destroy `window'.
		require else
			window_not_void: window /= Void
		do
			window.first.destroy
		ensure then
			is_destroyed: window.first.destroyed
		end;

end -- class CANCEL_COMMAND
