--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "Text editor history."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TEXT_EDITOR_HISTORY

inherit
	EV_LINKED_HISTORY
		redefine
			undo,
			redo
		end
	
create
	make

feature {NONE} -- Initialization

feature -- Basic operations


	undo is
			-- Undo the last recorded command
		local
			insert_text_cmd: EV_INSERT_TEXT_COMMAND
		do
			insert_text_cmd ?= next_undo_command
			{EV_LINKED_HISTORY} Precursor

				-- Group single (non seperator) characters together (Smart Undo).
			from
			until
				not (can_undo and then
				insert_text_cmd /= Void and then 
				not insert_text_cmd.is_separator)
			loop
				insert_text_cmd ?= next_undo_command
				
				if
					insert_text_cmd /= Void and then not insert_text_cmd.is_separator
				then
					{EV_LINKED_HISTORY} Precursor
				end
				
			end
		end

	redo is
			-- Redo the last undone command
		local
			insert_text_cmd: EV_INSERT_TEXT_COMMAND
		do
			insert_text_cmd ?= next_redo_command
			{EV_LINKED_HISTORY} Precursor

				-- Group single (non seperator) characters together (Smart Undo).
			from
			until
				not (can_redo and then
				insert_text_cmd /= Void and then 
				not insert_text_cmd.is_separator)
			loop
				insert_text_cmd ?= next_redo_command
				
				if
					insert_text_cmd /= Void and then not insert_text_cmd.is_separator
				then
					{EV_LINKED_HISTORY} Precursor
				end
				
			end
		end

feature {NONE} -- Implementation

end -- class EV_TEXT_EDITOR_HISTORY

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
--| Revision 1.4  2000/02/14 11:40:25  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.6.2  2000/01/27 19:29:24  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.6.1  1999/11/24 17:29:40  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.2  1999/11/02 17:20:01  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
