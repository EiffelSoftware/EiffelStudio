--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "Linked infinite history."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_LINKED_HISTORY

inherit
	EV_HISTORY
	
create
	make

feature {NONE} -- Initialization

	make is
		do
			create {TWO_WAY_LIST [EV_UNDOABLE_COMMAND]} list.make
		end
feature -- Access


	can_undo: BOOLEAN is
		do
			Result := not list.empty and not list.before
		end
		
	can_redo: BOOLEAN is
		do
			Result := not list.empty and not list.islast
		end


	next_undo_command: EV_UNDOABLE_COMMAND is
			-- Returns the command that is next in the undo queue
		do
			Result := list.item
		end

	next_redo_command: EV_UNDOABLE_COMMAND is
			-- Returns the command that is next in the redo queue
		do
			list.forth
			Result := list.item
			list.back
		end

feature -- Basic operations


	record (cmd: EV_UNDOABLE_COMMAND) is
			-- Record `cmd' in Current history.
		do
			remove_all_right_list_items
			list.extend (cmd)
			list.forth
		ensure then
			can_undo: can_undo
			can_not_redo: not can_redo
		end

	undo is
			-- Undo the last recorded command
		do
			list.item.undo
			list.back
		end

	redo is
			-- Redo the last undone command
		do
			list.forth
			list.item.redo
		end

	fake_undo is
			-- Moves the history cursor to the next undo position,
			-- but does not execute the command.
		do
			list.back
		end

	fake_redo is
			-- Moves the history cursor to the next redo position,
			-- but does not execute the command.
		do
			list.forth
		end

feature {NONE} -- Implementation

	list: DYNAMIC_LIST [EV_UNDOABLE_COMMAND]
	
	remove_all_right_list_items is
		do
			from
			variant
				list.count
			until
				list.islast or list.empty
			loop
				list.remove_right
			end
		end

end -- class EV_LINKED_HISTORY

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
--| Revision 1.3  2000/02/14 11:40:24  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.2.6.2  2000/01/27 19:29:22  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.2.6.1  1999/11/24 17:29:39  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.2.2  1999/11/02 17:20:01  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
