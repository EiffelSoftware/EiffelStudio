
-- Hole for an existing class tool.
-- Yes, I know, it's very funny.

class CLASS_HOLE 

inherit

	HOLE
		redefine
			compatible, symbol, stone_type, command_name
		end

creation

	make

feature 

	symbol: PIXMAP is
			-- Icon for the class tool
		once
			!!Result.make;
			Result.read_from_file (bm_Class)
		end;

	stone_type: INTEGER is do Result := Class_type end;
	
feature {NONE}

	compatible (dropped: STONE): BOOLEAN is
			-- Can current accept `dropped'?
		do
			Result := dropped /= Void and then
				((dropped.stone_type = Class_type) or else (dropped.stone_type = Routine_type))
		end;

	command_name: STRING is do Result := l_Class end;

end
