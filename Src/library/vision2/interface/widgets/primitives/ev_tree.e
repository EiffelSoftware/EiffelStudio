--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: 
		"EiffelVision tree. A tree show a hierarchy with%
		% several levels of items."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TREE

inherit
	EV_PRIMITIVE
		redefine
			implementation
		end

	EV_TREE_ITEM_HOLDER
		undefine
			create_action_sequences
		redefine
			implementation
		end

feature -- Access

	selected_item: EV_TREE_ITEM is
			-- Item which is currently selected.
		require
		do
			Result := implementation.selected_item
		end

	total_count: INTEGER is
			-- Total number of items in the tree.
		require
		do
			Result := implementation.total_count
		ensure
			positive_result: Result >= 0
		end

feature -- Status report

	selected: BOOLEAN is
			-- Is one item selected ?
		require
		do
			Result := implementation.selected
		end

feature -- Event : command association

	add_select_command (a_command: EV_COMMAND; arguments: EV_ARGUMENT) is	
			-- Add `cmd' to the list of commands to be executed
			-- when an item has been selected.
		require
		do
			--FIXME implementation.add_select_command (a_command, arguments)
		end

	add_unselect_command (a_command: EV_COMMAND; arguments: EV_ARGUMENT) is	
			-- Add `cmd' to the list of commands to be executed
			-- when an item has been unselected.
		require
		do
			--FIXME implementation.add_unselect_command (a_command, arguments)
		end

feature -- Event -- removing command association

	remove_select_commands is	
			-- Empty the list of commands to be executed
			-- when an item has been selected.
		require
		do
			--FIXME implementation.remove_select_commands
		end

	remove_unselect_commands is	
			-- Empty the list of commands to be executed
			-- when an item has been unselected.
		require
		do
			--FIXME implementation.remove_unselect_commands
		end

feature -- Implementation
	
	implementation: EV_TREE_I	
			-- Platform dependent access.

	create_implementation is
			-- Create implementation of tree
		do
			create {EV_TREE_IMP} implementation.make (Current)
		end

end -- class EV_TREE

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
--| Revision 1.15  2000/02/14 11:40:53  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.14.6.4  2000/01/27 19:30:58  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.14.6.3  2000/01/16 23:36:40  oconnor
--| formatting
--|
--| Revision 1.14.6.2  1999/12/17 19:23:32  rogers
--| the addition and removal of commands needs to be fixed so that they use the
--| new action sequences.
--|
--| Revision 1.14.6.1  1999/11/24 17:30:56  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.14.2.3  1999/11/04 23:10:55  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.14.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
