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
			fac: IRON_REPOSITORY_FACTORY
			l_no_op: BOOLEAN
		do
			if args.is_info then
				print ("Iron packages installation:%N  - ")
				print (a_iron.layout.path.name)
				print_new_line

				print ("Iron client installation:%N  - ")
				print (a_iron.layout.installation_path.name)
				print_new_line
			elseif args.is_listing then
				list_repositories (a_iron)
			elseif args.is_cleaning then
				if
					attached a_iron.catalog_api.invalid_repositories as l_invalid_repositories and then
					not l_invalid_repositories.is_empty
				then
					print ("Clean invalid repositories:%N")
					across
						l_invalid_repositories as ic
					loop
						if a_iron.catalog_api.has_repository_registered (ic.item.location_string) then
							print (" - ")
							print (m_unregistering_repository (ic.item.location_string))
							print_new_line
							a_iron.catalog_api.unregister_repository (ic.item.location_string)
						end
					end
				end

				if
					attached a_iron.installation_api.unexpected_installed_packages as l_unexpected_installed_packages and then
					not l_unexpected_installed_packages.is_empty
				then
					print ("Clean unexpected packages:%N")
					across
						a_iron.installation_api.unexpected_installed_packages as ic
					loop
						print (" - ")
						print (ic.item.human_identifier)
						print_new_line
						a_iron.catalog_api.uninstall_package (ic.item)
					end
				end
				check cleaned: a_iron.installation_api.unexpected_installed_packages.is_empty end
				print ("Cleaning finished.")
				print_new_line
			else
				l_no_op := True
			end
			if attached args.repository_to_add as l_repo_location then
				l_no_op := False
				print (m_registering_repository (l_repo_location))
				print_new_line
				create fac
				if attached a_iron.catalog_api.repository_at (l_repo_location) then
					print (m_already_registered_repository_location (l_repo_location))
					print_new_line
				elseif attached fac.new_repository (l_repo_location) as repo then
					a_iron.catalog_api.register_repository (repo)
				else
					print (m_invalid_repository_location (l_repo_location))
					print_new_line
				end
			end
			if attached args.repository_to_remove as l_repo_url then
				l_no_op := False
				print (m_unregistering_repository (l_repo_url))
				print_new_line
				if a_iron.catalog_api.has_repository_registered (l_repo_url) then
					a_iron.catalog_api.unregister_repository (l_repo_url)
				else
					print (m_repository_location_not_registered (l_repo_url))
					print_new_line
					print_new_line
					print (m_help_see_list_of_registered_repositories)
					print_new_line
				end
			end
			if l_no_op then
				list_repositories (a_iron)
			end
		end

	list_repositories (a_iron: IRON)
		do
			if
				attached a_iron.catalog_api.repositories as l_repositories and then
				l_repositories.count > 0
			then
				across
					l_repositories as c
				loop
					print (c.item.location_string)
					if
						attached {IRON_WORKING_COPY_REPOSITORY} c.item as wc_repo and then
						not wc_repo.exists
					then
						print (" -- Warning: path does not exist!")
					end
					print_new_line
				end
			else
				print (m_warning_no_repository)
				print_new_line
				print_new_line
				print (m_help_add_repository)
				print_new_line
			end
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
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
