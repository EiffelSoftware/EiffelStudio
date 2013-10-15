note
	description: "[
	A repository that keeps all values in main memory. Useful for testing.
	Use REPOSITORY_FACTORY to get an instance of this class.
	]"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_IN_MEMORY_REPOSITORY

inherit

	PS_REPOSITORY_COMPATIBILITY

create
	make_empty

feature {NONE} -- Initialization

	make_empty
			-- Initialization for `Current'.
		local
			in_memory_database: PS_IN_MEMORY_DATABASE
			simple_in_memory_backend: PS_SIMPLE_IN_MEMORY_BACKEND
			special_handler: PS_SPECIAL_COLLECTION_HANDLER
		do
			create in_memory_database.make
--			create simple_in_memory_backend.wipe_out
			make (in_memory_database)
--			make (simple_in_memory_backend)
			create special_handler.make
			add_collection_handler (special_handler)
		end

end
