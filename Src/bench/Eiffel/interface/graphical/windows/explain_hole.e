class EXPLAIN_HOLE

inherit
	DEFAULT_HOLE_COMMAND
		redefine
			full_symbol, icon_symbol, symbol, name, stone_type,
			menu_name, accelerator
		end

create
	make

feature -- Properties

	symbol: PIXMAP is
			-- Standard symbol representing Current.
		once
			Result := Pixmaps.bm_Explain
		end;

	full_symbol: PIXMAP is
			-- Icon for the class tool
		once
			Result := Pixmaps.bm_Explain_dot
		end;

	icon_symbol: PIXMAP is
			-- Icon for the explain tool
		once
			Result := Pixmaps.bm_Explain_icon
		end;

	name: STRING is
		do
			Result := Interface_names.s_Explain_stone
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_New_explain
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

    stone_type: INTEGER is
            -- Type of compatible stone.
        do
            Result := Explain_type
        end

end -- class EXPLAIN_HOLE
