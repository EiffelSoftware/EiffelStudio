indexing

	description: 
		"Abstract notion of graphical text.";
	date: "$Date$";
	revision: "$Revision $"

deferred class TEXT_FIGURE

feature -- Properties

	font (values: GRAPHICAL_VALUES): FONT is
			-- Font to be used for text
		require
			values_not_void: values /= Void	
		deferred
		end;

	foreground_color (values: GRAPHICAL_VALUES): COLOR is
			-- Foreground color
		require
			values_not_void: values /= Void	
		deferred
		end;

	is_clickable: BOOLEAN is
			-- Is the figure clickable?
		do
			Result := stone /= Void
		ensure
			yes_if_has_stone: Result implies stone /= Void
		end;

	stone: STONE;
			-- Associated stone

	text: STRING
			-- Text of image

	base_left_x, base_left_y: INTEGER;
			-- Base left point for rectangular figure

	width: INTEGER;
			-- Width of figure

	text_position: INTEGER
			-- Text position of `text'

feature -- Access

	contains (p: COORD_XY): BOOLEAN is
			-- Does line contain point `p'?
		require
			valid_p: p /= Void
		do
				--| Do not check to see if `p' is within the top or bottom
				--| of text since this associated line would have
				--| check this before calling this routine.
			Result := p.x >= base_left_x and p.x <= base_left_x + width
		end;

feature -- Setting

	set_base_left (x, y: INTEGER) is
			-- Set `base_left' coordinates.
		do
			base_left_x := x;
			base_left_y := y
		end;

	set_stone (a_stone: like stone) is
			-- Initialize a figure with `a_stone'.
		require
			valid_stone: a_stone /= Void
		do
			stone := a_stone
		ensure
			set: stone = a_stone
		end

	set_text_info (a_text: STRING; tp: like text_position) is
			-- Set `text' to `a_text'.
		require
			a_text_exists: a_text /= Void
		do
			text := a_text;
			text_position := tp
		end; 

	append_text (a_text: STRING) is
			-- Set `text' to `a_text'.
		require
			a_text_exists: a_text /= Void
		do
			text.append (a_text)
		end; 

	set_width (new_width: INTEGER) is
			-- Set `width' to `new_width'
		do
			width := new_width
		ensure
			set: width = new_width
		end;

	reset_stone is
			-- Set `stone' to `Void';
		do
			stone := Void
		ensure
			set: stone = Void
		end

feature -- Output

	draw (d: DRAWING_X; 
			values: GRAPHICAL_VALUES;
			is_in_highlighted_line: BOOLEAN;
			x_offset, y_offset: INTEGER) is
			-- Draw the current text.
		require
			drawable: d /= Void and then d.is_drawable
		do
			d.set_drawing_font (font (values));
			if is_in_highlighted_line then
				d.set_foreground_gc_color (values.highlighted_line_fg_color);
			else
				d.set_foreground_gc_color (foreground_color (values));
			end;
			d.draw_string (d, 
					base_left_x - x_offset,
					base_left_y - y_offset, 	
					text);
		end;

end -- class TEXT_FIGURE
