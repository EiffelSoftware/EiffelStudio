--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision list item. Mswindows implementation."
	status: "See notice at end of class"
	id: "$$"
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

	EV_SIMPLE_ITEM_IMP
		undefine
			parent
		redefine
			parent_imp,
			interface
		end

	EV_SYSTEM_PEN_IMP
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the widget with `par' as parent.
		do
			base_make (an_interface)
		end

	initialize is
		do
			is_initialized := True
		end

feature -- Access

	index: INTEGER is
			-- Index of the current item.
		do
			Result := parent_imp.internal_get_index (Current) + 1
		end

	parent_imp: EV_LIST_ITEM_HOLDER_IMP
	
	set_parent (par: like parent) is
                      -- Make `par' the new parent of the widget.
                      -- `par' can be Void then the parent is the screen.
              do
				if par /= Void then
					parent_imp ?= par.implementation
				else
					parent_imp := Void
				end
              end


--|FIXME implement as now pick and dropable

	set_capture is
		do
			check
				to_be_implemented: FALSE
			end
		end

	release_capture is
		do
			check
				to_be_implemented: FALSE
			end
		end

feature -- Status report

	text: STRING

	is_selected: BOOLEAN is
			-- Is the item selected
		do
			Result := parent_imp.internal_is_selected (Current)
		end

	is_first: BOOLEAN is
			-- Is the item first in the list ?
		do
			Result := (index = 1)
		end

	is_last: BOOLEAN is
			-- Is the item last in the list ?
		do
			Result := (index = parent_imp.count)
		end
	
feature -- Status setting

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		do
			if flag then
				parent_imp.internal_select_item (Current)
			else
				parent_imp.internal_deselect_item (Current)
			end
		end

	toggle is
			-- Change the state of the toggle button to
			-- opposit status.
		do
			set_selected (not is_selected)
		end

feature -- Element change

	set_text (txt: STRING) is
			-- Make `txt' the new label of the item.
		do
			text := clone (txt)
			if parent_imp /= Void then
				parent_imp.internal_set_text (Current.interface, clone (txt))
			end
		end

feature {EV_LIST_IMP} -- Implementation.

	relative_y: INTEGER is
			-- `Result' is relative y coordinate in pixels to parent.
		require
			parent_not_void: parent_imp /= Void
		local
			list_imp: EV_LIST_IMP
		do
			list_imp ?= parent_imp
			check
				Parent_is_a_list_imp : list_imp /= Void
			end
			Result := (index - list_imp.top_index - 1) * list_imp.item_height
		end

feature -- Event : command association

--|FIXME	add_select_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
--|FIXME			-- Add `cmd' to the list of commands to be executed
--|FIXME			-- when the item is selected.
--|FIXME		do
--|FIXME			add_command (Cmd_item_activate, cmd, arg)			
--|FIXME		end	

--|FIXME	add_unselect_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
--|FIXME			-- Add `cmd' to the list of commands to be executed
--|FIXME			-- when the item is unselected.
--|FIXME		do
--|FIXME			add_command (Cmd_item_deactivate, cmd, arg)		
--|FIXME		end

--|FIXME	add_double_click_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
--|FIXME			-- Add 'cmd' to the list of commands to be executed
--|FIXME			-- when the item is double clicked.
--|FIXME		do
--|FIXME			add_command (Cmd_item_dblclk, cmd, arg)
--|FIXME		end	

feature -- Event -- removing command association

--|FIXME	remove_select_commands is
--|FIXME			-- Empty the list of commands to be executed when
--|FIXME			-- the item is selected.
--|FIXME		do
--|FIXME			remove_command (Cmd_item_activate)			
--|FIXME		end	

--|FIXME	remove_unselect_commands is
--|FIXME			-- Empty the list of commands to be executed when
--|FIXME			-- the item is unselected.
--|FIXME		do
--|FIXME			remove_command (Cmd_item_deactivate)		
--|FIXME		end

--|FIXME	remove_double_click_commands is
--|FIXME			-- Empty the list of commands to be executed when
--|FIXME			-- the item is double-clicked.
--|FIXME		do
--|FIXME			remove_command (Cmd_item_dblclk)
--|FIXME		end

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
--| Revision 1.32  2000/03/15 16:51:53  rogers
--| Removed commented out destroyed;. Added relative_y which returns the relative coordinate of the item to its parent.
--|
--| Revision 1.31  2000/03/10 00:32:00  rogers
--| Added set_capture and release_capture with a fixme and a check False so they compile. They need to be fixed.
--|
--| Revision 1.30  2000/03/02 16:58:33  rogers
--| Set_text now sets the text to a clone of the passed text.
--|
--| Revision 1.29  2000/03/01 16:37:54  rogers
--| Changed type of parent_imp from EV_LIST_IMP to EV_LIST_ITEM_HOLDER_IMP.
--|
--| Revision 1.28  2000/02/25 17:44:27  rogers
--| Removed call to precursor in set_text, and replaced with text := txt as text is now an attribute of this class directly.
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
--| Removed commented make_with_text references. changed the type of parent_imp from EV_LIST_ITEM_HOLDER_IMP to EV_LIST_IMP.
--|
--| Revision 1.24.6.4  2000/01/27 19:30:07  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.24.6.3  2000/01/18 23:39:01  rogers
--| The body of set_text had been commented out. It has been uncommented as it is required.
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
