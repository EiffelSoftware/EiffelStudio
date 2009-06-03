note
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_BACKUP

inherit
	SQLITE_BACKUP_EXTERNALS
		export
			{NONE} all
		end

	SQLITE_SHARED_API

create
	make

feature {NONE} -- Initialization

	make (a_source: SQLITE_DATABASE; a_destination: SQLITE_DATABASE)
			-- Backs up a source data to a destination.
			-- Note: No operations should be performed on the destination database whilst a database is being backed up
		require
			is_interface_usable: is_interface_usable
			a_source_attached: attached a_source
			a_source_is_interface_usable: a_source.is_interface_usable
			a_source_is_readable: a_source.is_readable
			not_a_source_is_locked: not a_source.is_locked
			a_destination_attached: attached a_destination
			a_destination_is_interface_usable: a_destination.is_interface_usable
			a_destination_is_writable: a_destination.is_writable
			not_a_destination_is_locked: not a_destination.is_locked
			not_is_same_connection: not a_source.is_same_connection (a_destination)
		do
			source := a_source
			destination := a_destination
		end

feature -- Access

	source: SQLITE_DATABASE
			-- The source database to back up from.

	destination: SQLITE_DATABASE
			-- The destination database to back up to.

feature -- Access

	last_exception: detachable SQLITE_EXCEPTION
			-- The last exception raised when processing the back up.

feature -- Measurements

	page_count: NATURAL
			-- Number of pages in the source database to back up.

	remaining_pages: NATURAL
			-- Number of remaining pages to process.

feature -- Status report

	is_backing_up: BOOLEAN
			-- Indicates if a back is currently being processed.

	is_backed_up: BOOLEAN
			-- Indicates if a back up has already taken place.

feature {NONE} -- Status report

	is_abort_requested: BOOLEAN
			-- Indicates if an abort was requested

feature -- Actions

	start_actions: ACTION_SEQUENCE [ANY, TUPLE]
			-- Actions called when a back up is started.
		do
			if attached internal_start_actions as l_result then
				Result := l_result
			else
				create Result
				internal_start_actions := Result
			end
		ensure
			result_attached: attached Result
			result_consistent: Result = start_actions
		end

	progress_actions: ACTION_SEQUENCE [ANY, TUPLE]
			-- Actions called when a back up is started.
		do
			if attached internal_progress_actions as l_result then
				Result := l_result
			else
				create Result
				internal_progress_actions := Result
			end
		ensure
			result_attached: attached Result
			result_consistent: Result = progress_actions
		end

	finished_actions: ACTION_SEQUENCE [ANY, TUPLE]
			-- Actions called when a back up is completed.
		do
			if attached internal_finished_actions as l_result then
				Result := l_result
			else
				create Result
				internal_finished_actions := Result
			end
		ensure
			result_attached: attached Result
			result_consistent: Result = finished_actions
		end

feature -- Basic operations

	backup
			-- Starts the back up process
		require
			is_interface_usable: is_interface_usable
			not_is_backing_up: not is_backing_up
			source_is_interface_usable: source.is_interface_usable
			source_is_readable: source.is_readable
			not_source_is_locked: not source.is_locked
			destination_is_interface_usable: destination.is_interface_usable
			destination_is_writable: destination.is_writable
			not_a_destination_is_locked: not a_destination.is_locked
		do
			is_abort_requested := False
			destination.lock
			l_locked := True

			

			l_locked := False
			destination.unlock
		ensure
			is_backing_up: is_backing_up
		rescue
			if l_locked then
				l_locked := False
				destination.unlock
			end
		end

	abort
			-- Call to abort the back up
		require
			is_backing_up: is_backing_up
		do
			is_abort_requested := True
		ensure
			is_abort_requested: is_abort_requested
		end

--feature -- Basic operations

--	backup (a_source: SQLITE_DATABASE; a_destination: SQLITE_DATABASE)
--			-- Backs up a source data to a destination.
--			-- Note: No operations should be performed on the destination database whilst a database is being backed up
--		require
--			is_interface_usable: is_interface_usable
--			a_source_attached: attached a_source
--			a_source_is_interface_usable: a_source.is_interface_usable
--			a_source_is_readable: a_source.is_readable
--			not_a_source_is_locked: not a_source.is_locked
--			a_destination_attached: attached a_destination
--			a_destination_is_interface_usable: a_destination.is_interface_usable
--			a_destination_is_writable: a_destination.is_writable
--			not_a_destination_is_locked: not a_destination.is_locked
--			not_is_same_connection: not a_source.is_same_connection (a_destination)
--		do

--		end

--	backup_with_callbacks (a_source: SQLITE_DATABASE; a_destination: SQLITE_DATABASE)
--			-- Backs up a source data to a destination.
--			-- Note: No operations should be performed on the destination database whilst a database is being backed up
--		require
--			is_interface_usable: is_interface_usable
--			a_source_attached: attached a_source
--			a_source_is_interface_usable: a_source.is_interface_usable
--			a_source_is_readable: a_source.is_readable
--			not_a_source_is_locked: not a_source.is_locked
--			a_destination_attached: attached a_destination
--			a_destination_is_interface_usable: a_destination.is_interface_usable
--			a_destination_is_writable: a_destination.is_writable
--			not_a_destination_is_locked: not a_destination.is_locked
--			not_is_same_connection: not a_source.is_same_connection (a_destination)
--		do

--		end

invariant
	source_attached: attached source
	destination_attached: attached destination
	not_is_same_connection: not source.is_same_connection (destination)

;note
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
