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

--inherit
--	XSC_SERVER_INTERFACE

  create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
--			create commands.make
--		ensure
--			commands_attached: commands /= Void
		end

--feature -- Access

--	commands: XS_COMMANDS

--feature -- Status report

--feature -- Status setting

--	set_commands (a_commands: like commands)
--			-- Sets commands.
--		require
--			a_commands_attached: a_commands /= Void
--		do
--			commands  := a_commands
--		ensure
--			commands_set: commands  = a_commands
--		end

--feature -- Inherited from XSC_SERVER_INTERFACE

--	shutdown_webapps
--			-- <Precursor>

--		do
--			commands.list.force (create {XSC_SHUTDOWN_WEBAPPS}.make)
--		end

--	shutdown_https
--			-- <Precursor>
--		do
--			commands.list.force (create {XSC_SHUTDOWN_HTTPS}.make)
--		end


--	launch_https
--			-- <Precursor>
--		do
--			commands.list.force (create {XSC_LAUNCH_HTTPS}.make)
--		end


--	load_config
--			-- <Precursor>
--		do
--			commands.list.force (create {XSC_LOAD_CONFIG}.make)
--		end

--	shutdown_server
--			-- <Precursor>
--		do
--			commands.list.force (create {XSC_SHUTDOWN_SERVER}.make)
--		end

--	handle_errors
--			-- <Precursor>
--		do
--		end


--invariant
--	commands_attached: commands /= Void
end

