note
	description: "Summary description for {ES_IRON_CLIENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_IRON_CLIENT

inherit
	IRON_CLIENT
		redefine
			iron_layout,
			initialize_iron
		end

	EIFFEL_LAYOUT
		rename
			print as print_any
		export
			{NONE} all
		end

	IRON_NAMES
		rename
			print as print_any
		export
			{NONE} all
		end

	IRON_EXPORTER
		rename
			print as print_any
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	initialize_iron (a_iron: IRON)
			-- Initialize `a_iron' if needed
		local
			repo: IRON_REPOSITORY
			l_version: STRING
		do
			if
				a_iron.catalog_api.repositories.is_empty and then
				is_eiffel_layout_defined
			then
					-- Initialize default repo
				print ("First initialization with default repository...%N")
				create l_version.make (5)
				l_version.append ({EIFFEL_CONSTANTS}.major_version.out)
				l_version.append_character ('.')
				if {EIFFEL_CONSTANTS}.minor_version < 10 then
					l_version.append_character ('0')
				end
				l_version.append ({EIFFEL_CONSTANTS}.minor_version.out)

				create repo.make (create {URI}.make_from_string ("http://iron.eiffel.com/"), l_version)
				print (m_registering_repository ("iron", repo.url))
				io.put_new_line
				a_iron.catalog_api.register_repository ("iron", repo)

				print (m_updating_repositories)
				io.put_new_line
				a_iron.catalog_api.update
				io.put_new_line
			end
		end

feature -- Access

	iron_layout: ES_IRON_LAYOUT
		do
			if not is_eiffel_layout_defined then
				set_eiffel_layout (create {EC_EIFFEL_LAYOUT})
			end
			create Result.make (eiffel_layout)
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
