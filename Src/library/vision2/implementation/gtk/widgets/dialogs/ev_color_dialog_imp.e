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
			interface,
			initialize
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
			Precursor {EV_STANDARD_DIALOG_IMP}
			is_initialized := False
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
			if not user_clicked_ok and then internal_set_color /= Void then
				Result := clone (internal_set_color)
			else
				a_colorsel := gtk_color_selection_dialog_struct_colorsel (c_object)
				a_colors := gtk_color_selection_struct_values (a_colorsel)
				create Result.make_with_rgb (
					double_array_i_th (a_colors, 3), -- values [3] == RED
					double_array_i_th (a_colors, 4),
					double_array_i_th (a_colors, 5)
				)
			end
		end

feature -- Element change

	set_color (a_color: EV_COLOR) is
			-- Set `color' to `a_color'.
		local
			a_color_array: ARRAY [DOUBLE]
			a_array_pointer: ANY
		do
			internal_set_color := clone (a_color)
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

	internal_set_color: EV_COLOR
		-- Color explicitly set with `set_color'.
		
feature {NONE} -- Externals

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

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

