note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XS_SERVER_MODULE

inherit
	THREAD

	XS_SHARED_SERVER_OUTPUTTER
	XS_SHARED_SERVER_CONFIG

feature {NONE} -- Initialization

	make (a_main_server: XS_MAIN_SERVER)
			-- Initializes current
		require
			a_main_servera_ttached: a_main_server /= Void
		do
			launched := False
			running := False
			main_server := a_main_server
 		ensure
			main_server_set: equal (a_main_server, main_server)
		end


feature -- Access

	main_server: XS_MAIN_SERVER

feature -- Status report

	launched: BOOLEAN
		-- Checks if a module has been launched

	running: BOOLEAN
		-- Checks if a module is currently running	

feature -- Status setting


	shutdown
			-- Launches the module.
		deferred
		end

feature -- Basic operations

feature {NONE} -- Implementation


invariant
	main_server_attached: main_server /= Void
end

