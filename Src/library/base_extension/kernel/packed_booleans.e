note
	description: "[
		An array of BOOLEAN but in a packed form,
		saving 7 bits for every boolean contained by Current.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PACKED_BOOLEANS

inherit
	ANY
		redefine
			copy, is_equal
		end

create
	make

feature -- Initialization

	make (n: INTEGER)
			-- Creation method
		require
			non_negative_argument: n >= 0
		do
			create area.make_filled (0, 1 + n ⧁ index_shift)
		ensure
			allocated: area /= Void
			enough_entries: count >= n
		end

feature -- Access

	item alias "[]" (i: INTEGER): BOOLEAN
			-- Access `i-th' boolean in Current.
		require
			valid_index: valid_index (i)
		do
			Result := area.item (i ⧁ index_shift).bit_test (i ⊗ index_mask)
		end

feature -- Status Report

	valid_index (i: INTEGER): BOOLEAN
			-- Is `i' within bounds?
		do
			Result := lower <= i and i <= upper
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- <Precursor>
		local
			a, oa: like area
		do
			Result := other = Current
			if not Result then
				a := area
				oa := other.area
				if a.count = oa.count then
					Result := a.same_items (oa, 0, 0, a.count)
				end
			end
		end

feature -- Measurement

	lower: INTEGER = 0
			-- Minimum index

	upper: INTEGER
			-- Maximum index
		do
			Result := count - 1
		end

	count, capacity: INTEGER
			-- Number of available indices
		do
			Result := area.count ⧀ index_shift
		ensure then
			consistent_with_bounds: Result = upper - lower + 1
		end

feature -- Element change

	put (v: BOOLEAN; i: INTEGER)
			-- Insert `v' at `i`-th bit of Current.
		require
			valid_index: valid_index (i)
		local
			index: INTEGER
		do
			index := i ⧁ index_shift
			area [index] := area [index].set_bit (v, i ⊗ index_mask)
		ensure
			inserted: v = item (i)
		end

	set (i: INTEGER)
			-- Put `True` at `i`-th bit of Current.
		require
			valid_index: valid_index (i)
		local
			index: INTEGER
			v: like area.item
		do
			index := i ⧁ index_shift
			v := area [index] ⦶ ({INTEGER} 1 ⧀ (i ⊗ index_mask))
			area [index] := v
		ensure
			item (i)
		end

	clear (i: INTEGER)
			-- Put `False` at `i`-th bit of Current.
		require
			valid_index: valid_index (i)
		local
			index: INTEGER
			v: like area.item
		do
			index := i ⧁ index_shift
			v := area [index] ⊗ ⊝ ({INTEGER} 1 ⧀ (i ⊗ index_mask))
			area [index] := v
		ensure
			¬ item (i)
		end

	force (v: BOOLEAN; i: INTEGER)
		require
			min_i: i >= 0
		local
			old_count: INTEGER
		do
			old_count := count
			if i >= old_count then
				resize (i.max (old_count + old_count * 30 // 100))
			end
			put (v, i)
		ensure
			inserted: v = item (i)
		end

	include (other: PACKED_BOOLEANS)
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

	set_all
			-- Set all items to `True`.
		do
			area.fill_with (0xFFFFFFFF, 0, area.upper)
		ensure
			all_set: area.filled_with (0xFFFFFFFF, 0, area.upper)
		end

feature -- Resizing

	resize (n: INTEGER)
			-- Rearrange array so that it can accommodate `n' items.
			-- Do not lose any previously entered item.
		local
			new_count: INTEGER
		do
			new_count := 1 + n ⧁ index_shift
			if new_count > area.count then
				area := area.aliased_resized_area_with_default (0, new_count)
			end
		ensure
			consistent_count: count >= n
		end

feature -- Removal

	clear_all
			-- Reset all items to default values.
		do
			area.fill_with (0, 0, area.upper)
		ensure
			default_items: area.filled_with (0, 0, area.upper)
		end

feature -- Duplication

	copy (other: like Current)
			-- <Precursor>
		do
			if other /= Current then
				area := other.area.twin
			end
		ensure then
			equal_areas: area ~ other.area
		end

feature {NONE} -- Constants

	index_mask: INTEGER = 31
			-- The mark to extract bit number from the bit index.
			-- See also: `index_shift`.

	index_shift: INTEGER = 5
			-- The number of bits to shift bit index to get the index of the integer in `area`.
			-- See also: `index_mask`.

feature {PACKED_BOOLEANS} -- Implementation

	area: SPECIAL [INTEGER]
			-- Storage for booleans.

invariant
	area_not_void: area /= Void
	area_not_empty: area.count > 0

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
