note
	description: "Summary description for {IRON_TESTING_TASK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_TESTING_TASK

inherit
	IRON_TASK

create
	make

feature -- Access

	name: STRING = "testing"
			-- Iron client task

feature -- Execute

	process (a_iron: IRON)
		local
			lst: ARRAYED_LIST [IRON_PACKAGE]
			lst_to_uninstall: ARRAYED_LIST [IRON_PACKAGE]
			l_uri: URI
		do
			create lst.make (5)
			create lst_to_uninstall.make (5)

			print ("= Testing =%N")
			print ("== Update catalog ==%N")
			a_iron.catalog_api.update

			print ("== available repositories ==%N")
			across
				a_iron.catalog_api.repositories as c
			loop
				print ("  Repository [" + c.item.location_string + ")%N")
				display_packages (Void, c.item)
				across
					c.item as p
				loop
					lst.force (p.item)
--					print ("  - package [" + p.item.human_identifier + "]%N")
				end
			end

			display_installed_packages (a_iron)
			across
				a_iron.installation_api.installed_packages as p
			loop
				lst_to_uninstall.force (p.item)
			end

			print ("== Operations ==%N")

			if not lst_to_uninstall.is_empty then
				across
					lst_to_uninstall as p
				loop
					print ("* Uninstall ["+ p.item.human_identifier +"] ==%N")
					a_iron.catalog_api.uninstall_package (p.item)
				end
			end
			if not lst.is_empty then
				across
					lst as p
				loop
					if attached {IRON_WEB_REPOSITORY} p.item.repository as l_remote_repo then
						print ("* Download ["+ p.item.human_identifier +"] ==%N")
						a_iron.catalog_api.download_package (l_remote_repo, p.item, True)
					end
				end
			end
			if not lst.is_empty then
				across
					lst as p
				loop
					if attached {IRON_WEB_REPOSITORY} p.item.repository as l_remote_repo then
						print ("* Install ["+ p.item.human_identifier +"] ==%N")
						a_iron.catalog_api.install_package (l_remote_repo, p.item, True)
						a_iron.catalog_api.setup_package_installation (p.item, Void, True)
					end
				end
			end

			create l_uri.make_from_string ("http://localhost:9090/14.05/eiffel.com/library/preferences/xml_pref-safe.ecf")
			print ("* Path associated with "+ l_uri.string +" ?%N")

			if attached a_iron.installation_api.local_path_associated_with_uri (l_uri.string) as l_path then
				print ("  -> Installed: " + l_path.name + "%N")
			elseif attached a_iron.catalog_api.available_path_associated_with_uri (l_uri.string) as l_path then
				print ("  -> Available: " + l_path.name + "%N")
			else
				print ("  -> Not found%N")
			end
		end

	display_installed_packages (a_iron: IRON)
		do
			display_packages ("== Installed packages ==", a_iron.installation_api.installed_packages)
		end

	display_packages (a_title: detachable READABLE_STRING_8; lst: ITERABLE [IRON_PACKAGE])
		do
			if a_title /= Void then
				print (a_title)
				print ("%N")
			end
			across
				lst as c
			loop
				print ("  - package [" + c.item.human_identifier + "]")
				print ("%N")
				across
					c.item.associated_paths as cur
				loop
					print ("%T"+ c.item.repository.location_string + cur.item +"%N")
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
