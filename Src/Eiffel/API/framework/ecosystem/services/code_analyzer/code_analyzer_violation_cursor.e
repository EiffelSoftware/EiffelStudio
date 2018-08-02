note
	description: "[
		The ecosystem's default implementation for the {CODE_ANALYZER_S} interface.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_ANALYZER_VIOLATION_CURSOR

inherit
	ITERATION_CURSOR [CA_RULE_VIOLATION]

create
	make

feature {NONE} -- Creation.

	make (violations: like {CA_CODE_ANALYZER}.rule_violations)
			-- Initialize cursor with data from `collection`.
		local
			i: like inner_cursor
		do
				-- Look for a non-empty inner container.
			across
				violations as o
			from
				outer_cursor := o
				i := inner_empty_structure.new_cursor
			until
				not i.after
			loop
				i := o.item.new_cursor
			end
			inner_cursor := i
		end

feature -- Access

	item: CA_RULE_VIOLATION
			-- <Precursor>
		do
			Result := inner_cursor.item
		end

feature -- Status report	

	after: BOOLEAN
			-- <Precursor>
		do
			Result := inner_cursor.after
		ensure then
			definition: Result = inner_cursor.after
		end

feature -- Cursor movement

	forth
			-- <Precursor>
		local
			o: like outer_cursor
			i: like inner_cursor
		do
			o := outer_cursor
			i := inner_cursor
			from
				check
					inner_cursor_not_after_from_precondition: not i.after
				end
				i.forth
			until
				not i.after or else o.after
			loop
					-- Inner cursor has finished, advance to the next one.
				i := o.item.new_cursor
				o.forth
			end
			inner_cursor := i
		end

feature {NONE} -- Implementation: Internal cache

	outer_cursor: like {CA_CODE_ANALYZER}.rule_violations.new_cursor
			-- Outer cursor.

	inner_cursor: like {CA_CODE_ANALYZER}.rule_violations.new_cursor.item.new_cursor
			-- Inner cursor.

	inner_empty_structure: SORTED_TWO_WAY_LIST [CA_RULE_VIOLATION]
			-- An empty container to initialize inner cursor.
		once
			create Result.make
		end

invariant

	consistent_cursors: inner_cursor.after implies outer_cursor.after

note
	copyright: "Copyright (c) 2017-2018, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
