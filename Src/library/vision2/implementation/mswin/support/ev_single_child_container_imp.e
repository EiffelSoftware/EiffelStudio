--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: 
		"A common class for Mswindows containers with one child without%N%
		%commitment to a WEL control."
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
			propagate_background_color,
			extend
		end

feature -- Access

	item: EV_WIDGET
			-- The child of the container.

	item_imp: EV_WIDGET_IMP is
			-- `item'.`implementation'.
		do
			if item /= Void then
				Result ?= item.implementation
			end
		end

feature -- Status setting

	enable_sensitive is
			-- Set `item' sensitive to user actions.
		do
			if item /= Void then
				item.enable_sensitive
			end
			{EV_CONTAINER_IMP} Precursor
		end

	disable_sensitive is
			-- Set `item' insensitive to user actions.
		do
			if item /= Void then
				item.disable_sensitive
			end
			{EV_CONTAINER_IMP} Precursor
		end

feature -- Element change

	remove is
			-- Remove `item' from `Current'.
		local
			v_imp: EV_WIDGET_IMP
		do
			if item /= Void then
				remove_item_actions.call ([item])
				v_imp ?= item_imp
				check
					v_imp_not_void: v_imp /= Void
				end	
				v_imp.set_parent (Void)
				v_imp.on_orphaned
				item := Void
				notify_change (2 + 1)
			end
		end

	insert (v: like item) is
			-- Assign `v' to `item'.
		local
			v_imp: EV_WIDGET_IMP
		do
			check
				has_no_item: item = Void
			end
			v.implementation.on_parented
			v_imp ?= v.implementation
			check
				v_imp_not_void: v_imp /= Void
			end
			item := v
			v_imp.set_parent (interface)
			notify_change (2 + 1)
			
			new_item_actions.call ([item])
		end

	put, replace (v: like item) is
			-- Replace `item' with `v'.
		do
			remove
			insert (v)
		end

feature -- Basic operations

	propagate_background_color is
			-- Propagate the current background color of the container
			-- to the children.
		do
			if item /= Void then
				item.set_background_color (background_color)
			end
		end

	propagate_foreground_color is
			-- Propagate the current foreground color of the container
			-- to the children.
		do
			if item /= Void then
				item.set_foreground_color (foreground_color)
			end
		end

feature -- Obsolete

	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into composite
		obsolete
			"Call notify_change."
		do
			notify_change (2 + 1)
		end

	remove_child (child_imp: EV_WIDGET_IMP) is
			-- Remove the given child from the children of
			-- the container.
		obsolete
			"Call notify_change."
		do
			notify_change (2 + 1)
		end

	add_child_ok: BOOLEAN is
			-- Used in the precondition of
			-- 'add_child'. True, if it is ok to add a
			-- child to container.
		obsolete
			"Do: item = Void"
		do
			Result := item = Void
		end

	is_child (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Is `a_child' a child of the container?
		obsolete
			"Do: ?? = item.implementation"
		do
			Result := a_child = item.implementation
		end

end -- class EV_SINGLE_CHILD_CONTAINER_IMP

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.12  2000/04/28 23:38:55  brendel
--| Improved all features in obsolete clause (My idea of a good time.)
--|
--| Revision 1.11  2000/04/26 22:16:50  rogers
--| Rplace now calls insert instead of extend.
--|
--| Revision 1.10  2000/04/26 21:51:06  brendel
--| Revised.
--|
--| Revision 1.9  2000/04/26 18:36:48  brendel
--| First attempt to fix cell.
--|
--| Revision 1.8  2000/04/14 21:41:18  brendel
--| Fixed put for PIXMAP's.
--|
--| Revision 1.7  2000/02/28 16:30:56  brendel
--| Added action sequence calls for on-remove and on-add of items.
--| Since this class has not been reviewed yet, I did not know exactly
--| where to put the calls and where not. Needs reviewing!
--|
--| Revision 1.6  2000/02/19 05:45:00  oconnor
--| released
--|
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
