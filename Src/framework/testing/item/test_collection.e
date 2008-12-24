indexing
	description: "[
		Objects representing an active collection of tests.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_COLLECTION

inherit
	TEST_COLLECTION_I

	DISPOSABLE_SAFE

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'
		do
			create test_added_event
			automation.auto_dispose (test_added_event)
			create test_removed_event
			automation.auto_dispose (test_removed_event)
			create test_changed_event
			automation.auto_dispose (test_changed_event)
			create tests_reset_event
			automation.auto_dispose (tests_reset_event)
		end

feature -- Events

	test_added_event: !EVENT_TYPE [TUPLE [collection: !ACTIVE_COLLECTION_I [!TEST_I]; active: !TEST_I]]
			-- <Precursor>

	test_removed_event: !EVENT_TYPE [TUPLE [collection: !ACTIVE_COLLECTION_I [!TEST_I]; active: !TEST_I]]
			-- <Precursor>

	test_changed_event: !EVENT_TYPE [TUPLE [collection: !ACTIVE_COLLECTION_I [!TEST_I]; active: !TEST_I]]
			-- <Precursor>

	tests_reset_event: !EVENT_TYPE [TUPLE [collection: !ACTIVE_COLLECTION_I [!TEST_I]]]
			-- <Precursor>

;indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
