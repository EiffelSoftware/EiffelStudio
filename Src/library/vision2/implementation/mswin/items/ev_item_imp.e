indexing	
	description: "Eiffel Vision item. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ITEM_IMP

inherit
	EV_ITEM_I
		redefine
			interface
		end

	EV_PIXMAPABLE_IMP
		redefine
			interface
		end

	EV_PICK_AND_DROPABLE_ITEM_IMP
		redefine
			interface
		end

	EV_ITEM_ACTION_SEQUENCES_IMP

feature -- Status setting

	destroy is
			-- Destroy the current item.
		do
			if parent_imp /= Void then
				parent_imp.prune (interface)
			end
			is_destroyed := True
		end

	set_parent_imp (a_parent_imp: like parent_imp) is
			-- Assign `a_parent_imp' to `parent_imp'.
		deferred
		ensure
			assigned: parent_imp = a_parent_imp
		end

feature {EV_PICK_AND_DROPABLE_I} -- Status report

	cursor_on_widget: CELL [EV_WIDGET_IMP] is
			-- Widget currently under the pointer.
		do
			check
				to_be_implemented: False
			end
		end

feature {EV_ITEM_LIST_I} -- Implementation

	on_parented is
			-- `Current' has just been put into a container.
		do
			-- Does nothing by default.
		end

	on_orphaned is
			-- `Current' has just been removed from its container.
		do
			-- Does nothing by default.
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_ITEM

end -- class EV_ITEM_IMP

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
--| Revision 1.23  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.22  2001/06/07 23:08:11  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.7.4.8  2001/05/18 17:08:46  rogers
--| Removed destroy_just_called.
--|
--| Revision 1.7.4.7  2000/08/24 21:56:28  rogers
--| Removed align_text_center, align_text_right and align_text_left as redundent.
--|
--| Revision 1.7.4.6  2000/08/11 19:18:36  rogers
--| Fixed copyright clause. Now use ! instead of |.
--|
--| Revision 1.7.4.5  2000/07/24 22:45:48  rogers
--| Now inherits EV_ITEM_ACTION_SEQUENCES_IMP.
--|
--| Revision 1.7.4.4  2000/06/12 16:03:59  rogers
--| Comments, formatting.
--|
--| Revision 1.7.4.3  2000/06/12 15:50:44  rogers
--| Removed invalidate as it was never re-defined and therefore had no use.
--|
--| Revision 1.7.4.2  2000/05/18 23:12:44  rogers
--| set_parent renamed to set_parent_imp and parameter is now of type
--| parent_imp.
--|
--| Revision 1.7.4.1  2000/05/03 19:09:10  oconnor
--| mergred from HEAD
--|
--| Revision 1.20  2000/04/14 17:34:27  rogers
--| Inheritance changed from EV_PICK_AND_DROPABLE_IMP to
--| EV_PICK_AND_dROPABLE_ITEM_IMP. Removed commented pnd_motion
--| and pnd_press.
--|
--| Revision 1.19  2000/04/07 22:31:14  brendel
--| Revised.
--|
--| Revision 1.18  2000/03/30 19:49:21  rogers
--| Added pnd_motion and pnd_press as deferred.
--|
--| Revision 1.17  2000/03/24 19:17:30  rogers
--| Changed export status of on_parented and on_orphaned to EV_ITEM_LIST_I
--| from NONE.
--|
--| Revision 1.16  2000/03/23 23:37:03  brendel
--| Added on_parented and on_orphaned. Not called yet.
--|
--| Revision 1.15  2000/03/21 01:22:59  rogers
--| Removed set_pointer_style.
--|
--| Revision 1.14  2000/03/17 23:31:22  rogers
--| Added set_pointer_style and cursor_on_widget, both with
--| to_be_implemented_checks.
--|
--| Revision 1.13  2000/02/29 22:38:25  rogers
--| Removed redundent code from destroy, and added destroy_just_called :=
--| True and is_destroyed := True into destroy.
--|
--| Revision 1.12  2000/02/24 01:43:55  brendel
--| Changed postcondition on `set_parent' to be exactly the same, but without
--| using the function `parent_set'.
--|
--| Revision 1.11  2000/02/23 02:13:59  brendel
--| Changed spaces with tabs.
--|
--| Revision 1.10  2000/02/22 23:08:37  rogers
--| Added parent_set which was taken from EV_ITEM_I, and improved comment on
--| implementation feature clause.
--|
--| Revision 1.9  2000/02/19 05:44:59  oconnor
--| released
--|
--| Revision 1.8  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.7.6.5  2000/02/05 02:06:47  brendel
--| Added empty features align_text_* and destroyed.
--|
--| Revision 1.7.6.4  2000/02/03 17:18:47  brendel
--| Commented out line where parent is treated as variable.
--|
--| Revision 1.7.6.3  2000/01/27 19:30:07  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.7.6.2  1999/12/17 17:36:02  rogers
--| Altered to fit in with the review branch.
--|
--| Revision 1.7.6.1  1999/11/24 17:30:15  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.7.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
