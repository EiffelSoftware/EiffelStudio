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
			default_key_processing_blocked,
			--set_focus,
			dispose,
			destroy,
			on_key_event,
			on_focus_changed
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
			set_c_object (feature {EV_GTK_EXTERNALS}.gtk_drawing_area_new)
			--feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_set_redraw_on_allocate (c_object, False)
				-- This means that when the drawing area is resized, only the new portions are redrawn
			gc := feature {EV_GTK_EXTERNALS}.gdk_gc_new (App_implementation.default_gdk_window)
			feature {EV_GTK_EXTERNALS}.GTK_WIDGET_SET_FLAGS (c_object, feature {EV_GTK_EXTERNALS}.GTK_CAN_FOCUS_ENUM)
			init_default_values
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_set_double_buffered (c_object, False)
		end

feature {NONE} -- Implementation

	default_key_processing_blocked (a_key: EV_KEY): BOOLEAN is
		do
			if a_key.is_arrow or else a_key.code = App_implementation.Key_constants.key_tab then
				Result := True
			end
		end

	interface: EV_DRAWING_AREA

	redraw is
		do
			redraw_rectangle (0, 0, width, height)
		end

	redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
		local
			a_rectangle: POINTER
			a_drawable: POINTER
		do
			a_drawable := drawable
			if a_drawable /= NULL then
				a_rectangle := feature {EV_GTK_EXTERNALS}.c_gdk_rectangle_struct_allocate
				feature {EV_GTK_EXTERNALS}.set_gdk_rectangle_struct_width (a_rectangle, a_width)
				feature {EV_GTK_EXTERNALS}.set_gdk_rectangle_struct_height (a_rectangle, a_height)
				feature {EV_GTK_EXTERNALS}.set_gdk_rectangle_struct_x (a_rectangle, a_x)
				feature {EV_GTK_EXTERNALS}.set_gdk_rectangle_struct_y  (a_rectangle, a_y)
				feature {EV_GTK_EXTERNALS}.gdk_window_invalidate_rect (a_drawable, a_rectangle, False)
				a_rectangle.memory_free				
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
			-- Redraw the screen immediately.
		do
			-- Do nothing
		end

feature {EV_DRAWABLE_IMP} -- Implementation

	drawable: POINTER is
		do
			Result := feature {EV_GTK_EXTERNALS}.gtk_widget_struct_window (visual_widget)
		end
		
feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	on_focus_changed (a_has_focus: BOOLEAN) is
			-- Focus for `Current' has changed'.
		do
			if a_has_focus then
				top_level_window_imp.set_focus_widget (Current)
			else
				top_level_window_imp.set_focus_widget (Void)
			end
			Precursor {EV_PRIMITIVE_IMP} (a_has_focus)
		end

	call_expose_actions (a_x, a_y, a_width, a_height: INTEGER) is
			-- Call the expose actions for the drawing area.
		do
			if expose_actions_internal /= Void then
				expose_actions_internal.call ([a_x, a_y, a_width, a_height])
			end
		end

	lose_focus is
		do
			--| FIXME IEK Remove me
		end
		
feature {NONE} -- Implementation

	on_key_event (a_key: EV_KEY; a_key_string: STRING; a_key_press: BOOLEAN) is
			-- Key event has occured
		do
			Precursor {EV_PRIMITIVE_IMP} (a_key, a_key_string, a_key_press)
			if 
				a_key /= Void and then
				(a_key.code = App_implementation.Key_constants.Key_up or else a_key.code = App_implementation.Key_constants.Key_down)
			then
				-- This is a hack for Studio to force trailing cursors to be undrawn upon key scrolling.
				--feature {EV_GTK_EXTERNALS}.gtk_widget_queue_draw (visual_widget)
				redraw_rectangle (1, 1, width, height)
			end				
		end

	destroy is
			-- Destroy implementation
		do
			Precursor {EV_PRIMITIVE_IMP}
			if gc /= NULL then
				feature {EV_GTK_EXTERNALS}.gdk_gc_unref (gc)
				gc := NULL
			end
		end
		
	dispose is
			-- Clean up
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

