indexing
	description: "EiffelVision font selection dialog, implementation."
	status: "See notice at end of class"
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FONT_DIALOG_IMP

inherit
	EV_FONT_DIALOG_I
		redefine
			interface
		end

	EV_STANDARD_DIALOG_IMP
		redefine
			interface,
			initialize
		end

create
	make


feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Connect `interface' and initialize `c_object'.
		local
			temp_font: EV_FONT
		do
			base_make (an_interface)
			set_c_object (C.gtk_font_selection_dialog_new (
						eiffel_to_c ("Font selection dialog")
					))
			create temp_font
			temp_font.set_height (14)
			set_font (temp_font)
			C.gtk_widget_realize (c_object)
		end

	reset_dialog is
			-- Initialize the dialog when a font has been selected.
		local
			a_font_sel, a_pixels_button: POINTER
		do
			a_font_sel := gtk_font_selection_dialog_struct_fontsel (c_object)
			a_pixels_button := gtk_font_selection_struct_pixels_button (a_font_sel)
			C.gtk_toggle_button_set_active (a_pixels_button, True)
			C.gtk_widget_hide (C.gtk_widget_struct_parent (a_pixels_button))
		end

	initialize is
			-- Initialize the dialog.
		do
			Precursor {EV_STANDARD_DIALOG_IMP}
			real_signal_connect (
				gtk_font_selection_dialog_struct_ok_button (c_object),
				"clicked",
				~on_ok,
				Void
			)
			real_signal_connect (
				gtk_font_selection_dialog_struct_cancel_button (c_object),
				"clicked",
				~on_cancel,
				Void
			)
			enable_closeable
			is_initialized := True
		end

feature -- Access

	font: EV_FONT is
			-- Current selected font.
		local
			a_fullname: STRING
			font_imp: EV_FONT_IMP
			size_clist: POINTER
			a_selected_index: INTEGER
			a_height_ptr: POINTER
			a_font_height: STRING
		do
			create Result
			font_imp ?= Result.implementation
			create a_fullname.make (0)
			a_fullname.from_c (C.gtk_font_selection_dialog_get_font_name (c_object))
			Result.preferred_families.extend (font_imp.substring_dash (a_fullname, 2))

			a_font_height := font_imp.substring_dash (a_fullname, 7)
			if not a_font_height.is_integer then
				size_clist := gtk_font_selection_struct_size_clist (
					gtk_font_selection_dialog_struct_fontsel (c_object)
				)
				a_selected_index := pointer_to_integer (
					C.glist_struct_data (gtk_clist_struct_selection (size_clist))
				)
				a_selected_index := C.gtk_clist_get_text (
							size_clist,
							a_selected_index,
							0,
							$a_height_ptr
				)
				create a_font_height.make (0) 
				a_font_height.from_c_substring (a_height_ptr, 1, 2)
			end
			Result.set_height (a_font_height.to_integer)
			Result.set_weight (font_imp.weight_from_string (font_imp.substring_dash (a_fullname, 3)))
			Result.set_shape (font_imp.shape_from_string (font_imp.substring_dash (a_fullname, 4)))
		end

feature -- Element change

	set_font (a_font: EV_FONT) is
			-- Select `a_font'.
		local
			a_success_flag: BOOLEAN
			font_imp: EV_FONT_IMP
		do
			font_imp ?= a_font.implementation
			a_success_flag := C.gtk_font_selection_dialog_set_font_name (
							c_object,
							eiffel_to_c (font_imp.system_name)
						)
			check font_found: a_success_flag end
			reset_dialog
		end

feature {NONE} -- Implementation

	gtk_font_selection_dialog_struct_ok_button (a_c_struct: POINTER): POINTER is
		external
			"C [struct <gtk/gtk.h>] (GtkFontSelectionDialog): EIF_POINTER"
		alias
			"ok_button"
		end

	gtk_font_selection_dialog_struct_cancel_button (a_c_struct: POINTER): POINTER is
		external
			"C [struct <gtk/gtk.h>] (GtkFontSelectionDialog): EIF_POINTER"
		alias
			"cancel_button"
		end

	gtk_font_selection_dialog_struct_fontsel (a_c_struct: POINTER): POINTER is
		external
			"C [struct <gtk/gtk.h>] (GtkFontSelectionDialog): EIF_POINTER"
		alias
			"fontsel"
		end

	gtk_font_selection_struct_pixels_button (a_c_struct: POINTER): POINTER is
		external
			"C [struct <gtk/gtk.h>] (GtkFontSelection): EIF_POINTER"
		alias
			"pixels_button"
		end

	gtk_font_selection_struct_size_clist (a_c_struct: POINTER): POINTER is
		external
			"C [struct <gtk/gtk.h>] (GtkFontSelection): EIF_POINTER"
		alias
			"size_clist"
		end

	gtk_clist_struct_row_list (a_c_struct: POINTER): POINTER is
		external
			"C [struct <gtk/gtk.h>] (GtkCList): EIF_POINTER"
		alias
			"row_list"
		end

	gtk_clist_struct_selection (a_c_struct: POINTER): POINTER is
		external
			"C [struct <gtk/gtk.h>] (GtkCList): EIF_POINTER"
		alias
			"selection"
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_FONT_DIALOG	

end -- class EV_FONT_DIALOG_IMP

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

