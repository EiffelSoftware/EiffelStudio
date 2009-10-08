note
	description: "[
		Shared, thread-dependent access to the SQLite dynamic raw API.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_SHARED_API

inherit
	USABLE_I

--inherit {NONE}
	SQLITE_HELPERS
		export
			{NONE} all
		end

feature {NONE} -- Access

	sqlite_api: SQLITE_API
			-- Shared access to the SQLite API.
		once
			create Result.make
		end

feature -- Status report

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := sqlite_api.is_interface_usable
		ensure then
			sqlite_api_is_interface_usable: Result implies sqlite_api.is_interface_usable
		end

	is_sqlite_available: BOOLEAN
			-- Indicates if the sqlite API is available for use.
		once
			Result := sqlite_api.is_interface_usable
		ensure
			sqlite_api_is_interface_usable: Result implies sqlite_api.is_interface_usable
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
