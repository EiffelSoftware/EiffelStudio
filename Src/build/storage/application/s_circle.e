

class S_CIRCLE 

inherit

	STORAGE_INFO
		export
			{NONE} all
		end


creation

	make

	
feature 

	make (s: STATE_CIRCLE) is
		do
			identifier := s.identifier;
			x := s.center.x;
			y := s.center.y
		end;

	identifier: INTEGER;

	
feature {NONE}

	x, y: INTEGER;

	
feature 

	state_circle: STATE_CIRCLE is
		do
			!!Result.make;
			Result.init;
			Result.set_stone (state_table.item (identifier));
			circle_table.put (Result, identifier);
		end;

	center: COORD_XY_FIG is
		do
			!!Result;
			Result.set (x, y);
		end;

end
