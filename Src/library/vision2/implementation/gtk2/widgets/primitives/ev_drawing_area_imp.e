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
			dispose,
			destroy,
			on_focus_changed,
			needs_event_box,
			gdk_events_mask
		end

	EV_DRAWING_AREA_ACTION_SEQUENCES_IMP
		redefine
			interface,
			needs_event_box
		end

create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN is True
		-- Place drawing area inside an event box.

	make (an_interface: like interface) is
			-- Create an empty drawing area.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_drawing_area_new)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_set_redraw_on_allocate (visual_widget, False)
				-- This means that when the drawing area is resized, only the new portions are redrawn
			gc := {EV_GTK_EXTERNALS}.gdk_gc_new (App_implementation.default_gdk_window)
			{EV_GTK_EXTERNALS}.GTK_WIDGET_SET_FLAGS (visual_widget, {EV_GTK_EXTERNALS}.GTK_CAN_FOCUS_ENUM)
			init_default_values
			{EV_GTK_EXTERNALS}.gtk_widget_set_double_buffered (visual_widget, False)
		end

	Gdk_events_mask: INTEGER is
			-- Mask of all the gdk events the gdkwindow shall receive.
		once
			Result := Precursor {EV_PRIMITIVE_IMP} |
			{EV_GTK_EXTERNALS}.GDK_POINTER_MOTION_HINT_MASK_ENUM
				-- We only want motion events when we query for them.
				-- Setting this flag on other gtk widgets such as GtkTreeView causes problems with the implementation
		end

feature {NONE} -- Implementation

	default_key_processing_blocked (a_key: EV_KEY): BOOLEAN is
		do
			Result := a_key.is_arrow or else a_key.code = App_implementation.Key_constants.key_tab
		end

	redraw is
			-- Redraw the entire area.
		do
			redraw_rectangle (0, 0, width, height)
		end

	redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
			-- Redraw the rectangle area defined by `a_x', `a_y', `a_width', a_height'
		local
			a_rectangle: POINTER
			a_drawable: POINTER
		do
			a_drawable := drawable
			if a_drawable /= NULL then
				a_rectangle := {EV_GTK_EXTERNALS}.c_gdk_rectangle_struct_allocate
				{EV_GTK_EXTERNALS}.set_gdk_rectangle_struct_width (a_rectangle, a_width)
				{EV_GTK_EXTERNALS}.set_gdk_rectangle_struct_height (a_rectangle, a_height)
				{EV_GTK_EXTERNALS}.set_gdk_rectangle_struct_x (a_rectangle, a_x)
				{EV_GTK_EXTERNALS}.set_gdk_rectangle_struct_y  (a_rectangle, a_y)
				{EV_GTK_EXTERNALS}.gdk_window_invalidate_rect (a_drawable, a_rectangle, False)
				a_rectangle.memory_free				
			end
		end
		
	clear_and_redraw is
			-- Clear `Current' and redraw
		do
			clear
			redraw
		end

	clear_and_redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
			-- Clear the rectangle area defined by `a_x', `a_y', `a_width', `a_height' and then redraw it
		do
			clear_rectangle (a_x, a_y, a_width, a_height)
			redraw_rectangle (a_x, a_y, a_width, a_height)
		end

	flush is
			-- Redraw the screen immediately.
		do
			if drawable /= NULL and then is_displayed then
				{EV_GTK_EXTERNALS}.gdk_window_process_updates (drawable, False)
			end
		end

	update_if_needed is
			-- Update `Current' if needed
		do
			-- Not applicable
		end
		

feature {EV_DRAWABLE_IMP} -- Implementation

	drawable: POINTER is
			-- Pointer to the drawable object for `Current'
		do
			Result := {EV_GTK_EXTERNALS}.gtk_widget_struct_window (visual_widget)
		end

	mask: POINTER
			-- Mask of Current, which is always NULL
		
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

	interface: EV_DRAWING_AREA
		-- Interface object of Current

	destroy is
			-- Destroy implementation
		do
			Precursor {EV_PRIMITIVE_IMP}
			if gc /= NULL then
				{EV_GTK_EXTERNALS}.gdk_gc_unref (gc)
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
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

