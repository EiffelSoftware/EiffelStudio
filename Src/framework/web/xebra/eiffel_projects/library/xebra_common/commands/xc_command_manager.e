note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XC_COMMAND_MANAGER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create {ARRAYED_QUEUE [XC_COMMAND]}queue.make (1)
		ensure
			queue_attached: queue /= Void
		end

feature -- Access

	queue: QUEUE [XC_COMMAND]

feature -- Status report

feature -- Status setting

	put (a_command: XC_COMMAND)
			-- Adds a new command to the queue
		require
			a_Command_attached: a_command /= Void
		do
			queue.force (a_command)
		ensure
			queue_bigger: queue.count = old queue.count + 1
		end


	put_multiple (a_commands: XC_COMMANDS)
			-- Adds the list of commands to the queue
		require
			a_commands_attached: a_commands /= Void
		do
			from
				a_commands.list.start
			until
				a_commands.list.after
			loop
				put (a_commands.list.item)
				a_commands.list.forth
			end
		end

feature -- Basic operations

	execute_next (a_main_server: XC_SERVER_INTERFACE)
			-- Executes the next command in the queue and removes it
		require
			a_main_server_attached: a_main_server /= Void
		do
			if not queue.is_empty then
					queue.item.execute (a_main_server)
					queue.item.handle_errors (a_main_server)
					queue.remove
			end
		end

invariant
	queue_attached: queue /= Void

end
