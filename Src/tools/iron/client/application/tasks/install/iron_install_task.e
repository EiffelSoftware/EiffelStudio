note
	description: "Summary description for {IRON_INSTALL_TASK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_INSTALL_TASK

inherit
	IRON_TASK

create
	make

feature -- Access

	name: STRING = "install"
			-- Iron client task

feature -- Execute

	process (a_iron: IRON)
		local
			args: IRON_INSTALL_ARGUMENT_PARSER
		do
			create args.make (Current)
			args.execute (agent execute (args, a_iron))
		end

	execute (args: IRON_INSTALL_ARGUMENTS; a_iron: IRON)
		local
			l_package: detachable IRON_PACKAGE
			lst: ARRAYED_LIST [IRON_PACKAGE]
			l_conflicts: detachable ITERABLE [IRON_PACKAGE]
			l_choices: ARRAYED_LIST [TUPLE [prompt: READABLE_STRING_GENERAL; value: IRON_PACKAGE]]
		do
			if args.installing_all then
				lst := a_iron.catalog_api.available_packages
			else
				create lst.make (args.resources.count)
				across
					args.resources as c
				loop
					print (m_searching (c.item))
					print_new_line
					l_package := Void
					if
						c.item.has ('/') or c.item.has ('\')
					then -- uri or local path
						l_package := a_iron.catalog_api.package_associated_with_uri (c.item)
					else
							-- name (or uuid) ?
						if attached a_iron.catalog_api.packages_associated_with_name (c.item) as l_packages and then not l_packages.is_empty then
							if l_packages.count = 1 then
								l_package := l_packages.first
							else
								print ("-> ")
								print (m_several_packages_for_name (c.item))
								print_new_line

								create l_choices.make (l_packages.count)

								across
									l_packages as packages_ic
								loop
									if l_package = Void then
											-- Install first the first package found in repository order.
										l_package := packages_ic.item
									end
									a_iron.installation_api.refresh_installed_packages
									if a_iron.installation_api.is_package_installed (packages_ic.item) then
										l_choices.force ([packages_ic.item.human_identifier + " [installed]", packages_ic.item])
									else
										l_choices.force ([packages_ic.item.human_identifier, packages_ic.item])
									end
									if args.is_batch then
										print ("    - ")
										print (packages_ic.item.human_identifier)
										print ("%N")
									end
								end

								if args.is_batch then
										-- use default `l_package'
								else
									l_package := selected_package ("Select a package", l_choices, l_package)
								end

								if l_package /= Void then
									print ("-> Install ")
									print (l_package.human_identifier)
									print ("%N")
								end
							end
						end
						if l_package = Void then
							l_package := a_iron.catalog_api.package_associated_with_id (c.item)
						end
					end
					if l_package /= Void then
						lst.force (l_package)
					else
						print ("  -> ")
						print (tk_not_found)
						print_new_line
					end
				end
			end
			if not lst.is_empty then
				across
					lst as c
				loop
					l_package := c.item
					l_conflicts := a_iron.installation_api.packages_conflicting_with_package (l_package)
								-- This can occurs if package are referenced by full URI
					print (m_installing (l_package.human_identifier))
					if a_iron.installation_api.is_package_installed (l_package) then
						print (" -> ")
						print (tk_already_installed)
						print_new_line
						if args.verbose and attached a_iron.layout.package_installation_path (l_package) as l_installation_path then
							print ("  [")
							print (l_installation_path.name)
							print ("]%N")
						end
					else
						if args.is_simulation then
							print (" -> ")
							print (tk_simulated)
							print_new_line
						else
							a_iron.catalog_api.install_package (l_package.repository, l_package, args.ignoring_cache)
							print (" -> ")
							a_iron.installation_api.refresh_installed_packages
							if a_iron.installation_api.is_package_installed (l_package) then
								print (tk_successfully_installed)
								print_new_line
								if args.verbose and attached a_iron.installation_api.package_installation_path (l_package) as l_installation_path then
									print ("  [")
									print (l_installation_path.name)
									print ("]%N")
								end
							else
								print (tk_failed)
								print_new_line
							end
						end
					end
					if l_conflicts /= Void then
						print ("  -> ")
						print (m_conflicting (l_package.human_identifier))
						across
							l_conflicts as ic
						loop
							print ("(")
							print (ic.item.human_identifier)
							print (") ")
						end
						print_new_line
					end
				end
			end
			if not args.files.is_empty then
				print ("[ERROR] Installing package from file is not yet implemented!")
				print_new_line
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
