indexing
	description: "Optimized id container list with one element most of the time."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ID_LIST

inherit
	ANY
		redefine
			is_equal, copy
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Allocate current ID set.
		do
			first := Dead_value
		end

feature -- Access

	first: INTEGER
			-- First id.

	item (i: INTEGER): like first is
			-- Entry at index `i'.
		require
			valid_index: valid_index (i)
		do
			if i = 1 then
				Result := first
			else
				Result := area.item (i - 2)
			end
		end

feature -- Status report

	Lower: INTEGER is 1
			-- Lower bound of set.

	is_empty: BOOLEAN is
			-- Is set empty?
		do
			Result := first = Dead_value
		ensure
			is_empty_definition: Result implies count = 0
		end

	count: INTEGER is
			-- Number of routine IDs.
		do
			if area /= Void then
				Result := 1 + area.count
					-- `first' plus items in 'area'
			else
				if first /= Dead_value then
					Result := 1
				end
			end
		ensure
			count_nonnegative: count >= 0
		end

	valid_index (i: INTEGER): BOOLEAN is
			-- Is `i' within bounds of current set?
		do
			Result := (1 <= i) and then (i <= count)
		end

	has (a_id: like first): BOOLEAN is
			-- Is id `a_id' present in the set ?
		require
			a_id_positive: a_id >= 0
		local
			i, nb: INTEGER
			l_area: like area
		do
			Result := first = a_id
			if not Result then
				l_area := area
				if l_area /= Void then
					from
						nb := l_area.count - 1
					until
						i > nb or Result
					loop
						Result := a_id = l_area.item (i)
						i := i + 1
					end
				end
			end
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := other = Current or else (first = other.first and then equal (area, other.area))
		end

	same_as (other: like Current): BOOLEAN is
			-- Has `other' the same content than Current ?
		require
			other_not_void: other /= Void
		local
			i, nb: INTEGER
			l_area: like area
		do
			Result := other = Current
			if not Result then
				nb := count
				if nb = 1 then
						-- We only have one item so we just need to compare 'first' and make sure that count is 1.
					Result := first = other.first and then other.area = Void
				elseif nb > 1 and then nb = other.count then
						-- We have more than one item and equal counts so we need to compare all items.
					Result := other.has (first)
					if Result then
						l_area := area
						if l_area /= Void then
							from
								nb := nb - 2
									-- Account for 'first' and zero-indexing. ' - 1 - 1 '
							until
								i > nb or else not Result
							loop
								Result := other.has (l_area.item (i))
								i := i + 1
							end
						end
					end
				end
			end
		end

feature -- Duplication

	copy (other: like Current) is
			-- Reinitialize by copying all items of `other'.
			-- (This is also used by `clone'.)
		do
			if other /= Current then
				first := other.first
				if other.area /= Void then
					area := other.area.twin
				else
					area := Void
				end
			end
		end

feature -- Conversion

	linear_representation: ARRAYED_LIST [like first] is
			-- Representation as a linear structure
		local
			i, nb: INTEGER
		do
			from
				i := 1
				nb := count
				create Result.make (nb)
			until
				i > nb
			loop
				Result.extend (item (i))
				i := i + 1
			end
		ensure
			linear_representation_not_void: Result /= Void
		end

feature -- Change

	put, force (a_id: like first) is
			-- Insert id `a_id' in set if not already
			-- present.
		require
			a_id_positive: a_id >= 0
		do
			extend (a_id)
		ensure
			inserted: has (a_id)
		end

	extend (a_id: like first) is
			-- Insert id `a_id' in set if not already
			-- present.
		require
			a_id_positive: a_id >= 0
		local
			l_pos: INTEGER
		do
				-- id `a_id' is not present in set.
			if first = Dead_value then
				first := a_id
			else
				if area /= Void then
					l_pos := area.count
					area := area.aliased_resized_area (l_pos + 1)
				else
					create area.make (1)
				end
				area.put (a_id, l_pos)
			end
		ensure
			inserted: has (a_id)
		end

	merge (other: like Current) is
			-- Put ids of `other' not present in Current.
		require
			good_argument: other /= Void
		local
			i, nb: INTEGER
		do
			from
				i := 1
				nb := other.count
			until
				i > nb
			loop
				extend (other.item (i))
				i := i + 1
			end
		end

	wipe_out is
			-- Clear the structure.
		do
			first := Dead_value
			area := Void
		ensure
			is_empty: is_empty
		end

feature -- Output

	trace is
			-- Debug purpose. Not efficient at all.
		local
			i: INTEGER
		do
			io.error.put_character ('[')
			from
				i := 1
			until
				i > count
			loop
				io.error.put_integer (item (i))
				io.error.put_character (' ')
				i := i + 1
			end
			io.error.put_character (']')
		end

feature {ID_LIST} -- Implementation: access

	area: SPECIAL [INTEGER]
			-- Hold additional IDs.

feature {NONE} -- Implementation

	dead_value: INTEGER is -1;
			-- Special value to show that `first' is not yet set.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
