indexing

	description: "General notion of undoable command";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class UNDOABLE 

inherit

	COMMAND

feature 

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

	history: HISTORY is
			-- History in which Current command
			-- is to be recorded
		deferred
		ensure
			History_exists: Result /= Void
		end;

feature {NONE}

	failed: BOOLEAN is
			-- Was execution of Current command
			-- successful?
		deferred
		end; 

feature 

	n_ame: STRING is 
			-- Name of Current command
		obsolete
			"Use ``name'' instead."
		do
			Result := name
		end; 

	name: STRING is
			-- Name of Current command
		deferred
		end;

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

	
feature {NONE}

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
		end 

end


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
