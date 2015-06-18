note
	description: "A mock database to avoid setting up a real one."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	DUMMY_CONNECTION

create
	make

feature {NONE} -- Initialization

	make (user, password, host, db_name: STRING; port: INTEGER)
			-- Initialization for `Current'.
		do
		end

feature -- Status report

	is_connected: BOOLEAN
			-- Is there an active connection to the database?

feature -- Basic operations

	connect
			-- Connect to the database.
		do
			print ("Establishing new connection.%N")
			is_connected := True
		end

	execute (sql: STRING)
			-- Execute `sql' in the database.
		require
			connected: is_connected
		do
			print ("Received command: " + sql + "%N")
		end

	close
			-- Shut down the connection
		require
			connected: is_connected
		do
			print ("Connection closed.%N")
			is_connected := False
		ensure
			closed: not is_connected
		end

end
