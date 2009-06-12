note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XWA_SERVER_CONTROL

inherit
	XSC_SERVER_INTERFACE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create commands.make
		ensure
			commands_attached: commands /= Void
		end

feature -- Access

	commands: XS_COMMANDS

feature -- Status report

feature -- Status setting

	set_commands (a_commands: like commands)
			-- Sets commands.
		require
			a_commands_attached: a_commands /= Void
		do
			commands  := a_commands
		ensure
			commands_set: commands  = a_commands
		end

feature -- Inherited from XSC_SERVER_INTERFACE

	shutdown_webapps
			-- <Precursor>

		do

		end

	shutdown_http_server
			-- <Precursor>
		do

		end


	launch_http_server
			-- <Precursor>
		do

		end


	display_response
			-- <Precursor>
		do
		end

	load_config
			-- <Precursor>
		do

		end

	stop_server
			-- <Precursor>
		do
			commands.list.force (create {XSC_STOP_SERVER}.make)
		end

	handle_errors
			-- <Precursor>
		do
		end


invariant
	commands_attached: commands /= Void
end

