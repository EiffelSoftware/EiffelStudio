note
	description: "[
		Constants representing a defined column affinity for SQLite tables.

		SQLite column datatypes are actually dynamic. A set affinity ensure a specific type is stored and
		performs necessary conversion if other types are specified in SQL statements.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_COLUMN_AFFINITY

feature -- Access

	none: INTEGER    = 0x1
			-- No affinity, making the column datatype fully dynamic.

	numeric: INTEGER = 0x2
			-- Numeric affinity for all numberic types.

	integer: INTEGER = 0x6  -- | `numeric'
			-- Integer affinity, converting all text/reals to integers.

	real: INTEGER    = 0xA  -- | `numeric'
			-- Real affinity

	text: INTEGER    = 0x10
			-- Text affinity, converting all values to text.

feature -- Access: Convience types

	null: INTEGER    = 0x0  -- `none'
			-- Synonymous with no affinity, fully dynamic.
			-- Note: Supported only for easy conversion between static DBs and SQLite's dynamic column
			--       datatypes.

	blob: INTEGER    = 0x0  -- `none'
			-- Synonymous with no affinity, fully dynamic.
			-- Note: Supported only for easy conversion between static DBs and SQLite's dynamic column
			--       datatypes.

	float: INTEGER   = 0xA  -- `real'
			-- Synonymous with a `real' affinity.
			-- Note: Supported only for easy conversion between static DBs and SQLite's dynamic column
			--       datatypes.

	double: INTEGER  = 0xA  -- `real'
			-- Synonymous with a `real' affinity.
			-- Note: Supported only for easy conversion between static DBs and SQLite's dynamic column
			--       datatypes.

	varchar: INTEGER = 0x10 -- `text'
			-- Synonymous with a `text' affinity.
			-- Note: Supported only for easy conversion between static DBs and SQLite's dynamic column
			--       datatypes.

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
