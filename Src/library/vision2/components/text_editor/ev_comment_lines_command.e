indexing
	description: ""
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_COMMENT_LINES_COMMAND

inherit
	EV_TEXT_EDITOR_COMMAND

create
	make

feature -- Basic operation

	execute (arg: EV_ARGUMENT; a_event_data: EV_EVENT_DATA) is
			-- Execution to be done by the command.
		do
			event_data ?= a_event_data
			print ("EV CMT LNS execute%N")
			event_data.print_contents
			redo

			event_data.rich_text.select_lines (event_data.first_line, event_data.last_line)
		ensure then
			event_data_set: event_data /= Void
		end

	undo is
			-- Undo the effect of the command execution.
		local
			i: INTEGER
			editor: EV_TEXT_EDITOR
		do
			editor ?= event_data.rich_text

			check
				valid_cast: editor /= Void
			end
			
			editor.decomment_lines (event_data.first_line, event_data.last_line)
		end

	redo is
			-- Redo the effect of the command execution.
		local
			i: INTEGER
			editor: EV_TEXT_EDITOR
		do
			editor ?= event_data.rich_text

			check
				valid_cast: editor /= Void
			end
			
			editor.comment_lines (event_data.first_line, event_data.last_line)
		end

feature -- Debug

	print_contents is
		do
			event_data.print_contents
		end


feature {NONE} -- Implementation

	event_data: EV_LINE_RANGE_EVENT_DATA
	
end -- class EV_COMMENT_LINES_COMMAND

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
