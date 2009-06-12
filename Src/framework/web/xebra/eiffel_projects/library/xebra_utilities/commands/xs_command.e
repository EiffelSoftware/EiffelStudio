note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XS_COMMAND

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do

		end

feature -- Access

feature -- Status report

feature -- Status setting

feature -- Basic operations

	execute (a_server: XSC_SERVER_INTERFACE)
			-- Executes the command.
		require
			a_server_attached: a_server /= Void
		deferred
		end

	handle_errors (a_server: XSC_SERVER_INTERFACE)
			--
		require
			a_server_attached: a_server /= Void
		do
			a_server.handle_errors
		end
end
