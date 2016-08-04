note
	description: "A use example"
	author: "Basile Maret"

deferred class
	EXAMPLE

feature -- Initialization

	make
			-- Create the example
		deferred
		ensure
			imap_not_void: imap /= Void and then imap.is_connected
		end

feature -- Basic operation

	run_example
			-- Run the example
		require
			imap.is_connected
		deferred
		ensure
			not imap.is_connected
		end

feature {NONE} -- Constants

	Server_name: STRING = "your_server.ch"
			-- The address of the server

	User_name: STRING = "your_name@your_server.ch"
			-- The user name

	Password: STRING = "qwertz"
			-- The password for `user_name'

feature -- Access

	imap: IMAP_CLIENT_LIB
end
