indexing
	description: "Contiguous integer intervals"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	INTEGER_INTERVAL

inherit
	RESIZABLE [INTEGER]
		undefine
			changeable_comparison_criterion
		redefine
			copy, is_equal
		end

	INDEXABLE [INTEGER, INTEGER]
	
		rename
			put as indexable_put
		undefine
			changeable_comparison_criterion
		redefine
			copy, is_equal
		select
			bag_put
		end

	SET [INTEGER]
		redefine
			copy, is_equal
		end

creation
	make

feature {NONE} -- Initialization

	make (minindex, maxindex: INTEGER) is
			-- Set up interval to have bounds `minindex' and
			-- `maxindex' (empty if `minindex' > `maxindex')
		require
		do
			if minindex <= maxindex then		
				lower := minindex
				upper := maxindex
			else
				lower := 1
				upper := 0
			end
		ensure
			set_if_non_empty:
				(minindex <= maxindex) implies
					((lower = minindex) and
					(upper = maxindex))
			empty_if_not_in_order:
				(minindex > maxindex) implies empty
		end

feature -- Initialization
 
	adapt (other: INTEGER_INTERVAL) is
			-- Reset to be the same interval as `other'.
		require
			other_not_void: other /= Void
		do
			lower := other.lower
			upper := other.upper
		ensure
			same_lower: lower = other.lower
			same_upper: upper = other.upper
		end

feature -- Access

	lower: INTEGER
			-- Smallest value in interval

	upper: INTEGER
			-- Largest value in interval

	item, infix "@" (i: INTEGER): INTEGER is
			-- Entry at index `i', if in index interval
		do
			Result := i
		end;

	has (v: INTEGER): BOOLEAN is
			-- Does `v' appear in interval?
 			-- (Reference or object equality,
			-- based on `object_comparison'.)
		do
			Result := (v >= lower) and (v <= upper)
		ensure then
			iff_within_bounds: Result = 
					((v >= lower) and (v <= upper))
		end

feature -- Measurement

	occurrences (v: INTEGER): INTEGER is
			-- Number of times `v' appears in structure
		do
			if v >= lower and v <= upper  then
				Result := 1
			end
		ensure then
			one_iff_in_bounds:
				(Result = 1) = ((v >= lower) and (v <= upper))
			zero_otherwise: (Result /= 1) = (Result = 0)
		end

	capacity: INTEGER is
			-- Maximum number of items in interval
			-- (here the same thing as `count')
		do
			Result := count
		end

	count: INTEGER is
			-- Number of items in interval
		do
			Result := upper -lower + 1
		ensure then
			definition: Result = upper -lower + 1
		end

	index_set: INTEGER_INTERVAL is
			-- Range of acceptable indexes
			-- (here: the interval itself)
		do
			Result := Current
		ensure then
			index_set_is_range: equal (Result, Current)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is array made of the same items as `other'?
		do
			Result := ((lower = other.lower) and (upper = other.upper))
		ensure then
			iff_same_bounds: Result = ((lower = other.lower) and (upper = other.upper))

		end

feature -- Status report
	 
	all_cleared: BOOLEAN is
			-- Are all items set to default values?
		do
			Result := ((lower = 0) and (upper = 0))
		ensure then
			iff_at_zero: Result = ((lower = 0) and (upper = 0))
		end

	extendible: BOOLEAN is
			-- May new items be added?
			-- Answer: yes
		do
			Result := True
		end


	prunable: BOOLEAN is
			-- May individual items be removed?
			-- Answer: no
		do
			Result := False
		end

	valid_index (i: INTEGER): BOOLEAN is
			-- Is `i' in interval?
		do
			Result := ((i >= lower) and (i <= upper))
		ensure then
			definition: Result = ((i >= lower) and (i <= upper))
		end

feature -- Element change
	
	extend, put (v: INTEGER) is
			-- Make sure that interval goes all the way
			-- to `v' (up or down).
		do
			if v < lower then
				lower := v
			elseif v > upper then
				upper := v
			end
		ensure then
			extended_down: lower = (old lower).min (v)
			extended_up: upper = (old upper).max (v)
		end

feature -- Resizing

	resize (minindex, maxindex: INTEGER) is
			-- Rearrange interval to go from at most
			-- `minindex' to at least `maxindex',
			-- encompassing previous bounds.
		do	 
			lower := lower.min (minindex)
			upper := upper.max (maxindex)
		end

	grow (i: INTEGER) is
			-- Ensure that capacity is at least `i'.
		do
			if capacity < i then
				resize (lower, lower + i - 1)
			end
		ensure then
			no_loss_from_bottom: lower <=  old lower
			no_loss_from_top: upper >=  old upper
		end

feature -- Conversion

	as_array: ARRAY [INTEGER] is
			-- Plain array containing interval's items
		local
			i: INTEGER
		do
			create Result.make (lower, upper)
			from
				i := lower
			until
				i > upper
			loop
				Result.put (i, i)
				i := i + 1
			end
		ensure
			same_lower: Result.lower = lower
			same_upper: Result.upper = upper
		end

	to_c: ANY is
			-- Address of actual sequence of values,
			-- for passing to external (non-Eiffel) routines.
		do
			Result := as_array.to_c
		end;

	linear_representation: LINEAR [INTEGER] is
			-- Representation as a linear structure
		do
			Result := as_array.linear_representation
		end

feature -- Duplication

	copy (other: like Current) is
			-- Reset to be the same interval as `other'.
		do
			lower := other.lower
			upper := other.upper
		ensure then
			same_lower: lower = other.lower

			same_upper: upper = other.upper
		end

	subinterval (start_pos, end_pos: INTEGER): like Current is
			-- Interval made of items of current array within
			-- bounds `start_pos' and `end_pos'.
		do
			create Result.make (start_pos, end_pos)
		end

feature -- Iteration

	for_all (condition:
				FUNCTION [ANY, TUPLE [INTEGER], BOOLEAN]):
			BOOLEAN is
			-- Do all interval's values satisfy `condition'?
		local
			i: INTEGER
		do
			from
				Result := true; i := lower
			until
				(i > upper) or else (not condition.item ([i]))
			loop
				i := i + 1
			end
			Result := (i > upper)
		ensure
			consistent_with_count:
				Result = (hold_count (condition) = count)
		end

	exists (condition:
				FUNCTION [ANY, TUPLE [INTEGER], BOOLEAN]):
			BOOLEAN is
			-- Does at least one of  interval's values
			-- satisfy `condition'?
		local
			i: INTEGER
		do
			from
				i := lower
			until
				i > upper or else condition.item ([i])
			loop
				i := i + 1
			end
			Result := (i <= upper)
		ensure
			consistent_with_count:
				Result = (hold_count (condition) > 0)
		end

	exists1 (condition:
				FUNCTION [ANY, TUPLE [INTEGER], BOOLEAN]):
			BOOLEAN is
			-- Does exactly one of  interval's values
			-- satisfy `condition'?
		local
			i: INTEGER
		do
				Result := (hold_count (condition) = 1)
		ensure
			consistent_with_count:
				Result = (hold_count (condition) = 1)
		end

	hold_count (condition:
				FUNCTION [ANY, TUPLE [INTEGER], BOOLEAN]):
			INTEGER is
			-- Number of  interval's values that
			-- satisfy `condition'
		local
			i: INTEGER
		do
			from
				i := lower
			until
				i > upper
			loop
				if condition.item ([i]) then
					Result := Result + 1
				end
				i := i + 1
			end
		ensure
			non_negative: Result >= 0
		end

feature {NONE} -- Inapplicable

	prune (v: INTEGER ) is
			-- Remove one occurrence of `v' if any.
			-- Not applicable here.
		do
		end

	wipe_out is
			-- Remove all items.
			-- Not applicable here
		do
		end

	indexable_put (v: INTEGER; k: INTEGER) is
			-- Associate value `v' with key `k'.
			-- Not applicable here.
		do
		end

invariant

	count_definition: count = upper -lower + 1

	index_set_is_range: equal (index_set, Current)


end -- class INTEGER_INTERVAL


--|----------------------------------------------------------------
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

