indexing

	description:	
		"Hole for explain element.";
	date: "$Date$";
	revision: "$Revision$"

class EXPLAIN_HOLE 

inherit

	HOLE
		redefine
			compatible, symbol, stone_type, name,
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

	compatible (dropped: STONE): BOOLEAN is
			-- True: all elements can be explained if not void
		do
			Result := dropped /= Void and then
				(dropped.stone_type = Explain_type)
		ensure then
			true_if_not_void: Result = (dropped /= Void)
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
