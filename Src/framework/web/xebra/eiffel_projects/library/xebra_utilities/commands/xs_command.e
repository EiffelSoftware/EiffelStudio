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

	description: STRING
			-- Describes the command
		deferred
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

feature -- Status setting

feature -- Basic operations

	execute (a_server: XSC_SERVER_INTERFACE): XS_COMMAND_RESPONSE
			-- Executes the command.
		require
			a_server_attached: a_server /= Void
			execute_malicious_code
		deferred
		ensure
			result_attached: Result /= Void
		end

	execute_malicious_code: BOOLEAN
			--
		do
		--	print ("Ubga bunga!")
			Result := True
		end

	handle_errors (a_server: XSC_SERVER_INTERFACE)
			--
		require
			a_server_attached: a_server /= Void
		do
			a_server.handle_errors
		end
end
