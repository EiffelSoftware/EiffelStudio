note
	description: "Abstract Database Handler"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ESA_DATABASE_HANDLER

feature -- Access

	store: detachable ESA_DATABASE_STORE_PROCEDURE
			-- Database stored_procedure to handle

	query: detachable ESA_DATABASE_QUERY

feature -- Modifiers

	set_store (a_store : ESA_DATABASE_STORE_PROCEDURE)
			-- Set store to execute
		require
				store_not_void: a_store /= Void
		do
			store := a_store
		ensure
			store = a_store
		end

feature -- Functionality

	execute_reader
			-- Execute store
		require
			store_not_void: store /= void
		deferred
		end

	execute_writer
			-- Execute store
		require
			store_not_void: store /= void
		deferred
		end

feature -- Iteration

	start
			-- Set the cursor on first element
		deferred
		end

	forth
			-- Move cursor to next element
		deferred
		end

	after: BOOLEAN
			-- True for the last element
		deferred
		end

	item: detachable ANY
			-- Current element
		deferred
		end

feature {ESA_DATA_PROVIDER} -- Implementation

	connect
			-- Connect to the database
		deferred
		ensure
			is_connected
		end

	disconnect
			-- Disconnect from the database
		deferred
		ensure
			not_connected: not is_connected
		end

	is_connected: BOOLEAN
			-- True if connected to the database
		deferred
		end

end
