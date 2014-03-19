note
	description: "Summary description for {IRON_LIST_TASK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_LIST_TASK

inherit
	IRON_TASK

create
	make

feature -- Access

	name: STRING = "list"
			-- Iron client task

feature -- Execute

	process (a_iron: IRON)
		local
			args: IRON_LIST_ARGUMENT_PARSER
		do
			create args.make (Current)
			args.execute (agent execute (args, a_iron))
		end

	execute (args: IRON_LIST_ARGUMENTS; a_iron: IRON)
		local
			l_package_names: STRING_TABLE [IRON_PACKAGE]
			l_has_conflict: BOOLEAN
			l_only_conflict: BOOLEAN
			l_conflict_nb: INTEGER
		do
			if a_iron.catalog_api.repositories.is_empty then
				print (m_warning_no_repository)
				print_new_line
			end
			create l_package_names.make_caseless (10)

			l_only_conflict := args.only_conflicts
			if args.only_installed then
				a_iron.installation_api.refresh
				if attached a_iron.installation_api.installed_packages as l_packages and then not l_packages.is_empty then
					print (m_installed_packages)
					if l_only_conflict then
						print (" (only conflict) ")
					end

					print_new_line
					across
						l_packages as p
					loop
						l_has_conflict := l_package_names.has (p.item.identifier)
						if l_has_conflict then
							l_conflict_nb := l_conflict_nb + 1
						else
							l_package_names.force (p.item, p.item.identifier)
						end
						if not l_only_conflict or else l_has_conflict then
							print (p.item.human_identifier)
							if l_has_conflict then
								print (" [Conflict!] ")
							end
							print_new_line
							if args.verbose then
								if l_has_conflict and then attached l_package_names.item (p.item.identifier) as l_conflict then
									print ("  ! in conflict with ")
									print (l_conflict.human_identifier)
									print_new_line
								end

								across
									p.item.associated_paths as ic
								loop
									print ("  - ")
									print (ic.item)
									print_new_line
								end
								if attached a_iron.layout.package_installation_path (p.item) as l_install_path then
									print ("  # ")
									print (l_install_path.name)
									print_new_line
								end

								print_new_line
							end
						end
					end
					if l_only_conflict and l_conflict_nb = 0 then
						print (" No conflict%N")
					end
				else
					print (m_no_installed_package)
					print_new_line
				end
			else
				if attached a_iron.catalog_api.repositories as l_repositories and then not l_repositories.is_empty then
					print (m_available_packages)
					if l_only_conflict then
						print (" (only conflict) ")
					end
					print_new_line

					across
						l_repositories as c
					loop
						if
							c.item.available_packages_count > 0 and then
							attached c.item.available_packages as l_packages
						then
							print (m_repository (c.item.location_string))
							print_new_line
							across
								l_packages as p
							loop
								l_has_conflict := l_package_names.has (p.item.identifier)
								if l_has_conflict then
									l_conflict_nb := l_conflict_nb + 1
								else
									l_package_names.force (p.item, p.item.identifier)
								end
								if not l_only_conflict or else l_has_conflict then
									print (p.item.human_identifier)
									if p.item.is_local_working_copy then
										if p.item.associated_paths.is_empty then
											print (" !No associated path! ")
										end
									else
										if not p.item.has_archive_uri then
											print (" !No archive available! ")
										end
									end
									if a_iron.installation_api.is_package_installed (p.item) then
										print (" [installed] ")
									end
									if l_has_conflict then
										print (" [conflict!] ")
									end
									print_new_line
									if args.verbose then
										if l_has_conflict and then attached l_package_names.item (p.item.identifier) as l_conflict then
											print (" ! in conflict with ")
											print (l_conflict.human_identifier)
											print_new_line
										end
										across
											p.item.associated_paths as cur
										loop
											print (" - ")
											print (cur.item)
											print_new_line
										end
									end
								end
							end
							if l_only_conflict and l_conflict_nb = 0 then
								print (" No conflict%N")
							end
						else
							print (m_repository_without_package (c.item.location_string))
							print_new_line
						end
					end
				end
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
