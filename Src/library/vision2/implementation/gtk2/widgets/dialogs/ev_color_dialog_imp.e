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
			create a_cs.make ("Color selection dialog")
			set_c_object (
				feature {EV_GTK_EXTERNALS}.gtk_color_selection_dialog_new (
					a_cs.item
				)
			)
			feature {EV_GTK_EXTERNALS}.gtk_widget_hide (
				feature {EV_GTK_EXTERNALS}.gtk_color_selection_dialog_struct_help_button (c_object)
			)
			feature {EV_GTK_EXTERNALS}.gtk_widget_realize (c_object)	
		end

	initialize is
			-- Connect action sequences to button signals.
		do
			Precursor {EV_STANDARD_DIALOG_IMP}
			is_initialized := False
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
			disable_user_resize
			is_initialized := True
		end

feature -- Access

	color: EV_COLOR is
			-- Currently selected color.
		local
			color_struct: POINTER
		do
			if not user_clicked_ok and then internal_set_color /= Void then
				Result := internal_set_color.twin
			else				
				color_struct := feature {EV_GTK_EXTERNALS}.c_gdk_color_struct_allocate
				feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_color_selection_get_current_color (
					feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_color_selection_dialog_struct_color_selection (c_object),
					color_struct
				)
				create Result.make_with_8_bit_rgb (
					feature {EV_GTK_EXTERNALS}.gdk_color_struct_red (color_struct) // 256,
					feature {EV_GTK_EXTERNALS}.gdk_color_struct_green (color_struct) // 256,
					feature {EV_GTK_EXTERNALS}.gdk_color_struct_blue (color_struct) // 256
				)
				color_struct.memory_free
			end
		end

feature -- Element change

	set_color (a_color: EV_COLOR) is
			-- Set `color' to `a_color'.
		local
			color_struct: POINTER
		do
			internal_set_color := a_color.twin
			color_struct := feature {EV_GTK_EXTERNALS}.c_gdk_color_struct_allocate
			feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_red (color_struct, a_color.red_16_bit)
			feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_green (color_struct, a_color.green_16_bit)
			feature {EV_GTK_EXTERNALS}.set_gdk_color_struct_blue (color_struct, a_color.blue_16_bit)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_color_selection_set_current_color (
				feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_color_selection_dialog_struct_color_selection (c_object),
				color_struct
			)
			color_struct.memory_free
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

