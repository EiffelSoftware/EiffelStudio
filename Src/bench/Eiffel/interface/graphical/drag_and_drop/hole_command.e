deferred class HOLE_COMMAND

inherit
	TWO_STATE_CMD
		rename
			true_state_symbol as symbol,
			false_state_symbol as full_symbol,
			init_from_tool as make
		redefine
			holder, full_symbol
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

	name: STRING is
		deferred
		end;

	symbol: PIXMAP is
		deferred
		end;

	holder: HOLE_HOLDER;
			-- Holder of Current

	target: WIDGET is
			-- Initialization of the hole is
			-- done in the associated button
		do
		end;

	full_symbol: PIXMAP is
		do	
			Result := symbol
		end;

	icon_symbol: PIXMAP is
		do
			Result := symbol
		end;

	transported_stone: STONE is
		do
		end

end -- class HOLE_COMMAND
