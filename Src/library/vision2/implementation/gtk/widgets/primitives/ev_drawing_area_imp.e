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
			initialize,
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create an empty drawing area.
		do
			base_make (an_interface)
			set_c_object (C.gtk_drawing_area_new)
			C.gtk_widget_set_events (c_object, C.Gdk_all_events_mask_enum)
	
			gc := C.gdk_gc_new (C.gdk_root_parent)
			gcvalues := C.c_gdk_gcvalues_struct_allocate
			c.gdk_gc_get_values (gc, gcvalues)
			init_default_values
		end

	initialize is
			-- Set up action sequence connections
			-- and `Precursor' initialization.
		do
			Precursor
			connect_signal_to_actions ("expose-event",
				interface.expose_actions)
		end

feature {NONE} -- Implementation

	interface: EV_DRAWING_AREA

feature {EV_DRAWABLE_IMP} -- Implementation

	drawable: POINTER is
		do
			Result := C.gtk_widget_struct_window (c_object)
		end

end -- class EV_DRAWING_AREA_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
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
--| not have to worry about the `gc', since that is all handled in EV_DRAWABLE_IMP.
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
--| Rearranged externals to GEL or EV_C_GTK. Modified some features that relied on specific things like return value BOOLEAN instead of INTEGER.
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
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
