indexing
	description: "EiffelVision drawing area. GTK implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_DRAWING_AREA_IMP

inherit
	EV_DRAWING_AREA_I
		redefine
			interface
		end

	EV_DRAWABLE_IMP
		undefine
			C
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		undefine
			foreground_color,
			background_color,
			set_foreground_color,
			set_background_color
		redefine
			interface,
			visual_widget,
			has_focus,
			disconnect_all_signals,
			default_key_processing_blocked,
			screen_x,
			screen_y
		end

	EV_DRAWING_AREA_ACTION_SEQUENCES_IMP
		redefine
			interface,
			visual_widget
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create an empty drawing area.
		local
			temp_sig_id: INTEGER
		do
			base_make (an_interface)
			set_c_object (C.gtk_event_box_new)
			drawing_area_widget := C.gtk_drawing_area_new
			temp_sig_id := c_signal_connect (
					drawing_area_widget,
					eiffel_to_c ("button-press-event"),
					agent give_focus
			)
			temp_sig_id := c_signal_connect (
					drawing_area_widget,
					eiffel_to_c ("focus-in-event"),
					agent attain_focus
			)
			temp_sig_id := c_signal_connect (
					drawing_area_widget,
					eiffel_to_c ("focus-out-event"),
					agent lose_focus
			)
			C.gtk_widget_show (drawing_area_widget)
			C.gtk_container_add (c_object, drawing_area_widget)
			C.gtk_container_set_focus_child (c_object, NULL)
			gc := C.gdk_gc_new (default_gdk_window)
			gcvalues := C.c_gdk_gcvalues_struct_allocate
			c.gdk_gc_get_values (gc, gcvalues)
			init_default_values
			gtk_widget_set_flags (visual_widget, C.GTK_CAN_FOCUS_ENUM)
				-- Needed for focus hack
		end

feature -- Access

	screen_x: INTEGER is
			-- Horizontal offset relative to screen.
		local
			useless_y: INTEGER 
			success: BOOLEAN
			gdk_window: POINTER
		do
				--|FIXME: redefined to quickly solve a problem that appeared in EiffelStudio (screen_x wrong after resizing)			
			gdk_window := C.gtk_widget_struct_window (c_object)
			if gdk_window /= NULL then
				success := C.gdk_window_get_deskrelative_origin (
					gdk_window,
					$Result,
					$useless_y
					)
			end
		end

	screen_y: INTEGER is
			-- Vertical offset relative to screen. 
		local
			useless_x: INTEGER
			success: BOOLEAN
			gdk_window: POINTER
		do
				--|FIXME: redefined to quickly solve a problem that appeared in EiffelStudio (screen_y wrong after resizing)			
			gdk_window := C.gtk_widget_struct_window (c_object)
			if gdk_window /= NULL then
				success := C.gdk_window_get_deskrelative_origin (
					gdk_window,
					$useless_x,
					$Result
					)				
			end
		end

feature {NONE} -- Implementation

	default_key_processing_blocked (a_key: EV_KEY): BOOLEAN is
		do
			if a_key.is_arrow or else a_key.code = app_implementation.Key_constants.key_tab then
				Result := True
			end
		end

	give_focus is
		do
			if not has_focus then
				set_focus
			end
		end

	attain_focus is
		do
			top_level_window_imp.set_focus_widget (Current)
			has_focus := True
		end

	lose_focus is
		do
			top_level_window_imp.set_focus_widget (Void)
			has_focus := False
		end

	has_focus: BOOLEAN

	interface: EV_DRAWING_AREA

	redraw is
		do
			if expose_actions_internal /= Void then
				expose_actions_internal.call ([0, 0, width, height])
			end
		end

	redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
		do
			if expose_actions_internal /= Void then
				expose_actions_internal.call ([a_x, a_y, a_width, a_height])
			end
		end

	clear_and_redraw is
		do
			clear
			redraw
		end

	clear_and_redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
		do
			clear_rectangle (a_x, a_y, a_width, a_height)
			redraw_rectangle (a_x, a_y, a_width, a_height)
		end

	flush is
			-- Redraw the screen immediately (useless with GTK)
		do
			-- do nothing
		end

feature {EV_DRAWABLE_IMP} -- Implementation

	visual_widget: POINTER is
		do
			Result := drawing_area_widget
		end

	drawing_area_widget: POINTER

	drawable: POINTER is
		do
			Result := C.gtk_widget_struct_window (drawing_area_widget)
		end

end -- class EV_DRAWING_AREA_IMP

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

