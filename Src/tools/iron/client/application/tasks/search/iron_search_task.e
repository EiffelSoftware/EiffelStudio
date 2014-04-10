note
	description: "Summary description for {IRON_SEARCH_TASK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_SEARCH_TASK

inherit
	IRON_TASK

create
	make

feature -- Access

	name: STRING = "search"
			-- Iron client task

feature -- Execute

	process (a_iron: IRON)
		local
			args: IRON_SEARCH_ARGUMENT_PARSER
		do
			create args.make (Current)
			args.execute (agent execute (args, a_iron))
		end

	execute (args: IRON_SEARCH_ARGUMENTS; a_iron: IRON)
		local
			s,t: READABLE_STRING_32
		do
			across
				args.resources as c
			loop
				print ("Search %"")
				print (c.item)
				print ("%" ...%N")
				if
					c.item.starts_with ("http://")
					or c.item.starts_with ("https://")
					or c.item.starts_with ("file://")
				then
					if attached a_iron.installation_api.local_path_associated_with_uri (c.item) as l_path then
						print ("Installed:%N  ")
						print (l_path.name)
						print ("%N")
					end
					if attached a_iron.catalog_api.available_path_associated_with_uri (c.item) as l_path then
						print ("Available:%N  ")
						print (l_path.name)
						print ("%N")
					end
				else
					if attached a_iron.installation_api.packages_associated_with_name (c.item) as lst then
						print ("Installed inside %"")
						s := a_iron.layout.packages_path.name
						print (s)
						print ("%":%N")
						across
							lst as p
						loop
							print (" - ")
--							print (p.item.human_identifier)
							if attached a_iron.installation_api.package_installation_path (p.item) as l_installation_path then
								t := l_installation_path.name
								print (t.substring (s.count + 2, t.count))
							else
								print ("not found")
							end
							print ("%N")
						end
					end
					if attached a_iron.catalog_api.packages_associated_with_name (c.item) as lst then
						print ("Available:%N")
						across
							lst as p
						loop
							print (" - ")
							print (p.item.human_identifier)
							print ("%N")
						end
					end
				end
				print ("%N")
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
