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
			l_packages: detachable LIST [IRON_PACKAGE]
		do
			if a_iron.catalog_api.repositories.is_empty then
				print (m_warning_no_repository)
				print_new_line
			end
			if args.only_installed then
				l_packages := a_iron.installation_api.installed_packages
				if l_packages /= Void and then not l_packages.is_empty then
					print (m_installed_packages)
					print_new_line
					across
						l_packages as p
					loop
						print (p.item.human_identifier)
						print_new_line
					end
				else
					print (m_no_installed_package)
					print_new_line
				end
			else
				if attached a_iron.catalog_api.repositories as l_repositories and then not l_repositories.is_empty then
					print (m_available_packages)
					print_new_line

					across
						l_repositories as c
					loop
						l_packages := c.item.available_packages
						if l_packages /= Void and then not l_packages.is_empty then
							print (m_repository (c.item.uri.string, c.item.version))
							print_new_line
							across
								l_packages as p
							loop
								print (p.item.human_identifier)
								if not p.item.has_archive_uri then
									print (" !No archive available! ")
								end

								if a_iron.installation_api.is_installed (p.item) then
									print (" [Installed] ")
								end

								print_new_line


								across
									p.item.associated_paths as cur
								loop
									print (" - ")
									print (cur.item)
									print_new_line
								end
							end
						else
							print (m_repository_without_package (c.item.uri.string, c.item.version))
							print_new_line
						end
					end
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
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
