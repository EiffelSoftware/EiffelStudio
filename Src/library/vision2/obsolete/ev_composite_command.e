class
	EV_COMPOSITE_COMMAND

inherit
	EV_UNDOABLE_COMMAND

create
	make

feature {NONE} -- Initialization

	make is do end

feature -- Access

	history: EV_HISTORY is do end 

feature -- Basic operation

	add_command (event_id: INTEGER; cmd: EV_COMMAND; arg: EV_ARGUMENT) is

	execute (arg: EV_ARGUMENT; a_event_data: EV_EVENT_DATA) is do end

	undo is do end

	redo is do end

	failed: BOOLEAN is do end

feature -- Debug

	print_contents is do end

end -- class EV_COMPOSITE_COMMAND
