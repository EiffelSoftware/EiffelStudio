class APPLICATION_CONSTANTS

feature -- Colors

	Black: COLOR is
		once
			!!Result.make;
			Result.set_name ("black");
		end;

	White: COLOR is
		once
			!!Result.make;
			Result.set_name ("white");
		end;

feature -- Integer constants

	Arrow_head_w: INTEGER is 10;
	Arrow_head_h: INTEGER is 20;
	Arrow_head_line_w: INTEGER is 1;
	Sub_square_radius: INTEGER is 45;
	State_circle_radius: INTEGER is 27;
	Initial_state_line_thickness: INTEGER is 3;
	Rect_thickness: INTEGER is 1;
	Rect_width: INTEGER is 60;
	Rect_height: INTEGER is 100;
	Selection_square_thickness_sl: INTEGER is 1;
	Selection_square_side_length: INTEGER is 15;
	Standard_thickness: INTEGER is 1;

end
