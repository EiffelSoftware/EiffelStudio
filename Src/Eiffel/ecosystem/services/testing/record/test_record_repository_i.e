note
	description: "[
		Repository containing {TEST_SESSION_RECORD} objects from previous testing sessions.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_RECORD_REPOSITORY_I

inherit
	USABLE_I

	EVENT_CONNECTION_POINT_I [TEST_RECORD_REPOSITORY_OBSERVER, TEST_RECORD_REPOSITORY_I]

feature -- Access

	records: DS_ARRAYED_LIST [TEST_SESSION_RECORD]
			-- All records stored in `Current'.
		require
			usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			results_valid: Result.for_all (agent has_record (?))
			results_sorted: Result.sorted (create {DS_BUBBLE_SORTER [TEST_SESSION_RECORD]}.make (
				create {KL_COMPARABLE_COMPARATOR [TEST_SESSION_RECORD]}.make))
		end

	records_of_type (a_type: TYPE [TEST_SESSION_RECORD]): like records
			-- All records stored in `Current' of a specific type.
			--
			-- `a_type': Type of records to be returned.
		require
			a_type_attached: a_type /= Void
			usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			results_is_subset: attached records as l_all and then Result.for_all (agent l_all.has (?))
			results_conform: Result.for_all (
				agent (a_t: TYPE [TEST_SESSION_RECORD]; a_record: TEST_SESSION_RECORD): BOOLEAN
					do
						Result := a_t.attempt (a_record) /= Void
					end (a_type, ?))
			results_sorted: Result.sorted (create {DS_BUBBLE_SORTER [TEST_SESSION_RECORD]}.make (
				create {KL_COMPARABLE_COMPARATOR [TEST_SESSION_RECORD]}.make))
		end

	connection: EVENT_CONNECTION_I [TEST_RECORD_REPOSITORY_OBSERVER, TEST_RECORD_REPOSITORY_I]
			-- <Precursor>
		local
			l_cache: like connection_cache
		do
			l_cache := connection_cache
			if l_cache = Void then
				l_cache := create {EVENT_CONNECTION [TEST_RECORD_REPOSITORY_OBSERVER, TEST_RECORD_REPOSITORY_I]}.make
					(agent (an_observer: TEST_RECORD_REPOSITORY_OBSERVER): ARRAY [TUPLE [EVENT_TYPE [TUPLE], PROCEDURE [ANY, TUPLE]]]
						do
							Result := <<
									[record_added_event, agent an_observer.on_record_added],
									[record_removed_event, agent an_observer.on_record_removed],
									[record_property_updated_event, agent an_observer.on_record_property_updated]
								>>
						end)
				connection_cache := l_cache
			end
			Result := l_cache
		end

feature {NONE} -- Access

	record_added_event: EVENT_TYPE [TUPLE [repository: TEST_RECORD_REPOSITORY_I; record: TEST_SESSION_RECORD]]
			-- Events called when a record is added to `Current'.
			--
			-- repository: `Current'.
			-- record: Record which was added to `Current'.
		require
			usable: is_interface_usable
		deferred
		end

	record_removed_event: EVENT_TYPE [TUPLE [repository: TEST_RECORD_REPOSITORY_I; record: TEST_SESSION_RECORD]]
			-- Events called after a record was removed from `Current'.
			--
			-- repository: `Current'.
			-- record: Record which was removed from `Current'.
		require
			usable: is_interface_usable
		deferred
		end

	record_property_updated_event: EVENT_TYPE [TUPLE [repository: TEST_RECORD_REPOSITORY_I; record: TEST_SESSION_RECORD]]
			-- Events called after a property of a record was changed.
			--
			-- Note: a property is considered any record dependent query in `Current'.
			--
			-- repository: `Current'.
			-- record: Record for which a property of `Current' was changed.
		require
			usable: is_interface_usable
		deferred
		end

	connection_cache: detachable like connection
			-- Cache for `connection'
			--
			-- Note: do not use directly, use `connection' instead.

feature -- Status setting

	force_record_persistence (a_record: TEST_SESSION_RECORD)
			-- Force permament storage of given record.
			--
			-- `a_record': Record which should be stored persistently.
		require
			a_record_attached: a_record /= Void
			usable: is_interface_usable
			has_a_record: has_record (a_record)
		deferred
		end

feature -- Query

	has_record (a_record: TEST_SESSION_RECORD): BOOLEAN
			-- Does `Current' contain a specific record?
			--
			-- `a_record': A test record.
		require
			a_record_attached: a_record /= Void
			usable: is_interface_usable
		deferred
		ensure
			result_valid: Result = records.has (a_record)
			result_implies_attached: Result implies
				(a_record.is_attached and then a_record.repository = Current)
		end

	is_record_persistent (a_record: TEST_SESSION_RECORD): BOOLEAN
			-- Should given record be stored permanently?
		require
			a_record_attached: a_record /= Void
			usable: is_interface_usable
			has_a_record: has_record (a_record)
		deferred
		end

feature -- Element change

	remove_record (a_record: TEST_SESSION_RECORD)
			-- Remove record from `Current'.
			--
			-- `a_record': Record to be removed from `Current'.
		require
			a_record_attached: a_record /= Void
			usable: is_interface_usable
			has_record: has_record (a_record)
		deferred
		ensure
			not_has_rrecord: not has_record (a_record)
		end

feature {TEST_SUITE_S} -- Element change

	append_record (a_record: TEST_SESSION_RECORD)
			-- Add new record to `records'.
			--
			-- Note: there is no guarantee that `a_record' is part of `Current' after `append_record'
			--       returns. This is usually because the number of records in `Current' is limited and
			--       depending on the record's creation date.
			--
			-- Note: `a_record' should no longer be modified after calling `append_record', since these
			--       changes might not be stored permanently.
			--
			-- `a_record': Record to be added.
		require
			a_record_attached: a_record /= Void
			usable: is_interface_usable
			a_record_not_attached: not a_record.is_attached
			not_has_record: not has_record (a_record)
		deferred
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
