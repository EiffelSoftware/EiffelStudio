

deferred class TRANS_STONE  

inherit

	STONE
		redefine
			data
		end;
	REMOVABLE

feature 

	stone_type: INTEGER is
		do
			Result := Stone_types.transition_type
		end;

	process (hole: HOLE) is
			-- Process Current stone dropped in hole `hole'.
		do
			hole.process_transition (Current)
		end;

	stone_cursor: SCREEN_CURSOR is
		do
			Result := Cursors.transition_cursor
		end;

	data: STATE_LINE is
		deferred
		end;

	remove_yourself is
		local
			cut_line_command: APP_CUT_LINE;
		do
			!!cut_line_command;
			cut_line_command.execute (data)
		end;

end
