indexing
	description:
		"Eiffel Vision multi column list row. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MULTI_COLUMN_LIST_ROW_IMP

inherit
	EV_MULTI_COLUMN_LIST_ROW_I
		redefine
			parent_imp,
			interface
		select
			pixmap
		end

	EV_ITEM_IMP
		rename
			pixmap as ev_item_imp_pixmap
		undefine
			parent,
			set_pixmap,
			remove_pixmap
		redefine
			parent_imp,
			interface,
			on_parented
		end

	EV_MULTI_COLUMN_LIST_ROW_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)is
			-- Create the row with one column by default.
			-- The sub-items start at 2. 1 is the index of
			-- the current item.
		do
			base_make (an_interface)
		end

	initialize is
			-- Initialize `Current'.
		do
			is_initialized := True
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is `Current' selected?
		do
			Result := parent_imp.internal_is_selected (Current)
		end

feature -- Status setting

	enable_select is
			-- Select `Current'.
		do
			parent_imp.internal_select (Current)
		end

	disable_select is
			-- Deselect Current.
		do
			parent_imp.internal_deselect (Current)
		end

feature {EV_ANY_I} -- Access

	index: INTEGER is
			-- Index of `Current' in `Parent_imp'.
		do
			Result := parent_imp.internal_get_index (Current)
		end

	parent_imp: EV_MULTI_COLUMN_LIST_IMP
		-- The parent of `Current'.

	on_parented is
			-- `Current' just parented.
		do
			dirty_child
			parent_imp.update_children
		end

	set_parent_imp (par_imp: like parent_imp) is
			-- Assign `par_imp' to `parent_imp'.
			--| Make `par_imp' the new parent of `Current'.
		do
			if par_imp /= Void then
				parent_imp := par_imp
			else
				parent_imp := Void
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_MULTI_COLUMN_LIST_ROW

end -- class EV_MULTI_COLUMN_LIST_ROW_IMP

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.45  2001/06/07 23:08:12  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.15.4.6  2000/08/11 19:17:41  rogers
--| Fixed copyright clause. Now use ! instead of |.
--|
--| Revision 1.15.4.5  2000/07/24 22:46:30  rogers
--| Now inherits EV_MULTI_COLUMN_LIST_ROW_ACTION_SEQUENCES_IMP.
--|
--| Revision 1.15.4.4  2000/07/13 23:38:38  rogers
--| Date in information at end.
--|
--| Revision 1.15.4.3  2000/05/18 23:09:35  rogers
--| Set_parent renamed to set_parent_imp and now takes a parameter of type
--| parent_imp.
--|
--| Revision 1.15.4.2  2000/05/04 17:47:50  rogers
--| Removed FIXME NOT_REVIWED. Removed Unecessary FIXME.
--|
--| Revision 1.15.4.1  2000/05/03 19:09:10  oconnor
--| mergred from HEAD
--|
--| Revision 1.43  2000/04/25 01:15:10  pichery
--| Removed useless (and confusing)
--| inheritance.
--|
--| Revision 1.42  2000/04/22 00:22:46  rogers
--| Formatting.
--|
--| Revision 1.41  2000/04/21 21:59:17  rogers
--| Various comments improved. Removed set_capture, release_capture,
--| set_heavy_capture, release_heavy_capture and set_pointer_style.
--|
--| Revision 1.40  2000/04/21 18:50:33  rogers
--| Removed relative_position. Relative_y is now used within the
--| parent, instead of the call to relative_position.
--|
--| Revision 1.39  2000/04/21 17:47:35  rogers
--| Removed pnd_press as it is now inherited from EV_ITEM_IMP.
--|
--| Revision 1.38  2000/04/21 16:31:57  rogers
--| Performance improvement in relative_position.
--|
--| Revision 1.37  2000/04/20 19:54:32  rogers
--| Relative_postion now uses parent_imp.get_item_position.
--|
--| Revision 1.36  2000/04/20 16:38:00  rogers
--| Removed commented inheritance, Removed redefinition of
--| destroy.
--|
--| Revision 1.35  2000/04/07 22:31:51  brendel
--| Removed EV_SIMPLE_ITEM_IMP from inheritance.
--|
--| Revision 1.34  2000/03/30 19:52:24  rogers
--| Changed all instances of:
--| 	set_source_true -> set_parent_source_true
--| 	set_pnd_child_source -> set_item_source
--| 	set_t_item_true -> set_item_source_true
--|
--| Revision 1.33  2000/03/29 19:19:19  rogers
--| Redefined on_parented from EV_ITEM_IMP so that a row which
--| had texts added before the parent was set will have it's texts
--| updated correctly. Removed redundent set_cell_text.
--|
--| Revision 1.32  2000/03/29 02:18:09  brendel
--| Removed inheritance from EV_PIXMAPABLE temporarily.
--| Added inheritance of WEL_LIST_VIEW_ITEM.
--|
--| Revision 1.31  2000/03/27 21:52:46  pichery
--| implemented new deferred features from EV_PICK_AND_DROPPABLE_IMP
--| `set_heavy_capture' and `release_heavy_capture'.
--|
--| Revision 1.30  2000/03/24 17:30:44  brendel
--| Moved update into _I.
--|
--| Revision 1.29  2000/03/23 19:36:56  brendel
--| Removed feature `toggle'.
--|
--| Revision 1.28  2000/03/23 18:18:03  brendel
--| Revised.
--| To be implemented.
--|
--| Revision 1.27  2000/03/22 20:23:40  rogers
--| Added pnd_press.
--|
--| Revision 1.26  2000/03/21 01:22:27  rogers
--| Added set_pointer_style.
--|
--| Revision 1.25  2000/03/17 23:26:50  rogers
--| Undefined set_pointer_style from EV_PICK_AND_AND_DROPABLE_IMP.
--|
--| Revision 1.24  2000/03/14 18:43:03  rogers
--| Fixed bug in relative_position.
--|
--| Revision 1.23  2000/03/13 23:17:49  rogers
--| Removed redundent command associations. Added relative_position. Changed the
--| export status of implementation features to {EV_MULTI_COLUMN_LIST_IMP}.
--|
--| Revision 1.22  2000/03/09 16:13:52  brendel
--| Added inheritance of EV_PICK_AND_DROPABLE_IMP.
--|
--| Revision 1.21  2000/03/03 19:03:32  rogers
--| Fixed set_parent by adding handling a Void argument.
--|
--| Revision 1.20  2000/03/03 00:19:50  rogers
--| Implemented set_parent and split set_selected into enable_select and
--| disable_select.
--|
--| Revision 1.19  2000/02/19 06:34:12  oconnor
--| removed old command stuff
--|
--| Revision 1.18  2000/02/19 05:44:59  oconnor
--| released
--|
--| Revision 1.17  2000/02/17 00:23:59  brendel
--| Commented out old command association code.
--|
--| Revision 1.16  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.15.6.4  2000/02/05 02:10:50  brendel
--| Removed feature `destroyed'.
--|
--| Revision 1.15.6.3  2000/01/27 19:30:08  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.15.6.2  1999/12/17 17:33:10  rogers
--| Altered to fit in with the review branch. Make takes an interface.
--| Now inherits from EV_PICK_AND_DROPABLE_IMP.
--|
--| Revision 1.15.6.1  1999/11/24 17:30:16  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.15.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
