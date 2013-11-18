note
	description: "[
		A repository that stores data on a CouchDB.	
		Use REPOSITORY_FACTORY to get an instance of this class.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CDB_REPOSITORY

inherit

	--PS_REPOSITORY_COMPATIBILITY
	PS_DEFAULT_REPOSITORY

create
	make_empty, make_with_host_and_port

feature {NONE} -- Initialization

	make_empty
			-- Initialization for `Current'.
		local
			in_memory_database: CDB_BACKEND
			special_handler: PS_SPECIAL_COLLECTION_HANDLER
		do
			create in_memory_database.make
			make (in_memory_database)
			create special_handler.make
			add_collection_handler (special_handler)
		end

	make_with_host_and_port (host: STRING; port: INTEGER)
			-- Initialization for `Current'.
		local
			in_memory_database: CDB_BACKEND
			special_handler: PS_SPECIAL_COLLECTION_HANDLER
		do
			create in_memory_database.make_with_host_and_port (host, port)
			make (in_memory_database)
			create special_handler.make
			add_collection_handler (special_handler)
		end

end
