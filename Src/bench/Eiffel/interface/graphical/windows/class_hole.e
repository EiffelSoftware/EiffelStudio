indexing

	description:	
		"Hole for an existing class tool. Yes, I know, %
					%it's very funny.";
	date: "$Date$";
	revision: "$Revision$"

class CLASS_HOLE 

inherit

	EB_BUTTON_HOLE
		redefine
			compatible, symbol, stone_type, command_name, icon_symbol,
			full_symbol
		end

creation

	make

feature -- Properties

	symbol: PIXMAP is
			-- Icon for the class tool
		once
			Result := bm_Class
		end;

	full_symbol: PIXMAP is
			-- Icon for the class tool
		once
			Result := bm_Class_dot
		end;

	icon_symbol: PIXMAP is
			-- Icon for the class tool
		once
			Result := bm_Class_icon
		end;

	stone_type: INTEGER is
		do
			Result := Class_type
		end;
	
feature {NONE} -- Properties

	compatible (dropped: STONE): BOOLEAN is
			-- Can current accept `dropped'?
		do
			Result := dropped /= Void and then
				((dropped.stone_type = Class_type) or 
				else (dropped.stone_type = Routine_type))
		end;

	name: STRING is
		do
			Result := l_Class
		end;

end -- class CLASS_HOLE
