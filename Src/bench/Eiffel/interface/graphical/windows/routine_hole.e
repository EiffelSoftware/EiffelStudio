indexing

	description:	
		"Hole for routine element.";
	date: "$Date$";
	revision: "$Revision$"

class ROUTINE_HOLE 

inherit

	EB_BUTTON_HOLE
		redefine
			stone_type
		end

creation

	make

feature -- Properties

	stone_type: INTEGER is
		do
			Result := Routine_type
		end;

end -- class ROUTINE_HOLE
