note
	description: "[
		Factory responsible for creating instanced of {TEST_SESSION_I} for a test suite.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_SESSION_FACTORY [G -> TEST_SESSION_I]

feature -- Type

	frozen type: TYPE [G]
			-- Type of session created by `new_session'.
		do
			Result := {G}
		end

feature -- Factory

	new_session (a_test_suite: TEST_SUITE_S): G
			-- Create new session.
		require
			a_test_suite_attached: a_test_suite /= Void
			a_test_suite_usable: a_test_suite.is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			result_valid: Result.test_suite = a_test_suite
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
