class EB_TEXT_IMAGE 

inherit

	FIGURE
		export
			{ANY} all
		redefine
			attach_drawing, select_figure, deselect,
			is_superimposable
		end;

	CHILD_CLIP
		export
			{NONE} all
		end


creation

	make
	
feature

	origin: COORD_XY_FIG;
	is_superimposable (other: like Current): BOOLEAN is do end;
	xyrotate (a: REAL; px, py: INTEGER) is do end;
	xyscale (f: REAL; px,py: INTEGER) is do end;
----------

	bottom_right: COORD_XY_FIG is
		local
			futur_x, futur_y: INTEGER
		do
			futur_x := base_left.x + string_width;
			futur_y := base_left.y + string_descent;
			!!Result;
			Result.set (futur_x, futur_y);
		end;

	middle_left: COORD_XY_FIG is
		local
			futur_x, futur_y: INTEGER
		do
			futur_x := base_left.x;
			futur_y := base_left.y - (string_ascent-string_descent) // 2;
			!!Result;
			Result.set (futur_x, futur_y);
		end;

	middle_right: COORD_XY_FIG is
		local
			futur_x, futur_y: INTEGER
		do
			futur_x := base_left.x + string_width;
			futur_y := base_left.y - (string_ascent-string_descent) // 2;
			!!Result;
			Result.set (futur_x, futur_y);
		end;

	middle_center: COORD_XY_FIG is
		local
			futur_x, futur_y: INTEGER
		do
			futur_x := base_left.x + string_width // 2;
			futur_y := base_left.y - (string_ascent-string_descent) // 2;
			!!Result;
			Result.set (futur_x, futur_y);
		end;

	top_left: COORD_XY_FIG is
		local
			futur_x, futur_y: INTEGER
		do
			futur_x := base_left.x;
			futur_y := base_left.y - string_ascent;
			!!Result;
			Result.set (futur_x, futur_y);
		end;

	base_left: COORD_XY_FIG;

	base_right: COORD_XY_FIG is
		local
			futur_x, futur_y: INTEGER
		do
			futur_x := base_left.x + string_width;
			futur_y := base_left.y;
			!!Result;
			Result.set (futur_x, futur_y);
		end;

	set_top_left (c: COORD_XY_FIG) is
		local
			futur_x, futur_y: INTEGER
		do
			futur_x := c.x;
			futur_y := c.y + string_ascent;
			base_left.set (futur_x, futur_y);
		end;

	
feature {NONE}

	string_width, string_ascent, string_descent: INTEGER;

	font: FONT is
		once
			!!Result.make;
			Result.set_name ("variable");
		end;

feature 

	make is
		do
			init_fig (Void)
			!!base_left
		end;

feature {NONE}

	drawing_i_to_widget_i (a_drawing: DRAWING_I): WIDGET_I is
            -- Conversion routine
		local
			temp_wid: WIDGET_I;
		do
			temp_wid ?= a_drawing;
			Result := temp_wid;
		end; -- drawing_i_to_widget_i
	
feature 

	attach_drawing (a_drawing: DRAWING) is
		do
			drawing := a_drawing.implementation;
			drawing.set_subwindow_mode (subwindow_mode);
			if not (foreground_color = Void) then
				drawing.set_foreground_gc_color (foreground_color);
			end;
			if not (background_color = Void) then
				drawing.set_background_gc_color (background_color);
			end;
			drawing.set_drawing_font (font);
			string_width := font.implementation.width_of_string (text);
			string_descent := font.implementation.descent
			string_ascent := font.implementation.ascent
		end;

	set_text (s: STRING) is
		do
			text := clone (s);
			if drawing /= Void then
				string_width := font.implementation.width_of_string (text);
			end;
		end;

	xytranslate (vx, vy: INTEGER) is
		do
			base_left.xytranslate (vx, vy);
		end;

	set_foreground_color (a_color: COLOR) is
		do
			foreground_color := a_color;
			if not (drawing = Void) then
				drawing.set_foreground_gc_color (foreground_color);
			end;
		end;

feature {NONE}

	foreground_color: COLOR;
	
feature 

	set_background_color (a_color: COLOR) is
        do
			background_color := a_color;
			if not (drawing = Void) then
				drawing.set_background_gc_color (background_color);
			end;
        end;

feature {NONE}

	background_color: COLOR;
	
feature 

	text: STRING;

feature {NONE}

	select_figure is
        do
		end;

feature 

	deselect is
        do
		end;

	draw is
		do
			drawing.set_foreground_gc_color (foreground_color);
			drawing.set_background_gc_color (background_color);
			drawing.draw_image_text (base_left, text)
		end;

	set_middle_center (c: COORD_XY_FIG) is
		local
			futur_x, futur_y: INTEGER
		do
			futur_x := c.x - string_width // 2;
			futur_y := c.y + (string_ascent - string_descent) // 2;
			base_left.set (futur_x, futur_y)
		end;

end
