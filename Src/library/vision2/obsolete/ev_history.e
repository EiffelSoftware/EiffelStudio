deferred class
	EV_HISTORY

feature -- Access

	can_undo: BOOLEAN is deferred end
		
	can_redo: BOOLEAN is deferred end

	next_undo_command: EV_UNDOABLE_COMMAND is deferred end

	next_redo_command: EV_UNDOABLE_COMMAND is deferred end
		
feature -- Basic operations

	record (cmd: EV_UNDOABLE_COMMAND) is deferred end

	undo is deferred end

	redo is deferred end

	fake_undo is deferred end

	fake_redo is deferred end

end -- class EV_HISTORY
