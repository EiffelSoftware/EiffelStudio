
class STATE_CIRCLE 

inherit

	APP_FIGURE
		export
			{ANY} all
		redefine
			inner_figure, outer_figure, text
		
		end;
	STATE_STONE
		
		export
			{NONE} all
		end;
	PIXMAPS
		export
			{NONE} all
		end

creation

	make
	
feature -- Creation

    make is
            -- Create the figures.
        do
            !!inner_figure.make;
            !!outer_figure.make;
            !!text_image.make;
        end; -- create

feature

	set_standard_thickness is
		do
			path.set_line_width (Standard_thickness)
		end;

	set_double_thickness is
		do
			path.set_line_width (Standard_thickness * 2)
		end;

 	set_stone (state: STATE) is
			-- Set original_stone to `state' and update the
			-- text to the original_stone label.
		require else
				not_void_state: not (state = Void)
		do
			original_stone := state;
			update_text
		end; -- set_stone

	update_text is
		do
			if not (original_stone.visual_name = Void) then
				text_image.set_text (original_stone.visual_name);
			else
				text_image.set_text (original_stone.internal_name);
			end;
			text_image.set_middle_center (center)
		end;

	radius: INTEGER is
		do
			Result := outer_figure.radius
		end;

	original_stone: STATE;

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
			a_path.set_line_width (standard_thickness); 
			a_path.set_foreground_color (black); 
			Result.set_path (a_path); 
			Result.path.set_xor_mode; 
			!!temp_int.make; 
			temp_int.set_foreground_color (white); 
		 	Result.set_interior (temp_int); 
			Result.interior.set_xor_mode; 
		end; -- moving_fig
			
	set_radius (i: INTEGER) is
		do
			inner_figure.set_radius (i - 3);
			outer_figure.set_radius (i);
		end;

	set_center (p: COORD_XY_FIG) is
				-- Set the center of the circle and the
				-- text_image field.
		do
			inner_figure.set_center (p);
			outer_figure.set_center (p);
			text_image.set_middle_center (p);
		end; -- set_center

	
	
feature 

	text: STRING is
			-- Text of Current.
		require else
			not_void_original_stone: not (original_stone = Void)
		do
			Result := label 
		end; -- text

feature -- Stone

	label: STRING is
		do
			Result := original_stone.label
		end;

	identifier: INTEGER is
		do
			Result := original_stone.identifier
		end;

feature {NONE}

	symbol: PIXMAP  is
		do
			Result := original_stone.symbol
		end;

	labels: LINKED_LIST [CMD_LABEL] is
		do
			Result := original_stone.labels
		end;

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
			Result :=  state_circle_radius
		end;

end -- class STATE_CIRCLE
	

