-- Hole for an object

class OBJECT_HOLE 

inherit

	HOLE
		redefine
			symbol, stone_type, command_name
		end

creation

	make
	
feature 

	symbol: PIXMAP is
			-- Icon for the object tool
		once
			Result := bm_Object
		end;

	
feature {NONE}

	command_name: STRING is do Result := l_Object end;

	
feature 

	stone_type: INTEGER is do Result := Object_type end

end
