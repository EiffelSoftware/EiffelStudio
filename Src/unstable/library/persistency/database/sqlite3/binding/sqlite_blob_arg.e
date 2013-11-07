note
	description: "[
		An blob binding argument value for use with executing a SQLite statement.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_BLOB_ARG

inherit
	SQLITE_BIND_ARG [MANAGED_POINTER]
		redefine
			is_valid_value
		end

create
	make

feature -- Status report

	is_valid_value (a_value: like value): BOOLEAN
			-- <Precursor>
		do
			Result := attached a_value
		ensure then
			attached_a_value: Result implies attached a_value
		end

feature {SQLITE_STATEMENT} -- Basic operations

	bind_to_statement (a_statement: SQLITE_STATEMENT; a_index: INTEGER)
			-- <Precursor>
		local
			l_value: like value
		do
			l_value := value
			check l_value_attached: attached l_value end
			sqlite_raise_on_failure ({SQLITE_EXTERNALS}.c_sqlite3_bind_blob (a_statement.internal_stmt, a_index, l_value.item, l_value.count, default_pointer))
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
