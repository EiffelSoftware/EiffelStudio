indexing
	description: "Command to enable a push button"
	author: "Parker Abercrombie"
	date: "$Date$"

class
	SET_BUTTON_STATE_COMMAND

inherit
	EV_COMMAND

create
	default_create

feature -- Basic operations

	execute (args: EV_ARGUMENT2 [BOOLEAN, EV_BUTTON]; data: EV_EVENT_DATA) is
			-- If `args.first' is `true' then enable button in `args.second'.  If `args.first' is `false' then disable `args.second'.
		do
			args.second.set_insensitive (not args.first)
		end;

end -- class SET_BUTTON_STATE_COMMAND
