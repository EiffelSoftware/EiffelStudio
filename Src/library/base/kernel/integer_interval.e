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
			item as item alias "[]",
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

create
	make

feature {NONE} -- Initialization

	make (min_index, max_index: INTEGER) is
			-- Set up interval to have bounds `min_index' and
			-- `max_index' (empty if `min_index' > `max_index')
		do
			lower_defined := True
			upper_defined := True
			if min_index <= max_index then		
				lower_internal := min_index
				upper_internal := max_index
			else
				lower_internal := 1
				upper_internal := 0
			end
		ensure
			lower_defined: lower_defined
			upper_defined: upper_defined
			set_if_non_empty:
				(min_index <= max_index) implies
					((lower = min_index) and
					(upper = max_index))
			empty_if_not_in_order:
				(min_index > max_index) implies is_empty
		end
		
feature -- Initialization
	
	adapt (other: INTEGER_INTERVAL) is
			-- Reset to be the same interval as `other'.
		require
			other_not_void: other /= Void
		do
			lower_internal := other.lower_internal
			upper_internal := other.upper_internal
			lower_defined := other.lower_defined
			upper_defined := other.upper_defined
		ensure
			same_lower: lower = other.lower
			same_upper: upper = other.upper
			same_lower_defined: lower_defined = other.lower_defined
			same_upper_defined: upper_defined = other.upper_defined
		end

feature -- Access

	lower_defined: BOOLEAN
			-- Is there a lower bound?

	lower: INTEGER is
			-- Smallest value in interval
		require
			lower_defined: lower_defined
		do
			Result := lower_internal
		end

	upper_defined: BOOLEAN
			-- Is there an upper bound?

	upper: INTEGER is
			-- Largest value in interval
		require
			upper_defined: upper_defined
		do
			Result := upper_internal
		end

	item alias "[]", infix "@" (i: INTEGER): INTEGER is
			-- Entry at index `i', if in index interval
		do
			Result := i
		end

	has, valid_index (v: INTEGER): BOOLEAN is
			-- Does `v' appear in interval?
		do
			Result :=
				(upper_defined implies v <= upper) and
				(lower_defined implies v >= lower)
		ensure then
			iff_within_bounds: Result = 
				((upper_defined implies v <= upper) and
				(lower_defined implies v >= lower))
		end

feature -- Measurement

	occurrences (v: INTEGER): INTEGER is
			-- Number of times `v' appears in structure
		do
			if has (v) then
				Result := 1
			end
		ensure then
			one_iff_in_bounds: Result = 1 implies has (v)
			zero_otherwise: Result /= 1 implies Result = 0
		end

	capacity: INTEGER is
			-- Maximum number of items in interval
			-- (here the same thing as `count')
		do
			check
				terminal: upper_defined and lower_defined
			end
			Result := count
		end

	count: INTEGER is
			-- Number of items in interval
		do
			check
				finite: upper_defined and lower_defined
			end
			if upper_defined and lower_defined then
				Result := upper - lower + 1
			end
		ensure then
			definition: Result = upper - lower + 1
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
			Result :=
				(lower_defined implies (other.lower_defined and lower = other.lower)) and
				(upper_defined implies (other.upper_defined and upper = other.upper))
		ensure then
			iff_same_bounds: Result =
				((lower_defined implies (other.lower_defined and lower = other.lower)) and
				(upper_defined implies (other.upper_defined and upper = other.upper)))
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

feature -- Element change
	
	extend, put (v: INTEGER) is
			-- Make sure that interval goes all the way
			-- to `v' (up or down).
		do
			if v < lower then
				lower_internal := v
			elseif v > upper then
				upper_internal := v
			end
		ensure then
			extended_down: lower = (old lower).min (v)
			extended_up: upper = (old upper).max (v)
		end

feature -- Resizing

	resize (min_index, max_index: INTEGER) is
			-- Rearrange interval to go from at most
			-- `min_index' to at least `max_index',
			-- encompassing previous bounds.
		do	 
			lower_internal := min_index.min (lower)
			upper_internal := max_index.max (upper)
		end

	resize_exactly (min_index, max_index: INTEGER) is
			-- Rearrange interval to go from
			-- `min_index' to `max_index'.
		do
			lower_internal := min_index
			upper_internal := max_index
		end

	grow (i: INTEGER) is
			-- Ensure that capacity is at least `i'.
		do
			if capacity < i then
				resize (lower, lower + i - 1)
			end
		ensure then
			no_loss_from_bottom: lower <= old lower
			no_loss_from_top: upper >= old upper
		end

feature -- Removal

	wipe_out is
			-- Remove all items.
		do
			lower_defined := True
			upper_defined := True
			lower_internal := 1
			upper_internal := 0
		end

feature -- Conversion

	as_array: ARRAY [INTEGER] is
			-- Plain array containing interval's items
		require
			finite: upper_defined and lower_defined
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
		obsolete
			"No replacement"
		do
			check
				False
			end
		end

	linear_representation: LINEAR [INTEGER] is
			-- Representation as a linear structure
		do
			check
				terminal: upper_defined and lower_defined
			end
			Result := as_array.linear_representation
		end

feature -- Duplication

	copy (other: like Current) is
			-- Reset to be the same interval as `other'.
		do
			lower_internal := other.lower_internal
			upper_internal := other.upper_internal
			lower_defined := other.lower_defined
			upper_defined := other.upper_defined
		ensure then
			same_lower: lower = other.lower
			same_upper: upper = other.upper
			same_lower_defined: lower_defined = other.lower_defined
			same_upper_defined: upper_defined = other.upper_defined
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
		require
			finite: upper_defined and lower_defined
		local
			i: INTEGER
		do
			from
				Result := True; i := lower
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
		require
			finite: upper_defined and lower_defined
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
		require
			finite: upper_defined and lower_defined
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
		require
			finite: upper_defined and lower_defined
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

feature {INTEGER_INTERVAL} -- Implementation

	upper_internal: INTEGER
			-- See `upper`.
			--| `upper' has a precondition so it can't be an attribute.

	lower_internal: INTEGER
			-- See `lower`.
			--| `lower' has a precondition so it can't be an attribute.

feature {NONE} -- Inapplicable

	prune (v: INTEGER) is
			-- Remove one occurrence of `v' if any.
			-- Not applicable here.
		do
		end

	indexable_put (v: INTEGER; k: INTEGER) is
			-- Associate value `v' with key `k'.
			-- Not applicable here.
		do
		end

invariant

	count_definition: upper_defined and lower_defined implies count = upper - lower + 1

	index_set_is_range: equal (index_set, Current)
	
	not_infinite: upper_defined and lower_defined


indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class INTEGER_INTERVAL



