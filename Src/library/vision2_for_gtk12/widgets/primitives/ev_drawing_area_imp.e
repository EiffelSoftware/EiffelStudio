indexing
	description: "EiffelVision drawing area. GTK implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			set_c_object ({EV_GTK_EXTERNALS}.gtk_drawing_area_new)
			real_signal_connect (c_object, "button-press-event", agent (App_implementation.gtk_marshal).on_drawing_area_event_intermediary (c_object, 1), Void)
			real_signal_connect (c_object, "focus-out-event", agent (App_implementation.gtk_marshal).on_drawing_area_event_intermediary (c_object, 2), Void)
			gc := {EV_GTK_EXTERNALS}.gdk_gc_new (App_implementation.default_gdk_window)
			init_default_values
		end

feature {NONE} -- Implementation

	is_tabable_to: BOOLEAN is
			-- Is Current able to be tabbed to?
		do
			
		end

	is_tabable_from: BOOLEAN is
			-- Is Current able to be tabbed from?
		do
			
		end

	enable_tabable_to is
			-- Make `is_tabable_to' `True'.
		do
			
		end

	disable_tabable_to is
			-- Make `is_tabable_to' `False'.
		do
			
		end

	enable_tabable_from is
			-- Make `is_tabable_from' `True'.
		do
			
		end

	disable_tabable_from is
			-- Make `is_tabable_from' `False'.
		do
			
		end
		
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
		do
			{EV_GTK_EXTERNALS}.gtk_widget_queue_draw_area (visual_widget, a_x, a_y, a_width, a_height)
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
			Result := {EV_GTK_EXTERNALS}.gtk_widget_struct_window (visual_widget)
		end
		
feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	call_expose_actions (a_x, a_y, a_width, a_height: INTEGER) is
			-- Call the expose actions for the drawing area.
		do
			if expose_actions_internal /= Void then
				expose_actions_internal.call ([a_x, a_y, a_width, a_height])
			end
		end

	lose_focus is
		do
			top_level_window_imp.set_focus_widget (Void)
			{EV_GTK_EXTERNALS}.GTK_WIDGET_UNSET_FLAGS (c_object, {EV_GTK_EXTERNALS}.GTK_HAS_FOCUS_ENUM)
			-- This is a hack to make sure focus flag is unset.
		end
		
	set_focus is
			-- Grab keyboard focus.
		do
			if not has_focus then
				{EV_GTK_EXTERNALS}.GTK_WIDGET_SET_FLAGS (c_object, {EV_GTK_EXTERNALS}.GTK_CAN_FOCUS_ENUM)
				if focus_in_actions_internal /= Void then
					focus_in_actions_internal.block
					-- This needs to be called manually for cases that gtk doesn't handle.
				end
				{EV_GTK_EXTERNALS}.gtk_widget_grab_focus (c_object)
				{EV_GTK_EXTERNALS}.GTK_WIDGET_SET_FLAGS (c_object, {EV_GTK_EXTERNALS}.GTK_HAS_FOCUS_ENUM)
				top_level_window_imp.set_focus_widget (Current)
				{EV_GTK_EXTERNALS}.GTK_WIDGET_UNSET_FLAGS (c_object, {EV_GTK_EXTERNALS}.GTK_CAN_FOCUS_ENUM)
				if focus_in_actions_internal /= Void then
					focus_in_actions_internal.resume
					focus_in_actions_internal.call (Void)
				end
			end
		end
		
feature {NONE} -- Implementation

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




end -- class EV_DRAWING_AREA_IMP

