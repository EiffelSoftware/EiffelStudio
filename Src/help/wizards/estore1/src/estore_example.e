indexing
	description: "Example of Database Interactions"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	ESTORE_EXAMPLE

inherit
	SHARED

Creation
	perform_example

feature -- Initialization

	perfom_example(username,password: STRING) is
			-- Run the example
		local
			b: BOOLEAN
		do
			if not b then
				b := db_manager.try_to_connect(username,password)
				if b then 
					b := db_manager.establish_connection
					if b then
						proceed
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

	proceed is
		do
			
		end
	
end -- class ESTORE_EXAMPLE
