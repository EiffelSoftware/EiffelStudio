note
	description: "Summary description for {PS_SIMPLE_IN_MEMORY_REPOSITORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_SIMPLE_IN_MEMORY_REPOSITORY

inherit
	PS_DEFAULT_REPOSITORY
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
			-- Initialization for `Current'.
		local
			simple_in_memory_backend: PS_EVEN_SIMPLER_IN_MEMORY_BACKEND
			special_handler: PS_SPECIAL_COLLECTION_HANDLER
		do
			create simple_in_memory_backend.wipe_out
			make (simple_in_memory_backend)
			create special_handler.make
			add_collection_handler (special_handler)
		end

end
