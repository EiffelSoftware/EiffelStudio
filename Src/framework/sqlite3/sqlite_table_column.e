note
	description: "[
		An SQLite table column descriptor.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_TABLE_COLUMN

create
	make

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_8; a_affinity: INTEGER)
			-- Initializes a database table column.
			--
			-- `a_name': Column name.
			-- `a_affinity': A column affinity, see {SQLITE_COLUMN_AFFINITY}. Use {SQLITE_COLUMN_AFFINITY}.none
			--               to use the full dynamic capabilities of SQLite.
		require
			a_name_attached: attached a_name
			a_type_is_valid_column_affinity: is_valid_column_affinity (a_affinity)
		do
			create name.make_from_string (a_name)
			affinity := a_affinity
		ensure
			name_set: name.same_string (a_name)
			affinity_set: affinity = a_affinity
		end

feature -- Access

	name: IMMUTABLE_STRING_8
			-- Name of the database column

	affinity: INTEGER
			-- Column affinity type, See {SQLITE_COLUMN_AFFINITY}.

feature -- Status report

	is_valid_column_affinity (a_affinity: INTEGER): BOOLEAN
			-- Determines if a type is a valid column type.
			--
			-- `a_affinity': The affinity of column. See {SQLITE_COLUMN_AFFINITY}.
			-- `Result': True if the column affinity is valid; False otherwise.
		do
			Result := a_affinity = {SQLITE_COLUMN_AFFINITY}.none or
				a_affinity = {SQLITE_COLUMN_AFFINITY}.numeric or
				a_affinity = {SQLITE_COLUMN_AFFINITY}.integer or
				a_affinity = {SQLITE_COLUMN_AFFINITY}.real or
				a_affinity = {SQLITE_COLUMN_AFFINITY}.text
		end

invariant
	name_attached: attached name
	not_name_is_empty: not name.is_empty
	affinity_is_valid_column_affinity: is_valid_column_affinity (affinity)

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
