class EXPLAIN_HOLE

inherit
	DEFAULT_HOLE_COMMAND
		redefine
			full_symbol, icon_symbol, symbol, name, stone_type
		end

creation
	make

feature -- Properties

	symbol: PIXMAP is
			-- Standard symbol representing Current.
		once
			Result := bm_Explain
		end;

	full_symbol: PIXMAP is
			-- Icon for the class tool
		once
			Result := bm_Explain_dot
		end;

	icon_symbol: PIXMAP is
			-- Icon for the explain tool
		once
			Result := bm_Explain_icon
		end;

	name: STRING is
		do
			Result := l_New_explain
		end;

    stone_type: INTEGER is
            -- Type of compatible stone.
        do
            Result := Explain_type
        end

end -- class EXPLAIN_HOLE
