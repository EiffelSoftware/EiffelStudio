indexing

	description:	
		"Hole for an object.";
	date: "$Date$";
	revision: "$Revision$"

class OBJECT_HOLE 

inherit

	EB_BUTTON_HOLE
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

	name: STRING is
		do
			Result := l_Object
		end;

end -- class OBJECT_HOLE
