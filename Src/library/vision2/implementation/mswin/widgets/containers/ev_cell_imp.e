--| FIXME Not for release
indexing
	description: 
		"Eiffel Vision cell, Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_CELL_IMP
	
inherit
	EV_CELL_I
		redefine
			interface
		end

	EV_SINGLE_CHILD_CONTAINER_IMP
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_WEL_CONTROL_CONTAINER_IMP
		rename
			make as ev_wel_control_container_make,
			move as move_to
		redefine
			top_level_window_imp
		end

create
	make

feature {NONE} -- initialization

	make (an_interface: like interface) is
			-- Connect interface.
		do
			base_make (an_interface)
			ev_wel_control_container_make
		end

feature -- Element change

	top_level_window_imp: EV_WINDOW_IMP
			-- Top level window that contains the current widget.

	set_top_level_window_imp (a_window: EV_WINDOW_IMP) is
			-- Make `a_window' the new `top_level_window_imp'
			-- of the widget.
		do
			top_level_window_imp := a_window
			if child /= Void then
				child.set_top_level_window_imp (a_window)
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_CONTAINER
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

end -- class EV_CELL_IMP

--!-----------------------------------------------------------------------------
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.2  2000/02/14 12:05:10  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.5  2000/01/29 01:05:02  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.1.2.4  2000/01/27 19:30:19  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.2.3  2000/01/20 20:12:25  brendel
--| Got it to compile.
--|
--| Revision 1.1.2.2  2000/01/20 20:02:29  brendel
--| Started implementing.
--|
--| Revision 1.1.2.1  2000/01/20 19:26:11  brendel
--| Initial.
--|
--| Revision 1.1.2.4  2000/01/20 18:47:16  oconnor
--| made non deferred
--|
--| Revision 1.1.2.3  2000/01/18 19:35:39  oconnor
--| added feature item
--|
--| Revision 1.1.2.2  2000/01/18 18:02:39  oconnor
--| redefined interface
--|
--| Revision 1.1.2.1  2000/01/18 18:01:48  oconnor
--| initial
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
