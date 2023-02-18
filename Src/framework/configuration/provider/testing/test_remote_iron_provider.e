note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_REMOTE_IRON_PROVIDER

inherit
	EQA_TEST_SET

feature -- Test routines

	test_remote_iron
			-- New test routine
		local
			iron_prov: ES_LIBRARY_IRON_PROVIDER
			prov: ES_LIBRARY_PROVIDER
			target: detachable CONF_TARGET
		do
			target := new_conf_target ("test_remote_iron_provider")
			create iron_prov
			prov := iron_prov
			if attached prov.libraries (Void, target) as libs then
			end
		end

	new_conf_target (a_name: READABLE_STRING_8): CONF_TARGET
		local
			fac: CONF_PARSE_FACTORY
			sys: CONF_SYSTEM
		do
			create fac
			sys := fac.new_system_generate_uuid_with_file_name (a_name, a_name, {CONF_FILE_CONSTANTS}.latest_namespace)
			Result := fac.new_target (a_name, sys)
		end

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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


