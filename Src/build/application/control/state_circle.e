
class STATE_CIRCLE 

inherit

	APP_FIGURE
		redefine
			inner_figure, outer_figure, text
		end;
	STATE_STONE;
	REMOVABLE

creation

	make
	
feature -- Creation

	data: BUILD_STATE;

	make is
			-- Create the figures.
		do
			init_fig (Void)
			!!inner_figure.make;
			!!outer_figure.make;
			!!text_image.make;
		end; -- create

	remove_yourself is
			-- Remove source_figure.
		local
			cut_figure_command: APP_CUT_FIGURE;
		do
			!!cut_figure_command;
			cut_figure_command.execute (Current)
		end;

feature

	set_standard_thickness is
		do
			path.set_line_width (App_const.standard_thickness)
		end;

	set_double_thickness is
		do
			path.set_line_width (App_const.standard_thickness * 2)
		end;

 	set_stone (state: BUILD_STATE) is
			-- Set data to `state' and update the
			-- text to the data label.
		require else
				not_void_state: not (state = Void)
		do
			data := state;
			update_text
		end; -- set_stone

	update_text is
		do
			text_image.set_text (label);
			text_image.set_middle_center (center)
		end;

	radius: INTEGER is
		do
			Result := outer_figure.radius
		end;

	set_center (p: COORD_XY_FIG) is
			-- Set the center of the figure and the 
			-- text_image field.
		do
			inner_figure.set_center (p);
			outer_figure.set_center (p);
			if text_image.drawing /= Void then
				text_image.set_middle_center (p);
			end;
		end

	moving_figure: CIRCLE is
			-- Create a new circle. This circle has the same radius and
			-- center as Current but only has one component (i.e the 
			-- outer circle).
		local
			a_path: PATH;
			a_center: COORD_XY_FIG;
			temp_int: INTERIOR
		do 
			a_center := clone (center);
			!!Result.make; 
			Result.set_radius (radius); 
			Result.set_center (a_center); 
			!!a_path.make; 
			a_path.set_line_width (App_const.standard_thickness); 
			a_path.set_foreground_color (Resources.foreground_figure_color); 
			Result.set_path (a_path); 
			Result.path.set_xor_mode; 
			!!temp_int.make; 
			temp_int.set_foreground_color (Resources.background_figure_color); 
		 	Result.set_interior (temp_int); 
			Result.interior.set_xor_mode; 
		end; -- moving_fig
			
	set_radius (i: INTEGER) is
		do
			inner_figure.set_radius (i - 3);
			outer_figure.set_radius (i);
		end;

feature 

	text: STRING is
			-- Text of Current.
		require else
			not_void_data: not (data = Void)
		do
			Result := label 
		end; -- text

feature {NONE}

	inner_figure: CIRCLE;
			-- Inner circle of figure

	outer_figure: CIRCLE;
			-- Outer circle of figure

	source: WIDGET is
		do
		end;

	init_radius: INTEGER is 
		do
			Result :=  App_const.state_circle_radius
		end;

end -- class STATE_CIRCLE
	

