
--===================================================================
-- General notion of stone containing information about a command.
-- Each command is represented by an Eiffel class.
--===================================================================

deferred class CMD_STONE 

inherit

	STONE
		redefine
			data
		end

feature 

	stone_type: INTEGER is
		do
			Result := Stone_types.command_type
		end;

	process (hole: HOLE) is
			-- Process Current stone dropped in hole `hole'.
		do
			hole.process_command (Current)
		end;

	stone_cursor: SCREEN_CURSOR is
		do
			Result := Cursors.command_cursor
		end;

	data: CMD is
		deferred
		end;

end
