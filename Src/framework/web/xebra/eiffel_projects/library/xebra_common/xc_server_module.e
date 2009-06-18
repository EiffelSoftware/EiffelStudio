note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XC_SERVER_MODULE

feature {NONE} -- Initialization

	make (a_main_server: like main_server)
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

feature {NONE} -- Access

	main_server: XC_SERVER_INTERFACE

feature -- Status report

	launched: BOOLEAN
		-- Checks if a module has been launched

	running: BOOLEAN
		-- Checks if a module is currently running	

feature -- Status setting

	shutdown
			-- Shutds down the module.
		deferred
		end

	launch
			-- Launches the module.	
		deferred
		end

	join
			-- Joins the thread.	
		deferred
		end

feature -- Basic operations

feature {NONE} -- Implementation

invariant
	main_server_attached: main_server /= Void
end

