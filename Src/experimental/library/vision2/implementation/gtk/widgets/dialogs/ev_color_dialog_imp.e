note
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
			make
		end

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: attached like interface)
			-- Create a directory selection dialog with `par' as
			-- parent.
		do
			assign_interface (an_interface)
		end

	make
			-- Connect action sequences to button signals.
		local
			a_cs: EV_GTK_C_STRING
		do
				-- Create the gtk object.
			a_cs := "Color selection dialog"
			set_c_object (
				{GTK}.gtk_color_selection_dialog_new (
					a_cs.item
				)
			)
			{GTK}.gtk_widget_hide (
				{GTK}.gtk_color_selection_dialog_struct_help_button (c_object)
			)
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

	color: EV_COLOR
			-- Currently selected color.
		local
			color_struct: POINTER
		do
			if not user_clicked_ok and then attached internal_set_color as l_internal_set_color then
				Result := l_internal_set_color.twin
			else
				color_struct := {GTK}.c_gdk_color_struct_allocate
				{GTK2}.gtk_color_selection_get_current_color (
					{GTK2}.gtk_color_selection_dialog_struct_color_selection (c_object),
					color_struct
				)
				create Result.make_with_8_bit_rgb (
					{GTK}.gdk_color_struct_red (color_struct) // 256,
					{GTK}.gdk_color_struct_green (color_struct) // 256,
					{GTK}.gdk_color_struct_blue (color_struct) // 256
				)
				color_struct.memory_free
			end
		end

feature -- Element change

	set_color (a_color: EV_COLOR)
			-- Set `color' to `a_color'.
		local
			color_struct: POINTER
		do
			internal_set_color := a_color.twin
			color_struct := {GTK}.c_gdk_color_struct_allocate
			{GTK}.set_gdk_color_struct_red (color_struct, a_color.red_16_bit)
			{GTK}.set_gdk_color_struct_green (color_struct, a_color.green_16_bit)
			{GTK}.set_gdk_color_struct_blue (color_struct, a_color.blue_16_bit)
			{GTK2}.gtk_color_selection_set_current_color (
				{GTK2}.gtk_color_selection_dialog_struct_color_selection (c_object),
				color_struct
			)
			color_struct.memory_free
		end

feature {NONE} -- Implementation

	internal_set_color: detachable EV_COLOR
		-- Color explicitly set with `set_color'.

feature {NONE} -- Externals

	gtk_color_selection_dialog_struct_colorsel (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkColorSelectionDialog): EIF_POINTER"
		alias
			"colorsel"
		end

	gtk_color_selection_dialog_struct_ok_button (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkColorSelectionDialog): EIF_POINTER"
		alias
			"ok_button"
		end

	gtk_color_selection_dialog_struct_cancel_button (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkColorSelectionDialog): EIF_POINTER"
		alias
			"cancel_button"
		end

	gtk_color_selection_dialog_struct_help_button (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkColorSelectionDialog): EIF_POINTER"
		alias
			"help_button"
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_COLOR_DIALOG note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_COLOR_DIALOG_IMP
