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

	PS_RELATIONAL_REPOSITORY

create
	make_empty

feature {NONE} -- Initialization

	make_empty
			-- Initialization for `Current'.
		local
			in_memory_database: PS_IN_MEMORY_DATABASE
			special_handler: PS_SPECIAL_COLLECTION_HANDLER
		do
			create in_memory_database.make
			make (in_memory_database)
			create special_handler.make
			add_collection_handler (special_handler)
		end

end
