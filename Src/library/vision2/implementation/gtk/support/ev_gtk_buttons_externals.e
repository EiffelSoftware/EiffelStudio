indexing
	description: "External C functions for accessing gtk.%
		% Those are used by buttons.";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_GTK_BUTTONS_EXTERNALS


feature {NONE} -- GTK C functions for buttons

	gtk_button_new_with_label (label: POINTER): POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_button_new: POINTER is
		external "C | <gtk/gtk.h>"
		end

feature {NONE} -- GTK C functions for toggle buttons


	gtk_toggle_button_new_with_label (label: POINTER): POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_toggle_button_set_active (button: POINTER; state: BOOLEAN) is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_toggle_button_toggled (button: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_toggle_button_new: POINTER is
		external "C | <gtk/gtk.h>"
		end

feature {NONE} -- GTK C functions for check buttons

	gtk_check_button_new_with_label (label: POINTER): POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_check_button_new: POINTER is
		external "C | <gtk/gtk.h>"
		end

feature {NONE} -- GTK C functions for radio buttons

	gtk_radio_button_new (gp: POINTER): POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_radio_button_new_with_label (gp: POINTER; label: POINTER): POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_radio_button_group (gp: POINTER): POINTER is
		external "C | <gtk/gtk.h>"
		end

feature {NONE} -- code in the glue library

	c_gtk_toggle_button_active (button: POINTER): BOOLEAN is
		external "C | %"gtk_eiffel.h%""
		end

end -- class EV_GTK_BUTTONS_EXTERNALS

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
