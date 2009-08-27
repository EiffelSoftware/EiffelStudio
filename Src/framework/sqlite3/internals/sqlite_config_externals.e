note
	description: "[
		Externals for interacting with SQLite's internal configuration options.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_CONFIG_EXTERNALS

feature -- Basic operations

	sqlite3_config_threading (a_api: DYNAMIC_API; a_mode: INTEGER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			a_mode_is_threading:
				a_mode = SQLITE_CONFIG_SINGLETHREAD or
				a_mode = SQLITE_CONFIG_MULTITHREAD or
				a_mode = SQLITE_CONFIG_SERIALIZED
		do
			Result := c_sqlite3_config_thread (a_api.api_pointer (sqlite3_config_api), a_mode)
		end

	sqlite3_config_memstatus (a_api: DYNAMIC_API; a_onoff: BOOLEAN): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
		do
			Result := c_sqlite3_config_memstatus (a_api.api_pointer (sqlite3_config_api), a_onoff)
		end

feature {NONE} -- Constants

	sqlite3_config_api: STRING = "sqlite3_config"

feature {NONE} -- External: Experimental

	c_sqlite3_config_thread (a_fptr: POINTER; a_mode: INTEGER): INTEGER
			-- Experimental
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
			a_mode_is_threading:
				a_mode = SQLITE_CONFIG_SINGLETHREAD or
				a_mode = SQLITE_CONFIG_MULTITHREAD or
				a_mode = SQLITE_CONFIG_SERIALIZED
		external
			"C inline use <sqlite3.h>"
		alias
			"[
				return (EIF_INTEGER)(FUNCTION_CAST(int, (int, ...)) $a_fptr) (
					$a_mode);
			]"
		end

	c_sqlite3_config_memstatus (a_fptr: POINTER; a_onoff: BOOLEAN): INTEGER
			-- Experimental
		require
			not_a_fptr_is_null: a_fptr /= default_pointer
		external
			"C inline use <sqlite3.h>"
		alias
			"[
				return (EIF_INTEGER)(FUNCTION_CAST(int, (int, ...)) $a_fptr) (
					SQLITE_CONFIG_MEMSTATUS, (bool)$a_onoff);
			]"
		end

feature -- Externals

	SQLITE_CONFIG_SINGLETHREAD: INTEGER
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_CONFIG_SINGLETHREAD"
		end

	SQLITE_CONFIG_MULTITHREAD: INTEGER
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_CONFIG_MULTITHREAD"
		end

	SQLITE_CONFIG_SERIALIZED: INTEGER
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_CONFIG_SERIALIZED"
		end

	SQLITE_CONFIG_MEMSTATUS: INTEGER
		external
			"C macro use <sqlite3.h>"
		alias
			"SQLITE_CONFIG_MEMSTATUS"
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
