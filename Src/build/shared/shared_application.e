
class SHARED_APPLICATION
	
feature 

	black: COLOR is
		once
			!!Result.make;
			Result.set_name ("black");
		end;

	white: COLOR is
		once
			!!Result.make;
			Result.set_name ("white");
		end;

	normal_cursor: SCREEN_CURSOR is
		once
			!!Result.make;
			Result.set_type (Result.Left_ptr);
		end;

	move_cursor: SCREEN_CURSOR is
		once
			!!Result.make;
			Result.set_type (Result.Fleur);
		end;

	select_cursor: SCREEN_CURSOR is
		once
			!!Result.make;
			Result.set_type (Result.Tcross);
		end;

	exit_element: EXIT_ELEMENT is
		once
			!!Result;
		end;

	graph: APP_GRAPH is
		once
			!!Result.make
		end;

	arrow_head_w: INTEGER is 10;

	arrow_head_h: INTEGER is 20;

	arrow_head_line_w: INTEGER is 1;

	sub_square_radius: INTEGER is 45;

	state_circle_radius: INTEGER is 27;

	initial_state_line_thickness: INTEGER is 3;

	rect_thickness: INTEGER is 1;

	rect_width: INTEGER is 60;

	rect_height: INTEGER is 100;

	selection_square_thickness_sl: INTEGER is 1;

	selection_square_side_length: INTEGER is 15;

	standard_thickness: INTEGER is 1;

end 
