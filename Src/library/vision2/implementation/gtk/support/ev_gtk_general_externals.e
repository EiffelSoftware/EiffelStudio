indexing
	description: "External C functions for accessing gtk.%
		% Those are used by all the widgets.";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_GTK_GENERAL_EXTERNALS


feature {NONE} -- general GTK C functions 

	gtk_set_locale is
		external "C | <gtk/gtk.h>"
		end

	gtk_rc_parse (f: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_main is
		external "C | <gtk/gtk.h>"
		end

	gtk_main_quit is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_exit (n: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_signal_handlers_destroy (widget: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_signal_disconnect (widget: POINTER; id: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

feature {NONE} -- code in the glue library

	c_gtk_init_toolkit is
		external "C | %"gtk_eiffel.h%""
		end
	
	c_gtk_signal_connect (widget: POINTER; event: POINTER; 
			      routine: POINTER; object: POINTER; 
			      arguments: POINTER; event_data: POINTER; event_data_imp: POINTER; 
			      set_event_data_rtn: POINTER;
			      mouse_button: INTEGER; 
			      double_click: BOOLEAN): INTEGER is
		external "C | %"gtk_eiffel.h%""
		end

	c_gtk_signal_connect_after (widget: POINTER; event: POINTER; 
			      routine: POINTER; object: POINTER; 
			      arguments: POINTER; event_data: POINTER; event_data_imp: POINTER; 
			      set_event_data_rtn: POINTER;
			      mouse_button: INTEGER; 
			      double_click: BOOLEAN): INTEGER is
		external "C | %"gtk_eiffel.h%""
		end

	c_free_call_back_block (p: POINTER) is
		external "C | %"gtk_eiffel.h%""
		end

end -- class EV_GTK_GENERAL_EXTERNALS

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
