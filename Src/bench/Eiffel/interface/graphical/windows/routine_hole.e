indexing

	description:	
		"Hole for routine element.";
	date: "$Date$";
	revision: "$Revision$"

class ROUTINE_HOLE

inherit

	DEFAULT_HOLE_COMMAND
		redefine
			symbol, full_symbol, icon_symbol,
			name, stone_type
		end

creation

	make

feature -- Properties

	symbol: PIXMAP is
			-- Icon for the routine tool
		once
			Result := bm_Routine
		end;

	full_symbol: PIXMAP is
			-- Icon for the class tool
		once
			Result := bm_Routine_dot
		end;

	icon_symbol: PIXMAP is
			-- Icon for the routine tool
		once
			Result := bm_Routine_icon
		end;

	name: STRING is
		do
			Result := l_Routine
		end;

    stone_type: INTEGER is
        do
            Result := Routine_type
        end
end -- class ROUTINE_HOLE
