indexing

	description:	
		"Hole for an object.";
	date: "$Date$";
	revision: "$Revision$"

class OBJECT_HOLE

inherit

	DEFAULT_HOLE_COMMAND
		redefine
			symbol, full_symbol, icon_symbol, name, stone_type
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

	name: STRING is
		do
			Result := l_New_object
		end;

    stone_type: INTEGER is
            -- Type of compatible stone.
        do
            Result := Object_type
        end;
end -- class OBJECT_HOLE
