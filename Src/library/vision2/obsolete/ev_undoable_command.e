deferred class
	EV_UNDOABLE_COMMAND

inherit
	EV_COMMAND
		rename
			execute as internal_execute
		end

feature -- Access

	history: EV_HISTORY is deferred end

feature -- Basic operation

	execute (arg: EV_ARGUMENT; event_data: EV_EVENT_DATA) is deferred end

	undo is deferred end

	redo is deferred end

feature -- Basic operation

	update_history is do end

	failed: BOOLEAN

end -- class EV_UNDOABLE_COMMAND
