--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "Notion of a composite command, that is a command that%
					 %groups one or more unduable commands together."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_COMPOSITE_COMMAND

inherit
	EV_UNDOABLE_COMMAND

create
	make

feature {NONE} -- Initialization

	make is
			-- Create a composite command
		do
--			create {TWO_WAY_LIST} children.make
		ensure
			children /= Void
		end
feature -- Access

	history: EV_HISTORY is
			-- History in which Current command is to be recorded
		do
			check
				To_be_implemented: False
			end
		end

feature -- Basic operation

--	add_command (event_id: INTEGER; cmd: EV_COMMAND; arg: EV_ARGUMENT) is

	execute (arg: EV_ARGUMENT; a_event_data: EV_EVENT_DATA) is
			-- Execution to be done by the command.
		do
			check
				False
			end
			from
				children.start
			until
				children.off
			loop
				children.item.execute (arg, a_event_data)
				children.forth
			end
		end

	undo is
			-- Undo the effect of the command execution.
		do
			from
				children.start
			until
				children.off
			loop
				children.item.undo
				children.forth
			end
		end

	redo is
			-- Redo the effect of the command execution.
		do
			from
				children.start
			until
				children.off
			loop
				children.item.redo
				children.forth
			end
		end

	failed: BOOLEAN is
			-- Was the command execution succesful?
		do
			check
				To_be_implemented: False
			end
		end

feature -- Debug

	print_contents is
		do
			from
				children.start
			until
				children.off
			loop
--				children.item.print_contents
--				children.forth
			end
		end


feature {NONE} -- Implementation

	children: DYNAMIC_LIST [EV_UNDOABLE_COMMAND]
	
invariant

	children_not_void: children /= Void

end -- class EV_COMPOSITE_COMMAND

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
--| Revision 1.5  2000/02/14 11:40:48  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.2  2000/01/27 19:30:43  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.1  1999/11/24 17:30:45  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.2  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
