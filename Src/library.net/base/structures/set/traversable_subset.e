indexing
	description: "Subsets that are traversable sequentially"
	class_type: Interface
	external_name: "ISE.Base.TraversableSubset"

deferred class
	TRAVERSABLE_SUBSET [G]
	
inherit
	SUBSET [G]

feature -- Access

	item: G is
		indexing
			description: "Current item"
		require
			not_off: not off
		deferred
		end

feature -- Status report

	after: BOOLEAN is
		indexing
			description: "Is cursor behind last item?"
		deferred
		end

	off: BOOLEAN is
		indexing
			description: "Is cursor off the active items?"
		deferred
		end
	 
feature -- Cursor movement

	start is
		indexing
			description: "Move cursor to first item."
		deferred
		end

	forth is
		indexing
			description: "Move cursor to next element."
		require
			not_after: not after
		deferred
		end
		
feature -- Removal

	remove is
		indexing
			description: "Remove current item."
		require
			not_off: not off
		deferred
		end
	 
feature {NONE} -- Implementation

	subset_strategy_selection (v: G; other: TRAVERSABLE_SUBSET [G]): 
								SUBSET_STRATEGY [G] is
		indexing
			description: "[
						Strategy to calculate several subset features selected depending
						on the dynamic type of `v'
					  ]"
		require
			exists: v /= Void
		deferred
		ensure
			strategy_set: Result /= Void
		end

	subset_strategy (other: TRAVERSABLE_SUBSET [G]): SUBSET_STRATEGY [G] is
		indexing
			description: "Subset strategy suitable for the type of the contained elements."
		require
			not_empty: not is_empty
		deferred
		end

--invariant

--	empty_definition: is_empty = (count = 0)
--	count_range: count >= 0

end -- class TRAVERSABLE_SUBSET
