indexing
	description: "External C functions for accessing gtk.%
		% Those are used by widgets.";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_GTK_WIDGETS_EXTERNALS


feature {NONE} -- GTK C functions for widgets

	gtk_widget_show (w: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_widget_hide (w: POINTER) is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_widget_realize (w: POINTER) is
		external "C | <gtk/gtk.h>"
		end	
	
	gtk_widget_unrealize (w: POINTER) is
		external "C | <gtk/gtk.h>"
		end	
	
	gtk_widget_set_uposition (w: POINTER; x,y: INTEGER) is
		external "C | <gtk/gtk.h>"
		end	

	gtk_widget_set_usize (w: POINTER; width, height: INTEGER) is
		external "C | <gtk/gtk.h>"
		end	

	gtk_widget_set_sensitive (w: POINTER; sensitive: BOOLEAN) is
		external "C | <gtk/gtk.h>"
		end

	gtk_widget_grab_default (w: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_widget_destroy (w: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_widget_reparent (w: POINTER; p: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_widget_set_parent (w: POINTER; p:POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_widget_unparent (w: POINTER) is
		external "C | <gtk/gtk.h>"
		end

feature {NONE} -- code in the glue library

	c_gtk_widget_destroyed (widget: POINTER): BOOLEAN is
		external "C | %"gtk_eiffel.h%""
		end
	
	c_gtk_widget_set_flags (w: POINTER; flags: INTEGER) is
		external "C | %"gtk_eiffel.h%""
		end

	c_gtk_widget_realized (w: POINTER): BOOLEAN is
		external "C | %"gtk_eiffel.h%""
		end	
	
	c_gtk_widget_visible (w: POINTER): BOOLEAN is
		external "C | %"gtk_eiffel.h%""
		end
	
	c_gtk_widget_height (w: POINTER): INTEGER is
		external "C [macro %"gtk_eiffel.h%"]"
		end
	
	c_gtk_widget_width (w: POINTER): INTEGER is
		external "C [macro %"gtk_eiffel.h%"]"
		end

	c_gtk_widget_x (w:POINTER): INTEGER is
		external "C [macro %"gtk_eiffel.h%"]"
		end
	
	c_gtk_widget_y (w: POINTER): INTEGER is
		external "C [macro %"gtk_eiffel.h%"]"
		end

	c_gtk_widget_sensitive (w: POINTER): BOOLEAN is
		external "C | %"gtk_eiffel.h%""
		end
	
	c_gtk_widget_set_size (w: POINTER; width, height: INTEGER) is
		external "C | %"gtk_eiffel.h%""
		end
	
	c_gtk_widget_minimum_width (w: POINTER): INTEGER is
		external "C [macro %"gtk_eiffel.h%"]"
		end

	c_gtk_widget_minimum_height (w: POINTER): INTEGER is
		external "C [macro %"gtk_eiffel.h%"]"
		end

	c_gtk_widget_position_set (widget: POINTER; x, y: INTEGER): BOOLEAN is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_widget_minimum_size_set (widget: POINTER; width, height: INTEGER): BOOLEAN is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_widget_set_bg_color (widget: POINTER; r, g, b: INTEGER) is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_widget_get_bg_color (widget: POINTER; r, g, b: POINTER) is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_widget_set_fg_color (widget: POINTER; r, g, b: INTEGER) is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_widget_get_fg_color (widget: POINTER; r, g, b: POINTER) is
		external
			"C | %"gtk_eiffel.h%""
		end

end -- class EV_GTK_WIDGETS_EXTERNALS

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
