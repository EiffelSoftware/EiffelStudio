indexing

	description:
		"Command with two states.";
	date: "$Date$";
	revision: "$Revision$"

deferred class TWO_STATE_CMD

inherit
	PIXMAP_COMMAND
		rename
			symbol as active_symbol
		end

feature -- Properties

	inactive_symbol: PIXMAP is
			-- Symbol to indicate the `inactive' state
			--| `active_symbol' by default.
		do
			Result := active_symbol
		end

end -- class TWO_STATE_CMD
