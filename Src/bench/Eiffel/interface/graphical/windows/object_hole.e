indexing

	description:	
		"Hole for an object.";
	date: "$Date$";
	revision: "$Revision$"

class OBJECT_HOLE

inherit

	DEFAULT_HOLE_COMMAND
		redefine
			symbol, full_symbol, icon_symbol, name, 
			stone_type, menu_name, accelerator
		end

create

	make
	
feature -- Properties

	symbol: PIXMAP is
			-- Icon for the object tool
		once
			Result := Pixmaps.bm_Object
		end;

	full_symbol: PIXMAP is
			-- Icon for the class tool
		once
			Result := Pixmaps.bm_Object_dot
		end;

	icon_symbol: PIXMAP is
			-- Icon for the object tool
		once
			Result := Pixmaps.bm_Object_icon
		end;

	name: STRING is
		do
			Result := Interface_names.s_Object_stone
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_New_object
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

    stone_type: INTEGER is
            -- Type of compatible stone.
        do
            Result := Object_type
        end;
end -- class OBJECT_HOLE
