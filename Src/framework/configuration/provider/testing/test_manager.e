note
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_MANAGER

inherit
	EQA_TEST_SET

feature -- Access

	test_manager
		local
			m: ES_LIBRARY_PROVIDER_SERVICE
			iron_prov: ES_LIBRARY_IRON_PROVIDER
			deliv_prov: ES_LIBRARY_LOCAL_PROVIDER
			index_prov: ES_LIBRARY_INDEX_PROVIDER
			tgt: CONF_TARGET
		do
			create m.make (2)
			create iron_prov
			create deliv_prov
			create index_prov
			m.register (deliv_prov)
			m.register (iron_prov)
			m.register (index_prov)

			tgt := new_test_target ("all")

			iron_prov.reset (tgt)
			deliv_prov.reset (tgt)
			index_prov.reset (tgt)

			if attached m.libraries (Void, tgt, Void) as lst then

			end
		end

	test_deliv
		local
			m: ES_LIBRARY_PROVIDER_SERVICE
			deliv_prov: ES_LIBRARY_LOCAL_PROVIDER
			tgt: CONF_TARGET
		do
			create m.make (2)
			create deliv_prov
			m.register (deliv_prov)

			tgt := new_test_target ("deliv")

			deliv_prov.reset (tgt)
			if attached m.libraries (Void, tgt, Void) as lst then

			end
		end

	test_iron
		local
			m: ES_LIBRARY_PROVIDER_SERVICE
			iron_prov: ES_LIBRARY_IRON_PROVIDER
			tgt: CONF_TARGET
		do
			create m.make (2)
			create iron_prov
			m.register (iron_prov)

			tgt := new_test_target ("iron")

			iron_prov.reset (tgt)

			if attached m.libraries (Void, tgt, Void) as lst then

			end
		end

	new_test_target (a_name: READABLE_STRING_8): CONF_TARGET
		local
			fac: CONF_PARSE_FACTORY
		do
			create fac
			Result := fac.new_target ("test_" + a_name, fac.new_system_generate_uuid_with_file_name ("no_test_file_for_"+ a_name +".ecf", "test_" + a_name, {CONF_FILE_CONSTANTS}.latest_namespace))
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
