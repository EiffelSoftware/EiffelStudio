indexing
	description: "Multi-dimensional array"
	status: "See notice at end of class"
	representation: array
	access: multi_dimensional_index
	size: resizable
	contents: generic
	date: "$Date$"
	revision: "$Revision$"

class
	ECOM_ARRAY [G]

inherit
	ANY
		undefine
			consistent, setup, is_equal, copy
		end

	ARRAY [G]
		rename
			make as array_make,
			item as array_item,
			put as array_put, 
			force as array_force,
			resize as array_resize,
			make_from_array as array_make_from_array
		export
			{NONE} all
			{ANY} area
		redefine
			wipe_out
		end

create
	make, make_from_array

feature {NONE} -- Initialization

	make (a_dimension_count: INTEGER; some_lower_indeces, some_element_counts: ARRAY [INTEGER]) is
			-- Create `a_dimensional_count' dimensional array
			-- with lower indeces in each dimension as described by `some_lower_indeces'
			-- and element count in each dimension as described by `some_element_counts'.
		require
			valid_dimension_count: a_dimension_count > 0
			valid_lower_indeces: some_lower_indeces /= Void and then 
					some_lower_indeces.count = a_dimension_count and
					some_lower_indeces.lower = 1
			valid_element_count: some_element_counts /= Void and then
					some_element_counts.count = a_dimension_count and
					some_element_counts.lower = 1 and then
					are_element_counts_valid (some_element_counts)
		local
			a_count: INTEGER
			i: INTEGER
		do
			dimension_count := a_dimension_count
			element_counts := clone (some_element_counts)
			lower_indeces := clone (some_lower_indeces)
			from
				i := 1
				create upper_indeces.make (1, dimension_count)
				a_count := 1
			variant
				dimension_count - i + 1
			until
				i > dimension_count
			loop
				upper_indeces.put (element_counts.item (i) + lower_indeces.item (i) - 1, i)
				a_count := a_count * element_counts.item (i)
				i := i + 1
			end

			array_make (0, a_count - 1)
		ensure
			valid_dimension_count: dimension_count >0
			valid_element_counts: element_counts /= Void and then element_counts.count = dimension_count
			valid_lower_indeces: lower_indeces /= Void and then lower_indeces.count = dimension_count
			valid_upper_indeces: upper_indeces /= Void and then upper_indeces.count = dimension_count
		end

	make_from_array (a: ARRAY [G]; a_dimension_count: INTEGER; some_lower_indeces, some_element_counts: ARRAY [INTEGER]) is
			-- Create `a_dimensional_count' dimensional array
			-- with lower indeces in each dimension as described by `some_lower_indeces'
			-- and element count in each dimension as described by `some_element_counts'.
		require
			valid_dimension_count: a_dimension_count > 0
			valid_lower_indeces: some_lower_indeces /= Void and then 
					some_lower_indeces.count = a_dimension_count and
					some_lower_indeces.lower = 1
			valid_element_count: some_element_counts /= Void and then
					some_element_counts.count = a_dimension_count and
					some_element_counts.lower = 1 and then
					are_element_counts_valid (some_element_counts)
			valid_array_size: a.count = total_count (some_element_counts)
		do
			make (a_dimension_count, some_lower_indeces, some_element_counts)
			area := a.area
		ensure
			valid_dimension_count: dimension_count >0
			valid_element_counts: element_counts /= Void and then element_counts.count = dimension_count
			valid_lower_indeces: lower_indeces /= Void and then lower_indeces.count = dimension_count
			valid_upper_indeces: upper_indeces /= Void and then upper_indeces.count = dimension_count
		end

feature -- Initialization

	initialize (v: G) is
			-- Make each entry have value `v'
		local
			an_index: ARRAY [INTEGER]
			i: INTEGER
		do
			from
				i := 1
				create an_index.make (1, dimension_count)
			variant
				dimension_count - i + 1
			until
				i > dimension_count
			loop
				an_index.put (lower_indeces.item (i), i)
				i := i + 1
			end

			from
				exhausted := False
			until
				exhausted
			loop
				put (v, an_index)
				next_index (an_index)
			end
		end

feature -- Access

	item (some_indeces: ARRAY [INTEGER]): G is
			-- Entry at `some_indeces'
		require
			valid_indeces: are_indeces_valid (some_indeces)
		do
			Result := array_item (flat_index (some_indeces))
		end

feature -- Measurement

	dimension_count: INTEGER
			-- Number of dimensions

	element_counts: ARRAY [INTEGER]
			-- Element count in each dimension

	lower_indeces: ARRAY [INTEGER]
			-- Lower indedeces in each dimension

	upper_indeces: ARRAY [INTEGER] 
			-- Upper indeces in each dimension

feature -- Status report

	are_element_counts_valid (some_element_counts: ARRAY [INTEGER]): BOOLEAN is
			-- Are `some_element_counts' valid element counts?
		require
			valid_element_counts: some_element_counts /= Void and then 
					some_element_counts.lower = 1 and
					some_element_counts.count > 0
		local
			i: INTEGER
		do
			Result := True
			from
				i := 1
			variant
				some_element_counts.count - i + 1
			until
				i > some_element_counts.count
			loop
				if some_element_counts.item (i) < 1 then
					Result := False
				end
				i := i + 1
			end
		end

	are_indeces_valid (some_indeces: ARRAY [INTEGER]): BOOLEAN is
			-- Are `some_indeces' valid indeces?
		local
			i: INTEGER
		do
			Result := True
			if some_indeces = Void or else some_indeces.count /= dimension_count then
				Result := False
			else
				from
					i := 1
				variant
					dimension_count - i + 1
				until
					i > dimension_count 
				loop
					if some_indeces.item (i) < lower_indeces.item (i) or
							some_indeces.item (i) > upper_indeces.item (i) then
						Result := False
					end
					i := i + 1
				end
			end
		end

	are_indeces_large_enough (some_indeces: ARRAY [INTEGER]): BOOLEAN is
			-- Are `some_indeces' large enough?
		local
			i: INTEGER
		do
			Result := True
			if some_indeces = Void or else some_indeces.count /= dimension_count then
				Result := False
			else
				from
					i := 1
				variant
					dimension_count - i + 1
				until
					i > dimension_count 
				loop
					if some_indeces.item (i) < lower_indeces.item (i) then
						Result := False
					end
					i := i + 1
				end
			end
		end

	total_count (some_element_counts: ARRAY [INTEGER]): INTEGER is
			-- Total number of elements
		require
			valid_counts: are_element_counts_valid (some_element_counts)
		local
			i, a_count: INTEGER
		do
			Result := 1
			from
				i := 1
				a_count := some_element_counts.count
			variant
				a_count - i + 1
			until
				i > a_count
			loop
				Result := Result * some_element_counts.item (i)
				i := i + 1
			end
		ensure
			valid_count: Result > 0
		end

	are_element_counts_consistent: BOOLEAN is
			-- Are `element_counts' consistent?
		local
			i: INTEGER
		do
			Result := element_counts.count = dimension_count and
					are_element_counts_valid (element_counts)
			from
				i := 1
			variant
				dimension_count - i + 1
			until
				i > dimension_count
			loop
				Result := Result and 
					upper_indeces.item (i) - lower_indeces.item (i) + 1 = element_counts.item (i)
				i := i + 1
			end
		end

feature -- Element change

	put (v: like item; some_indeces: ARRAY [INTEGER]) is
			-- Assign item `v' at indeces `some_indeces'.
		require
			valid_indeces: are_indeces_valid (some_indeces)
		do
			array_put (v, flat_index (some_indeces))
		ensure
			element_inserted: item (some_indeces) = v
		end

	force (v: like item; some_indeces: ARRAY [INTEGER]) is
			-- Assign item `v' at indeces `some_indeces'.
			-- Resize if necesary.
		require
			valid_indeces: are_indeces_large_enough (some_indeces)
		do
			resize (some_indeces)
			put (v, some_indeces)
		ensure
			element_inserted: item (some_indeces) = v
		end

feature -- Removal

	wipe_out is
			-- Remove all elements
		do
			dimension_count := 0
			upper := 0
			element_counts := Void
			lower_indeces := Void
			upper_indeces := Void
			Precursor
		end

feature -- Resizing

	resize (n_upper_indeces: ARRAY [INTEGER]) is
			-- Rearrange array so that it can accommodate `new_upper_indeces'
			-- without losing any previously entered items
			-- or changing their indeces;
			-- do nothing if possible.
		require
			are_indeces_large_enough (n_upper_indeces)
		local
			i, an_upper: INTEGER
			new_upper_indeces, new_element_counts, an_index: ARRAY [INTEGER]
			new: like Current
			need_resize: BOOLEAN
		do
			from
				i := 1
				an_upper := 1
				create new_upper_indeces.make (1, dimension_count)
				create new_element_counts.make (1, dimension_count)
				create an_index.make (1, dimension_count)
			variant
				dimension_count - i + 1
			until
				i > dimension_count
			loop
				if n_upper_indeces.item (i) > upper_indeces.item (i) then
					new_upper_indeces.put (n_upper_indeces.item (i), i)
					new_element_counts.put 
						(new_upper_indeces.item (i) - lower_indeces.item (i) + 1, i)
					need_resize := True
				else
					new_upper_indeces.put (upper_indeces.item (i), i)
					new_element_counts.put (element_counts.item (i), i)
				end
				an_upper := an_upper * new_element_counts.item (i)
				an_index.put (lower_indeces.item (i), i)
				i := i + 1
			end

			if need_resize then
				create new.make (dimension_count, lower_indeces, new_upper_indeces)

				from
					exhausted := False
				until
					exhausted
				loop
					new.put (item (an_index), an_index)
					next_index (an_index)
				end
				upper_indeces := new_upper_indeces
				element_counts := new_element_counts
				upper := an_upper
				area := new.area
			end
		end

feature {NONE} -- Implementation

	flat_index (some_indeces: ARRAY [INTEGER]): INTEGER is
			-- Flattened index
		require
			valid_indeces: are_indeces_valid (some_indeces) 
		local
			i, j, inter_dim: INTEGER
		do
			from
				Result := 0
				i := 0
			variant
				dimension_count - i 
			until
				i = dimension_count
			loop
				from
					inter_dim := 1
					j := i + 1
				variant
					dimension_count - i
				until
					j = dimension_count
				loop
					inter_dim := inter_dim * element_counts.item (j)
					j := j +1
				end
				Result := Result + 
						(some_indeces.item (i) - lower_indeces.item (i)) * inter_dim
				i := i + 1
			end
		end
 

	next_index (some_indeces: ARRAY [INTEGER]) is
			-- Generate next index
		require
			valid_indeces: are_indeces_valid (some_indeces)
		local
			new_index: BOOLEAN
			i: INTEGER
		do
			from
				i := dimension_count
				exhausted := True
			variant
				i
			until
				i = 0 or new_index
			loop
				if some_indeces.item (i) < upper_indeces.item (i) then
					some_indeces.put (some_indeces.item (i) + 1, i)
					new_index := True
					exhausted := False
				else
					some_indeces.put (lower_indeces.item (i), i)
					i := i - 1
				end
			end
		end

	exhausted: BOOLEAN 
			-- Is structure exhausted?

invariant
	consistent_upper_indeces: upper_indeces.count = dimension_count
	consistent_lower_indeces: lower_indeces.count = dimension_count
	consistent_element_counts: are_element_counts_consistent
	consistent_size: capacity = total_count (element_counts)
	non_negative_count: count >= 0

end -- class ECOM_ARRAY

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

