indexing

	description:	
		"Hole for explain element.";
	date: "$Date$";
	revision: "$Revision$"

class EXPLAIN_HOLE 

inherit

	EB_BUTTON_HOLE
		redefine
			symbol, stone_type, name,
			icon_symbol, full_symbol
		end

creation

	make
	
feature  -- Properties

	symbol: PIXMAP is
			-- Icon for the explain tool
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
			Result := l_Explain
		end;
	
	stone_type: INTEGER is
			-- Type of compatible stone.
		do
			Result := Explain_type
		end

end -- class EXPLAIN_HOLE
