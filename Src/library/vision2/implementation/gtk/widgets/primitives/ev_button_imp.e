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
			foreground_color_pointer,
			on_focus_changed
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
			interface,
			initialize
		end

	EV_FONTABLE_IMP
		redefine
			interface,
			initialize,
			fontable_widget
		end

	EV_BUTTON_ACTION_SEQUENCES_IMP
		export
			{EV_INTERMEDIARY_ROUTINES} select_actions_internal
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
			set_c_object (feature {EV_GTK_EXTERNALS}.gtk_button_new)
		end

	initialize is
			-- `Precursor' initialization,
			-- create button box to hold label and pixmap.
		local
			dummy_focus_in_actions: EV_NOTIFY_ACTION_SEQUENCE
		do
			Precursor {EV_PRIMITIVE_IMP}
			feature {EV_GTK_EXTERNALS}.gtk_container_set_border_width (c_object, 0)
			feature {EV_GTK_EXTERNALS}.gtk_button_set_relief (visual_widget, feature {EV_GTK_EXTERNALS}.gtk_relief_normal_enum)
			pixmapable_imp_initialize
			textable_imp_initialize
			initialize_button_box
			is_initialized := True
			align_text_center
			dummy_focus_in_actions := focus_in_actions
		end

	initialize_button_box is
			-- Create and initialize button box.
		local
			box: POINTER
		do
			box := feature {EV_GTK_EXTERNALS}.gtk_hbox_new (False, 0)
			feature {EV_GTK_EXTERNALS}.gtk_container_add (visual_widget, box)
			feature {EV_GTK_EXTERNALS}.gtk_widget_show (box)
			feature {EV_GTK_EXTERNALS}.gtk_box_pack_start (box, pixmap_box, True, True, padding)
			feature {EV_GTK_EXTERNALS}.gtk_widget_hide (pixmap_box)
			feature {EV_GTK_EXTERNALS}.gtk_box_pack_end (box, text_label, True, True, padding)
			feature {EV_GTK_EXTERNALS}.gtk_widget_hide (text_label)
		ensure
			button_box /= NULL
		end
		
	fontable_widget: POINTER is
			-- Pointer to the widget that may have fonts set.
		do
			Result := text_label
		end

feature -- Access

	is_default_push_button: BOOLEAN
			-- Is this button currently a default push button 
			-- for a particular container?
		
feature -- Status Setting

	enable_default_push_button is
			-- Set the style of the button corresponding
			-- to the default push button.
--		local
--			par_ptr: POINTER
		do
			enable_can_default
--			from
--				par_ptr := feature {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (visual_widget)
--			until
--				GTK_IS_WINDOW (par_ptr) or else par_ptr = NULL
--			loop
--				par_ptr := feature {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (par_ptr)
--			end
--			if par_ptr /= NULL then
--				feature {EV_GTK_EXTERNALS}.set_gtk_window_struct_default_widget (par_ptr, visual_widget)
--			end	
		end

	disable_default_push_button is
			-- Remove the style of the button corresponding
			-- to the default push button.
--		local
--			par_ptr: POINTER
		do		
			--| FIXME IEK Undraw default widget style.
			is_default_push_button := False
--			from
--				par_ptr := feature {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (visual_widget)
--			until
--				GTK_IS_WINDOW (par_ptr) or else par_ptr = NULL
--			loop
--				par_ptr := feature {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (par_ptr)
--			end
--
--			if par_ptr /= NULL then
--				feature {EV_GTK_EXTERNALS}.set_gtk_window_struct_default_widget (par_ptr, NULL)
--			end			
		end

	enable_can_default is
			-- Allow the style of the button to be the default push button.
		do
			is_default_push_button := True
			--| FIXME IEK Draw fake default style that represents gtk one (but nicer).
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
				feature {EV_GTK_EXTERNALS}.gtk_box_set_child_packing (
					button_box,
					pixmap_box,
					False,      -- Don't expand box.
					False,
					padding,
					feature {EV_GTK_EXTERNALS}.Gtk_pack_end_enum
				)
			end
			Precursor {EV_TEXTABLE_IMP} (a_text)
		end

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Assign `a_pixmap' to `pixmap'.
		do
			align_text_left
			Precursor {EV_PIXMAPABLE_IMP} (a_pixmap)
		end

	remove_pixmap is
			-- Assign Void to `pixmap'.
		do
			Precursor {EV_PIXMAPABLE_IMP}
			feature {EV_GTK_EXTERNALS}.gtk_widget_hide (pixmap_box)
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
						Result := a_gdkwin = feature {EV_GTK_EXTERNALS}.gtk_widget_struct_window (a_gtk_pix)
					end
				end
			end
		end
	
feature {NONE} -- implementation

	on_focus_changed (a_has_focus: BOOLEAN) is
			-- Called from focus intermediary agents when focus for `Current' has changed.
			-- if `a_has_focus' then `Current' has just received focus.
		local
			top_level_dialog_imp: EV_DIALOG_IMP
		do
			Precursor {EV_PRIMITIVE_IMP} (a_has_focus)
			top_level_dialog_imp ?= top_level_window_imp
			if
				top_level_dialog_imp /= Void
			then
				if a_has_focus then
					top_level_dialog_imp.set_current_push_button (interface)
				elseif top_level_dialog_imp.default_push_button = interface  then
					top_level_dialog_imp.set_current_push_button (Void)
				end
			end
		end

	foreground_color_pointer: POINTER is
		do
			Result := feature {EV_GTK_EXTERNALS}.gtk_style_struct_fg (
				feature {EV_GTK_EXTERNALS}.gtk_widget_struct_style (text_label)
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
			a_child_list := feature {EV_GTK_EXTERNALS}.gtk_container_children (visual_widget)
			Result := feature {EV_GTK_EXTERNALS}.g_list_nth_data (a_child_list, 0)
			feature {EV_GTK_EXTERNALS}.g_list_free (a_child_list)
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

