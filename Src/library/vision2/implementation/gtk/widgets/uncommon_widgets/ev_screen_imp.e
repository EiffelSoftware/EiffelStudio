indexing 
	description:
		"EiffelVision screen. GTK+ implementation."
	status: "See notice at end of class"
	keywords: "screen, root, window, visual, top"
	date: "$Date$"
	revision: "$Revision$"


class
	EV_SCREEN_IMP

inherit
	EV_SCREEN_I
		redefine
			interface
		end

	EV_DRAWABLE_IMP
		redefine
			interface,
			initialize
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create an empty drawing area.
		do
			base_make (an_interface)
			gc := C.gdk_gc_new (drawable)
			gcvalues := C.c_gdk_gcvalues_struct_allocate
			C.gdk_gc_set_subwindow (gc, C.Gdk_include_inferiors_enum)
			C.gdk_gc_get_values (gc, gcvalues)
			init_default_values
		end

	initialize is
			-- Set up action sequence connections and create graphics context.
		do
			is_initialized := True
			
			--| FIXME IEK Gdk event handling needs implementing
			--connect_signal_to_actions ("expose-event",
			--	interface.expose_actions)
		end

	destroy is
		do
			C.c_gdk_gcvalues_struct_free (gcvalues)
			C.gdk_gc_unref (gc)
			is_destroyed := True
			destroy_just_called := True
		end

feature -- Measurement

	height: INTEGER is
			-- Vertical size in pixels.
		do
			Result := C.gdk_screen_height
		end

	width: INTEGER is
			-- Horizontal size in pixels.
		do
			Result := C.gdk_screen_width
		end

feature {NONE} -- Implementation

	drawable: POINTER is
			-- Pointer to the screen (root window)
		do
			Result := C.gdk_root_parent
		end

	interface: EV_SCREEN

end -- class EV_SCREEN_IMP

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
--| Revision 1.4  2000/02/14 11:40:33  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.4.1.2.18  2000/02/04 04:25:39  oconnor
--| released
--|
--| Revision 1.3.4.1.2.17  2000/01/27 19:29:51  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.4.1.2.16  2000/01/25 23:22:16  brendel
--| Changed gc to be created with every screen object instead of once.
--|
--| Revision 1.3.4.1.2.15  2000/01/18 01:12:28  king
--| Removed instantation of feature C
--|
--| Revision 1.3.4.1.2.14  2000/01/17 23:31:26  brendel
--| Moved initialization of `gcvalues' to make.
--|
--| Revision 1.3.4.1.2.13  1999/12/23 01:38:41  king
--| Updated check statement
--|
--| Revision 1.3.4.1.2.12  1999/12/18 02:22:37  king
--| Removed unwanted unreferencing of GC
--|
--| Revision 1.3.4.1.2.11  1999/12/16 09:19:36  oconnor
--| fixed cyclic creation order depenancy
--|
--| Revision 1.3.4.1.2.10  1999/12/16 03:42:23  oconnor
--| improved memory management
--|
--| Revision 1.3.4.1.2.9  1999/12/15 19:35:25  king
--| Changed drawable to use gdk_root_parent external
--| Using ev_color to set default values
--| Removed expose_actions (need GDK event init)
--|
--| Revision 1.3.4.1.2.8  1999/12/09 23:23:41  brendel
--| Added implementation of features `width' and `height'.
--|
--| Revision 1.3.4.1.2.7  1999/12/09 19:00:56  brendel
--| Improved cosmetics and indexing clauses.
--|
--| Revision 1.3.4.1.2.6  1999/12/04 19:17:56  oconnor
--| fixed external access
--|
--| Revision 1.3.4.1.2.5  1999/12/04 19:16:32  oconnor
--| fixed external access
--|
--| Revision 1.3.4.1.2.4  1999/12/04 00:41:24  brendel
--| Started first implementation.
--|
--| Revision 1.3.4.1.2.3  1999/12/03 23:56:43  brendel
--| Added redefine of initialize.
--| Commented out feature destroy.
--|
--| Revision 1.3.4.1.2.2  1999/11/30 23:02:36  oconnor
--| Redefined interface to more refined type
--|
--| Revision 1.3.4.1.2.1  1999/11/24 17:30:00  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.3  1999/11/04 23:10:31  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.3.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
