

class S_LINE 

inherit

	SHARED_STORAGE_INFO

creation

	make
	
feature 

	make (s: STATE_LINE) is
		local
			state_circle: STATE_CIRCLE
		do
			state_circle ?= s.source;
			if (state_circle = Void) then
				io.putstring ("Does not know how to store black boxes yet%N");
			end;
			source := state_circle.identifier;
			state_circle ?= s.destination;
			if (state_circle = Void) then
				io.putstring ("Does not know how to store black boxes yet%N");
			end;
			destination := state_circle.identifier;
			bidirectional := s.bi_directional;	
			x1 := s.tail.x;
			y1 := s.tail.y;
			x2 := s.head.x;
			y2 := s.head.y;
		end;

	
feature {NONE}

	source, destination: INTEGER;
	
	bidirectional: BOOLEAN;

	x1, y1, x2, y2: INTEGER;

	
feature 

	state_line: STATE_LINE is
		local
			tail, head: COORD_XY_FIG
		do
			!!Result.make;
			Result.set_elements (circle_table.item (source), 
						circle_table.item (destination));
			Result.set_bi_directional (bidirectional);
				!!tail;
				tail.set (x1, y1);
				!!head;
				head.set (x2, y2);
			Result.set_from_points (tail, head);
		end;

end
