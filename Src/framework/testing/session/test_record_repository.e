note
	description: "[
		Implementation of a {TEST_RECORD_REPOSITORY_I} which keeps a limited number of records and uses
		the file system to store records permanently.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_RECORD_REPOSITORY

inherit
	TEST_RECORD_REPOSITORY_I

	DISPOSABLE_SAFE

	INTERNAL
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
				-- TODO: retrieve `record_storage' from file system!
			create record_storage.make_default

			create record_added_event
			create record_removed_event
			create record_updated_event
			create record_property_updated_event
		end

feature -- Access

	records: DS_ARRAYED_LIST [TEST_SESSION_RECORD]
			-- <Precursor>
		do
			create Result.make_from_linear (record_storage)
		end

	records_of_type (a_type: TYPE [TEST_SESSION_RECORD]): DS_ARRAYED_LIST [TEST_SESSION_RECORD]
			-- <Precursor>
		local
			l_records: like record_storage
		do
			l_records := record_storage
			create Result.make (l_records.count)
			from
				l_records.start
			until
				l_records.after
			loop
				if attached a_type.attempt (l_records.item_for_iteration) as l_item then
					l_records.force_last (l_item)
				end
				l_records.forth
			end
		end

feature {NONE} -- Access

	record_storage: DS_ARRAYED_LIST [TEST_SESSION_RECORD]

feature -- Status report

	has_record (a_record: TEST_SESSION_RECORD): BOOLEAN
			-- <Precursor>
		do
			Result := record_storage.has (a_record)
		end

feature -- Element change

	remove_record (a_record: TEST_SESSION_RECORD)
			-- <Precursor>
		local
			l_storage: like record_storage
		do
			l_storage := record_storage
			l_storage.start
			l_storage.search_forth (a_record)
			check found: not l_storage.off end
			l_storage.remove_at
			record_removed_event.publish ([Current, a_record])
		end

feature {TEST_SUITE_S} -- Element change

	append_record (a_record: TEST_SESSION_RECORD)
			-- <Precursor>
		local
			l_storage: like record_storage
			l_item: TEST_SESSION_RECORD
			i, l_count: INTEGER
			l_type: INTEGER
		do
			from
				l_type := dynamic_type (a_record)
				l_storage := record_storage
				l_storage.start
			until
				l_storage.after
			loop
				if l_type = dynamic_type (l_storage.item_for_iteration) then
					l_count := l_count + 1
					if i = 0 then
						i := l_storage.index
					end
				end
				l_storage.forth
			end
				-- Replace 4 with preference setting
			if l_count >= 10 then
				check valid_index: 1 <= i and i <= l_storage.count end
				l_item := l_storage.item (i)
				l_storage.remove (i)
				record_removed_event.publish ([Current, l_item])
			end
			l_storage.force_last (a_record)
			record_added_event.publish ([Current, a_record])
		end

feature {TEST_SESSION_I} -- Access

	record_updated_event: EVENT_TYPE [TUPLE [repository: TEST_RECORD_REPOSITORY_I; record: TEST_SESSION_RECORD]]
			-- <Precursor>

feature {NONE} -- Events

	record_added_event: EVENT_TYPE [TUPLE [repository: TEST_RECORD_REPOSITORY_I; record: TEST_SESSION_RECORD]]
			-- <Precursor>

	record_removed_event: EVENT_TYPE [TUPLE [repository: TEST_RECORD_REPOSITORY_I; record: TEST_SESSION_RECORD]]
			-- <Precursor>

	record_property_updated_event: EVENT_TYPE [TUPLE [repository: TEST_RECORD_REPOSITORY_I; record: TEST_SESSION_RECORD]]
			-- <Precursor>

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
			if a_explicit then
				record_updated_event.dispose
				record_added_event.dispose
				record_removed_event.dispose

					-- TODO: store `records_of_type' to file system
			end
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
