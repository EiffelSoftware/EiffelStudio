indexing

	description:
		"Command with two states.";
	date: "$Date$";
	revision: "$Revision$"

deferred class TWO_STATE_CMD

inherit
	PIXMAP_COMMAND
		rename
			symbol as true_state_symbol
		end

feature -- Properties

	false_state_symbol: PIXMAP is
			-- Symbol to indicate the false state
			--| `true_state_symbol' by default.
		do
			Result := true_state_symbol
		end

end -- class TWO_STATE_CMD
