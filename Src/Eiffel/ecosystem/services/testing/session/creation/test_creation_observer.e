note
	description: "[
		Observer for events in {TEST_CREATION_I}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_CREATION_OBSERVER

inherit
	TEST_SESSION_OBSERVER

feature {TEST_CREATION_I} -- Events

	on_test_created (a_session: TEST_CREATION_I; a_test: READABLE_STRING_8)
			-- Called when a test was created.
			--
			-- Note: only the name of the created test is passed here, since it's actual TEST_I
			--       representation might not be available yet.
			--
			-- `a_session': Test creation which triggered event.
			-- `a_test': Name of test which was created.
		require
			a_session_attached: a_session /= Void
			a_test_attached: a_test /= Void
			a_session_usable: a_session.is_interface_usable
			a_test_not_empty: not a_test.is_empty
		do

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
