note
	description: "Observer for events in {TEST_STATISTICS_I}"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_STATISTICS_OBSERVER

inherit
	EVENT_OBSERVER_I

feature {TEST_STATISTICS_I} -- Events

	on_statistics_updated (a_statistics: TEST_STATISTICS_I)
			-- Called when general statistics have changed.
			--
			-- `a_statistics': Statistics which have changed.
		require
			a_statistics_attached: a_statistics /= Void
			a_statistics_usabel: a_statistics.is_interface_usable
		do

		ensure
			a_statistics_usable: a_statistics.is_interface_usable
		end

	on_test_statistics_updated (a_statistics: TEST_STATISTICS_I; a_test: TEST_I)
			-- Called when statistics for a test have changed.
			--
			-- `a_statistics': Statistics which have changed.
			-- `a_test': Test for which statistics have changed.
		require
			a_statistics_attached: a_statistics /= Void
			a_test_attached: a_test /= Void
			a_statistics_usable: a_statistics.is_interface_usable
			a_test_usable: a_test.is_interface_usable
			a_test_valid: a_statistics.test_suite.has_test (a_test.name) and then
				a_statistics.test_suite.test (a_test.name) = a_test
		do

		ensure
			a_statistics_usable: a_statistics.is_interface_usable
			a_test_usable: a_test.is_interface_usable
			a_test_valid: a_statistics.test_suite.has_test (a_test.name) and then
				a_statistics.test_suite.test (a_test.name) = a_test
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
