note
	description: "[
		Auxillary memory functions associated with the internals and performance tuning of SQLite.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_MEMORY

inherit
	DYNAMIC_SHARED_API

create
	make

feature {NONE} -- Initialize

	initialize
			-- <Precursor>
		do
		end

feature -- Clean up

	clean_up
			-- <Precursor>
		do
		end

feature -- Element change

	set_heap_soft_limit (a_limit: INTEGER)
			-- Places a "soft" upper limit on the amount of heap memory that may be allocated by SQLite.
			-- Note: To remove the limit use `unset_soft_heap_limit'.
			--
			-- `a_limit': An upper memory limit.
		require
			a_limit_positive: a_limit > 0
		do
			set_heap_soft_limit_internal (a_limit)
		ensure
			is_heap_soft_limit_set: is_heap_soft_limit_set
		end

	unset_heap_soft_limit
			-- Removed an set soft upper limit of heap memory.
		do
			set_heap_soft_limit_internal (0)
		ensure
			not_is_heap_soft_limit_set: not is_heap_soft_limit_set
		end

feature {NONE} -- Element change

	set_heap_soft_limit_internal (a_limit: INTEGER)
			-- Places a "soft" upper limit on the amount of heap memory that may be allocated by SQLite.
			-- Note: To remove the limit use `unset_soft_heap_limit'.
			--
			-- `a_limit': An upper memory limit. A zero or negative number resets the limit.
		require
			is_interface_usable: is_interface_usable
		do
			c_sqlite3_soft_heap_limit (api_pointer (once "sqlite3_soft_heap_limit"), a_limit)
			is_heap_soft_limit_set_internal.put (a_limit > 0)
		end

feature -- Status report

	is_heap_soft_limit_set: BOOLEAN
			-- Indicates if a soft heap limit is set.
		do
			Result := is_heap_soft_limit_set_internal.item
		end

feature {NONE} -- External

	c_sqlite3_soft_heap_limit (a_fptr: POINTER; a_limit: INTEGER)
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
			a_size_non_negative: a_size >= 0
		external
			"C inline use <sqlite3.h>"
		alias
			"[
				(FUNCTION_CAST(void, (int)) $a_fptr) (
					(int)$a_limit);
			]"
		end

	c_sqlite3_malloc (a_fptr: POINTER; a_size: INTEGER): POINTER
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
			a_size_non_negative: a_size >= 0
		external
			"C inline use <sqlite3.h>"
		alias
			"[
				return (EIF_POINTER)(FUNCTION_CAST(void, (int)) $a_fptr) (
					(int)$a_size);
			]"
		end

	c_sqlite3_relloc (a_fptr: POINTER; a_p: POINTER): POINTER
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
			not_a_p_is_null: a_p /= default_pointer
		external
			"C inline use <sqlite3.h>"
		alias
			"[
				return (EIF_POINTER)(FUNCTION_CAST(void, (int)) $a_fptr) (
					(void *)$a_p);
			]"
		end

	c_sqlite3_free (a_fptr: POINTER; a_p: POINTER)
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
			not_a_p_is_null: a_p /= default_pointer
		external
			"C inline use <sqlite3.h>"
		alias
			"[
				(FUNCTION_CAST(void, (int)) $a_fptr) (
					(void *)$a_p);
			]"
		end

feature {NONE} -- Implementation

	is_heap_soft_limit_set_internal: CELL [BOOLEAN]
			-- Singleton for caching the set value of a soft heap limit.
		note
			once_status: global
		once
			create Result.put (False)
		end

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
