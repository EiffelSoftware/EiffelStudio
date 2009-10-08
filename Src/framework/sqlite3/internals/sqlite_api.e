note
	description: "[
		Core wrapping of the SQLite library.
		
		This class is no indended for pulic use and is used by the internals of the SQLite Eiffel
		library. Please use the higher level classes such as {SQLITE_DATABASE}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_API

inherit
	USABLE_I

--inherit {NONE}
	SQLITE_INTERNALS
		export
			{NONE} all
		end

	SQLITE_API_EXTERNALS
		export
			{NONE} all
		end

	SQLITE_HELPERS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialize

	make
			-- <Precursor>
		local
			l_count: like initialization_count
			l_result: INTEGER
		do
			l_count := initialization_count
			if l_count.item = 0 then
					-- Configure thread-safety mode (before initialization)
				if is_thread_safe then
						-- Set serialized threading mode so access to the database is serialized.
					set_threading_mode ({SQLITE_THREADING_MODE}.multi_threaded_serialized)
				else
						-- The library may be multi-threaded but system is no, set the mono-threaded mode.
						-- Note: There may or may not be performance benifits from this.
					set_threading_mode ({SQLITE_THREADING_MODE}.single_threaded)
				end

				l_result := sqlite3_initialize (Current)
				if sqlite_success (l_result) then
						-- Increment the reference counter.
					l_count.put (1)
				else
					sqlite_raise_on_failure (l_result)
				end
			else
				l_count.put (l_count.item + 1)
			end
		end

feature {NONE} -- Clean up

	clean_up
			-- <Precursor>
		local
			l_count: like initialization_count
			l_result: INTEGER
		do
			l_count := initialization_count
			if l_count.item = 1 then
				l_result := sqlite3_shutdown (Current)
				if sqlite_success (l_result) then
					l_count.put (0)
				end
			else
				l_count.put (l_count.item - 1)
			end
		end

feature -- Access

	version: IMMUTABLE_STRING_8
			-- Version of the sqlite3 library represented as a string.
		require
			is_interface_usable: is_interface_usable
		local
			p: like sqlite3_libversion
		once
			p := sqlite3_libversion (Current)
			if p /= default_pointer then
				create Result.make_from_c (p)
			else
				create Result.make_empty
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	version_number: NATURAL
			-- Flat version number of the sqlite library.
		require
			is_interface_usable: is_interface_usable
		once
			Result := sqlite3_libversion_number (Current).as_natural_32
		end

--feature {NONE} -- Access: API

--	initialization_config: SQLITE_INITIALIZATION_CONFIG
--			-- Configuration used to initialize the API.
--		once
--			create Result
--		ensure
--			api_set: Result.api = Current
--		end

feature {NONE} -- Measurement

	initialization_count: CELL [INTEGER]
			-- Number of times `c_sqlite3_initialize' has been called.
			-- Note: This is retained to ensure correct clean up.
		once
			create Result.put (0)
		ensure
			result_attached: Result /= Void
		end

feature -- Element change

	set_threading_mode (a_mode: INTEGER)
			-- Sets the threading mode.
			--
			-- `a_mode': The threading mode to set.
		require
			is_interface_usable: is_interface_usable
			not_is_initialized: not is_initialized
		local
			l_result: INTEGER
		do
			l_result := sqlite3_config (Current, {SQLITE_THREADING_MODE}.multi_threaded_serialized)
			check success: sqlite_success (l_result) end
		end

feature -- Status report

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := is_initialized
		ensure then
			is_initialized: Result implies is_initialized
		end

	is_initialized: BOOLEAN
			-- Indicates if the library has been initialized correctly and is ready for use.
		do
			Result := initialization_count.item > 0
		ensure
			initialization_count_positive: Result implies initialization_count.item > 0
		end

	is_thread_safe: BOOLEAN
			-- <Precursor>
		do
			Result := {PLATFORM}.is_thread_capable and then
				sqlite3_threadsafe (Current) /= 0
		ensure then
			is_thread_capable: Result implies {PLATFORM}.is_thread_capable
		end

invariant
	initialization_count_not_negative: initialization_count.item >= 0

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
