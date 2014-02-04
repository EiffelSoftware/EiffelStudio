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
			l_require_update: BOOLEAN
		do
			if args.is_info then
				print ("Iron packages installation:%N  - ")
				print (a_iron.layout.path.name)
				print ("%N")

				print ("Iron client installation:%N  - ")
				print (a_iron.layout.installation_path.name)
				print ("%N")
			elseif args.is_listing then
				across
					a_iron.catalog_api.repositories as c
				loop
					print (c.key)
					print (" -> ")
					print (c.item.url)
					print ("%N")
				end
			end
			if attached args.repository_to_add as v and then attached args.repository_url as l_repo_url then
				print (m_registering_repository (v, l_repo_url))
				print_new_line
				create repo.make_from_version_uri ((create {IRI}.make_from_string (l_repo_url)).to_uri)
				a_iron.catalog_api.register_repository (v, repo)
				l_require_update := True
			end
			if attached args.repository_to_remove as v then
				print (m_unregistering_repository (v))
				print_new_line
				a_iron.catalog_api.unregister_repository (v)
				l_require_update := True
			end
			if l_require_update then
				print (m_updating_repositories)
				print_new_line
				a_iron.catalog_api.update
			end
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
