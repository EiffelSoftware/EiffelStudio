
-- Hole for explain element

class EXPLAIN_HOLE 

inherit

	HOLE
		redefine
			compatible, symbol, stone_type, command_name
		end

creation

	make
	
feature 

	symbol: PIXMAP is
			-- Icon for the explain tool
		once
			!!Result.make;
			Result.read_from_file (bm_Explain)
		end;

	compatible (dropped: STONE): BOOLEAN is
			-- True: all elements can be explained if not void
		do
			Result := dropped /= Void
		ensure then
			true_if_not_void: Result = (dropped /= Void)
		end;

	command_name: STRING is do Result := l_Explain end;
	
feature 

	stone_type: INTEGER is do Result := Explain_type end

end
