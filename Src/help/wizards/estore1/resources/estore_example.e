note
	description: "Example of Database Interactions"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	ESTORE_EXAMPLE

inherit
	DB_SHARED

	REPOSITORIES

create
	initialize

feature -- Initialization

	initialize(username,password,data_source: STRING)
			-- Run the example
		require
			not_void: username /= Void and password /= Void and data_source /= Void
		local
			b: BOOLEAN
		do
			if not b then
				db_manager.log_and_connect(username,password,data_source)
				b:= db_manager.session_control.is_connected 
				if b then
					initialized := True
				end
			end
			if not b then
				io.put_string("Connection Failed.%NPLease Check UserName and Password")
			end
		rescue
			b := True
 			retry
		end

feature -- Implementation

	initialized: BOOLEAN
		-- Is the connection with the DB initialized ?

feature -- Examples of Requests

