--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: 
		"EiffelVision invisible container. Allow several children.%
	     % Mswindows implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_INVISIBLE_CONTAINER_IMP
	
inherit
	EV_INVISIBLE_CONTAINER_I
		redefine
			interface
		end

	EV_CONTAINER_IMP
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			enable_sensitive,
			disable_sensitive,
			interface
		end

	EV_WEL_CONTROL_CONTAINER_IMP
		rename
			make as ev_wel_control_container_make
		redefine
			top_level_window_imp
		end

feature -- Access
	
	ev_children: ARRAYED_LIST [EV_WIDGET_IMP]
			-- List of the children of the box

	top_level_window_imp: EV_WINDOW_IMP
			-- Top level window that contains the current widget.

feature -- Status setting

	set_insensitive (flag: BOOLEAN) is
			-- Set current widget in insensitive mode if
   			-- `flag'.
		local
			list: ARRAYED_LIST [EV_WIDGET_IMP]
		do
			if not ev_children.empty then
				list := ev_children
				from
					list.start
				until
					list.after
				loop
					list.item.disable_sensitive
					list.forth
				end
			end
		end

	enable_sensitive is 
		do
			set_insensitive (False)
			{EV_CONTAINER_IMP} Precursor
		end
	disable_sensitive is
		do
			set_insensitive (True)
			{EV_CONTAINER_IMP} Precursor
		end


feature -- Element change

	set_top_level_window_imp (a_window: EV_WINDOW_IMP) is
			-- Make `a_window' the new `top_level_window_imp'
			-- of the widget.
		local
			list: ARRAYED_LIST [EV_WIDGET_IMP]
		do
			top_level_window_imp := a_window
			if not ev_children.empty then
				list := ev_children
				from
					list.start
				until
					list.after
				loop
					list.item.set_top_level_window_imp (a_window)
					list.forth
				end
			end
		end

feature -- Assertion features

	add_child_ok: BOOLEAN is
			-- Used in the precondition of
			-- 'add_child'. True, if it is ok to add a
			-- child to container.
		do
			Result := True
		end

	is_child (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Is `a_child' a child of the container?
		do
			Result := ev_children.has (a_child)
		end

feature {NONE}

	interface: EV_INVISIBLE_CONTAINER

end -- class EV_INVISIBLE_CONTAINER_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.22  2000/02/14 11:40:43  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.21.10.5  2000/01/31 17:27:46  brendel
--| Removed set_default_minimum_size from inh. clause.
--|
--| Revision 1.21.10.4  2000/01/27 19:30:22  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.21.10.3  2000/01/18 00:20:54  rogers
--| Undefined propagatae_foreground_color and propagate_background_color from EV_CONTAINER_IMP. Removed these functions from the class text also, as they are now inherited from EV_INVISIBLE_CONTAINER_I.
--|
--| Revision 1.21.10.2  1999/12/17 00:51:22  rogers
--| Altered to fit in with the review branch. set_insensitve has been split into enable_sensitive and disable_sensitive.
--|
--| Revision 1.21.10.1  1999/11/24 17:30:27  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.21.6.3  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
