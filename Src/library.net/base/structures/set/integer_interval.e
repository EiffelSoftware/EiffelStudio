indexing
	description: "Contiguous integer intervals"
	external_name: "ISE.Base.IntegerInterval"

class
	INTEGER_INTERVAL

inherit
	RESIZABLE [INTEGER]
		undefine
			is_equal
		end

	INDEXABLE [INTEGER, INTEGER]	
		rename
			put as indexable_put
		undefine
			is_equal
		end

	SET [INTEGER]
		undefine
			is_equal
		end

create
	make,
	make_infinite,
	make_infinite_upper,
	make_infinite_lower

feature {NONE} -- Initialization

	make (min_index, max_index: INTEGER) is
		indexing
			description: "[
						Set up interval to have bounds `min_index' and
						`max_index' (empty if `min_index' > `max_index')
					  ]"
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

	make_infinite is
		indexing
			description: "Set up to have no bounds."
		do
		ensure
			not_lower_defined: not lower_defined
			not_upper_defined: not upper_defined
		end

	make_infinite_upper (min_index: INTEGER) is
		indexing
			description: "Set up to have lower bound 'min_index'."
		do
			lower_defined := True
			lower_internal := min_index
		ensure
			lower_defined: lower_defined
			not_upper_defined: not upper_defined
		end

	make_infinite_lower (max_index: INTEGER) is
		indexing
			description: "Set up to have lower bound 'max_index'."
		do
			upper_defined := True
			upper_internal := max_index
		ensure
			not_lower_defined: not lower_defined
			upper_defined: upper_defined
		end

feature -- Initialization
	
	adapt (other: INTEGER_INTERVAL) is
		indexing
			description: "Reset to be the same interval as `other'."
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
		indexing
			description: "Is there a lower bound?"
		end

	lower: INTEGER is
		indexing
			description: "Smallest value in interval"
		require
			lower_defined: lower_defined
		do
			Result := lower_internal
		end

	upper_defined: BOOLEAN
		indexing
			description: "Is there an upper bound?"
		end

	upper: INTEGER is
		indexing
			description: "Largest value in interval"
		require
			upper_defined: upper_defined
		do
			Result := upper_internal
		end

	item (i: INTEGER): INTEGER is
		indexing
			description: "Entry at index `i', if in index interval"
		do
			Result := i
		end

	infix "@" (i: INTEGER): INTEGER is
		indexing
			description: "Entry at index `i', if in index interval"
		do
			Result := i
		end
		
	has (v: INTEGER): BOOLEAN is
		indexing
			description: "Does `v' appear in interval?"
		do
			Result :=
				upper_defined implies v <= upper and
				lower_defined implies v >= lower
		ensure then
			iff_within_bounds: Result = 
				upper_defined implies v <= upper and
				lower_defined implies v >= lower
		end

	valid_index (v: INTEGER): BOOLEAN is
		indexing
			description: "Does `v' appear in interval?"
		do
			Result :=
				upper_defined implies v <= upper and
				lower_defined implies v >= lower
		ensure then
			iff_within_bounds: Result = 
				upper_defined implies v <= upper and
				lower_defined implies v >= lower
		end
		
feature -- Status report

	object_comparison: BOOLEAN is
		indexing
			description: "[
						Must search operations use `equal' rather than `='
						for comparing references? (Default: no, use `='.)
					  ]"
		do
			Result := internal_object_comparison
		end

	is_empty: BOOLEAN is
		indexing
			description: "Is there no element?"
		do
			Result := (count = 0)
		end

	changeable_comparison_criterion: BOOLEAN is
		indexing
			description: "May `object_comparison' be changed? (Answer: yes by default.)"
		do
			Result := is_empty
		end

	full: BOOLEAN is
		indexing
			description: "Is structure filled to capacity?"
		do
			Result := (count = capacity)
		end

	resizable: BOOLEAN is
		indexing
			description: "May `capacity' be changed?"
		do
			Result := True
		end

	all_cleared: BOOLEAN is
		indexing
			description: "Are all items set to default values?"
		do
			Result := ((lower = 0) and (upper = 0))
		ensure then
			iff_at_zero: Result = ((lower = 0) and (upper = 0))
		end

	extendible: BOOLEAN is
		indexing
			description: "May new items be added? Answer: yes"
		do
			Result := True
		end

	prunable: BOOLEAN is
		indexing
			description: "May individual items be removed? Answer: no"
		do
			Result := False
		end

	is_inserted (v: INTEGER): BOOLEAN is
		indexing
			description: "[
						Has `v' been inserted by the most recent insertion?
						(By default, the value returned is equivalent to calling 
						`has (v)'. However, descendants might be able to provide more
						efficient implementations.)
					  ]"
		do
			Result := has (v)
		end

feature -- Status setting

	compare_objects is
		indexing
			description: "[
						Ensure that future search operations will use `equal'
						rather than `=' for comparing references.
					  ]"
		do
			internal_object_comparison := True
		end

	compare_references is
		indexing
			description: "[
						Ensure that future search operations will use `='
						rather than `equal' for comparing references.
					  ]"
		do
			internal_object_comparison := False
		end

feature -- Measurement

	additional_space: INTEGER is
			--| Result is a reasonable value, resulting from a space-time tradeoff.
		indexing
			description: "Proposed number of additional items"			
		do
			if capacity * Growth_percentage // 100 >= Minimal_increase then
				Result := capacity * Growth_percentage // 100
			else
				Result := Minimal_increase
			end
		end

	Growth_percentage: INTEGER is
		indexing
			description: "Percentage by which structure will grow automatically"
		do
			Result := 50
		end

	Minimal_increase: INTEGER is
		indexing
			description: "Minimal number of additional items"
		do
			Result := 5
		end

	occurrences (v: INTEGER): INTEGER is
		indexing
			description: "Number of times `v' appears in structure"
		do
			if has (v) then
				Result := 1
			end
		ensure then
			one_iff_in_bounds: Result = 1 implies has (v)
			zero_otherwise: Result /= 1 implies Result = 0
		end

	capacity: INTEGER is
		indexing
			description: "[
						Maximum number of items in interval
						(here the same thing as `count')
					  ]"
		do
			check
				terminal: upper_defined and lower_defined
			end
			Result := count
		end

	count: INTEGER is
		indexing
			description: "Number of items in interval"
		do
			check
				finite: upper_defined and lower_defined
			end
			if upper_defined and lower_defined then
				Result := upper -lower + 1
			else
				from until False loop end
			end
		ensure then
			definition: Result = upper -lower + 1
		end

	index_set: INTEGER_INTERVAL is
		indexing
			description: "Range of acceptable indexes (here: the interval itself)"
		do
			Result := Current
		ensure then
			index_set_is_range: Result.is_equal (Current)
		end

feature -- Resizing

	automatic_grow is
			--| Trades space for time:
			--| allocates fairly large chunks of memory but not very often.
		indexing
			description: "[
						Change the capacity to accommodate at least
						`Growth_percentage' more items.
					  ]"
		do
			grow (capacity + additional_space)
		end

	undefine_upper is
		indexing
			description: "Remove upper bound."
		do
			upper_defined := False
		end

	undefine_lower is
		indexing
			description: "Remove lower bound."
		do
			lower_defined := False
		end

	resize (min_index, max_index: INTEGER) is
		indexing
			description: "[
						Rearrange interval to go from at most
						`min_index' to at least `max_index',
						encompassing previous bounds.
					  ]"
		do	
			if min_index < lower then
				lower_internal := min_index
			else
				lower_internal := lower
			end
			if max_index > upper then
				lower_internal := max_index
			else
				lower_internal := upper
			end
		end

	resize_exactly (min_index, max_index: INTEGER) is
		indexing
			description: "Rearrange interval to go from `min_index' to `max_index'."
		do
			lower_internal := min_index
			upper_internal := max_index
		end

	grow (i: INTEGER) is
		indexing
			description: "Ensure that capacity is at least `i'."
		do
			if capacity < i then
				resize (lower, lower + i - 1)
			end
		ensure then
			no_loss_from_bottom: lower <=  old lower
			no_loss_from_top: upper >=  old upper
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		indexing
			description: "Is array made of the same items as `other'?"
		do
			Result :=
				lower_defined implies other.lower_defined and lower = other.lower and
				upper_defined implies other.upper_defined and upper = other.upper
		ensure then
			symmetric: Result implies other.is_equal (Current)
			consistent: is_equal (other) implies Result
			iff_same_bounds: Result =
				lower_defined implies other.lower_defined and lower = other.lower and
				upper_defined implies other.upper_defined and upper = other.upper
		end

feature -- Element change
	
	extend (v: INTEGER) is
		indexing
			description: "Make sure that interval goes all the way to `v' (up or down)."
		do
			if v < lower then
				lower_internal := v
			elseif v > upper then
				upper_internal := v
			end
		ensure then
			in_set_already: old has (v) implies (count = old count)
			added_to_set: not old has (v) implies (count = old count + 1)
			one_more_occurrence: occurrences (v) = old (occurrences (v)) + 1
--			extended_down: lower = SYSTEM_MATH.min_int32 (old lower, v)
--			extended_up: SYSTEM_MATH.max_int32 (old upper, v)
		end

	put (v: INTEGER) is
		indexing
			description: "Make sure that interval goes all the way to `v' (up or down)."
		do
			if v < lower then
				lower_internal := v
			elseif v > upper then
				upper_internal := v
			end
		ensure then
			in_set_already: old has (v) implies (count = old count)
			added_to_set: not old has (v) implies (count = old count + 1)
			one_more_occurrence: occurrences (v) = old (occurrences (v)) + 1
--			extended_down: lower = SYSTEM_MATH.min_int32 (old lower, v)
--			extended_up: SYSTEM_MATH.max_int32 (old upper, v)
		end
		
	fill (other: CONTAINER [INTEGER]) is
		indexing
			description: "[
						Fill with as many items of `other' as possible.
						The representations of `other' and current structure
						need not be the same.
					  ]"
		local
			lin_rep: LINEAR [INTEGER]
		do
			lin_rep := other.linear_representation
			from
				lin_rep.start
			until
				not extendible or else lin_rep.off
			loop
				extend (lin_rep.item)
				lin_rep.forth
			end
		end

feature -- Removal

	prune_all (v: INTEGER) is
			--| Default implementation, usually inefficient.
		indexing
			description: "[
						Remove all occurrences of `v'.
						(Reference or object equality,
						based on `object_comparison'.)
					  ]"
		do
			from
			until
				not has (v)
			loop
				prune (v)
			end
		end

	wipe_out is
		indexing
			description: "Remove all items."
		do
			lower_defined := True
			upper_defined := True
			lower_internal := 1
			upper_internal := 0
		end

feature -- Conversion

	as_array: ARRAY [INTEGER] is
		indexing
			description: "Plain array containing interval's items"
		require
			finite: upper_defined and lower_defined
		local
			i: INTEGER
		do
			check
				upper - lower > 0
			end
			create Result.make (upper - lower)
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

	linear_representation: LINEAR [INTEGER] is
		indexing
			description: "Representation as a linear structure"
		local
--			temp: ARRAYED_LIST [INTEGER]
			i: INTEGER
		do
			check
				terminal: upper_defined and lower_defined
			end
--			create temp.make (capacity)
			from
				i := lower
			until
				i > upper
			loop
--				temp.extend (i)
				i := i + 1
			end
--			Result := temp
		end

feature -- Duplication

	copy (other: like Current) is
		indexing
			description: "Reset to be the same interval as `other'."
		require
			other_not_void: other /= void
			type_identity: get_type.is_equal (other.get_type)
		do
			lower_internal := other.lower_internal
			upper_internal := other.upper_internal
			lower_defined := other.lower_defined
			upper_defined := other.upper_defined
		ensure then
			is_equal: is_equal (other)
			same_lower: lower = other.lower
			same_upper: upper = other.upper
			same_lower_defined: lower_defined = other.lower_defined
			same_upper_defined: upper_defined = other.upper_defined
		end

	subinterval (start_pos, end_pos: INTEGER): INTEGER_INTERVAL is
		indexing
			description: "[
						Interval made of items of current array within
						bounds `start_pos' and `end_pos'.
					  ]"
		do
			create Result.make (start_pos, end_pos)
		end

feature -- Iteration

--	for_all (condition:
--				FUNCTION [ANY, TUPLE [INTEGER], BOOLEAN]):
--			BOOLEAN is
--			-- Do all interval's values satisfy `condition'?
--		require
--			finite: upper_defined and lower_defined
--		do
--		ensure
--			consistent_with_count:
--				Result = (hold_count (condition) = count)
--		end

--	exists (condition:
--				FUNCTION [ANY, TUPLE [INTEGER], BOOLEAN]):
--			BOOLEAN is
			-- Does at least one of  interval's values
			-- satisfy `condition'?
--		require
--			finite: upper_defined and lower_defined
--		do
--		ensure
--			consistent_with_count:
--				Result = (hold_count (condition) > 0)
--		end

--	exists1 (condition:
--				FUNCTION [ANY, TUPLE [INTEGER], BOOLEAN]):
--			BOOLEAN is
			-- Does exactly one of  interval's values
			-- satisfy `condition'?
--		require
--			finite: upper_defined and lower_defined
--		do
--		ensure
--			consistent_with_count:
--				Result = (hold_count (condition) = 1)
--		end

--	hold_count (condition:
--				FUNCTION [ANY, TUPLE [INTEGER], BOOLEAN]):
--			INTEGER is
			-- Number of  interval's values that
			-- satisfy `condition'
--		require
--			finite: upper_defined and lower_defined
--		do
--		ensure
--			non_negative: Result >= 0
--		end

feature {INTEGER_INTERVAL} -- Implementation

	upper_internal: INTEGER
			--| `upper' has a precondition so it can't be an attribute.
		indexing
			description: "See `upper`."
		end
			
	lower_internal: INTEGER
			--| `lower' has a precondition so it can't be an attribute.
		indexing
			description: "See `lower`."
		end
			
feature {NONE} -- Inapplicable

	valid_key (v: INTEGER): BOOLEAN is
		indexing
			description: "Does `v' appear in interval?"
		do
		end
		
	prune (v: INTEGER) is
		indexing
			description: "[
						Remove one occurrence of `v' if any.
						(Reference or object equality,
						based on `object_comparison'.)
					  ]"
		do
		ensure then
			removed_count_change: old has (v) implies (count = old count - 1)
			not_removed_no_count_change: not old has (v) implies (count = old count)
			item_deleted: not has (v)
		end

	indexable_put (v: INTEGER; k: INTEGER) is
		indexing
			description: "Associate value `v' with key `k'. Not applicable here."
		do
		ensure then
			insertion_done: item (k) = v
		end

feature -- Implementation

	implementation: SYSTEM_COLLECTIONS_ICOLLECTION is
		indexing
			description: "Object for .NET access and implementation"
		do
		end

feature {NONE} -- Implementation

	internal_object_comparison: BOOLEAN

invariant
	count_definition: upper_defined and lower_defined implies count = upper -lower + 1
	index_set_is_range: index_set.is_equal (Current)


end -- class INTEGER_INTERVAL



