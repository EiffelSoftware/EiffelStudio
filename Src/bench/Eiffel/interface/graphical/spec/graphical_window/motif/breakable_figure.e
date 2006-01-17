indexing

	description: 
		"Breakpoint pixmap on a drawing area."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

	foreground_color (values: GRAPHICAL_VALUES): COLOR is
			-- Background color of pixmap
		do
			Result := actual_foreground_color
		end;

	font (values: GRAPHICAL_VALUES): FONT is
			-- Breakable font
		do
			Result := values.breakable_font
		end;

feature -- Status setting

	set_foreground_color (a_color: COLOR) is
			-- Set `background_color' to `a_color'.
		do
			actual_foreground_color := a_color
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

	draw (d: DRAWING_IMP; 
		values: GRAPHICAL_VALUES;
		is_in_hightlighted_line: BOOLEAN; 
			x_offset, y_offset: INTEGER) is
			-- Draw the current text.
		local
			ul: COORD_XY
		do
			if pixmap = Void then
				check
					non_void_text: text /= Void
				end;
				draw_text (d, values, is_in_hightlighted_line, x_offset, y_offset)
			else
				create ul;
				ul.set (base_left_x - x_offset, 
						base_left_y - pixmap.height - y_offset);
				d.set_foreground_gc_color (actual_foreground_color);
				d.set_background_gc_color (values.text_background_color);
				d.copy_bitmap (ul, pixmap);
			end
		end;

	select_clickable (d: DRAWING_IMP;
			values: GRAPHICAL_VALUES;
			x_offset, y_offset: INTEGER) is
			-- Select clickable.
		local
			ul: COORD_XY
		do
			if pixmap = Void then
				check
					non_void_text: text /= Void
				end;
				select_clickable_text (d, values, x_offset, y_offset)
			else
				create ul;
				ul.set (base_left_x - x_offset,
						base_left_y - pixmap.height - y_offset);
				d.set_foreground_gc_color (values.selected_clickable_fg_color);
				d.set_background_gc_color (values.selected_clickable_bg_color);
				d.copy_bitmap (ul, pixmap);
			end
		end;
 
	unselect_clickable (d: DRAWING_IMP;
			values: GRAPHICAL_VALUES;
			x_offset, y_offset: INTEGER) is
			-- Unselect clickable.
		local
			ul: COORD_XY
		do
			if pixmap = Void then
				check
					non_void_text: text /= Void
				end;
				unselect_clickable_text (d, values, x_offset, y_offset)
			else
				create ul;
				ul.set (base_left_x - x_offset,
						base_left_y - pixmap.height - y_offset);
				d.set_foreground_gc_color (actual_foreground_color);
				d.set_background_gc_color (values.text_background_color);
				d.copy_bitmap (ul, pixmap);
			end
		end

feature {NONE} -- Implementation

	actual_foreground_color: COLOR;
			-- Foreground color breakable figure

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class BREAKABLE_FIG
