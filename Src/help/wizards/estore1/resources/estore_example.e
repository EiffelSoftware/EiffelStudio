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

	initialize(username,password: STRING) is
			-- Run the example
		local
			b: BOOLEAN
		do
			if not b then
				b := db_manager.try_to_connect(username,password)
				if b then 
					b := db_manager.establish_connection
					if b then
						initialized := TRUE
					end
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

