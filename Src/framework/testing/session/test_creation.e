note
	description: "[
		Base implementations of {TEST_CREATION_I}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_CREATION

inherit
	TEST_CREATION_I

	TEST_SESSION
		undefine
			new_record
		redefine
			make
		end

feature {NONE} -- Initialization

	make (a_test_suite: like test_suite)
			-- <Precursor>
		do
			Precursor (a_test_suite)
			create test_created_event
		end

feature -- Access

	creation_connection: EVENT_CONNECTION_I [TEST_CREATION_OBSERVER, TEST_CREATION_I]
			-- <Precursor>
		local
			l_cache: like creation_connection_cache
		do
			l_cache := creation_connection_cache
			if l_cache = Void then
				l_cache := create {EVENT_CHAINED_CONNECTION [TEST_CREATION_OBSERVER, TEST_CREATION_I, TEST_SESSION_OBSERVER, TEST_SESSION_I]}.make
					(agent (an_observer: TEST_CREATION_OBSERVER): ARRAY [TUPLE [EVENT_TYPE [TUPLE], PROCEDURE [ANY, TUPLE]]]
						do
							Result := <<
								[test_created_event, agent an_observer.on_test_created]
							>>
						end,
					connection)
				creation_connection_cache := l_cache
			end
			Result := l_cache
		end

feature {NONE} -- Events

	test_created_event: EVENT_TYPE [TUPLE [session: TEST_CREATION_I; test: READABLE_STRING_8]]
			-- <Precursor>

feature {NONE} -- Basic operations

	publish_test_creation (a_name: IMMUTABLE_STRING_8)
			-- Notify observers of `Current' and `record' that new test was created.
			--
			-- `a_name': Name of new test.
		require
			a_name_attached: a_name /= Void
			usable: is_interface_usable
			running: has_next_step
			a_name_not_empty: not a_name.is_empty
		local
			l_record: like record
			l_repo: TEST_RECORD_REPOSITORY_I
		do
			l_record := record
			l_record.add_test (a_name)
			test_created_event.publish ([Current, a_name])
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
