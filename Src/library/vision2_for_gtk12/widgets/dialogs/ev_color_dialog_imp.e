indexing 
	description: "EiffelVision color selection dialog."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a directory selection dialog with `par' as
			-- parent.
		local
			a_cs: EV_GTK_C_STRING
		do
			base_make (an_interface)

			-- Create the gtk object.
			a_cs := "Color selection dialog"
			set_c_object (
				{EV_GTK_EXTERNALS}.gtk_color_selection_dialog_new (
					a_cs.item
				)
			)
			{EV_GTK_EXTERNALS}.gtk_widget_hide (
				{EV_GTK_EXTERNALS}.gtk_color_selection_dialog_struct_help_button (c_object)
			)
		end

	initialize is
			-- Connect action sequences to button signals.
		do
			Precursor {EV_STANDARD_DIALOG_IMP}
			set_is_initialized (False)
			real_signal_connect (
				gtk_color_selection_dialog_struct_ok_button (c_object),
				"clicked",
				agent (App_implementation.gtk_marshal).color_dialog_on_ok_intermediary (c_object),
				Void
			)
			real_signal_connect (
				gtk_color_selection_dialog_struct_cancel_button (c_object),
				"clicked",
				agent (App_implementation.gtk_marshal).color_dialog_on_cancel_intermediary (c_object),
				Void
			)
			enable_closeable
			forbid_resize
			set_is_initialized (True)
		end

feature -- Access

	color: EV_COLOR is
			-- Currently selected color.
		local
			a_colorsel: POINTER
			a_colors: POINTER
		do
			if not user_clicked_ok and then internal_set_color /= Void then
				Result := internal_set_color.twin
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
			internal_set_color := a_color.twin
			create a_color_array.make (1, 4)
			a_color_array.put (a_color.red, 1)
			a_color_array.put (a_color.green, 2)
			a_color_array.put (a_color.blue, 3)
			a_array_pointer := a_color_array.to_c
			{EV_GTK_EXTERNALS}.gtk_color_selection_set_color (
				gtk_color_selection_dialog_struct_colorsel (c_object),
				$a_array_pointer
			)
		end

feature {NONE} -- Implementation

	internal_set_color: EV_COLOR
		-- Color explicitly set with `set_color'.
		
feature {NONE} -- Externals

	double_array_i_th (double_array: POINTER; index: INTEGER): REAL is
			-- EIF_DOUBLE double_array_i_th (double *double_array, int index) {
			--	return double_array [index];
			-- }
		external
			"C | %"ev_c_util.h%""
		end

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

	gtk_color_selection_struct_values (a_c_struct: POINTER): POINTER is
		external
			"C [struct <gtk/gtk.h>] (GtkColorSelection): EIF_POINTER"
		alias
			"values"
		end
	
feature {EV_ANY_I} -- Implementation

	interface: EV_COLOR_DIALOG;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_COLOR_DIALOG_IMP

