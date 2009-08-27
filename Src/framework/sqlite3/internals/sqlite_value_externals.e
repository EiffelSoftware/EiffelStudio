note
	description: "[
		Externals for interacting with SQLite statemtent values (sqlite3_value *).
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_VALUE_EXTERNALS


feature -- Access

	sqlite3_value_blob (a_api: SQLITE_API; a_value: POINTER): POINTER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_value_is_null: a_value /= default_pointer
		do
			Result := c_sqlite3_value_blob (a_api.api_pointer (sqlite3_value_blob_api), a_value)
		end

	sqlite3_value_bytes (a_api: SQLITE_API; a_value: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_value_is_null: a_value /= default_pointer
		do
			Result := c_sqlite3_value_bytes (a_api.api_pointer (sqlite3_value_bytes_api), a_value)
		end

	sqlite3_value_bytes16 (a_api: SQLITE_API; a_value: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_value_is_null: a_value /= default_pointer
		do
			Result := c_sqlite3_value_bytes16 (a_api.api_pointer (sqlite3_value_bytes16_api), a_value)
		end

	sqlite3_value_double (a_api: SQLITE_API; a_value: POINTER): REAL_64
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_value_is_null: a_value /= default_pointer
		do
			Result := c_sqlite3_value_double (a_api.api_pointer (sqlite3_value_double_api), a_value)
		end

	sqlite3_value_int (a_api: SQLITE_API; a_value: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_value_is_null: a_value /= default_pointer
		do
			Result := c_sqlite3_value_int (a_api.api_pointer (sqlite3_value_int_api), a_value)
		end

	sqlite3_value_int_64 (a_api: SQLITE_API; a_value: POINTER): INTEGER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_value_is_null: a_value /= default_pointer
		do
			Result := c_sqlite3_value_int_64 (a_api.api_pointer (sqlite3_value_int_64_api), a_value)
		end

	sqlite3_value_text (a_api: SQLITE_API; a_value: POINTER): POINTER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_value_is_null: a_value /= default_pointer
		do
			Result := c_sqlite3_value_text (a_api.api_pointer (sqlite3_value_text_api), a_value)
		end

	sqlite3_value_text16 (a_api: SQLITE_API; a_value: POINTER): POINTER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_value_is_null: a_value /= default_pointer
		do
			Result := c_sqlite3_value_text16 (a_api.api_pointer (sqlite3_value_text16_api), a_value)
		end

	sqlite3_value_text16be (a_api: SQLITE_API; a_value: POINTER): POINTER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_value_is_null: a_value /= default_pointer
		do
			Result := c_sqlite3_value_text16be (a_api.api_pointer (sqlite3_value_text16be_api), a_value)
		end

	sqlite3_value_textle (a_api: SQLITE_API; a_value: POINTER): POINTER
		require
			a_api_attached: attached a_api
			a_api_is_interface_usable: a_api.is_interface_usable
			not_a_value_is_null: a_value /= default_pointer
		do
			Result := c_sqlite3_value_textle (a_api.api_pointer (sqlite3_value_textle_api), a_value)
		end

feature {NONE} -- Constants

	sqlite3_value_blob_api: STRING     = "sqlite3_value_blob"
	sqlite3_value_bytes_api: STRING    = "sqlite3_value_bytes"
	sqlite3_value_bytes16_api: STRING  = "sqlite3_value_bytes16"
	sqlite3_value_double_api: STRING   = "sqlite3_value_double"
	sqlite3_value_int_api: STRING      = "sqlite3_value_int"
	sqlite3_value_int_64_api: STRING   = "sqlite3_value_int_64"
	sqlite3_value_text_api: STRING     = "sqlite3_value_text"
	sqlite3_value_text16_api: STRING   = "sqlite3_value_text16"
	sqlite3_value_text16be_api: STRING = "sqlite3_value_text16be"
	sqlite3_value_textle_api: STRING   = "sqlite3_value_textle"

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
