indexing 
	description: "EiffelVision color selection dialog."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_COLOR_DIALOG_IMP

inherit
	EV_COLOR_DIALOG_I
		redefine
			interface
		end

	EV_STANDARD_DIALOG_IMP
		redefine
			interface
		end

	EV_C_UTIL

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a directory selection dialog with `par' as
			-- parent.
		do
			base_make (an_interface)

			-- Create the gtk object.
			set_c_object (
				C.gtk_color_selection_dialog_new (
					eiffel_to_c ("Color selection dialog")
				)
			)
			C.gtk_widget_hide (
				C.gtk_color_selection_dialog_struct_help_button (c_object)
			)
			C.gtk_widget_realize (c_object)	
		end

	initialize is
			-- Connect action sequences to button signals.
		do
			signal_connect_true ("delete_event", ~on_cancel)
			real_signal_connect (
				gtk_color_selection_dialog_struct_ok_button (c_object),
				"clicked",
				~on_ok,
				Void
			)
			real_signal_connect (
				gtk_color_selection_dialog_struct_cancel_button (c_object),
				"clicked",
				~on_cancel,
				Void
			)
			enable_closeable
			is_initialized := True
		end

feature -- Access

	color: EV_COLOR is
			-- Currently selected color.
		local
			a_colorsel: POINTER
			a_colors: POINTER
		do
			a_colorsel := gtk_color_selection_dialog_struct_colorsel (c_object)
			a_colors := gtk_color_selection_struct_values (a_colorsel)
			create Result.make_with_rgb (
				double_array_i_th (a_colors, 3), -- values [3] == RED
				double_array_i_th (a_colors, 4),
				double_array_i_th (a_colors, 5)
			)
		end

feature -- Element change

	set_color (a_color: EV_COLOR) is
			-- Set `color' to `a_color'.
		local
			a_color_array: ARRAY [DOUBLE]
			a_array_pointer: ANY
		do
			create a_color_array.make (1, 4)
			a_color_array.put (a_color.red, 1)
			a_color_array.put (a_color.green, 2)
			a_color_array.put (a_color.blue, 3)
			a_array_pointer := a_color_array.to_c
			C.gtk_color_selection_set_color (
				gtk_color_selection_dialog_struct_colorsel (c_object),
				$a_array_pointer
			)
		end

feature {NONE} -- Implementation

	gtk_color_selection_dialog_struct_colorsel (a_c_struct: POINTER): POINTER is
		external
			"C [struct <gtk/gtk.h>] (GtkColorSelectionDialog): EIF_POINTER"
		alias
			"colorsel"
		end

	gtk_color_selection_dialog_struct_ok_button (a_c_struct: POINTER): POINTER is
		external
			"C [struct <gtk/gtk.h>] (GtkColorSelectionDialog): EIF_POINTER"
		alias
			"ok_button"
		end

	gtk_color_selection_dialog_struct_cancel_button (a_c_struct: POINTER): POINTER is
		external
			"C [struct <gtk/gtk.h>] (GtkColorSelectionDialog): EIF_POINTER"
		alias
			"cancel_button"
		end

	gtk_color_selection_dialog_struct_help_button (a_c_struct: POINTER): POINTER is
		external
			"C [struct <gtk/gtk.h>] (GtkColorSelectionDialog): EIF_POINTER"
		alias
			"help_button"
		end

	gtk_color_selection_struct_use_opacity (a_c_struct: POINTER): INTEGER is
		external
			"C [struct <gtk/gtk.h>] (GtkColorSelection): EIF_INTEGER"
		alias
			"use_opacity"
		end

	gtk_color_selection_struct_values (a_c_struct: POINTER): POINTER is
		external
			"C [struct <gtk/gtk.h>] (GtkColorSelection): EIF_POINTER"
		alias
			"values"
		end
	
feature {EV_ANY_I} -- Implementation

	interface: EV_COLOR_DIALOG

end -- class EV_COLOR_DIALOG_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.10  2001/06/07 23:08:06  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.6.4.6  2000/09/06 23:18:45  king
--| Reviewed
--|
--| Revision 1.6.4.5  2000/08/16 19:41:04  king
--| Connecting delete_event to on_cancel
--|
--| Revision 1.6.4.4  2000/08/14 17:40:49  king
--| Now releaseable
--|
--| Revision 1.6.4.3  2000/07/20 18:56:46  king
--| select_color->set_color
--|
--| Revision 1.6.4.2  2000/07/20 18:38:52  king
--| Added double_array_i_thimplementation/gtk/Clib/ev_c_util.h
--|
--| Revision 1.6.4.1  2000/05/03 19:08:46  oconnor
--| mergred from HEAD
--|
--| Revision 1.9  2000/05/02 18:55:27  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.8  2000/02/22 18:39:37  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.7  2000/02/14 11:40:31  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.6.2  2000/01/27 19:29:40  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.6.1  1999/11/24 17:29:51  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.2  1999/11/02 17:20:03  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
