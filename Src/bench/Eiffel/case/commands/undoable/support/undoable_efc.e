indexing

	description: 
		"General notion of undoable command.";
	date: "$Date$";
	revision: "$Revision $"

deferred class UNDOABLE_EFC 

inherit

	ONCES

feature -- Property

	name: STRING is
		-- Command name
		deferred
		end;

feature -- Update

	redo is
		-- Re-execute command (after it was undone).
		deferred
		end;

	undo is
		-- Cancel effect of executing the command.
		deferred
		end

	free_data is
			-- Free data from server.
		do
			-- Do nothing
		end

	request_for_data is do end

feature -- Element change

	record is
			-- Record Current undoable into the history list
			-- (Also, Call request_data).
		do
			history.record (Current);
		end

	set_watch_cursor is
		do
			--Windows.set_watch_cursor;
		end

	restore_cursor is
		do
			--Windows.restore_cursor
		end

end -- class UNDOABLE_EFC
