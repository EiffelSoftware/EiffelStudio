indexing
	description: "Example of Database Interactions"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	ESTORE_EXAMPLE

inherit
	DB_SHARED

	REPOSITORIES

Creation
	initialize

feature -- Initialization

	initialize(username,password,data_source: STRING) is
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
					initialized := TRUE
				end
			end
			if not b then
				io.put_string("Connection Failed.%NPLease Check UserName and Password")
			end
		rescue
			b := TRUE
 			retry
		end

feature -- Implementation

	initialized: BOOLEAN
		-- Is the connection with the DB initialized ?

feature -- Examples of Requests

