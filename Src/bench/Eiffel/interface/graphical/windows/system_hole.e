indexing

	description:	
		"Hole for system tool.";
	date: "$Date$";
	revision: "$Revision$"

class SYSTEM_HOLE 

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
			Result := System_type
		end;

end -- class SYSTEM_HOLE
