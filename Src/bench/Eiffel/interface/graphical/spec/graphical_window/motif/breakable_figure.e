indexing

	description: 
		"Breakpoint pixmap on a drawing area.";
	date: "$Date$";
	revision: "$Revision $"

class BREAKABLE_FIGURE

inherit

	TEXT_FIGURE
		rename
			draw as draw_text,
			select_clickable as select_clickable_text,
			unselect_clickable as unselect_clickable_text
		redefine
			stone
		end;
	TEXT_FIGURE
		redefine
			stone, draw, select_clickable, unselect_clickable
		select
			draw, select_clickable, unselect_clickable
		end

feature -- Properties

	stone: BREAKABLE_STONE;
			-- Associated breakable stone

	pixmap: PIXMAP;
			-- Associated break point pixmap

	foreground_color: COLOR;
			-- Background color of pixmap

	font: FONT is
			-- Breakable font
		do
			Result := g_Breakable_font
		end;

feature -- Status setting

	set_foreground_color (a_color: like foreground_color) is
			-- Set `background_color' to `a_color'.
		do
			foreground_color := a_color
		end;

	set_pixmap (a_pixmap: like pixmap) is
			-- Set `a_pixmap' to a `pixmap'.
		require
			valid_pixmap: a_pixmap /= Void and a_pixmap.is_valid
		do
			pixmap := a_pixmap;
			width := a_pixmap.width
		end;

feature -- Output

	draw (d: DRAWING_X; is_in_debug_line: BOOLEAN; 
			x_offset, y_offset: INTEGER) is
			-- Draw the current text.
		local
			ul: COORD_XY
		do
			if pixmap = Void then
				check
					non_void_text: text /= Void
				end;
				draw_text (d, is_in_debug_line, x_offset, y_offset)
			else
				!! ul;
				ul.set (base_left_x - x_offset, 
						base_left_y - pixmap.height - y_offset);
				d.set_foreground_gc_color (foreground_color);
				d.set_background_gc_color (g_Bg_color);
				d.copy_bitmap (ul, pixmap);
			end
		end;

	select_clickable (d: DRAWING_X; x_offset, y_offset: INTEGER) is
			-- Select clickable.
		local
			ul: COORD_XY
		do
			if pixmap = Void then
				check
					non_void_text: text /= Void
				end;
				select_clickable_text (d, x_offset, y_offset)
			else
				!! ul;
				ul.set (base_left_x - x_offset, 
						base_left_y - pixmap.height - y_offset);
				d.set_foreground_gc_color (g_Selected_clickable_fg_color);
				d.set_background_gc_color (g_Selected_clickable_bg_color);
				d.copy_bitmap (ul, pixmap);
			end
		end;

	unselect_clickable (d: DRAWING_X; x_offset, y_offset: INTEGER) is
			-- Unselect clickable.
		local
			ul: COORD_XY
		do
			if pixmap = Void then
				check
					non_void_text: text /= Void
				end;
				unselect_clickable_text (d, x_offset, y_offset)
			else
				!! ul;
				ul.set (base_left_x - x_offset, 
						base_left_y - pixmap.height - y_offset);
				d.set_foreground_gc_color (foreground_color);
				d.set_background_gc_color (g_Bg_color);
				d.copy_bitmap (ul, pixmap);
			end
		end;

end -- class EB_BREAKABLE_FIG
