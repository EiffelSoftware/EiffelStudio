-- Hole for routine element

class ROUTINE_HOLE 

inherit

	HOLE
		redefine
			symbol, stone_type, command_name
		end

creation

	make

feature 

	symbol: PIXMAP is
			-- Icon for the routine tool
		once
			Result := bm_Routine
		end;

	
feature {NONE}

	command_name: STRING is do Result := l_Routine end;

feature 

	stone_type: INTEGER is do Result := Routine_type end;

end
