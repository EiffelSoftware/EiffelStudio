indexing

	description: "General notion of undoable command"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	UNDOABLE 

inherit

	COMMAND;
	SCROLLABLE_LIST_ELEMENT
		rename
			value as name
		end

feature -- Access

	history: HISTORY is
			-- History in which Current command
			-- is to be recorded
		deferred
		ensure
			Result_exists: Result /= Void
		end;

	name: STRING is
			-- Name of Current command
		deferred
		end

feature -- Update

	redo is
			-- Re-execute Current command. 
			-- (After it has previously been
			-- executed).
		deferred
		end;

	undo is
			-- Undo the effect of execution
			-- of Current command.
		deferred
		end;

feature -- Basic operations

	execute (argument: ANY) is
			-- Execute Current command and insert it
			-- into the history if it is successful. 
			-- `argument' is automatically passed by
			-- EiffelVision when Current command is
			-- invoked as a callback.
		do
			work (argument);
			if not failed then
				update_history
			end
		end;

feature {NONE} -- Implementation

	update_history is
			-- Update history.
			-- Default action is to record Current
			-- command in the history.
		do
			history.record (Current)
		end; 

	work (argument: ANY) is
			-- Execute actual semantics of
			-- current command.
		deferred
		end;

	failed: BOOLEAN is
			-- Was execution of Current command
			-- successful?
		deferred
		end; 

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class UNDOABLE

