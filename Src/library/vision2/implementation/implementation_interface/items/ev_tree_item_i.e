--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision tree item, implementation interface.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_TREE_ITEM_I

inherit
	EV_SIMPLE_ITEM_I
		redefine
			parent,
			interface
		end

	EV_TREE_ITEM_HOLDER_I
		redefine
			interface
		end

	EV_PICK_AND_DROPABLE_I
		redefine
			interface
		end

feature -- Access

	parent: EV_TREE_ITEM_HOLDER is
			-- The parent of the Current widget
			-- Can be void.
		do
			Result ?= {EV_SIMPLE_ITEM_I} Precursor
		end

	top_parent_imp: EV_TREE_IMP is
			-- Top item holder containing the current item.
		local
			itm: EV_TREE_ITEM_IMP
		do
			itm ?= parent_imp
			if itm = Void then
				Result ?= parent_imp
			else
				Result := itm.top_parent_imp
			end
		end

	top_parent: EV_TREE_ITEM_HOLDER is
		do
			if top_parent_imp /= Void then
				Result := top_parent_imp.interface
			end
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected?
		require
			in_widget: top_parent_imp /= Void
		deferred
		end

	is_expanded: BOOLEAN is
			-- is the item expanded ?
		require
			in_widget: top_parent_imp /= Void
		deferred
		end

	is_parent: BOOLEAN is
			-- is the item the parent of other items?
		require
		deferred
		end

feature -- Status setting

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		require
			in_widget: top_parent_imp /= Void
		deferred
		ensure
 			state_set: is_selected = flag
		end

	toggle is
			-- Change the state of selection of the item.
		require
			in_widget: top_parent_imp /= Void
		do
			set_selected (not is_selected)
		end

	set_expand (flag: BOOLEAN) is
			-- Expand the item if `flag', collapse it otherwise.
		require
			in_widget: top_parent_imp /= Void
			is_parent: is_parent
		deferred
		ensure
			state_set: is_expanded = flag
		end

feature -- Event : command association

	add_select_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is activated.
		require
			valid_command: cmd /= Void
		deferred
		end	

	add_unselect_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is unactivated.
		require
			valid_command: cmd /= Void
		deferred
		end	

	add_subtree_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the selection subtree is expanded or collapsed.
		require
			valid_command: cmd /= Void
		deferred
		end

feature -- Event -- removing command association

	remove_select_commands is
			-- Empty the list of commands to be executed when
			-- the item is activated.
		require
		deferred			
		end	

	remove_unselect_commands is
			-- Empty the list of commands to be executed when
			-- the item is deactivated.
		require
		deferred	
		end

	remove_subtree_commands is
			-- Empty the list of commands to be executed when
			-- the selection subtree is expanded or collapsed.
		require
		deferred
		end

	interface: EV_TREE_ITEM

end -- class EV_TREE_ITEM_I

--!----------------------------------------------------------------
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
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.23  2000/02/14 11:40:34  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.22.6.3  2000/01/27 19:29:53  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.22.6.2  1999/12/17 19:06:03  rogers
--| redefined interface to be a a more refined type. EV_PICK_AND_DROPABLE_I replaces EV_PND_SOURCE and EV_PND_TARGET. Added top_parent.
--|
--| Revision 1.22.6.1  1999/11/24 17:30:04  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.22.2.3  1999/11/04 23:10:33  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.22.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
