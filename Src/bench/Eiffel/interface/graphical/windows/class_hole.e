indexing

	description:	
		"Hole for an existing class tool. Yes, I know, %
					%it's very funny.";
	date: "$Date$";
	revision: "$Revision$"

class CLASS_HOLE 

inherit

	EB_BUTTON_HOLE
		redefine
			compatible, stone_type
		end

creation

	make

feature -- Properties

	stone_type: INTEGER is
		do
			Result := Class_type
		end;

feature {NONE} -- Properties

	compatible (dropped: STONE): BOOLEAN is
			-- Can current accept `dropped'?
		do
			Result := dropped /= Void and then
				((dropped.stone_type = Class_type) or 
				else (dropped.stone_type = Routine_type))
		end;

end -- class CLASS_HOLE
