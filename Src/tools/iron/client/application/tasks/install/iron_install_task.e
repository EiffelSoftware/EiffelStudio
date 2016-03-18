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

feature -- Status

	is_simulation: BOOLEAN

	is_verbose: BOOLEAN

	is_setup_enabled: BOOLEAN

	ignoring_cache: BOOLEAN

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
			l_choices: ARRAYED_LIST [TUPLE [prompt: READABLE_STRING_GENERAL; value: IRON_PACKAGE]]
		do
				-- Status
			is_simulation := args.is_simulation
			is_setup_enabled := args.setup_execution_enabled
			is_verbose := args.verbose
			ignoring_cache := args.ignoring_cache

				-- Processing
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
					install_package (c.item, a_iron)
					if a_iron.installation_api.is_package_installed (c.item) then
						process_package (c.item, a_iron)
					end
				end
			end
			if attached args.for_ecf_file as l_ecf then
				install_ecf_dependencies (l_ecf, args.target_name, a_iron)
			end
			if not args.files.is_empty then
				print ("[ERROR] Installing package from file is not yet implemented!")
				print_new_line
			end
		end

feature -- Operation: ecf dependency

	install_package (a_package: IRON_PACKAGE; a_iron: IRON)
			-- Install package `a_package'.
		local
			cl_succeed: CELL [BOOLEAN]
		do
			print (m_installing (a_package.human_identifier))
			if a_iron.installation_api.is_package_installed (a_package) then
				print (" -> ")
				print (tk_already_installed)
				print_new_line
				if
					is_verbose and
					attached a_iron.layout.package_installation_path (a_package) as l_installation_path
				then
					print ("  [")
					print (l_installation_path.name)
					print ("]%N")
				end
			else
				if is_simulation then
					print (" -> ")
					print (tk_simulated)
					print_new_line
				else
					a_iron.catalog_api.install_package (a_package.repository, a_package, ignoring_cache)
					print (" -> ")
					a_iron.installation_api.notify_change
					a_iron.installation_api.refresh_installed_packages
					if a_iron.catalog_api.is_package_installed (a_package) then
						print (tk_successfully_installed)
						io.put_new_line
-- Maybe too verbose.						
--						if is_verbose and attached a_iron.installation_api.package_installation_path (a_package) as l_installation_path then
--							print ("  [")
--							print (l_installation_path.name)
--							print ("]")
--							io.put_new_line
--						end
						if is_setup_enabled then
							print (m_setup_installation (a_package.human_identifier))
							print (" -> ")
							if is_simulation then
								print (tk_simulated)
							else
								create cl_succeed.put (False)
								a_iron.catalog_api.setup_package_installation (a_package, cl_succeed, not is_verbose)
								if cl_succeed.item then
									print (tk_completed)
								else
									print (tk_failed)
								end
							end
						else
							print (tk_skipped)
						end
					else
						print (tk_failed)
					end
					io.put_new_line
				end
			end

			if attached a_iron.installation_api.packages_conflicting_with_package (a_package) as l_conflicts then
						-- This can occurs if package are referenced by full URI
				print ("  -> ")
				print (m_conflicting (a_package.human_identifier))
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

	install_ecf_dependencies (a_ecf: PATH; a_target_name: detachable READABLE_STRING_GENERAL; a_iron: IRON)
			-- Install IRON package needed by `a_ecf'.
			-- This applies for current platform
		require
			a_ecf.name.ends_with_general (".ecf")
		local
			ut: FILE_UTILITIES
		do
			if ut.file_path_exists (a_ecf) then
				localized_print_error ("The installation of ecf dependencies is not supported.%N")
			else
				if is_verbose then
					print ("Process ")
					print (a_ecf.name)
					print (" -> File Not Found!")
					io.put_new_line
				end
			end
		end

	process_package_by_name (a_package_name: READABLE_STRING_GENERAL; a_iron: IRON)
		local
			l_package: IRON_PACKAGE
		do
			if not is_completed (a_package_name) then
				if
					attached a_iron.catalog_api.packages_associated_with_name (a_package_name) as l_packages and then
					l_packages.count >= 1
				then
					l_package := l_packages.first
					process_package (l_package, a_iron)
				end
			end
		end

	process_package (a_package: IRON_PACKAGE; a_iron: IRON)
		do
			if not is_completed (a_package.identifier) then
				if a_iron.installation_api.is_package_installed (a_package) then
						-- Installed
					process_installed_package (a_package, a_iron)
				else
						-- Available
					process_available_package (a_package, a_iron)
				end
			end
		end

	process_installed_package (a_package: IRON_PACKAGE; a_iron: IRON)
		local
			l_id: READABLE_STRING_GENERAL
		do
			l_id := a_package.identifier
			if not is_completed (l_id) then
				add_to_completed_pool (l_id)
				across
					projects_from_installed_package (a_package, a_iron) as ic
				loop
					l_id := ic.item.name
					add_to_completed_pool (l_id)
					install_ecf_dependencies (ic.item, Void, a_iron)
				end
			end
		end

	process_available_package (a_package: IRON_PACKAGE; a_iron: IRON)
		do
			if not is_completed (a_package.identifier) then
				install_package (a_package, a_iron)
				if a_iron.installation_api.is_package_installed (a_package) then
					process_package (a_package, a_iron)
				end
			end
		end

feature {NONE} -- Helpers

	completed_pool: detachable ARRAYED_LIST [READABLE_STRING_GENERAL]

	pending_ecf_pool: detachable ARRAYED_LIST [READABLE_STRING_GENERAL]

	add_to_pending_ecf_pool (a_ecf_file_name: READABLE_STRING_GENERAL)
		local
			l_pool: like pending_ecf_pool
		do
			l_pool := pending_ecf_pool
			if l_pool = Void then
				create l_pool.make (1)
				pending_ecf_pool := l_pool
			end
			l_pool.force (a_ecf_file_name)
		end

	add_to_completed_pool (a_package_name_or_ecf: READABLE_STRING_GENERAL)
		local
			l_pool: like completed_pool
		do
			l_pool := completed_pool
			if l_pool = Void then
				create l_pool.make (1)
				completed_pool := l_pool
			end
			l_pool.force (a_package_name_or_ecf)
		end

	is_completed (n: detachable READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := n /= Void and then
						attached completed_pool as l_pool and then
						across l_pool as ic some n.same_string (ic.item) end
		end

	is_pending_ecf (n: READABLE_STRING_GENERAL): BOOLEAN
		do
			Result := n /= Void and then
						attached pending_ecf_pool as l_pool and then
						across l_pool as ic some n.same_string (ic.item) end
		end

	package_name_from_iron_uri (a_uri: READABLE_STRING_GENERAL): STRING_32
			-- Package name extracted from `a_uri' "iron:package-name:....ecf".
		require
			a_uri_valid: a_uri.starts_with ("iron:")
		local
			p: INTEGER
		do
			create Result.make_from_string_general (a_uri)
			Result.remove_head (5)
			p := Result.index_of (':', 1)
			Result.keep_head (p - 1)
		end

	projects_from_installed_package (a_package: IRON_PACKAGE; a_iron: IRON): ARRAYED_LIST [PATH]
			--
		require
			a_iron.installation_api.is_package_installed (a_package)
		local
--			fac: IRON_PACKAGE_FILE_FACTORY
			ecfs_scanner: IRON_ECF_SCANNER
			l_inst_path: detachable PATH
		do
			create Result.make (0)
			l_inst_path := a_iron.layout.package_installation_path (a_package)
			if l_inst_path /= Void then
				create ecfs_scanner.make
				ecfs_scanner.process_directory (l_inst_path)
				across
					ecfs_scanner.items as ic
				loop
					Result.force (ic.item)
				end
			end
-- Maybe: we could restrict to projects declared in package.iron ...			
--			if
--				l_inst_path /= Void and then
--				attached a_iron.layout.package_installation_iron_file_path (a_package) as p
--			then
--				create fac
--				if attached fac.new_package_file (p) as ipf then
--					across
--						ipf.projects as ic
--					loop
--					end
--				end
--			end
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
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
