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
			name, stone_type, menu_name, accelerator
		end

create

	make

feature -- Properties

	symbol: PIXMAP is
			-- Icon for the routine tool
		once
			Result := Pixmaps.bm_Routine
		end;

	full_symbol: PIXMAP is
			-- Icon for the class tool
		once
			Result := Pixmaps.bm_Routine_dot
		end;

	icon_symbol: PIXMAP is
			-- Icon for the routine tool
		once
			Result := Pixmaps.bm_Routine_icon
		end;

	name: STRING is
		do
			Result := Interface_names.s_Routine_stone
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_New_routine
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

    stone_type: INTEGER is
        do
            Result := Routine_type
        end
end -- class ROUTINE_HOLE
