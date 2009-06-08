note
	description: "[
		An SQLite database connection for reading, writing and creating SQLite databases.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_DATABASE

inherit
	SQLITE_SHARED_API

	DISPOSABLE
		export
			{NONE} dispose
		end

--inherit {NONE}
	SQLITE_INTERNALS
		export
			{NONE} all
		end

	SQLITE_DATABASE_EXTERNALS
		export
			{NONE} all
		end

	SQLITE_MEMORY_EXTERNALS
		export
			{NONE} all
		end

create
	make,
	make_open_read,
	make_open_read_write,
	make_create_read_write

feature {NONE} -- Initialization

	make (a_source: SQLITE_SOURCE)
			-- Initializes the database from a database source, which could be a file or in memory.
			-- Note: The connection is not opened when using this approach, use one of the `open_*'
			--       routines after initialization, or one of the `make_open_*' convenience routines.
			--
			-- `a_source': The source where the database is or should be located.
		require
			is_sqlite_available: is_sqlite_available
			a_source_attached: attached a_source
		do
			source := a_source
			if {PLATFORM}.is_thread_capable then
				internal_thread_id := get_current_thread_id.to_integer_32
			end
		ensure
			source_set: source = a_source
		end

	frozen make_open_read (a_file_name: READABLE_STRING_GENERAL)
			-- Creates a database from a local file in a read-only mode.
			--
			-- `a_file_name': The file where the database is located.
		require
			is_sqlite_available: is_sqlite_available
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
			a_file_name_is_string_8: a_file_name.is_string_8
			a_file_name_exists: (create {RAW_FILE}.make (a_file_name.as_string_8)).exists
		do
			make (create {SQLITE_FILE_SOURCE}.make (a_file_name))
			open_read
		end

	frozen make_open_read_write (a_file_name: READABLE_STRING_GENERAL)
			-- Creates a database from a local file in a read-write mode.
			--
			-- `a_file_name': The file where the database is located.
		require
			is_sqlite_available: is_sqlite_available
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
			a_file_name_is_string_8: a_file_name.is_string_8
			a_file_name_exists: (create {RAW_FILE}.make (a_file_name.as_string_8)).exists
		do
			make (create {SQLITE_FILE_SOURCE}.make (a_file_name))
			open_read_write
		end

	frozen make_create_read_write (a_file_name: READABLE_STRING_GENERAL)
			-- Creates a database from a local file in a read-write mode. In the event the database doesn't
			-- exist then a new database will be created.
			--
			-- `a_file_name': The file where the database is located.
		require
			is_sqlite_available: is_sqlite_available
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
			a_file_name_is_string_8: a_file_name.is_string_8
		do
			make (create {SQLITE_FILE_SOURCE}.make (a_file_name))
			open_create_read_write
		end

feature {NONE} -- Clean up

	dispose
			-- <Precursor>
		do
			if not is_in_final_collect then
				close
			end
		end

feature -- Access

	source: SQLITE_SOURCE
			-- Database source where the data is, or is to be, located.

feature -- Access: Error reporting

	last_exception: detachable SQLITE_EXCEPTION
			-- Last occuring error, set from a previous interaction with the database.
			-- Note: In multi-threaded modes, be sure to obtain a DB lock when performing an
			--       operation and then retrieving the error
			-- Note: This is not the last raised exception, for that use {EXCEPTION_MANAGER}
			--       This is an exception object generated from the internals of SQLite.
		require
			is_interface_usable: is_interface_usable
			is_accessible: is_accessible
			is_readable: is_readable
		local
			l_api: like sqlite_api
			l_db: like internal_db
			l_code: INTEGER
			l_msg: POINTER
			l_message: STRING
		do
			lock

			l_api := sqlite_api
			l_db := internal_db
			l_code := sqlite3_errcode (l_api, l_db)
			if not sqlite_success (l_code) then
				l_code := l_code | sqlite3_extended_errcode (l_api, l_db).bit_shift_left (8)
				l_msg := sqlite3_errmsg (l_api, l_db)
				if l_msg = default_pointer then
					create l_message.make (20)
					l_message.append (once "Unknown Error! (Code: ")
					l_message.append_integer (l_code)
					l_message.append_character (')')
				else
					create l_message.make_from_c (l_msg)
				end
				Result := sqlite_exception (l_code, l_message)
			end

			unlock
		ensure
			is_locked_unchanged: is_locked = old is_locked
		end

feature -- Measurements

	changes_count: NATURAL
			-- Number of database rows affects during the last insertion/update/deletion.
		require
			is_interface_usable: is_interface_usable
			is_accessible: is_accessible
			is_readable: is_readable
		do
			Result := sqlite3_changes (sqlite_api, internal_db).as_natural_32
		end

feature -- Status report

	is_accessible: BOOLEAN
			-- Indicates if the database is accessible on the current thread
		do
			if {PLATFORM}.is_thread_capable then
				Result := internal_thread_id = get_current_thread_id.to_integer_32
			else
				Result := True
			end
		ensure
			true_result: not {PLATFORM}.is_thread_capable implies Result
			same_internal_thread_id: (Result and {PLATFORM}.is_thread_capable) implies internal_thread_id = get_current_thread_id.to_integer_32
		end

	is_readable: BOOLEAN
			-- Indicates if the database can be read from.
		require
			is_accessible: is_accessible
		do
			Result := not is_closed
		ensure
			not_is_closed: Result implies not is_closed
		end

	is_writable: BOOLEAN
			-- Indicates if the database can be written to.
		require
			is_accessible: is_accessible
		do
			Result := not is_closed and then (internal_flags & SQLITE_OPEN_READWRITE) = SQLITE_OPEN_READWRITE
		ensure
			not_is_closed: Result implies not is_closed
			is_open_write: Result implies (internal_flags & SQLITE_OPEN_READWRITE) = SQLITE_OPEN_READWRITE
		end

	is_closed: BOOLEAN
			-- Indicates if the database is closed.
		require
			is_accessible: is_accessible
		do
			Result := internal_db = default_pointer
		ensure
			db_handle_is_null: Result implies internal_db = default_pointer
		end

	has_error: BOOLEAN
			-- Indicates if an error occured during the last operation on an open database.
		require
			is_sqlite_available: is_sqlite_available
			is_interface_usable: is_interface_usable
			not_is_closed: not is_closed
		do
			Result := last_exception /= Void
		ensure
			last_exception_attached: Result implies last_exception /= Void
		end

feature -- Status report: Comparison

	is_same_connection (a_other: SQLITE_DATABASE): BOOLEAN
			-- Determines if another database connection is the same connection as Current.
			--
			-- `a_other': The other database to compare to Current.
			-- `Result': True if the databases share a common connection; False otherwise.
		do
			Result := internal_db = a_other.internal_db
			if not Result then
				if
					attached {SQLITE_FILE_SOURCE} source as l_source and then
					not l_source.is_temporary and then
					attached {SQLITE_FILE_SOURCE} a_other.source as l_other_source and then
					not l_other_source.is_temporary
				then
						-- May enter here because one of the databases may be closed.
					if {PLATFORM}.is_windows then
						Result := l_source.locator.same_string (l_other_source.locator)
					else
						Result := l_source.locator.same_string (l_other_source.locator)
					end
				end

			end
		end

feature -- Status report: Threading

	is_locked: BOOLEAN
			-- Indicates if there is an active lock on the database.
			-- Note: Use `is_accessible' or `is_locked_exclusivley' when accessing the connection from
			--       another thread to determine if access to database is permissable on the same thread.
		do
			Result := internal_lock_count > 0
		ensure
			internal_lock_count_positive: Result implies internal_lock_count > 0
		end

	is_locked_exclusivley: BOOLEAN
			-- Indicates if there is an active lock on the database by another thread.
		do
			Result := not is_accessible and then is_locked
		ensure
			is_thread_capable: Result implies {PLATFORM}.is_thread_capable
			is_locked: Result implies is_locked
			not_is_accessible: Result implies not is_accessible
		end

feature -- Basic operations

	open
			-- Opens the database connection.
		require
			is_interface_usable: is_interface_usable
			is_accessible: is_accessible
			is_closed: is_closed
			source_exists: source.exists
		local
			l_flags: INTEGER
		do
			l_flags := SQLITE_OPEN_READONLY
			if {PLATFORM}.is_thread_capable and then sqlite_api.is_thread_safe then
				l_flags := SQLITE_OPEN_FULLMUTEX
			else
				l_flags := SQLITE_OPEN_NOMUTEX
			end
			open_internal (l_flags)
		end

	open_read
			-- Opens the database connection in a read-only mode.
		require
			is_interface_usable: is_interface_usable
			is_accessible: is_accessible
			is_closed: is_closed
			source_exists: source.exists
		do
			open_internal (SQLITE_OPEN_READONLY)
		end

	open_read_write
			-- Opens the database connection in a read/write mode.
		require
			is_interface_usable: is_interface_usable
			is_accessible: is_accessible
			is_closed: is_closed
			source_exists: source.exists
		do
			open_internal (SQLITE_OPEN_READWRITE)
		ensure
			is_writable: not is_closed implies is_writable
		end

	open_create_read_write
			-- Opens the database connection in a read/write mode and creates the database if if does
			-- not already exist.
		require
			is_interface_usable: is_interface_usable
			is_accessible: is_accessible
			is_closed: is_closed
		do
			open_internal (SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE)
		ensure
			is_writable: not is_closed implies is_writable
		end

	close
			-- Closes and open database connection. If no connection is open nothing will happen. This is
			-- for convenience.
			-- Note: Closed connections can be reopened using one of the `open_*' routines.
		require
			is_interface_usable: is_interface_usable
			is_accessible: is_accessible
			not_is_locked: not is_locked
		local
			l_db: like internal_db
			l_api: like sqlite_api
			l_result: INTEGER
			l_externals: SQLITE_STATEMENT_EXTERNALS
			l_stmt: POINTER
		do
			check not_is_in_final_collect: not is_in_final_collect end
			if internal_db /= default_pointer then
					-- Before trying to close run a full collect of the GC to dispose of any lingering references.

					-- Now try to close.
				l_db := internal_db
				l_api := sqlite_api
				l_result := sqlite3_close (l_api, l_db)
				if
					(l_result & {SQLITE_RESULT_CODES}.mask) = {SQLITE_RESULT_CODES}.sqlite_locked or else
					(l_result & {SQLITE_RESULT_CODES}.mask) = {SQLITE_RESULT_CODES}.sqlite_busy
				then
						-- Database is locked, which means there are lingering references.
						-- Try forcing a GC to collect and dispose of any still held references.
					{MEMORY}.full_collect
					l_result := sqlite3_close (l_api, l_db)
					if
						(l_result & {SQLITE_RESULT_CODES}.mask) = {SQLITE_RESULT_CODES}.sqlite_locked or else
						(l_result & {SQLITE_RESULT_CODES}.mask) = {SQLITE_RESULT_CODES}.sqlite_busy
					then
							-- Still locked! The only option now is to sever all statement connections (as
							-- per-documentation recommendation.)
						create l_externals
						from
							l_stmt := sqlite3_next_stmt (l_api, l_db, default_pointer)
						until
							l_stmt = default_pointer
						loop
							l_result := l_externals.sqlite3_finalize (l_api, l_stmt)
							check success: sqlite_success (l_result) end

							l_stmt := sqlite3_next_stmt (l_api, l_db, l_stmt)
						end
					end
				end
				sqlite_raise_on_failure (l_result)
					-- Only reset the pointer if there was no failure, because there could still be a lock, which
					-- can possibly be resolved by a client cleaning up.
				internal_db := default_pointer
			end
		ensure
			internal_db_is_null: internal_db = default_pointer
			is_closed: is_closed
		end

feature -- Basic operations: Threading

	lock
			-- Locks access to the database for all threads except the current thread.
		require
			is_interface_usable: is_interface_usable
			is_accessible: is_accessible
			is_readable: is_readable
		local
			l_count: INTEGER
			l_mutex: POINTER
			l_api: like sqlite_api
		do
			l_count := internal_lock_count
			l_count := l_count + 1
			internal_lock_count := l_count

			l_api := sqlite_api
			l_mutex := sqlite3_db_mutex (l_api, internal_db)
			if l_mutex /= default_pointer then
				sqlite3_mutex_enter (l_api, l_mutex)
			end
		ensure
			is_locked: is_locked
		end

	unlock
			-- Unlocks access to the database for all threads.
		require
			is_accessible: is_accessible
			is_locked: is_locked
		local
			l_count: INTEGER
			l_mutex: POINTER
			l_api: like sqlite_api
		do
			l_count := internal_lock_count
			l_count := l_count - 1
			internal_lock_count := l_count

			if is_interface_usable then
				l_api := sqlite_api
				l_mutex := sqlite3_db_mutex (l_api, internal_db)
				if l_mutex /= default_pointer then
					sqlite3_mutex_leave (l_api, l_mutex)
				end
			end
		end

feature {NONE} -- Basic operations

	open_internal (a_flags: INTEGER)
			-- Opens the database connection with a set of flags.
			-- Note: For internal use only!
			--
			-- `a_flags': The flags to open the database connection with.
		require
			is_interface_usable: is_interface_usable
			is_closed: is_closed
		local
			l_file_name: C_STRING
			l_flags: INTEGER
			l_db: POINTER
			l_result: INTEGER
			l_other_result: INTEGER
		do
			check
				legal_mode_flags:
					(a_flags & SQLITE_OPEN_READONLY) = SQLITE_OPEN_READONLY or
					(a_flags & SQLITE_OPEN_READWRITE) = SQLITE_OPEN_READWRITE or
					(a_flags & (SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE)) = (SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE)
			end

				-- Check and set thread related flags.
			l_flags := a_flags
			if
				(a_flags & SQLITE_OPEN_NOMUTEX) = 0 and then
				(a_flags & SQLITE_OPEN_FULLMUTEX) = 0
			then
					-- No thread-safety flags specified, use defaults
				if {PLATFORM}.is_thread_capable and then sqlite_api.is_thread_safe then
					l_flags := l_flags | SQLITE_OPEN_FULLMUTEX
				else
					l_flags := l_flags | SQLITE_OPEN_NOMUTEX
				end
			end
			internal_flags := l_flags

				-- Open the database connection.
			create l_file_name.make (source.locator)
			l_result := sqlite3_open_v2 (sqlite_api, l_file_name.item, $l_db, l_flags, default_pointer)
			if sqlite_success (l_result) then
				check not_l_db_is_null: l_db /= default_pointer end
				internal_db := l_db
					-- Set use of extended errors because the exeception classes supports them.
				l_other_result := sqlite3_extended_result_codes (sqlite_api, l_db, 1)
				check success: sqlite_success (l_other_result) end
			else
				if l_db /= default_pointer then
						-- Even in the event of an error, db's must be closed.
					l_other_result := sqlite3_close (sqlite_api, l_db)
					check success: sqlite_success (l_other_result) end
					l_db := default_pointer
				end
				internal_db := default_pointer
				sqlite_raise_on_failure (l_result)
			end
		ensure
			internal_flags_set:
				internal_flags = (a_flags | SQLITE_OPEN_FULLMUTEX) or
				internal_flags = (a_flags | SQLITE_OPEN_NOMUTEX)
		end

feature {SQLITE_INTERNALS} -- Implementation

	internal_db: POINTER
			-- Handle to the database.

	internal_flags: INTEGER
			-- Flags database was opened with.

feature {NONE} -- Implementation

	internal_lock_count: INTEGER
			-- Internal lock count for thread protection.

	internal_thread_id: INTEGER
			-- The thread the database was connected using.
			--|In non multi-threaded systems this will always be 0.

feature {NONE} -- Externals

	get_current_thread_id: POINTER
			-- Returns a pointer to the thread-id of the thread.
		require
			is_thread_capable: {PLATFORM}.is_thread_capable
		external
			"C use %"eif_threads.h%""
		alias
			"eif_thr_thread_id"
		end

invariant
	source_attached: attached source
	is_readable: not is_closed implies is_readable
	locked_thread_id_unset: not {PLATFORM}.is_thread_capable implies internal_thread_id = 0
	locked_thread_id_is_positive: {PLATFORM}.is_thread_capable implies internal_thread_id > 0

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
