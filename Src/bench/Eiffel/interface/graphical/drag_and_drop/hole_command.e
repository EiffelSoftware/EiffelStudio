class HOLE_COMMAND

inherit
	TWO_STATE_CMD
		rename
			true_state_symbol as symbol,
			false_state_symbol as full_symbol
		redefine
			holder, full_symbol
		end;
	STONE_TYPES

creation
	make

feature -- Initialization

	make (a_text_window: TEXT_WINDOW) is
			-- Initialize a hole command with the `symbol' icon,
			-- `a_text_window' is passed as argument to the activation action.
		require
			a_text_window_not_void: a_text_window /= Void
		do
			init (a_text_window)
		ensure
			text_window_set: equal (text_window, a_text_window)
		end;

feature -- Pick and Throw

	receive (a_stone: STONE) is
			-- Process dropped stone `a_stone'.
		do
			holder.associated_button.receive (a_stone)
		end;

feature -- Execute

	work(argument: ANY) is
		do
		end;

feature -- Properties

	name: STRING is
		do
			Result := "Default"
		end;

	symbol: PIXMAP is
		do
		end;

	holder: HOLE_HOLDER;
			-- Holder of Current

	full_symbol: PIXMAP is
		do	
			Result := symbol
		end;

	icon_symbol: PIXMAP is
		do
			Result := symbol
		end;

end -- class HOLE_COMMAND
