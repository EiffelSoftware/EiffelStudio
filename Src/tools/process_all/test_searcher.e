note
	description: "Visitor to find test in a system"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_SEARCHER

inherit
	CONF_ITERATOR
		redefine
			process_test_cluster,
			process_library
		end

feature -- Node visit

	process_test_cluster (a_test_cluster: CONF_TEST_CLUSTER)
			-- <Precursor>
		do
			has_test := True
		end

	process_library (a_library: CONF_LIBRARY)
			-- <Precursor>
		local
			l_loader: CONF_LOAD
		do
			if not has_test and then attached a_library.path as l_path then
				create l_loader.make (create {CONF_PARSE_FACTORY})
				l_loader.retrieve_configuration (l_path)
				if not l_loader.is_error and then attached l_loader.last_system as l_system and then attached l_system.uuid as l_uuid then
					if l_uuid.out.is_case_insensitive_equal (testing_library_uuid) then
						has_test := True
					end
				end
			end
		end

feature -- Status report

	has_test: BOOLEAN;
			-- Has test?

feature -- Constants

	testing_library_uuid: STRING = "B77B3A44-A1A9-4050-8DF9-053598561C33";

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
