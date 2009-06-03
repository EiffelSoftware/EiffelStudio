note
	description: "[
		Externals used to process database back ups (sqlite3_backup *).
		
		Note: These APIs are considered experimental and may change.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_BACKUP_EXTERNALS

feature {SQLITE_INTERNALS} -- Initializations

	sqlite3_backup_init (a_api: SQLITE_API; a_dest_db: POINTER; a_dest_name: POINTER; a_src_db: POINTER; a_src_name: POINTER): POINTER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_dest_db_is_null: a_dest_db /= default_pointer
			not_a_dest_name_is_null: a_dest_name /= default_pointer
			not_a_src_db_is_null: a_src_db /= default_pointer
			not_a_src_name_is_null: a_src_name /= default_pointer
			a_dest_db_not_a_src_db: a_dest_name /= a_src_db
		do
			Result := c_sqlite3_backup_init (a_api.api_pointer (once "sqlite3_backup_init"), a_dest_db, a_dest_name, a_src_db, a_src_name)
		end

feature {SQLITE_INTERNALS} -- Clean up

	sqlite3_backup_finish (a_api: SQLITE_API; a_backup: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_backup_is_null: a_backup /= default_pointer
		do
			Result := c_sqlite3_backup_finish (a_api.api_pointer (once "sqlite3_backup_finish"), a_backup)
		end

feature {SQLITE_INTERNALS} -- Measurement

	sqlite3_backup_remaining (a_api: SQLITE_API; a_backup: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_backup_is_null: a_backup /= default_pointer
		do
			Result := c_sqlite3_backup_remaining (a_api.api_pointer (once "sqlite3_backup_remaining"), a_backup)
		end

	sqlite3_backup_pagecount (a_api: SQLITE_API; a_backup: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_backup_is_null: a_backup /= default_pointer
		do
			Result := c_sqlite3_backup_pagecount (a_api.api_pointer (once "sqlite3_backup_pagecount"), a_backup)
		end

feature {SQLITE_INTERNALS} -- Basic operations

	sqlite3_backup_step (a_api: SQLITE_API; a_backup: POINTER; a_page: INTEGER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_backup_is_null: a_backup /= default_pointer
		do
			Result := c_sqlite3_backup_step (a_api.api_pointer (once "sqlite3_backup_step"), a_backup, a_page)
		end

feature {NONE} -- Externals

	c_sqlite3_backup_init (a_fptr: POINTER; a_dest_db: POINTER; a_dest_name: POINTER; a_src_db: POINTER; a_src_name: POINTER): POINTER
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
			not_a_dest_db_is_null: a_dest_db /= default_pointer
			not_a_dest_name_is_null: a_dest_name /= default_pointer
			not_a_src_db_is_null: a_src_db /= default_pointer
			not_a_src_name_is_null: a_src_name /= default_pointer
		external
			"C inline use <sqlite3.h>"
		alias
			"[
				return (EIF_POINTER)(FUNCTION_CAST(void *, (sqlite3 *, const char *, sqlite3 *, const char *)) $a_fptr) (
					(sqlite3 *)$a_dest_db, 
					(const char *)$a_dest_name,
					(sqlite3 *)$a_src_db, 
					(const char *)$a_src_name);
			]"
		end

	c_sqlite3_backup_step (a_fptr: POINTER; a_backup: POINTER; a_pages: INTEGER): INTEGER
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
			not_a_backup_is_null: a_backup /= default_pointer
			a_pages_positive: a_pages > 0
		external
			"C inline use <sqlite3.h>"
		alias
			"[
				return (EIF_INTEGER)(FUNCTION_CAST(int, (sqlite3_backup *, int)) $a_fptr) (
					(sqlite3_backup *)$a_backup, 
					(int)$a_pages);
			]"
		end

	c_sqlite3_backup_finish,
	c_sqlite3_backup_remaining,
	c_sqlite3_backup_pagecount (a_fptr: POINTER; a_backup: POINTER): INTEGER
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
			not_a_backup_is_null: a_backup /= default_pointer
		external
			"C inline use <sqlite3.h>"
		alias
			"[
				return (EIF_INTEGER)(FUNCTION_CAST(int, (sqlite3_backup *)) $a_fptr) (
					(sqlite3_backup *)$a_backup);
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
