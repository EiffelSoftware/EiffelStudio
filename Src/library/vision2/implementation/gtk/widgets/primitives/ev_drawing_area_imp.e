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
			visual_widget,
			disconnect_all_signals
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
					~give_focus
			)
			temp_sig_id := c_signal_connect (
					drawing_area_widget,
					eiffel_to_c ("focus-in-event"),
					~attain_focus
			)
			temp_sig_id := c_signal_connect (
					drawing_area_widget,
					eiffel_to_c ("focus-out-event"),
					~lose_focus
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

	disconnect_all_signals is
			-- Disconnect all gtk signals.
		do
			--| FIXME
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

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.17  2001/07/14 12:16:27  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.16  2001/07/02 15:29:33  king
--| Using key constants from app_implementation to avoid object creation
--|
--| Revision 1.15  2001/06/30 19:23:12  pichery
--| updated to take into account changes in interface of EV_KEY
--|
--| Revision 1.14  2001/06/07 23:08:07  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.6.4.27  2001/06/01 22:49:17  etienne
--| Improved fix in `screen_x' and `screen_y'.
--|
--| Revision 1.6.4.26  2001/05/31 22:17:38  etienne
--| Added temporary fix for `screen_x' and `screen_y'.
--|
--| Revision 1.6.4.25  2001/05/18 18:17:33  king
--| Added code that only stops key emission on focus change keys
--|
--| Revision 1.6.4.24  2001/05/11 17:09:32  king
--| Updated rectangle functions to use new semantic
--|
--| Revision 1.6.4.23  2001/04/18 18:28:25  king
--| Redefined disconnect_all_signals to prevent warnings
--|
--| Revision 1.6.4.22  2001/02/27 00:14:34  andrew
--| Reverted to previous version.
--|
--| Revision 1.6.4.20  2001/01/25 00:28:51  andrew
--| Changed redraw_rectangle to send correct values to expose_actions_internal.call ([a_x, a_y, a_width, a_height]).
--|
--| Revision 1.6.4.19  2000/11/03 23:42:31  king
--| Fixed focusing problem
--|
--| Revision 1.6.4.18  2000/10/27 16:54:43  manus
--| Removed undefinition of `set_default_colors' since now the one from EV_COLORIZABLE_IMP is
--| deferred.
--| However, there might be a problem with the definition of `set_default_colors' in the following
--| classes:
--| - EV_TITLED_WINDOW_IMP
--| - EV_WINDOW_IMP
--| - EV_TEXT_COMPONENT_IMP
--| - EV_LIST_ITEM_LIST_IMP
--| - EV_SPIN_BUTTON_IMP
--|
--| Revision 1.6.4.17  2000/09/12 23:14:59  king
--| Moved top_level_window into widget_imp
--|
--| Revision 1.6.4.15  2000/09/06 17:48:44  oconnor
--| Use new default_gdk_window feature instead of gdk_root_parent to try
--| to get a basis for visuals that will work better on workstations that
--| have different color depths for diverent windows.
--|
--| Revision 1.6.4.14  2000/09/05 23:43:08  king
--| Implemented key event hack
--|
--| Revision 1.6.4.13  2000/08/28 22:10:39  king
--| Now setting focus on mouse click
--|
--| Revision 1.6.4.12  2000/08/28 16:36:13  king
--| Integrated event_box as c_object
--|
--| Revision 1.6.4.11  2000/08/22 18:10:51  king
--| Removed redundant initialize
--|
--| Revision 1.6.4.10  2000/08/08 00:03:15  oconnor
--| Redefined set_default_colors to do nothing in EV_COLORIZABLE_IMP.
--|
--| Revision 1.6.4.9  2000/08/03 23:18:11  king
--| Using internal expose_actions
--|
--| Revision 1.6.4.8  2000/07/24 21:36:10  oconnor
--| inherit action sequences _IMP class
--|
--| Revision 1.6.4.7  2000/06/14 23:16:15  king
--| Removed event masking code
--|
--| Revision 1.6.4.6  2000/06/14 00:08:34  king
--| Now using event_box for c_object
--|
--| Revision 1.6.4.5  2000/06/02 22:49:43  king
--| Fixed expose actions calling
--|
--| Revision 1.6.4.4  2000/06/01 22:05:36  king
--| Inheriting from event box to catch mouse events
--|
--| Revision 1.6.4.3  2000/05/09 16:40:54  brendel
--| Changed motion_mask to motion_hint_mask which prevents generation of mouse
--| motion events when one is still being processed.
--|
--| Revision 1.6.4.2  2000/05/03 19:08:50  oconnor
--| mergred from HEAD
--|
--| Revision 1.12  2000/04/04 20:54:08  oconnor
--| updated signal connection for new marshaling scheme
--|
--| Revision 1.11  2000/03/03 03:59:03  pichery
--| added feature `flush'
--|
--| Revision 1.10  2000/02/22 18:39:38  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.9  2000/02/21 22:38:06  brendel
--| Fixed bug in event setting.
--|
--| Revision 1.8  2000/02/16 18:11:25  bonnard
--| Added redraw features.
--|
--| Revision 1.7  2000/02/14 11:40:32  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.4.1.2.24  2000/02/06 21:16:32  brendel
--| Fixed bug where before no mouse-events were sent to the GtkDrawingArea.
--| Among other events, mouse-motion is turned off by default.
--|
--| Revision 1.6.4.1.2.23  2000/02/04 04:25:38  oconnor
--| released
--|
--| Revision 1.6.4.1.2.22  2000/01/27 19:29:46  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.4.1.2.21  2000/01/21 22:27:08  brendel
--| Rearranged inheritance of color features.
--|
--| Revision 1.6.4.1.2.20  2000/01/20 23:04:51  brendel
--| Formating.
--|
--| Revision 1.6.4.1.2.19  2000/01/20 00:14:45  brendel
--| Changed inheritance of background_color. Now takes the one from EV_WIDGET.
--|
--| Revision 1.6.4.1.2.18  2000/01/19 17:44:36  brendel
--| Added undefine for color features from EV_WIDGET.
--|
--| Revision 1.6.4.1.2.17  2000/01/18 01:10:50  king
--| Undefined C feature from ev_drawable_imp
--|
--| Revision 1.6.4.1.2.16  2000/01/17 23:32:14  brendel
--| GC is now created in make, so values can be initialized before it is
--| parented.
--|
--| Revision 1.6.4.1.2.15  2000/01/17 17:43:28  brendel
--| Removed redefine of initialize.
--|
--| Revision 1.6.4.1.2.14  2000/01/17 17:10:12  brendel
--| Moved signals to realize and unrealize from drawable to drawing area.
--|
--| Revision 1.6.4.1.2.13  1999/12/15 19:30:49  king
--| Uncommented drawable pointer
--|
--| Revision 1.6.4.1.2.12  1999/12/08 17:10:02  brendel
--| Removed old irrelevant notes.
--| Added keywords clause.
--| Added comment and FIXME in feature make.
--|
--| Revision 1.6.4.1.2.11  1999/12/08 01:21:59  brendel
--| Removed color-related features from inheritance clause.
--| Removed redeclaration of set_default_colors.
--|
--| Revision 1.6.4.1.2.10  1999/12/07 19:18:09  brendel
--| Ignore previous log message.
--| Now create c_object as gtk_drawing_area.
--| Removed color related features from inheritance clause.
--|
--| Revision 1.6.4.1.2.9  1999/12/07 18:56:16  brendel
--| Changed implementation of width and height to make it more compact.
--| Improved contracts on set_bounds.
--|
--| Revision 1.6.4.1.2.8  1999/12/06 17:58:26  brendel
--| Changed creation sequence. We just create the `c_object' now and do
--| not have to worry about the `gc', since that is all handled in
--| EV_DRAWABLE_IMP.
--|
--| Revision 1.6.4.1.2.7  1999/12/04 00:40:51  brendel
--| Removed all pixmapable stuff.
--|
--| Revision 1.6.4.1.2.6  1999/12/03 23:55:44  brendel
--| Added redefine of initialize.
--|
--| Revision 1.6.4.1.2.5  1999/12/03 20:28:14  brendel
--| I seem to have removed a line.
--|
--| Revision 1.6.4.1.2.4  1999/12/03 04:07:49  brendel
--| Tried something with creating c_object.
--|
--| Revision 1.6.4.1.2.3  1999/12/01 01:02:33  brendel
--| Rearranged externals to GEL or EV_C_GTK. Modified some features that relied
--| on specific things like return value BOOLEAN instead of INTEGER.
--|
--| Revision 1.6.4.1.2.2  1999/11/24 22:48:06  brendel
--| Just managed to compile figure cluster example.
--|
--| Revision 1.6.4.1.2.1  1999/11/24 17:29:56  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
