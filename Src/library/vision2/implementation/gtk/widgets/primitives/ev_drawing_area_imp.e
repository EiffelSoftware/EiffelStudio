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
		redefine
			interface,
			dispose
		end

	EV_PRIMITIVE_IMP
		undefine
			foreground_color,
			background_color,
			set_foreground_color,
			set_background_color
		redefine
			interface,
			disconnect_all_signals,
			default_key_processing_blocked,
			set_focus,
			dispose,
			destroy
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
		do
			base_make (an_interface)
			set_c_object (C.gtk_drawing_area_new)
			real_signal_connect (c_object, "button-press-event", agent Gtk_marshal.on_drawing_area_event_intermediary (c_object, 1), Void)
			real_signal_connect (c_object, "focus-out-event", agent Gtk_marshal.on_drawing_area_event_intermediary (c_object, 2), Void)
			gc := C.gdk_gc_new (default_gdk_window)
			init_default_values
		end

feature {NONE} -- Implementation

	default_key_processing_blocked (a_key: EV_KEY): BOOLEAN is
		do
			if a_key.is_arrow or else a_key.code = app_implementation.Key_constants.key_tab then
				Result := True
			end
		end

	interface: EV_DRAWING_AREA

	redraw is
		do
			redraw_rectangle (0, 0, width, height)
		end

	redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
		do
			if not full_redraw_needed then
				C.gtk_widget_queue_draw_area (c_object, a_x, a_y, a_width, a_height)
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
		end
		
	full_redraw_needed: BOOLEAN
		-- Is a full redraw needed

feature {EV_DRAWABLE_IMP} -- Implementation

	drawable: POINTER is
		do
			Result := C.gtk_widget_struct_window (c_object)
		end
		
feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	call_expose_actions (a_x, a_y, a_width, a_height: INTEGER) is
			-- Call the expose actions for the drawing area.
		do
			if expose_actions_internal /= Void then
				expose_actions_internal.call ([a_x, a_y, a_width, a_height])
			end
		end
		
	expose_actions_called: BOOLEAN
		-- Are the expose actions currently being called?

	lose_focus is
		do
			top_level_window_imp.set_focus_widget (Void)
			GTK_WIDGET_UNSET_FLAGS (c_object, C.GTK_HAS_FOCUS_ENUM)
			-- This is a hack to make sure focus flag is unset.
		end
		
	set_focus is
			-- Grab keyboard focus.
		do
			if not has_focus then
				GTK_WIDGET_SET_FLAGS (c_object, C.GTK_CAN_FOCUS_ENUM)
				C.gtk_widget_grab_focus (c_object)
				GTK_WIDGET_SET_FLAGS (c_object, C.GTK_HAS_FOCUS_ENUM)
				top_level_window_imp.set_focus_widget (Current)
				GTK_WIDGET_UNSET_FLAGS (c_object, C.GTK_CAN_FOCUS_ENUM)
			end
		end
		
feature {NONE} -- Implementation

	destroy is
		do
			Precursor {EV_PRIMITIVE_IMP}
			if gc /= NULL then
				C.gdk_gc_unref (gc)
				gc := NULL
			end
		end
		
	dispose is
			-- 
		do
			if gc /= NULL then
				gdk_gc_unref (gc)
				gc := NULL
			end
			Precursor {EV_PRIMITIVE_IMP}
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

