indexing
	description: "External C functions for accessing gtk.%
		% Those are used by drawables.";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_GTK_DRAWABLE_EXTERNALS


feature {NONE} -- GTK C functions for general drawables

--	gdk_draw_line
--	gdk_draw_rectangle
--	gdk_draw_arc
--	gdk_draw_polygon
--	gdk_draw_string
--	gdk_draw_text
--	gdk_draw_bitmap	
--	gdk_draw_pixmap
--	gdk_draw_image
--	gdk_draw_segments
--	gdk_draw_point (drawable: POINTER, 

feature {NONE} -- GTK C functions for pixmaps

	gtk_pixmap_new (pixmap, mask: POINTER): POINTER is
		external "C | <gtk/gtk.h>"
		end 

feature {NONE} -- GTK C functions for drawing area

	gtk_drawing_area_new : POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_drawing_area_size (drawable: POINTER; w, h: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

feature {NONE} -- code in the glue library

	c_gtk_pixmap_create_empty (parent: POINTER): POINTER is
		external "C | %"gtk_eiffel.h%""
		end
	
	c_gtk_pixmap_create_from_xpm (parent: POINTER; file_name: POINTER): POINTER is
		external "C | %"gtk_eiffel.h%""
		end


	c_gtk_pixmap_read_from_xpm (widget, parent: POINTER; file_name: POINTER) is
		external "C | %"gtk_eiffel.h%""
		end

end -- class EV_GTK_DRAWABLE_EXTERNALS

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
