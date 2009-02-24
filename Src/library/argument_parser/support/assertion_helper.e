note
	description: "[
			WARNING!! Temporary class to aid Void-Safe Transition.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ASSERTION_HELPER

feature -- Array

	array_contains_attached_items (a_array: ARRAY [ANY]): BOOLEAN
		require
			a_array_attached: a_array /= Void
		local
			l_item: detachable ANY
			l_count, i: INTEGER
		do
			Result := True
			from
				i := a_array.lower
				l_count := a_array.upper
			until
				i > l_count or not Result
			loop
				l_item := a_array[i]
				Result := l_item /= Void
				i := i + 1
			end
		end

	array_contains_valid_items (a_array: ARRAY [ANY]; a_predicate: PREDICATE [ANY, TUPLE [arg: ANY]]; a_expected: BOOLEAN): BOOLEAN
		require
			a_array_attached: a_array /= Void
			a_predicate_attached: a_predicate /= Void
		local
			l_item: detachable ANY
			l_count, i: INTEGER
		do
			Result := True
			from
				i := a_array.lower
				l_count := a_array.upper
			until
				i > l_count or not Result
			loop
				l_item := a_array[i]
				if l_item /= Void then
					Result := a_predicate.item ([l_item])
					i := i + 1
				else
					Result := False
				end
			end
		end

	sequence_contains_attached_items (a_sequence: SEQUENCE [ANY]): BOOLEAN
		require
			a_sequence_attached: a_sequence /= Void
		local
			l_item: detachable ANY
			l_cursor: detachable CURSOR
		do
			if attached {CURSOR_STRUCTURE [ANY]} a_sequence as l_cs1 then
				l_cursor := l_cs1.cursor
			end
			Result := True
			from a_sequence.start until a_sequence.after or not Result loop
				l_item := a_sequence.item_for_iteration
				Result := l_item /= Void
				a_sequence.forth
			end
			if attached {CURSOR_STRUCTURE [ANY]} a_sequence as l_cs2 and then l_cursor /= Void then
				l_cs2.go_to (l_cursor)
			end
		end

	sequence_contains_valid_items (a_sequence: SEQUENCE [ANY]; a_predicate: PREDICATE [ANY, TUPLE [arg: ANY]]; a_expected: BOOLEAN): BOOLEAN
		require
			a_sequence_attached: a_sequence /= Void
			a_predicate_attached: a_predicate /= Void
		local
			l_item: detachable ANY
			l_cursor: detachable CURSOR
		do
			if attached {CURSOR_STRUCTURE [ANY]} a_sequence as l_cs1 then
				l_cursor := l_cs1.cursor
			end
			Result := True
			from a_sequence.start until a_sequence.after or not Result loop
				l_item := a_sequence.item_for_iteration
				if l_item /= Void then
					a_sequence.forth
				else
					Result := False
				end
			end
			if attached {CURSOR_STRUCTURE [ANY]} a_sequence as l_cs2 and then l_cursor /= Void then
				l_cs2.go_to (l_cursor)
			end
		end

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
