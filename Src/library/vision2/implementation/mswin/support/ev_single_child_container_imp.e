--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: 
		"A common class for the container with only%
		% one child."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SINGLE_CHILD_CONTAINER_IMP

inherit
	EV_CONTAINER_IMP
		redefine
			enable_sensitive,
			disable_sensitive,
			propagate_foreground_color,
			propagate_background_color
		end

feature -- Access

	child: EV_WIDGET_IMP
			-- The child of the container. obsolete.

	item: EV_WIDGET
			-- The child of the container.

feature -- Status report

	enable_sensitive is
			-- Set current widget in insensitive mode if
   			-- `flag'.
		do
			if child /= Void then
				child.enable_sensitive
			end
			{EV_CONTAINER_IMP} Precursor
		end

	disable_sensitive is
			-- Set current widget in insensitive mode if
   			-- `flag'.
		do
			if child /= Void then
				child.disable_sensitive
			end
			{EV_CONTAINER_IMP} Precursor
		end

feature -- Element change

	put (new_child: like item) is
			-- Put `new_child' into `Current'
		local
			child_imp: EV_WIDGET_IMP
		do
			if new_child = Void then
				child_imp ?= item.implementation
				check
					item_implementation_not_void: child_imp /= Void
				end	
				child_imp.set_parent (Void)
				item := Void
				notify_change (2 + 1)
			else
				child_imp ?= new_child.implementation
				check
					new_child_implementation_not_void: child_imp /= Void
				end
				item := new_child
				child_imp.set_parent (interface)
				--|The line below has been changed from
				--|notify_change (2 + 1) to combat a re-sizing problem
				--|when you set the size of a parent before adding a child.
				--|Julian Rogers 02/01/2000.
				--|No problems have shown up on testing.
				child_imp.parent_ask_resize (client_width, client_height)
			end
		end

	replace (v: like item) is
			-- Replace `item' with `v'
		local
			child_imp: EV_WIDGET_IMP
		do
			if item /= Void then
				child_imp ?= item.implementation
				remove_child (child_imp)
			end
			put (v)
		end

	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into composite
		obsolete "Use put instead."
		do
			child := child_imp
			notify_change (2 + 1)
		end

	remove_child (child_imp: EV_WIDGET_IMP) is
			-- Remove the given child from the children of
			-- the container.
		do
			child := Void
			notify_change (2 + 1)
		end

feature -- Basic operations

	propagate_background_color is
			-- Propagate the current background color of the container
			-- to the children.
		do
			if child /= Void then
				child.set_background_color (background_color)
			end
		end

	propagate_foreground_color is
			-- Propagate the current foreground color of the container
			-- to the children.
		do
			if child /= Void then
				child.set_foreground_color (foreground_color)
			end
		end

feature -- Assertion

	add_child_ok: BOOLEAN is
			-- Used in the precondition of
			-- 'add_child'. True, if it is ok to add a
			-- child to container.
		do
			Result := child = Void
		end

	is_child (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Is `a_child' a child of the container?
		do
			Result := a_child = child
		end

end -- class EV_SINGLE_CHILD_CONTAINER_IMP

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
--| Revision 1.5  2000/02/14 11:40:41  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.10.7  2000/02/08 20:29:26  rogers
--| Implemented replace.
--|
--| Revision 1.4.10.6  2000/02/08 18:05:53  king
--| Added replace feature that needs implementing
--|
--| Revision 1.4.10.5  2000/02/02 21:02:28  rogers
--| Altered put. See comment in feature for full explanation.
--|
--| Revision 1.4.10.4  2000/01/27 19:30:16  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.10.3  2000/01/18 17:07:03  king
--| Added redefine of propagate_*_color to inh.
--|
--| Revision 1.4.10.2  1999/12/17 01:09:05  rogers
--| Altered to fit in with the review branch. set_insensitive has been split into two.
--|
--| Revision 1.4.10.1  1999/11/24 17:30:22  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.6.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
