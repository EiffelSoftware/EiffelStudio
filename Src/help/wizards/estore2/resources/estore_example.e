indexing
	description: "Generated Example of Database Interactions"

class
	ESTORE_EXAMPLE

inherit
		-- Inherit DB_SHARED to have an access to the Database Manager
	DB_SHARED
		-- Inherit REPOSITORIES to have an access to your database Tables
	REPOSITORIES

create
	initialize

feature -- Initialization

	initialize (username, password, data_source: STRING) is
			-- Run the example
		require
			not_void: username /= Void and password /= Void and data_source /= Void
		local
			b: BOOLEAN
		do
			if not b then
				db_manager.set_connection_information (username,password,data_source)
				db_manager.establish_connection
				b:= db_manager.session_control.is_connected 
				if b then
					initialized := True
				end
			end
			if not b then
				io.put_string ("Connection Failed.%NPLease Check UserName and Password")
			end
		rescue
			b := True
 			retry
		end

feature -- Implementation

	initialized: BOOLEAN
		-- Is the connection with the DB initialized ?

feature -- Examples of Requests

