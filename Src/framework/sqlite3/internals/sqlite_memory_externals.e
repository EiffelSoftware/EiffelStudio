note
	description: "[
		Externals for interacting with the memory managed features of SQLite.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_MEMORY_EXTERNALS

feature -- Element change

	sqlite3_soft_heap_limit (a_api: SQLITE_API; a_limit: INTEGER)
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			a_limit_non_negative: a_limit >= 0
		do
			c_sqlite3_soft_heap_limit (a_api.api_pointer (sqlite3_soft_heap_limit_api), a_limit)
		end

feature -- Basic operations

	sqlite3_malloc (a_api: SQLITE_API; a_size: INTEGER): POINTER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			a_size_non_negative: a_size >= 0
		do
			Result := c_sqlite3_malloc (a_api.api_pointer (sqlite3_malloc_api), a_size)
		end

	sqlite3_relloc (a_api: SQLITE_API; a_p: POINTER): POINTER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_p_is_null: a_p /= default_pointer
		do
			Result := c_sqlite3_relloc (a_api.api_pointer (sqlite3_realloc_api), a_p)
		end

	sqlite3_free (a_api: SQLITE_API; a_p: POINTER)
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_p_is_null: a_p /= default_pointer
		do
			c_sqlite3_free (a_api.api_pointer (sqlite3_free_api), a_p)
		end

feature {NONE} -- Constants

	sqlite3_free_api: STRING = "sqlite3_free"
	sqlite3_malloc_api: STRING = "sqlite3_malloc"
	sqlite3_realloc_api: STRING = "sqlite3_realloc"
	sqlite3_soft_heap_limit_api: STRING = "sqlite3_soft_heap_limit"

feature {NONE} -- Externals

	c_sqlite3_soft_heap_limit (a_fptr: POINTER; a_limit: INTEGER)
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
			a_limit_non_negative: a_limit >= 0
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
				return (EIF_POINTER)(FUNCTION_CAST(void *, (int)) $a_fptr) (
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
				return (EIF_POINTER)(FUNCTION_CAST(void *, (void *)) $a_fptr) (
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
				(FUNCTION_CAST(void, (void *)) $a_fptr) (
					(void *)$a_p);
			]"
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
