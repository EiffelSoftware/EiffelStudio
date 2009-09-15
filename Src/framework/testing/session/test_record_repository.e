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

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			l_project: like eiffel_project
		do
				-- TODO: retrieve `record_storage' from file system!
			create record_storage.make_default
			create property_storage.make_default

			create record_added_event
			create record_removed_event
			create record_property_updated_event

			if is_project_initialized then
				retrieve_records_once
			else
				eiffel_project.manager.load_agents.extend_kamikaze (agent retrieve_records_once)
				eiffel_project.manager.compile_stop_agents.extend_kamikaze (agent retrieve_records_once)
			end
		end

	retrieve_records_once
			-- Retrieve records from previous sessions by ensuring it is only done once.
		do
			if not has_retrieved_records then
				if is_project_initialized then
					retrieve_records
				else
					eiffel_project.manager.compile_stop_agents.extend_kamikaze (agent retrieve_records_once)
				end
			end
		end

	retrieve_records
			-- Retrieve records from previous sessions.
		require
			project_initialized: is_project_initialized
			not_retrieved_records: not has_retrieved_records
		local
			l_path: like path
			l_directory: DIRECTORY
			l_done: BOOLEAN
			l_filename: FILE_NAME
			l_file: RAW_FILE
			l_existing: like record_storage
		do
			create l_existing.make_from_linear (record_storage)
			l_path := path
			create l_directory.make (l_path)
			if l_directory.exists then
				l_directory.open_read
				if not l_directory.is_closed then
					from
						l_directory.start
					until
						l_done
					loop
						l_directory.readentry
						if attached l_directory.lastentry as l_entry then
							create l_filename.make_from_string (l_path)
							l_filename.set_file_name (l_entry)
							retrieve_record (l_filename)
						else
							l_done := True
						end
					end
					l_directory.close
				end
			else
				l_directory.recursive_create_dir
			end
			has_retrieved_records := True

				-- Store previously existing records to disk
			l_existing.do_all (
				agent (a_record: TEST_SESSION_RECORD)
					do
						seek_record (a_record)
						store_record_at_index (record_storage.index)
					end)
		ensure
			retrieved_records: has_retrieved_records
		end

	retrieve_record (a_filename: FILE_NAME)
			-- Try to retrieve record/properties from given filename.
		local
			l_retried: BOOLEAN
			l_file: detachable RAW_FILE
		do
			if not l_retried then
				create l_file.make (a_filename)
				if l_file.exists and then l_file.is_plain then
					l_file.open_read
					if l_file.is_open_read and l_file.readable then
						if attached {TUPLE [record: TEST_SESSION_RECORD; props: detachable TUPLE]} l_file.retrieved as l_retrieved then
							if not has_record (l_retrieved.record) then
								append_record_sorted (l_retrieved.record, new_property_tuple (l_retrieved.props))
							end
						end
					end
				end
			end
			if attached l_file and then not l_file.is_closed then
				l_file.close
			end
		rescue
			l_retried := True
			retry
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
			-- List of records in `Current'.

	property_storage: DS_ARRAYED_LIST [like new_property_tuple]
			-- List of properties associated with records in `record_storage'

	path: DIRECTORY_NAME
			-- Path to record files
		require
			project_initialized: is_project_initialized
		do
			Result := eiffel_project.project_directory.testing_results_path.twin
			Result.extend (record_directory_name)
		end

	file_name (a_record: TEST_SESSION_RECORD): FILE_NAME
			-- File name for given record
			--
			-- `a_record': Record for which file name should be returned.
		require
			a_record_attached: a_record /= Void
			project_initialized: is_project_initialized
		do
			create Result.make_from_string (path)
			Result.set_file_name (a_record.creation_date.formatted_out (file_name_format_string))
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	has_record (a_record: TEST_SESSION_RECORD): BOOLEAN
			-- <Precursor>
		do
			Result := record_storage.has (a_record)
		end

	is_record_persistent (a_record: TEST_SESSION_RECORD): BOOLEAN
			-- <Precursor>
		do
			seek_record (a_record)
			Result := property_storage.item_for_iteration.persistent
		end

feature {NONE} -- Status report

	is_project_initialized: BOOLEAN
			-- Has project been initialized?
		local
			l_project: like eiffel_project
		do
			l_project := eiffel_project
			if l_project.initialized and then l_project.system_defined then
				if attached l_project.project_directory as l_dir then
					Result := not l_dir.testing_results_path.is_empty
				end
			end
		ensure
			result_implies_valid_testing_directory: Result implies
				(attached eiffel_project.project_directory as l_dir and then not l_dir.testing_results_path.is_empty)
		end

	has_retrieved_records: BOOLEAN
			-- Has `retrieve_records' been called yet?

feature -- Status setting

	force_record_persistence (a_record: TEST_SESSION_RECORD)
			-- <Precursor>
		do
			seek_record (a_record)
			property_storage.item_for_iteration.persistent := True
			record_property_updated_event.publish ([Current, a_record])
		end

feature {NONE} -- Status setting

	seek_record (a_record: TEST_SESSION_RECORD)
			-- Move cursors in `record_storage' and `property_storage' to position of given record.
		require
			has_record: has_record (a_record)
		local
			l_storage: like record_storage
		do
			l_storage := record_storage
			l_storage.start
			l_storage.search_forth (a_record)
			check found: not l_storage.off end
			property_storage.go_i_th (l_storage.index)
		ensure
			storage_cursor_valid: not record_storage.off and then record_storage.item_for_iteration = a_record
			property_cursor_valid: record_storage.index = property_storage.index
		end

feature -- Element change

	remove_record (a_record: TEST_SESSION_RECORD)
			-- <Precursor>
		do
			seek_record (a_record)
			remove_record_at_index (record_storage.index)
		end

feature {TEST_SUITE_S} -- Element change

	append_record (a_record: TEST_SESSION_RECORD)
			-- <Precursor>
		do
			append_record_sorted (a_record, new_property_tuple (Void))
		end

feature {NONE} -- Element change

	store_record_at_index (an_index: INTEGER)
			-- Store record and properties at given index to disk.
			--
			-- `an_index': Index of record to be stored.
		require
			a_index_valid: 1 <= an_index and an_index <= record_storage.count
		local
			l_retried: BOOLEAN
			l_file: detachable RAW_FILE
			l_record: TEST_SESSION_RECORD
		do
			if not l_retried and is_project_initialized and has_retrieved_records then
				l_record := record_storage.item (an_index)
				create l_file.make (file_name (l_record))
				l_file.create_read_write
				l_file.independent_store ([l_record, property_storage.item (an_index)])
			end
			if attached l_file and then not l_file.is_closed then
				l_file.close
			end
		rescue
			l_retried := True
			retry
		end

	remove_record_at_index (an_index: INTEGER)
			-- Remove record and properties at given index.
			--
			-- `an_index': Index of record to be removed.
		require
			a_index_valid: 1 <= an_index and an_index <= record_storage.count
		local
			l_records: like record_storage
			l_props: like property_storage
			l_record: TEST_SESSION_RECORD
			l_file: RAW_FILE
		do
			l_records := record_storage
			property_storage.remove (an_index)
			l_records.go_i_th (an_index)
			l_record := l_records.item_for_iteration
			l_records.remove_at

			if is_project_initialized then
				create l_file.make (file_name (l_record))
				if l_file.exists then
					l_file.delete
				end
			end

			record_removed_event.publish ([Current, l_record])
		ensure
			removed: not has_record (old record_storage.item (an_index))
		end

feature {NONE} -- Element change

	append_record_sorted (a_record: TEST_SESSION_RECORD; a_property: like new_property_tuple)
			-- Add given record and property to `record_storage' and `property_storage' using insertion
			-- sort. Remove any non-persistent record of the same type to maintain `max_records_per_type'.
			--
			-- `a_record': Record to be added.
			-- `a_property': Properties of `a_record' to be added.
		require
			a_record_attached: a_record /= Void
			a_property_attached: a_property /= Void
			usable: is_interface_usable
			not_has_record: not has_record (a_record)
			a_record_not_attached: not a_record.is_attached
		local
			l_item: TEST_SESSION_RECORD
			l_storage: like record_storage
			l_properties: like property_storage
			l_remove, l_count, l_pos: INTEGER
			l_type: INTEGER
		do
			from
				l_type := dynamic_type (a_record)
				l_storage := record_storage
				l_storage.start
				l_properties := property_storage
				l_properties.start
			until
				l_storage.after
			loop
				l_item := l_storage.item_for_iteration
				if l_item < a_record then
					l_pos := l_pos + 1
				end
				if l_type = dynamic_type (l_item) and not l_properties.item_for_iteration.persistent then
					l_count := l_count + 1
					if l_remove = 0 then
						l_remove := l_storage.index
					end
				end
				l_storage.forth
				l_properties.forth
			end

				-- Remove first non persistent record of same type if `l_count' exceeds `max_records_per_type'
			if l_count >= max_records_per_type then
				check valid_index: 1 <= l_remove and l_remove <= l_storage.count end
				if l_remove <= l_pos then
					l_pos := l_pos - 1
				end
				remove_record_at_index (l_remove)
			end

			l_storage.go_i_th (l_pos)
			l_storage.force_right (a_record)
			l_properties.go_i_th (l_pos)
			l_properties.force_right (a_property)
			a_record.attach_repository (Current)
			store_record_at_index (l_pos + 1)
			record_added_event.publish ([Current, a_record])
		end

feature {NONE} -- Events

	record_added_event: EVENT_TYPE [TUPLE [repository: TEST_RECORD_REPOSITORY_I; record: TEST_SESSION_RECORD]]
			-- <Precursor>

	record_removed_event: EVENT_TYPE [TUPLE [repository: TEST_RECORD_REPOSITORY_I; record: TEST_SESSION_RECORD]]
			-- <Precursor>

	record_property_updated_event: EVENT_TYPE [TUPLE [repository: TEST_RECORD_REPOSITORY_I; record: TEST_SESSION_RECORD]]
			-- <Precursor>

feature {NONE} -- Factory

	new_property_tuple (an_old_property: detachable TUPLE): TUPLE [persistent: BOOLEAN]
			-- New property tuple. If an old tuple is given try to retrieve previous values.
			--
			-- persistent: should record be stored persistently?
		local
			l_count: INTEGER
		do
			Result := [False]
			if an_old_property /= Void then
				l_count := an_old_property.count
				if l_count >= 1 then
					if an_old_property.is_boolean_item (1) then
						Result.persistent := an_old_property.boolean_item (1)
					end
				end
			end
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
			if a_explicit then
				record_added_event.dispose
				record_removed_event.dispose
			end
		end

feature {NONE} -- Constants

	max_records_per_type: INTEGER = 5
			-- Maximum number of non-persistent records per type

	record_directory_name: STRING = "records"
			-- Subdirectory name where record should be stored permamently
                                    --"[0]mm/[0]dd/yyyy hh12:[0]mi:[0]ss.ff3 AM"
	file_name_format_string: STRING = "yyyy-[0]mm-[0]dd hh12:[0]mi:[0]ss.ff3 AM"

invariant
	same_record_and_property_count: record_storage.count = property_storage.count

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
