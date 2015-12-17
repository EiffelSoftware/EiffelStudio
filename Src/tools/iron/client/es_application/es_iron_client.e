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
			initialize_iron,
			tasks
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

	EIFFEL_CONSTANTS
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
			repo: IRON_WEB_REPOSITORY
			l_version: STRING
		do
			if
				a_iron.catalog_api.repositories.is_empty and then
				is_eiffel_layout_defined
			then
					-- Initialize default repo
				print ("First initialization with default repository...%N")
				create l_version.make (5)
				l_version.append (two_digit_minimum_major_version)
				l_version.append_character ('.')
				l_version.append (two_digit_minimum_minor_version)

				create repo.make_from_version_uri (create {URI}.make_from_string ("https://iron.eiffel.com/" + l_version))
				print (m_registering_repository (repo.location_string))
				io.put_new_line
				a_iron.catalog_api.register_repository (repo)

				print (m_updating_repositories)
				io.put_new_line
				a_iron.catalog_api.update
				io.put_new_line
			end
		end

feature -- Access

	iron_layout: ES_IRON_LAYOUT
		local
			lay: EC_EIFFEL_LAYOUT
		do
			if not is_eiffel_layout_defined then
				create lay
				lay.check_environment_variable
				set_eiffel_layout (lay)
			end
			create Result.make (eiffel_layout)
		end


	tasks: STRING_TABLE [TUPLE [factory_function: FUNCTION [ARRAY [IMMUTABLE_STRING_32], IRON_TASK]; description: READABLE_STRING_GENERAL]]
		once
			Result := Precursor
			Result.replace ([agent (args: like task_arguments): ES_IRON_INSTALL_TASK do create Result.make (args) end, "install package"], {ES_IRON_INSTALL_TASK}.name)

				-- Specific commands.
			Result.force ([agent (args: like task_arguments): IRON_UPDATE_PACKAGE_FILE_TASK  do create Result.make (args) end, "create or update package.iron file for a folder."], {IRON_UPDATE_PACKAGE_FILE_TASK}.name)
			Result.force ([agent (args: like task_arguments): IRON_UPDATE_ECF_TASK  do create Result.make (args) end, "Update the given Eiffel Configuration File (.ecf) to use IRON references."], {IRON_UPDATE_ECF_TASK}.name)


			debug ("iron")
				Result.force ([agent (args: like task_arguments): IRON_TESTING_TASK    do create Result.make (args) end, "Testing.."], "testing")
			end
		end

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software"
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
