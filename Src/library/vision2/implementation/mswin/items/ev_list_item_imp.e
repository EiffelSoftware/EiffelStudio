--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "Eiffel Vision list item. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_LIST_ITEM_IMP

inherit
	EV_LIST_ITEM_I
		redefine
			parent_imp,
			interface
		end

	EV_ITEM_IMP
		undefine
			parent,
			set_pointer_style
		redefine
			parent_imp,
			interface,
			pnd_press
		end

	EV_TEXTABLE_IMP
		redefine
			interface
		end

	WEL_LIST_VIEW_ITEM
		rename
			make as wel_make,
			text as wel_text,
			set_text as wel_set_text
		end

	WEL_LVM_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the widget with `par' as parent.
		do
			wel_make
			base_make (an_interface)
		end

	initialize is
			-- Initialize the item.
		do
			is_initialized := True
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected
		do
			Result := parent_imp.internal_is_selected (Current)
		end

feature -- Status setting

	enable_select is
			-- Set `is_selected' `True'.
		do
			parent_imp.internal_select (Current)
		end

	disable_select is
			-- Set `is_selected' `False'.
		do
			parent_imp.internal_deselect (Current)
		end

feature {EV_ANY_I} -- Access

	pnd_press (a_x, a_y, a_button, a_screen_x, a_screen_y: INTEGER) is
		local
			list_imp: EV_LIST_IMP
		do
			list_imp ?= parent_imp
			check
				parent_not_void: list_imp /= Void
			end
			if press_action = Ev_pnd_start_transport then
				start_transport (a_x, a_y, a_button, 0, 0, 0.5, a_screen_x,
					a_screen_y)
				list_imp.set_parent_source_true
				list_imp.set_item_source (Current)
				list_imp.set_item_source_true
			elseif press_action = Ev_pnd_end_transport then
				end_transport (a_x, a_y, a_button)
				list_imp.set_parent_source_false
				list_imp.set_item_source (Void)
				list_imp.set_item_source_false
			else
				list_imp.set_parent_source_false
				list_imp.set_item_source (Void)
				list_imp.set_item_source_false
				check
					disabled: press_action = Ev_pnd_disabled
				end
			end
		end

	index: INTEGER is
			-- One-based Index of the current item.
		do
			Result := parent_imp.internal_get_index (Current)
		end

	parent_imp: EV_LIST_IMP
		-- Parent of `Current'
	
	set_parent (par: like parent) is
			-- Assign `a_parent' to `parent'.
		do
			if par /= Void then
				parent_imp ?= par.implementation
			else
				parent_imp := Void
			end
		end

feature {EV_PICK_AND_DROPABLE_I} -- Pick and Drop

	set_pointer_style (c: EV_CURSOR) is
			-- Assign `c' to `parent_imp' pointer style.
		do
			if parent_imp /= Void then
				parent_imp.set_pointer_style (c)
			end
		end

feature {EV_LIST_IMP} -- Implementation.

	relative_y: INTEGER is
			-- `Result' is relative y coordinate in pixels to parent.
		require
			parent_not_void: parent_imp /= Void
		local
			wel_point: WEL_POINT
		do
			Result := parent_imp.get_item_position (index - 1).y
		end

	is_displayed: BOOLEAN is
			-- Can the user view `Current'?
		local
			local_index: INTEGER
			first_index: INTEGER -- first displayed index
			last_index: INTEGER	-- last displayed index
		do
			if parent_imp /= Void then
				local_index := index - 1
				first_index := parent_imp.top_index
				last_index := first_index + parent_imp.visible_count

				Result := (local_index >= first_index and
						   local_index < last_index)
			end
		end

feature {EV_LIST_IMP} -- Implementation

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

	set_heavy_capture is
			-- Grab user input.
		do
			parent_imp.set_heavy_capture
		end

	release_heavy_capture is
			-- Release user input.
		do
			parent_imp.release_heavy_capture
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_LIST_ITEM

end -- class EV_LIST_ITEM_IMP

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
--| Revision 1.48  2000/04/19 01:28:05  pichery
--| Fixed bugs...
--|
--| Revision 1.47  2000/04/18 21:19:47  pichery
--| Changed the implementation of EV_LIST_IMP. It now
--| inherit from WEL_LIST_VIEW instead of WEL_LIST_BOX.
--|
--| Adapted EV_LIST_ITEM to take that into account. Added
--| inheritance from WEL_LIST_VIEW_ITEM.
--|
--| Revision 1.46  2000/04/07 22:31:51  brendel
--| Removed EV_SIMPLE_ITEM_IMP from inheritance.
--|
--| Revision 1.45  2000/03/30 19:51:35  rogers
--| Changed all instances of:
--| 	set_source_true -> set_parent_source_true
--| 	set_pnd_child_source -> set_item_source
--| 	set_t_item_true -> set_item_source_true
--|
--| Revision 1.44  2000/03/30 17:46:30  brendel
--| Changed type of parent_imp to EV_LIST_ITEM_LIST_IMP.
--| `relative_y' now uses `displayed_index'.
--|
--| Revision 1.43  2000/03/30 16:35:52  rogers
--| Changed parent_imp from EV_LIST_IMP to
--| EV_ITEM_LIST_IMP [EV_LIST_ITEM]
--|
--| Revision 1.42  2000/03/29 22:13:09  brendel
--| Implemented `set_text'.
--| Clean-up.
--|
--| Revision 1.41  2000/03/29 20:25:17  brendel
--| Implemented using new _I.
--| To be cleaned up.
--|
--| Revision 1.40  2000/03/29 02:17:16  brendel
--| Commented out features that have no routine body anyway.
--| To be implemented.
--|
--| Revision 1.39  2000/03/28 00:17:00  brendel
--| Revised `text' related features as specified by new EV_TEXTABLE_IMP.
--|
--| Revision 1.38  2000/03/27 21:52:46  pichery
--| implemented new deferred features from EV_PICK_AND_DROPPABLE_IMP
--| `set_heavy_capture' and `release_heavy_capture'.
--|
--| Revision 1.37  2000/03/22 20:24:29  rogers
--| Removed press_action := ev_pnd_start_transport from initialize.
--|
--| Revision 1.36  2000/03/21 01:20:53  rogers
--| Redefined set_pointer_style, so the parent_imp pointer style is called.
--|
--| Revision 1.35  2000/03/20 22:34:12  rogers
--| Renamed set_child_source -> set_pnd_child_source.
--|
--| Revision 1.34  2000/03/17 23:29:01  rogers
--| Implemented pnd_press, set_capture and release_capture.
--|
--| Revision 1.33  2000/03/15 17:17:02  rogers
--| Improved comments and removed old command association.
--|
--| Revision 1.32  2000/03/15 16:51:53  rogers
--| Removed commented out destroyed;. Added relative_y which returns the
--| relative coordinate of the item to its parent.
--|
--| Revision 1.31  2000/03/10 00:32:00  rogers
--| Added set_capture and release_capture with a fixme and a check False so
--| they compile. They need to be fixed.
--|
--| Revision 1.30  2000/03/02 16:58:33  rogers
--| Set_text now sets the text to a clone of the passed text.
--|
--| Revision 1.29  2000/03/01 16:37:54  rogers
--| Changed type of parent_imp from EV_LIST_IMP to EV_LIST_ITEM_HOLDER_IMP.
--|
--| Revision 1.28  2000/02/25 17:44:27  rogers
--| Removed call to precursor in set_text, and replaced with text := txt as
--| text is now an attribute of this class directly.
--|
--| Revision 1.27  2000/02/19 06:23:05  oconnor
--| removed command stuff
--|
--| Revision 1.26  2000/02/19 05:44:59  oconnor
--| released
--|
--| Revision 1.25  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.24.6.6  2000/02/07 19:04:15  king
--| Commented out useless destroy feature
--|
--| Revision 1.24.6.5  2000/02/02 21:08:45  rogers
--| Removed commented make_with_text references. changed the type of
--| parent_imp from EV_LIST_ITEM_HOLDER_IMP to EV_LIST_IMP.
--|
--| Revision 1.24.6.4  2000/01/27 19:30:07  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.24.6.3  2000/01/18 23:39:01  rogers
--| The body of set_text had been commented out. It has been uncommented as it
--| is required.
--|
--| Revision 1.24.6.2  1999/12/17 17:35:07  rogers
--| Altered to fit in with the review branch. Make takes an interface.
--|
--| Revision 1.24.6.1  1999/11/24 17:30:15  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.24.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
