--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision multi-column list row. These rows are used in %
		%the multi-column lists."
	status: "See notice at end of class"
	note: "It is not an item because it doesn't have the same options."
	date: "$Date$";
	revision: "$Revision$"

class
	EV_MULTI_COLUMN_LIST_ROW

inherit
	EV_COMPOSED_ITEM
		rename
			count as columns,
			set_count as set_columns
		redefine
	--		parent,
			implementation,
			create_action_sequences
		end

	EV_PICK_AND_DROPABLE
		redefine
			implementation,
			create_action_sequences
		end

create
	default_create,
	make_with_text

feature -- Status report
	
	is_selected: BOOLEAN is
			-- Is the item selected
		require
			has_parent: parent /= Void
		do
			Result := implementation.is_selected
		end

feature -- Status setting

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		require
			has_parent: parent /= Void
		do
			implementation.set_selected (flag)
		ensure
			state_set: is_selected = flag
		end

	toggle is
			-- Change the state of selection of the item.
		require
			has_parent: parent /= Void
		do
			implementation.toggle
		end

feature -- Event : command association

	add_select_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is selected.
		obsolete "Use action sequence instead"
		do
			--FIXME implementation.add_select_command (cmd, arg)
		end

	add_unselect_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the item is unselected.
		obsolete "Use action sequence instead"
		do
			--FIXME implementation.add_unselect_command (cmd, arg)		
		end

	add_button_press_command (mouse_button: INTEGER; 
		 cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when button number 'mouse_button' is pressed.
		obsolete "Use action sequence instead"
		do
			--FIXME implementation.add_button_press_command (mouse_button, cmd, arg)
		end

	add_button_release_command (mouse_button: INTEGER;
		    cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when button number 'mouse_button' is released.
		obsolete "Use action sequence instead"
		do
		--FIXME	implementation.add_button_release_command (mouse_button, cmd, arg)
		end

feature -- Event -- removing command association

	remove_select_commands is
			-- Empty the list of commands to be executed when
			-- the item is selected.
		obsolete "Use action sequence instead"
		do
			--FIXME implementation.remove_select_commands			
		end

	remove_unselect_commands is
			-- Empty the list of commands to be executed when
			-- the item is unselected.
		obsolete "Use action sequence instead"
		do
			--FIXME implementation.remove_unselect_commands	
		end

	remove_button_press_commands (mouse_button: INTEGER) is
			-- Empty the list of commands to be executed when
			-- button number 'mouse_button' is pressed.
		obsolete "Use action sequence instead"
		do
			--FIXME implementation.remove_button_press_commands (mouse_button)
		end

	remove_button_release_commands (mouse_button: INTEGER) is
			-- Empty the list of commands to be executed when
			-- button number 'mouse_button' is released.
		obsolete "Use action sequence instead"
		do
			--FIXME implementation.remove_button_release_commands (mouse_button)
		end

feature -- Implementation

	implementation: EV_MULTI_COLUMN_LIST_ROW_I
			-- Platform dependent access.

	create_implementation is 
			-- Create `implementation'.
		do
			create {EV_MULTI_COLUMN_LIST_ROW_IMP} implementation.make (Current)
		end

	create_action_sequences is
		do
			{EV_COMPOSED_ITEM} Precursor
		end

end -- class EV_MULTI_COLUMN_LIST_ROW

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
--| Revision 1.19  2000/02/14 11:40:47  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.18.6.5  2000/02/02 23:49:03  king
--| Obsolete command association routines
--|
--| Revision 1.18.6.4  2000/01/29 01:05:04  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.18.6.3  2000/01/27 19:30:36  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.18.6.2  1999/12/17 21:14:50  rogers
--| Now inherits EV_PICK_AND_DROPABLE instead of EV_PND_SOURCE and EV_PND_TARGET. Make and make_with_text ahve been removed. Thwy will need to be re-implemented. The addition and removal of commands have been commented, ready for re-implementation.
--|
--| Revision 1.18.6.1  1999/11/24 17:30:42  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.18.2.3  1999/11/04 23:10:51  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.18.2.2  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
