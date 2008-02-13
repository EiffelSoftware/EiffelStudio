indexing
	description: "An array of BOOLEAN but in a packed forms, saving 7 bits for%
				%every boolean contained by Current."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PACKED_BOOLEANS

create
	make

feature -- Initialization

	make (n: INTEGER) is
		require
			non_negative_argument: n >= 0
		do
			create area.make (1 + (n // Integer_size))
		ensure
			allocated: area /= Void
			enough_entries: count >= n
		end

feature -- Access

	item alias "[]" (i: INTEGER): BOOLEAN is
			-- Access `i-th' boolean in Current.
		require
			valid_index: valid_index (i)
		do
			Result := area.item (i // Integer_size).bit_test (i \\ Integer_size)
		end

feature -- Status Report

	valid_index (i: INTEGER): BOOLEAN is
			-- Is `i' within bounds?
		do
			Result := (lower <= i) and (i <= upper)
		end

feature -- Measurement

	lower: INTEGER is 0
			-- Minimum index

	upper: INTEGER is
			-- Maximum index
		do
			Result := count - 1
		end

	count, capacity: INTEGER is
			-- Number of available indices
		do
			Result := area.count * Integer_size
		ensure then
			consistent_with_bounds: Result = upper - lower + 1
		end

feature -- Element change

	put (v: BOOLEAN; i: INTEGER) is
			-- Insert `v' at `i-th' bit of Current.
		require
			valid_index: valid_index (i)
		local
			index: INTEGER
		do
			index := i // Integer_size
			if v then
				area.put (area.item (index) | ((1).to_integer_32 |<<  (i \\ Integer_size)), index)
			else
				area.put (area.item (index) & ((1).to_integer_32 |<< (i \\ Integer_size)).bit_not, index)
			end
		ensure
			inserted: v = item (i)
		end

	force (v: BOOLEAN; i: INTEGER) is
		require
			min_i: i >= 0
		local
			old_count: INTEGER
		do
			old_count := count
			if (i >= old_count) then
				resize (i.max (old_count + old_count * 30 // 100))
			end
			put (v, i)
		ensure
			inserted: v = item (i)
		end

	include (other: PACKED_BOOLEANS) is
			-- Include all items set to `True' from `other' in current.
			-- (I.e. save a result of "Current or other" into current.)
		require
			other_not_void: other /= Void
			other_small_enough: other.count <= count
		local
			i: INTEGER
			current_area: like area
			other_area: like area
		do
			current_area := area
			other_area := other.area
			from
				i := other_area.count
			until
				i <= 0
			loop
				i := i - 1
				current_area.put (current_area.item (i) | other_area.item (i), i)
			end
		end

feature -- Resizing

	resize (n: INTEGER) is
			-- Rearrange array so that it can accommodate `n' items.
			-- Do not lose any previously entered item.
		local
			new_count: INTEGER
		do
			new_count := 1 + (n // Integer_size)
			if new_count > area.count then
				area := area.aliased_resized_area (new_count)
			end
		ensure
			consistent_count: count >= n
		end

feature -- Removal

	clear_all is
			-- Reset all items to default values.
		do
			area.clear_all
		ensure
			default_items: area.all_default (0, area.upper)
		end

feature -- Constants

	Integer_size: INTEGER is 32
			-- Size of INTEGER in bits.

feature {PACKED_BOOLEANS} -- Implementation

	area: SPECIAL [INTEGER]
			-- Storage for booleans.

invariant
	area_not_void: area /= Void
	area_not_empty: area.count > 0

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
