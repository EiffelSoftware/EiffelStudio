indexing
	description: ""
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DELETE_TEXT_COMMAND

inherit
	EV_TEXT_EDITOR_COMMAND

creation
	make

feature -- Basic operation

	execute (arg: EV_ARGUMENT; a_event_data: EV_EVENT_DATA) is
			-- Execution to be done by the command.
		do
			event_data ?= a_event_data
			print ("EV DEL TXT execute%N")
			print_contents
		ensure then
			event_data_set: event_data /= Void
		end

	undo is
			-- Undo the effect of the command execution.
		do
			print ("EV DEL TXT undo%N")
			print_contents
			event_data.rich_text.set_position (event_data.start_position)
			event_data.rich_text.insert_text (event_data.text)
			event_data.rich_text.set_position (event_data.cursor_position)
		end

	redo is
			-- Redo the effect of the command execution.
		do
			event_data.rich_text.remove_text (event_data.start_position, event_data.end_position )
		end

feature -- Debug

	print_contents is
		do
			event_data.print_contents
		end


feature {NONE} -- Implementation

	event_data: EV_DELETE_TEXT_EVENT_DATA
	
end -- class EV_DELETE_TEXT_COMMAND

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
