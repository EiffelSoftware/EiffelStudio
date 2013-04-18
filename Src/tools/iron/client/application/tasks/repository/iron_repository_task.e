note
	description: "Summary description for {IRON_REPOSITORY_TASK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_REPOSITORY_TASK

inherit
	IRON_TASK

	IRON_EXPORTER
		rename
			print as print_any
		end

create
	make

feature -- Access

	name: STRING = "repository"
			-- Iron client task

feature -- Execute

	process (a_iron: IRON)
		local
			args: IRON_REPOSITORY_ARGUMENT_PARSER
		do
			create args.make (Current)
			args.execute (agent execute (args, a_iron))
		end

	execute (args: IRON_REPOSITORY_ARGUMENTS; a_iron: IRON)
		local
			repo: IRON_REPOSITORY
		do
			if args.is_listing then
				across
					a_iron.catalog_api.repositories as c
				loop
					print (c.item.url)
					print ("%N")
				end
			end
			if attached args.repository_to_add as v and then attached args.repository_url as l_repo_url then
				print (m_registering_repository (v, l_repo_url))
				print_new_line
				create repo.make_from_version_uri ((create {IRI}.make_from_string (l_repo_url)).to_uri)
				a_iron.catalog_api.register_repository (v, repo)
			end
			if attached args.repository_to_remove as v then
				print (m_unregistering_repository (v))
				print_new_line
				a_iron.catalog_api.unregister_repository (v)
			end
			print (m_updating_repositories)
			print_new_line
			a_iron.catalog_api.update
		end

end
