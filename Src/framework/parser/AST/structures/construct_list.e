note
	description: "List used in abstract syntax trees."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CONSTRUCT_LIST [T]

inherit
	ARRAYED_LIST [T]
		redefine
			make, make_filled
		end

create
	make,
	make_filled_with

feature {NONE} -- Initialization

	make (n: INTEGER)
			-- Creation of the list.
		do
			Precursor (n)
			insertion_position := 0
		ensure then
			insertion_position = 0
		end

	make_filled (n: INTEGER)
			-- Creation of the list.
		obsolete "Use `make` or `make_filled_with` instead. [2021-05-31]"
		do
			Precursor (n)
			insertion_position := n
		ensure then
			insertion_position = n
		end

	make_filled_with (v: T; n: INTEGER)
			-- Create the list with `n` elements `v`.
			-- The list is `reverse_extend`-ed by one `v`.
		do
			make (n)
			area.extend_filled (v)
			insertion_position := n - 1
		ensure
			full
			count = n
			insertion_position = n - 1
			occurrences (v) = n
		end

feature -- Modification

	reverse_extend (v: T)
			-- Put `v` at `insertion_position` and decrement the latter.
			-- Expects that the list was initialized by `make_filled_with`.
			-- See also: `back_extend`.
		require
			count > 0
			insertion_position > 0
		local
			l_pos: INTEGER
		do
			l_pos := insertion_position - 1
			insertion_position := l_pos
			area.put (v, l_pos)
		ensure
			decremented: insertion_position = old insertion_position - 1
			extended: Current [insertion_position + 1] = v
			preserved: old insertion_position > count ⇒ ∀ i: (insertion_position + 2) |..| count ¦ Current [i] = (old twin) [i]
		end

	back_extend (v: T)
			-- Put `v` at `insertion_position` when `insertion_position > 0`.
			-- Put `v` at `capacity` otherwise.
			-- Set `insertion_position` to the previous position.
			-- Slightly less efficient version of `reverse_extend`, but also works for lists created by `make`.
		require
			capacity > 0
			insertion_position > 0 ⇒ full
		local
			j: like insertion_position
		do
			j := insertion_position
			if j > 0 then
				j := j - 1
				insertion_position := j
				area.put (v, j)
			else
				area.extend_filled (v)
				insertion_position := count - 1
			end
		ensure
			same_capacity: capacity = old capacity
			full
			decremented_if_positive: old insertion_position > 0 ⇒ insertion_position = old insertion_position - 1
			decremented_if_zero: old insertion_position = 0 ⇒ insertion_position = capacity - 1
			extended: Current [insertion_position + 1] = v
			preserved: old insertion_position > count ⇒ ∀ i: (insertion_position + 2) |..| count ¦ Current [i] = (old twin) [i]
			filled: old insertion_position = 0 ⇒ occurrences (v) = count
		end

feature -- Access

	insertion_position: INTEGER
			-- Insertion position for `reverse_extend` and `back_extend`.

invariant
	insertion_position ≥ 0
	insertion_position ≤ count

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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
