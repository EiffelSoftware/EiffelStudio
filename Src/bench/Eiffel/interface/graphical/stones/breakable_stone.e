class BREAKABLE_STONE 

inherit

	UNFILED_STONE;
	SHARED_DEBUG

creation

	make
	
feature -- making

	make (feature_i: FEATURE_I; break_index: INTEGER) is
		require
			not_feature_i_void: feature_i /= Void
		do
			routine := feature_i;
			index := break_index
		end; -- make
 
feature

	routine: FEATURE_I;
			-- Associated routine

	index: INTEGER;
			-- Breakpoint index in `routine'

feature -- dragging

	sign (stopped: BOOLEAN): STRING is 
			-- Textual representation of the breakable mark.
			-- Two different representations whether the breakpoint
			-- is set or not.
			-- If `stopped' is true and the execution is stopped
			-- on the current breakpoint, then `sign' is a stopped mark.
		do
			if stopped and Run_info.is_at (routine, index) then
					-- Execution stopped at that point.
				Result := "->|"
			elseif Debug_info.is_breakpoint_set (routine, index) then
				Result := "|#|"
			else
				Result := "|.|"
			end
		end; -- sign

	origin_text: STRING is "|.|";

	stone_type: INTEGER is do Result := Breakable_type end;
 
	stone_name: STRING is do Result := l_Showstops end;

	signature: STRING is "";
 
	click_list: ARRAY [CLICK_STONE] is do end;

	icon_name: STRING is
		do
			Result := signature
		end;
 
	clickable: BOOLEAN is
			-- Is Current an element with recorded structures information?
		do
			Result := False
		end

end -- class BREAKABLE_STONE
