note
	description: "Summary description for {SCHEMA_EVOLUTION_PROJECT_MANAGER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCHEMA_EVOLUTION_PROJECT_MANAGER

	create
		make

feature -- Access
	schema_evolution_handler: HASH_TABLE [SCHEMA_EVOLUTION_HANDLER, STRING]

feature	-- Creation
	make
			-- Default creation.
		do
			create schema_evolution_handler.make (10)
			schema_evolution_handler.force (create {ESCHER_TEST_CLASS_2_SCHEMA_EVOLUTION_HANDLER}.make, "ESCHER_TEST_CLASS_2")
	end

end
