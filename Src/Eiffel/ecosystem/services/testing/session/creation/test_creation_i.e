note
	description: "[
		Abstract interface of a test session which is capable of creating new tests.
		
		Whenever a new test is created, only the test name published to the observer. If required, they 
		can check {TEST_SUITE_S} if the corresponding {TEST_I} instance is available.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_CREATION_I

inherit
	TEST_SESSION_I
		redefine
			new_record
		select
			connection
		end

	EVENT_CONNECTION_POINT_I [TEST_CREATION_OBSERVER, TEST_CREATION_I]
		rename
			connection as creation_connection
		end

feature {NONE} -- Access

	creation_connection_cache: like creation_connection
			-- Cache for `execution_connection'
			--
			-- Note: do not use directly, use `execution_connection' instead

feature {NONE} -- Events

	test_created_event: EVENT_TYPE_I [TUPLE [session: TEST_CREATION_I; test: READABLE_STRING_8]]
			-- Events called when a new test has been created
			--
			-- session: `Current'.
			-- test: Test which was created
		require
			usable: is_interface_usable
		deferred
		end

feature {NONE} -- Factory

	new_record: TEST_CREATION_RECORD
			-- <Precursor>
		do
			create Result.make (Current)
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
