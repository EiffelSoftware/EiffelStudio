indexing
	description:
		"Eiffel Vision button. GTK implementation."
	status: "See notice at end of class"
	keywords: "press, push, label, pixmap"
	date: "$Date$"
	revision: "$Revision$"
        
class
	EV_BUTTON_IMP
        
inherit
	EV_BUTTON_I
		redefine
			interface
		end
        
	EV_PRIMITIVE_IMP
		redefine
			interface,
			initialize,
			make,
			pointer_over_widget,
			set_foreground_color,
			foreground_color_pointer
		end
 
	EV_PIXMAPABLE_IMP
		redefine
			set_pixmap,
			remove_pixmap,
			interface,
			initialize
		end
     
	EV_TEXTABLE_IMP
		redefine
			set_text,
			remove_text,
			interface,
			initialize
		end

	EV_BUTTON_ACTION_SEQUENCES_IMP
		redefine
			interface,
			visual_widget
		end

create
        make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Connect interface and initialize `c_object'.
		do
			base_make (an_interface)
			set_c_object (C.gtk_button_new)
		--	GTK_WIDGET_SET_FLAGS (visual_widget, C.GTK_CAN_DEFAULT_ENUM)
		--	GTK_WIDGET_UNSET_FLAGS (visual_widget, C.GTK_CAN_DEFAULT_ENUM)
		end

	initialize is
			-- `Precursor' initialization,
			-- create button box to hold label and pixmap.
		do
			{EV_PRIMITIVE_IMP} Precursor
			C.gtk_container_set_border_width (visual_widget, 0)
			C.gtk_button_set_relief (visual_widget, C.gtk_relief_half_enum)
			pixmapable_imp_initialize
			textable_imp_initialize
			initialize_button_box
			is_initialized := True
			align_text_center
		end

	initialize_button_box is
			-- Create and initialize button box.
		local
			box: POINTER
		do
			box := C.gtk_hbox_new (False, 0)
			C.gtk_container_add (visual_widget, box)
			C.gtk_widget_show (box)
			C.gtk_box_pack_start (box, text_label, True, True, padding)
			C.gtk_widget_hide (text_label)
			C.gtk_box_pack_end (box, pixmap_box, True, False, padding)
			C.gtk_widget_hide (pixmap_box)
		ensure
			button_box /= NULL
		end
	
feature -- Access

	is_default_push_button: BOOLEAN is
			-- Is this button currently a default push button 
			-- for a particular container?
		do
			Result := GTK_WIDGET_HAS_DEFAULT (visual_widget)
		end
		
feature -- Status Setting

	enable_default_push_button is
			-- Set the style of the button corresponding
			-- to the default push button.
		do
		--	enable_can_default
			--C.gtk_widget_grab_default (visual_widget)
		end

	disable_default_push_button is
			-- Remove the style of the button corresponding
			-- to the default push button.
		local
			par_ptr: POINTER
		do
			--GTK_WIDGET_UNSET_FLAGS (visual_widget, C.GTK_HAS_DEFAULT_ENUM)
			--C.gtk_widget_draw_default (visual_widget)
			from
				par_ptr := C.gtk_widget_struct_parent (visual_widget)
			until
				GTK_IS_WINDOW (par_ptr) or else par_ptr = NULL
			loop
				par_ptr := C.gtk_widget_struct_parent (par_ptr)
			end

			if par_ptr /= NULL then
				C.gtk_window_set_default (par_ptr, NULL)
			end			
		end

	enable_can_default is
			-- Allow the style of the button to be the default push button.
		do
			GTK_WIDGET_SET_FLAGS (visual_widget, C.GTK_CAN_DEFAULT_ENUM)
		end

	set_foreground_color (a_color: EV_COLOR) is
		do
			real_set_foreground_color (text_label, a_color)
		end

feature -- Element change

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
			--| Redefined because we want the text to be:
			--| 	- middle-aligned if there is no pixmap
			--| 	- left-aligned if there is a pixmap
		do
			if text = Void then
				C.gtk_box_set_child_packing (
					button_box,
					pixmap_box,
					False,      -- Don't expand box.
					False,
					padding,
					C.Gtk_pack_end_enum
				)
			end
			{EV_TEXTABLE_IMP} Precursor (a_text)
		end

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Assign `a_pixmap' to `pixmap'.
		do
			align_text_left
			{EV_PIXMAPABLE_IMP} Precursor (a_pixmap)
		end

	remove_text is
			-- Assign `Void' to text.
		do
			{EV_TEXTABLE_IMP} Precursor
			C.gtk_box_set_child_packing (
				button_box,
				pixmap_box,
				True,       -- Expand pixmap box.
				False,
				padding,
				C.Gtk_pack_end_enum
			)
		end

	remove_pixmap is
			-- Assign Void to `pixmap'.
		do
			{EV_PIXMAPABLE_IMP} Precursor
			C.gtk_widget_hide (pixmap_box)
			align_text_center
		end

feature {EV_APPLICATION_IMP} -- Implementation

	pointer_over_widget (a_gdkwin: POINTER; a_x, a_y: INTEGER): BOOLEAN is
			-- Comparison of gdk window and widget position to determine
			-- if mouse pointer is over widget.
		local
			a_gtk_pix: POINTER
		do
			if is_displayed then
				Result := Precursor (a_gdkwin, a_x, a_y)
				if not Result then
					a_gtk_pix := gtk_pixmap
					if a_gtk_pix /= NULL then
						-- No struct member call if gtk_pix is a NULL pointer.
						Result := a_gdkwin = C.gtk_widget_struct_window (a_gtk_pix)
					end
				end
			end
		end
	
feature {NONE} -- implementation

	foreground_color_pointer: POINTER is
		do
			Result := C.gtk_style_struct_fg (
				C.gtk_widget_struct_style (text_label)
			)
		end

	padding: INTEGER is 1
			-- Number of pixels of extra space around text and pixmap.

	button_box: POINTER is
			-- GtkHBox in button.
			-- Holds label and pixmap.
		local
			a_child_list: POINTER
		do
			a_child_list := C.gtk_container_children (visual_widget)
			Result := C.g_list_nth_data (a_child_list, 0)
			C.g_list_free (a_child_list)
		end

feature {NONE} -- Externals

	gtk_is_window (a_widget: POINTER): BOOLEAN is
		external
			"C [macro <gtk/gtk.h>]: EIF_BOOLEAN"
		alias
			"GTK_IS_WINDOW"
		end

	gtk_widget_can_default (a_widget: POINTER): BOOLEAN is
		external
			"C [macro <gtk/gtk.h>]: EIF_BOOLEAN"
		alias
			"GTK_WIDGET_CAN_DEFAULT"
		end

	gtk_widget_has_default (a_widget: POINTER): BOOLEAN is
		external
			"C [macro <gtk/gtk.h>]: EIF_BOOLEAN"
		alias
			"GTK_WIDGET_HAS_DEFAULT"
		end

feature {EV_ANY_I} -- implementation

	interface: EV_BUTTON
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

invariant
	button_box_not_void: is_usable implies button_box /= Void

end -- class EV_BUTTON_IMP

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

