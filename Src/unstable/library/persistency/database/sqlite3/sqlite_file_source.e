note
	description: "[
		A SQLite database source stored in a file.
		
		Note: Files do not need to exist to be a source, when creating a new database connection.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_FILE_SOURCE

inherit
	SQLITE_SOURCE
		redefine
			is_special
		end

create
	make,
	make_temporary

feature {NONE} -- Initialization

	make (a_file_name: READABLE_STRING_GENERAL)
			-- Initializes the databases source using a file name.
			--
			-- `a_file_name': The file name to read or create a database at.
		require
			a_file_name_attached: attached a_file_name
			not_a_file_name_is_empty: not a_file_name.is_empty
			a_file_name_is_string_8: a_file_name.is_string_8
		do
			create locator.make_from_string (a_file_name.as_string_8)
		ensure
			locator_set: locator.same_string (a_file_name.as_string_8)
			not_is_temporary: not is_temporary
		end

	make_temporary
			-- Initialized the database source using a temporary file name.
			--
			-- Note: The file name is not set here but internally by SQLite.
		do
			create locator.make_empty
		ensure
			is_temporary: is_temporary
		end

feature -- Access

	locator: IMMUTABLE_STRING_8
			-- <Precursor>

feature -- Status report

	exists: BOOLEAN
			-- <Precursor>
		do
			Result := is_temporary or else (create {RAW_FILE}.make (locator)).exists
		ensure then
			locator_exists: Result implies (is_temporary or else (create {RAW_FILE}.make (locator)).exists)
		end

	is_special: BOOLEAN = False
			-- <Precursor>

	is_temporary: BOOLEAN
			-- Indicates if the file name is a temporary file.
		do
			Result := locator.is_empty
		ensure
			not_locator_is_empty: not Result implies not locator.is_empty
		end

invariant
	locator_attached: attached locator
	not_locator_is_empty: not is_temporary implies not locator.is_empty

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
