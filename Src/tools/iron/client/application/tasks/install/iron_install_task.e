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
		do
			across
				args.resources as c
			loop
				print (m_searching (c.item))
				print_new_line
				l_package := Void
				if c.item.starts_with ("http://") or c.item.starts_with ("https://") then
					-- url
					l_package := a_iron.catalog_api.package_associated_with_uri (c.item)
				else
					-- name (or uuid) ?
					if attached a_iron.catalog_api.packages_associated_with_name (c.item) as lst and then not lst.is_empty then
						if lst.count = 1 then
							l_package := lst.first
						else
							if args.is_batch then
								print ("  -> ")
								print (m_several_packages_for_name (c.item))
								print_new_line
							else
								across
									lst as p
								loop
									-- Selection ..
									-- FIXME: to implemente
								end
							end
						end
					end
					if l_package = Void then
						l_package := a_iron.catalog_api.package_associated_with_id (c.item)
					end
				end
				if l_package = Void then
					print ("  -> ")
					print (tk_not_found)
					print_new_line
				elseif a_iron.installation_api.is_installed (l_package) then
					print ("  -> ")
					print (tk_already_installed)
					print_new_line
					print ("  [")
					print (a_iron.layout.package_installation_path (l_package).name)
					print ("]%N")
				else
					print (m_installing (l_package.human_identifier))
					print_new_line
					print ("  -> ")
					if args.is_simulation then
						print (tk_simulated)
						print_new_line
					else
						a_iron.catalog_api.install_package (l_package)
						if a_iron.installation_api.is_installed (l_package) then
							print (tk_successfully_installed)
							print_new_line
							print ("  [")
							print (a_iron.layout.package_installation_path (l_package).name)
							print ("]%N")
						else
							print (tk_failed)
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
