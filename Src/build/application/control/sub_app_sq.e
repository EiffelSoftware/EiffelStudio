
class SUB_APP_SQ 

inherit

	GRAPH_ELEMENT
		
		export
			{NONE} all
		end;

	APP_FIGURE
		redefine
			text, inner_figure, outer_figure, select_figure, deselect
		end;

	APP_STONE
		
		export
			{NONE} all
		end;
	

        
feature 


	internal_name: STRING is do end;
	visual_name: STRING is do end;

	set_stone (state: STATE) is
                        -- Set original_stone to `state' and update the
                        -- text to the original_stone label.
                require else
                        not_void_state: not (state = Void)
                do
                        --original_stone := state;
                        text_image.set_text (label);
                end; -- set_stone

	radius: INTEGER is
		do
			Result := outer_figure.radius
		end;

	set_label (s: STRING) is
		do
			text_image.set_text (s)
		end;

	original_stone: SUB_APP_SQ is
			-- Only temporary
		do
			Result := Current
		end;

	
feature {NONE}

	init_radius: INTEGER is
		do
			Result := sub_square_radius 
		end; -- radius

	top_middle: COORD_XY_FIG is
		do
			!!Result;
			Result.set (center.x, 
				    center.y - (outer_figure.size_of_side // 2));
			
		end; -- top_middle

	left_middle: COORD_XY_FIG is
		do
			!!Result;
			Result.set (center.x - (outer_figure.size_of_side // 2),
				    center.y)
		end; -- top_middle

	right_middle: COORD_XY_FIG is
		do
			!!Result;
			Result.set (center.x + (outer_figure.size_of_side // 2),
				    center.y)
		end; -- top_middle

	bottom_middle: COORD_XY_FIG is
		do
			!!Result;
			Result.set (center.x, 
				    center.y + (outer_figure.size_of_side // 2))
		end; -- top_middle

	inner_figure: SQUARE;
			-- Inner square of figure

	outer_figure: SQUARE;
			-- Outer square of figure

	
feature 

	closest_point (p: COORD_XY_FIG): COORD_XY_FIG is
		local
			closest, dist1, dist2, dist3, dist4: INTEGER;
		do
			dist1 := p.distance (top_middle);
			dist2 := p.distance (bottom_middle);
			dist3 := p.distance (left_middle);
			dist4 := p.distance (right_middle);
			if dist1 <= dist2 then
				Result := top_middle;
				closest := dist1
			else
				Result := bottom_middle;
				closest := dist2
			end;		
			if dist3 <= closest then
				Result := left_middle;
				closest := dist3
			end;
			if dist4 <= closest then
				Result := right_middle
			end;
		end; -- closest_point

	moving_figure: SQUARE is
			-- Create a new square. This square has the same dimenstions and
			-- center as Current but only has one component (i.e the 
			-- outer square).
		local
			a_path: PATH;
			a_center: COORD_XY_FIG;
			temp_int: INTERIOR
		do 
			a_center := clone (outer_figure.center);
			!!Result.make; 
			Result.set_radius (radius); 
			!!a_path.make; 
			a_path.set_line_width (standard_thickness); 
			a_path.set_foreground_color (black); 
			Result.set_path (a_path); 
			Result.path.set_xor_mode; 
			!!temp_int.make; 
			temp_int.set_foreground_color (white); 
		 	Result.set_interior (temp_int); 
			Result.interior.set_xor_mode; 
			Result.set_center (a_center); 
		end; -- moving_fig
			
	set_center (p: COORD_XY_FIG) is
			-- Set the center of the figure and the 
			-- text_image field.
		do
			inner_figure.set_center (p);
			outer_figure.set_center (p);
			text_image.set_middle_center (p);
		end; -- set_center

	set_radius (i: INTEGER) is
		local
			int: INTEGER
		do
			outer_figure.set_radius (i);
			int := i - 3;
			inner_figure.set_radius (int)
		end; -- set_radius

	text: STRING is
			-- Text of Current.
                do
			--Result := text_image.text 
                end; -- text

	select_figure is do end;
	
	deselect is do end;


        -- ***** Stone Details ***** --

        
feature {NONE}

	source: WIDGET is
                do
                end;

        
feature 

	label: STRING is
                do
			Result := text_image.text
                end;

        
feature {NONE}

	symbol: PIXMAP  is
                do
                end;

	labels: LINKED_LIST [CMD_LABEL] is
		do
		end;

end -- class SUB_APP_SQ
