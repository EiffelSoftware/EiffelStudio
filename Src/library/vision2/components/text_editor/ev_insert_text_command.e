--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: ""
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_INSERT_TEXT_COMMAND

inherit
	EV_TEXT_EDITOR_COMMAND

create
	make

feature -- Access

	is_separator: BOOLEAN is
		local
			chr: CHARACTER
		do
			if
				event_data.text.count = 1
			then
				chr := event_data.text.item (1) 
				Result := not chr.is_digit and not chr.is_alpha
			else
				Result := True
			end
		end

feature -- Basic operation

	execute (arg: EV_ARGUMENT; a_event_data: EV_EVENT_DATA) is
			-- Execution to be done by the command.
		local
			editor: EV_TEXT_EDITOR
		do
			event_data ?= a_event_data
--			print ("EV INS TXT execute%N")
--			event_data.print_contents
			editor ?= event_data.rich_text
			check
				editor /= Void
			end
			
			--editor.update_highlighting_lines_from_character_position (event_data.position, event_data.position + event_data.text.count)
			--editor.update_highlighting_all
		ensure then
			event_data_set: event_data /= Void
		end

	undo is
			-- Undo the effect of the command execution.
		do
			event_data.rich_text.remove_text (event_data.position, event_data.position + 
														 event_data.text.count - 1)
		end

	redo is
			-- Redo the effect of the command execution.
		do
			event_data.rich_text.set_position 
										(event_data.position)
			event_data.rich_text.insert_text	(event_data.text)
		end

feature -- Debug

	print_contents is
		do
			event_data.print_contents
		end


feature {NONE} -- Implementation

	event_data: EV_INSERT_TEXT_EVENT_DATA
	
end -- class EV_INSERT_CHARACTER_COMMAND

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
--| Revision 1.4  2000/02/14 11:40:24  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.6.2  2000/01/27 19:29:23  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.6.1  1999/11/24 17:29:39  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.2  1999/11/02 17:20:01  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
