indexing

	description:	
		"Hole for an object.";
	date: "$Date$";
	revision: "$Revision$"

class OBJECT_HOLE

inherit

	EB_BUTTON_HOLE
		redefine
			stone_type
		end

creation

	make
	
feature -- Properties

	stone_type: INTEGER is
			-- Type of compatible stone.
		do
			Result := Object_type
		end;

end -- class OBJECT_CMD
