--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision multi-column list row, mswindows implementation"
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
		end

	EV_COMPOSED_ITEM_IMP
		rename
			count as columns,
			set_count as set_columns
		undefine
			parent
		redefine
			destroy,
			set_cell_text,
			parent_imp,
			interface
		end

	EV_PICK_AND_DROPABLE_IMP
		undefine
			set_pointer_style
		redefine
			interface,
			pnd_press
		end

create
	make

feature -- Access

--|FIXME

	pnd_press (a_x, a_y, a_button, a_screen_x, a_screen_y: INTEGER) is
		local
			multi_column_list_imp: EV_MULTI_COLUMN_LIST_IMP
		do
			multi_column_list_imp := parent_imp
			if press_action = Ev_pnd_start_transport then
				start_transport (a_x, a_y, a_button, 0, 0, 0.5, a_screen_x, a_screen_y)
				multi_column_list_imp.set_source_true
				multi_column_list_imp.set_pnd_child_source (Current)
				multi_column_list_imp.set_t_item_true
			elseif press_action = Ev_pnd_end_transport then
				end_transport (a_x, a_y, a_button)
				multi_column_list_imp.set_source_false
				multi_column_list_imp.set_pnd_child_source (Void)
				multi_column_list_imp.set_t_item_false
			else
				multi_column_list_imp.set_source_false
				multi_column_list_imp.set_pnd_child_source (Void)
				multi_column_list_imp.set_t_item_false
				check
					disabled: press_action = Ev_pnd_disabled
				end
			end
		end

	index: INTEGER is
			-- Index of the current item.
		do
			Result := parent_imp.internal_get_index (Current)
		end

	parent_imp: EV_MULTI_COLUMN_LIST_IMP

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected?
		do
			Result := parent_imp.internal_is_selected (Current)
		end

feature -- Status setting

	set_parent (par: like parent) is
			-- Make `par' the new parent of the widget.
		do
			if par /= Void then
				parent_imp ?= par.implementation
			else
				parent_imp := Void
			end
		end

	destroy is
			-- Destroy the actual object.
		do
			{EV_COMPOSED_ITEM_IMP} Precursor
			internal_text := Void
		end

	enable_select is
			-- Select Current.
		do
			parent_imp.internal_select (Current)
		end

	disable_select is
			-- Deselect Current.
		do
			parent_imp.internal_deselect (Current)
		end

feature -- Element Change

	set_cell_text (column: INTEGER; txt: STRING) is
			-- Make `text ' the new label of the `column'-th
			-- cell of the row.
		do
			{EV_COMPOSED_ITEM_IMP} Precursor (column, txt)
			if parent_imp /= Void then
				parent_imp.set_cell_text (column - 1, index - 1, txt)
			end
		end

feature {EV_PICK_AND_DROPABLE_I} -- Pick and Drop

	set_pointer_style (c: EV_CURSOR) is
		--| FIXME Still under progress 
		do
			if parent_imp /= Void then
				parent_imp.set_pointer_style (c)
			end
		end

feature {EV_MULTI_COLUMN_LIST_IMP} -- Implementation

	set_capture is
			-- Grab user input.
		do
			parent_imp.set_capture
		end

	release_capture is
			-- Release user input.
		do
			parent_imp.release_capture
		end

	relative_position: TUPLE [INTEGER, INTEGER] is
			-- Position relative to `Parent'.
		do
			create Result.make
			Result.put (parent_imp.child_x, 1)
			Result.put (parent_imp.child_y (Current), 2)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_MULTI_COLUMN_LIST_ROW

end -- class EV_MULTI_COLUMN_LIST_ROW_IMP

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
--| Removed redundent command associations. Added relative_position. Changed the export status of implementation features to {EV_MULTI_COLUMN_LIST_IMP}.
--|
--| Revision 1.22  2000/03/09 16:13:52  brendel
--| Added inheritance of EV_PICK_AND_DROPABLE_IMP.
--|
--| Revision 1.21  2000/03/03 19:03:32  rogers
--| Fixed set_parent by adding handling a Void argument.
--|
--| Revision 1.20  2000/03/03 00:19:50  rogers
--| Implemented set_parent and split set_selected into enable_select and disable_select.
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
--| Altered to fit in with the review branch. Make takes an interface. Now inherits from EV_PICK_AND_DROPABLE_IMP.
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
