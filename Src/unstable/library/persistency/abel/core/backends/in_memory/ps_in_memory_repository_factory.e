note
	description: "[
	A factory class to create repositories with a database backend.
	Use this class as an entry point to the framework to get a repository object
	and then use it to create an executor.
	]"
	author: "Roman Schmocker, Marco Piccioni"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_IN_MEMORY_REPOSITORY_FACTORY

inherit
	PS_REPOSITORY_FACTORY

create
	make, make_uninitialized

feature -- Status report

	is_buildable: BOOLEAN = True
			-- Does `Current' have enough information to build a repository?

feature {NONE}

	new_backend: PS_READ_WRITE_BACKEND
		do
			create {PS_IN_MEMORY_BACKEND} Result.make
			Result.add_plug_in (create {PS_ATTRIBUTE_REMOVER_PLUGIN})
		end

feature -- Factory methods

--	create_in_memory_repository: PS_DEFAULT_REPOSITORY
--		-- Create a simple in memory repository
--		obsolete
--			"use new_repository"
--		local
--			repository: PS_DEFAULT_REPOSITORY
--			backend: PS_IN_MEMORY_BACKEND
--			special_handler: PS_SPECIAL_COLLECTION_HANDLER
--			tuple_handler: PS_TUPLE_COLLECTION_HANDLER
--		do
--			create backend.make
--			create repository.make (backend)
--			create special_handler.make
--			create tuple_handler
--			repository.add_collection_handler (special_handler)
--			repository.add_collection_handler (tuple_handler)
--			Result := repository
--		end

--	create_cdb_repository(host:STRING; port:INTEGER): PS_RELATIONAL_REPOSITORY
--		-- Create a CouchDB repository
--		local
--			repository: CDB_REPOSITORY
--		do
--			if host.is_empty or port=0 then
--				create repository.make_empty
--			else
--				create repository.make_with_host_and_port(host, port)
--			end
--			Result := repository
--		end
end
