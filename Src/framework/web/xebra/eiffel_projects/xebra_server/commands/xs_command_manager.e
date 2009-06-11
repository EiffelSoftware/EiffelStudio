note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_COMMAND_MANAGER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create {ARRAYED_QUEUE [XS_COMMAND]}commands.make (1)
		ensure
			commands_attached: commands /= Void
		end

feature -- Access

	commands: QUEUE [XS_COMMAND]

feature -- Status report

feature -- Status setting

	put (a_command: XS_COMMAND)
			-- Adds a new command to the queue
		require
			a_Command_attached: a_command /= Void
		do
			commands.force (a_command)
		ensure
			commands_bigger: commands.count = old commands.count + 1
		end


feature -- Basic operations

	execute_next (a_main_server: XS_MAIN_SERVER)
			-- Executes the next command in the queue and removes it
		require
			a_main_server_attached: a_main_server /= Void
		do
			if not commands.is_empty then
					commands.item.execute (a_main_server)
					commands.item.handle_error (a_main_server)
					commands.remove
			end
		end

invariant
	commands_attached: commands /= Void

end
