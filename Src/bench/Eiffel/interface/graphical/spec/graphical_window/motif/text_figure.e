indexing

	description: 
		"Abstract notion of graphical text."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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
			-- Does figure contain point `p'?
		require
			valid_p: p /= Void
		do
			--| Do not check to see if `p' is within the top or bottom
			--| of text since this associated line would have
			--| check this before calling this routine.
			Result := p.x >= base_left_x and p.x <= base_left_x + width
			end;

	contains_position (char_pos: INTEGER): BOOLEAN is
			-- Does line contain character position `char_pos'?
		do
			Result := char_pos >= text_position and then
				char_pos <= text_position + text.count
		end;

	character_position (values: GRAPHICAL_VALUES; x_pos: INTEGER): INTEGER is
			-- Character position at cursor position `x'
		require
			valid_x_pos: x_pos >= base_left_x and then
			x_pos <= base_left_x + width
		local
			prev_x, curr_x: INTEGER;
			str: STRING;
			c, i: INTEGER
		do
			from
				curr_x := base_left_x;
				c := text.count;
				create str.make (0);
					-- Text should not be empty
				i := 0
			until
				curr_x > x_pos or else i = c
			loop
				str.extend (text.item (i + 1));
				curr_x := base_left_x + font (values).width_of_string (str);
				i := i + 1
			end
			Result := text_position + i - 1
		ensure
			contains_position: contains_position (Result)
		end;

	coordinate (values: GRAPHICAL_VALUES; char_pos: INTEGER): COORD_XY is
			-- Coordinate of character position in current figure
		require
			contains_position: contains_position (char_pos)
		local
			pos: INTEGER;
			str: STRING
		do
			create Result;
			pos := char_pos - text_position;
			-- Extract the string
			if pos = 0 then
				str := ""
			else
				str := text.substring (1, pos);
			end;
			-- Figure out the coord
			Result.set (base_left_x + font (values).width_of_string (str), base_left_y)
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

	draw (d: DRAWING_IMP; 
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

	select_clickable (d: DRAWING_IMP;
			values: GRAPHICAL_VALUES;
			x_offset, y_offset: INTEGER) is
			-- Select current figure.
		require
			drawable: d /= Void and then d.is_drawable
		do
			d.set_drawing_font (font (values));
			d.set_background_gc_color (values.selected_clickable_bg_color);
			d.set_foreground_gc_color (values.selected_clickable_fg_color);
			d.draw_image_string (d,
					base_left_x - x_offset,
					base_left_y - y_offset,
					text);
		end;
 
	unselect_clickable (d: DRAWING_IMP;
			values: GRAPHICAL_VALUES;
			x_offset, y_offset: INTEGER) is
			-- Un select current figure.
		require
			drawable: d /= Void and then d.is_drawable
		do
			d.set_drawing_font (font (values));
			d.set_background_gc_color (values.text_background_color);
			d.set_foreground_gc_color (foreground_color (values));
			d.draw_image_string (d,
					base_left_x - x_offset,
					base_left_y - y_offset,
					text);
		end;
 
invariant

	valid_text: text /= Void implies not text.empty

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class TEXT_FIGURE
