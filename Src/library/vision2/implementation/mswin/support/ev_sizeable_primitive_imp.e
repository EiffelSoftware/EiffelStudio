indexing
	description:
		"Eiffel Vision sizeable primitive. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$" 
 
deferred class
	EV_SIZEABLE_PRIMITIVE_IMP

inherit
	EV_SIZEABLE_IMP

feature -- Access

	ev_set_minimum_width (value: INTEGER) is
			-- Make `value' the new `minimum_width' of `Current'.
			-- Should check if the user didn't set the minimum width
			-- before setting a new value.
		local
			p_imp: like parent_imp
		do
			if minimum_width /= value then
				internal_set_minimum_width (value)
				p_imp := parent_imp
				if p_imp /= Void then
					p_imp.notify_change (Nc_minwidth, Current)
				end
			end
		end

	ev_set_minimum_height (value: INTEGER) is
			-- Make `value' the new `minimum_height' of `Current'.
			-- Should check if the user didn't set the minimum width
			-- before setting a new value.
		local
			p_imp: like parent_imp
		do
			if minimum_height /= value then
				internal_set_minimum_height (value)
				p_imp := parent_imp
				if p_imp /= Void then
					p_imp.notify_change (Nc_minheight, Current)
				end
			end
		end

	ev_set_minimum_size (mw, mh: INTEGER) is
			-- Make `mw' the new minimum_width and `mh' the new
			-- minimum_height of `Current'.
			-- Should check if the user didn't set the minimum width
			-- before setting a new value.
		local
			w_cd, h_cd: BOOLEAN
			p_imp: like parent_imp
		do
			w_cd := minimum_width /= mw
			h_cd := minimum_height /= mh
			internal_set_minimum_size (mw, mh)
			p_imp := parent_imp
			if p_imp /= Void then
				if w_cd and h_cd then
					p_imp.notify_change (Nc_minsize, Current)
				elseif w_cd then
					p_imp.notify_change (Nc_minwidth, Current)
				elseif h_cd then
					p_imp.notify_change (Nc_minheight, Current)
				end
			end
		end

end -- EV_SIZEABLE_PRIMITIVE_IMP
 
--!-----------------------------------------------------------------------------
--! EiffelVision: library of reusable components for ISE Eiffel.
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
--| Revision 1.5  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.4  2001/06/07 23:08:14  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.2.4.6  2001/02/19 16:35:38  manus
--| Speed optimization by avoiding too many calls to `parent_imp' use a local
--| variable instead.
--|
--| Revision 1.2.4.5  2000/08/08 01:49:01  manus
--| New resizing policy which always do a minimum_size computation when needed, but not
--| always. See `vision2/implementation/mswin/doc/sizing_how_to.txt' for more details.
--|
--| Revision 1.2.4.4  2000/06/19 22:06:12  rogers
--| Removed integrate_changes as it is no longer deferred from ev_sizeable_imp.
--| Removed FIXME NOT_REVIEWED. Comments, formatting.
--|
--| Revision 1.2.4.3  2000/06/06 00:08:39  manus
--| `compute_minimum_size' will compute something only if a window is visible, and will just
--| notify the parent otherwise.
--| New signature for `notify_change' that takes `child' which request the change as 2 parameter.
--| The rational is that it is used only for EV_NOTEBOOK_IMP where we do not want to resize a
--| page if it is not visible. This largely improves the resizing performance.
--|
--| Revision 1.2.4.2  2000/05/27 01:54:23  pichery
--| Cosmetics
--|
--| Revision 1.2.4.1  2000/05/03 19:09:18  oconnor
--| mergred from HEAD
--|
--| Revision 1.2  2000/03/14 03:02:54  brendel
--| Merged changed from WINDOWS_RESIZING_BRANCH.
--|
--| Revision 1.1.2.3  2000/03/14 00:13:02  brendel
--| Changed all calls to wel_move_and_resize back to have repaint `True' at
--| every call. It seems to be inevitable to have every change redrawn.
--| This is what causes the flickering, though, so a workaround has to be
--| found or the entire design has to be redone.
--|
--| Revision 1.1.2.2  2000/03/09 21:56:42  brendel
--| Removed most features that are still in EV_SIZEABLE_IMP.
--| (this file was copied from EV_SIZEABLE_IMP)
--|
--| Revision 1.1  2000/03/09 16:58:55  brendel
--| New descendant of EV_SIZEABLE to make it more clear which features
--| apply only to primitives and containers, which are in
--| EV_SIZEABLE_CONTAINER.
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------

