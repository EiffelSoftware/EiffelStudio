indexing
	description: "Used for closing a window."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

deferred class CLOSEABLE

feature -- Access

	set_close_callback (arg: EV_ARGUMENT) is
		local
			close_cmd: EV_ROUTINE_COMMAND
		do
			create close_cmd.make (~close)
			add_close_command (close_cmd, arg)
		end

	close (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Close Current
		deferred
		end

feature {NONE} -- Implementation

	add_close_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
		deferred
		end

end -- class CLOSEABLE

