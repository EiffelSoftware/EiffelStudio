deferred class HOLE_COMMAND

inherit
	TWO_STATE_CMD
		rename
			active_symbol as symbol,
			inactive_symbol as full_symbol,
			init as make
		redefine
			full_symbol
		end;
	HOLE
		export
			{EB_BUTTON_HOLE} receive
		end

feature -- Initialization

	init_other_button_actions (a_button: EB_BUTTON_HOLE) is
			-- Initialize other button actions
			-- (Do nothing by default)
		do
		end;

feature -- Properties

	target: WIDGET is
			-- Initialization of the hole is
			-- done in the associated button
		do
			Result := tool.target
		end;

	icon_symbol, full_symbol: PIXMAP is
		do	
			Result := symbol
		end;

	transported_stone: STONE is
		do
		end

end -- class HOLE_COMMAND
