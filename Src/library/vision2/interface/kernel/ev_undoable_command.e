indexing
	description: "General notion of undoable command."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_UNDOABLE_COMMAND

inherit
	EV_COMMAND
		rename
			execute as internal_execute
		end

feature -- Access

	history: EV_HISTORY is
			-- History in which Current command is to be recorded
		deferred
		ensure
			Result_exists: Result /= Void
		end

feature -- Basic operation

	execute (arg: EV_ARGUMENT; event_data: EV_EVENT_DATA) is
			-- Execution to be done by the command.
		deferred
		end

	undo is
			-- Undo the effect of the command execution.
		deferred
		end

	redo is
			-- Redo the effect of the command execution.
		deferred
		end

feature -- Basic operation

	update_history is
			-- Update history.
			-- Default action is to record Current command in the
			-- history.
		require
			valid_history: history /= Void
		do
			history.record (Current)
		end

	failed: BOOLEAN is
			-- Was the command execution succesful?
		deferred
		end

feature {NONE} -- Implementation

	internal_execute (arg: EV_ARGUMENT; event_data: EV_EVENT_DATA) is
			-- Execution feature called internaly.
		do
			execute (arg, event_data)
			if not failed then
				update_history
			end
		end

end -- class EV_UNDOABLE_COMMAND

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
