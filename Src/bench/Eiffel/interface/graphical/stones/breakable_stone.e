indexing
	description: "Stone representating a breakable point."
	date: "$Date$"
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
			routine := e_feature
			body_index := e_feature.body_index
			index := break_index
		end; -- make
 
feature -- Properties

	routine: E_FEATURE;
			-- Associated routine

	body_index: INTEGER;
			-- body_index of the associated routine

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
			-- Three different representations whether the breakpoint
			-- is enabled, disabled or not set. If `display_arrow' is
			-- True, also draw the arrow if necessary
		local
			status: APPLICATION_STATUS
		do
			inspect Application.breakpoint_status (routine, index)
			when 1 then
				Result := Enabled_breakpoint_text
			when -1 then
				Result := Disabled_breakpoint_text
			else
				Result := Origin_text
			end

			status := Application.status
			if status /= Void and then status.is_at(body_index, index) then
					-- we will modify the string, so clone it
				Result := clone(Result)
					-- Execution stopped at that point - feature is active.
				Result.replace_substring(Execution_mark,1,2)
			end
		end

	stone_type: INTEGER is 
		do 
			Result := Breakable_type 
		end
 
	stone_name: STRING is 
		do 
			Result := Interface_names.s_Showstops 
		end

	stone_signature: STRING is ""
 
	header: STRING is "Stop point"

	click_list: ARRAY [CLICK_STONE] is
		do
		end

	icon_name: STRING is
		do
			Result := stone_signature
		end
 
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
		end

feature {NONE} -- Constants

	Origin_text: STRING is ":::"
		-- text when no breakpoint is set and 
		-- application is not stopped at this line

	Enabled_breakpoint_text: STRING is "|||"
		-- text when a breakpoint is set and enabled

	Disabled_breakpoint_text: STRING is "///"
		-- text when a breakpoint is set but disabled

	Execution_mark: STRING is "->"
		-- text when the application is stopped at this line
		-- and feature on top of stack

	Stack_mark: STRING is ">>"
		-- text when the application is stopped at this line
		-- and feature not on top of stack

end -- class BREAKABLE_STONE
