indexing

	description: 
		"Stone representating a breakable point.";
	date: "$Date$";
	revision: "$Revision $"

class BREAKABLE_STONE 

inherit
	STONE
		redefine
			header
		end

	SHARED_APPLICATION_EXECUTION

creation

	make
	
feature {NONE} -- Initialization

	make (e_feature: E_FEATURE; break_index: INTEGER) is
		require
			not_feature_i_void: e_feature /= Void
		do
			routine := e_feature;
			index := break_index
		end; -- make
 
feature -- Properties

	routine: E_FEATURE;
			-- Associated routine

	index: INTEGER;
			-- Breakpoint index in `routine'

feature -- Access

	stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
		do
			Result := Cursors.cur_Setstop
		end;

	x_stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
		do
			Result := Cursors.cur_X_setstop
		end;

	sign: STRING is 
			-- Textual representation of the breakable mark.
			-- Two different representations whether the breakpoint
			-- is set or not.
		local
			status: APPLICATION_STATUS
		do
			status := Application.status;
			if
				status /= Void and status.is_stopped and
				status.is_at (routine, index)
			then
					-- Execution stopped at that point.
				Result := "->|"
			elseif Application.is_breakpoint_set (routine, index) then
				Result := "|||"
			else
				Result := ":::"
			end
		end; 

	origin_text: STRING is ":::";

	stone_type: INTEGER is 
		do 
			Result := Breakable_type 
		end;
 
	stone_name: STRING is 
		do 
			Result := Interface_names.s_Showstops 
		end;

	stone_signature: STRING is "";
 
	header: STRING is "Stop point";

	click_list: ARRAY [CLICK_STONE] is
		do
		end

	icon_name: STRING is
		do
			Result := stone_signature
		end;
 
	clickable: BOOLEAN is
			-- Is Current an element with recorded structures information?
		do
			Result := False
		end

feature -- Update

	process (hole: HOLE) is
			-- Process Current stone dropped in hole `hole'.
		do
			hole.process_breakable (Current)
		end;

end -- class BREAKABLE_STONE
