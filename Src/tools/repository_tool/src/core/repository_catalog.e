note
	description: "Summary description for {REPOSITORY_CATALOG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REPOSITORY_CATALOG

create
	make

feature {NONE} -- Initialization

	make
		do
			create repositories.make (10)
		end

feature -- Access

	repositories: HASH_TABLE [REPOSITORY, STRING]

	repository_by_name (a_name: STRING_32): detachable REPOSITORY
		do
			Result := repositories.item (a_name)
		end

feature -- Element change

	add_repository (a_name: STRING_32; a_repo: REPOSITORY)
		do
			repositories.force (a_repo, a_name)
			if not a_repo.has_uuid then
				a_repo.set_uuid (uuid_generator.generate_uuid)
			end
		end

feature {NONE} -- Implementation

	uuid_generator: UUID_GENERATOR
		once ("PROCESS")
			create Result
		end

end
