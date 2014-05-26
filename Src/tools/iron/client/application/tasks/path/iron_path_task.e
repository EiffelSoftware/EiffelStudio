note
	description: "Summary description for {IRON_PATH_TASK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_PATH_TASK

inherit
	IRON_TASK

create
	make

feature -- Access

	name: STRING = "path"
			-- Iron client task

feature -- Execute

	process (a_iron: IRON)
		local
			args: IRON_PATH_ARGUMENT_PARSER
		do
			create args.make (Current)
			args.execute (agent execute (args, a_iron))
		end

	execute (args: IRON_PATH_ARGUMENTS; a_iron: IRON)
		local
			l_resources: LIST [READABLE_STRING_32]
		do
			l_resources := args.resources
			if l_resources.is_empty then
				print (a_iron.layout.path.name)
				io.put_new_line
			else
				across
					l_resources as c
				loop
					if
						c.item.starts_with ("http://")
						or c.item.starts_with ("https://")
						or c.item.starts_with ("file://")
					then
						if attached a_iron.catalog_api.package_associated_with_uri (c.item) as l_package then
							display_information (l_package, args, a_iron)
						end
					else
						if attached a_iron.catalog_api.packages_associated_with_name (c.item) as lst then
							across
								lst as p
							loop
								display_information (p.item, args, a_iron)
							end
						end
					end
				end
			end
		end

	display_information (a_package: IRON_PACKAGE; args: IRON_ARGUMENTS; a_iron: IRON)
		do
			if
				a_iron.installation_api.is_package_installed (a_package) and then
				attached a_iron.installation_api.package_installation_path (a_package) as l_installation_path
			then
				print (l_installation_path.name)
				io.put_new_line
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
