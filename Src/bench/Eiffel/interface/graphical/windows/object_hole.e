indexing

	description:	
		"Hole for an object.";
	date: "$Date$";
	revision: "$Revision$"

class OBJECT_HOLE 

inherit

	HOLE
		redefine
			symbol, stone_type, name, icon_symbol,
			full_symbol
		end

creation

	make
	
feature -- Properties

	symbol: PIXMAP is
			-- Icon for the object tool
		once
			Result := bm_Object
		end;

	full_symbol: PIXMAP is
			-- Icon for the class tool
		once
			Result := bm_Object_dot
		end;

	icon_symbol: PIXMAP is
			-- Icon for the object tool
		once
			Result := bm_Object_icon
		end;

	stone_type: INTEGER is
		do
			Result := Object_type
		end

feature {NONE} -- Properties

	name: STRING is
		do
			Result := l_Object
		end;

end -- class OBJECT_HOLE
