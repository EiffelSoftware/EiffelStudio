indexing
	description: "Structures whose items may be accessed sequentially, one-way"
	class_type: Interface
	external_name: "ISE.Base.Linear"

deferred class
	LINEAR [G]

inherit
	TRAVERSABLE [G]

feature -- Access

	index_of (v: G; i: INTEGER): INTEGER is
		indexing
			description: "[
						Index of `i'-th occurrence of `v'.
						0 if none.
						(Reference or object equality,
						based on `object_comparison'.
						if True use `is_equal' else
						`reference_equal')
					  ]"
		require
			positive_occurrences: i > 0
		deferred
		ensure
			non_negative_result: Result >= 0
		end

	search (v: G) is
		indexing
			description: "[
						Move to first position (at or after current
						position) where `item' and `v' are equal.
						(Reference or object equality,
						based on `object_comparison'.
						if True use `is_equal' else
						`reference_equal')
						If no such position ensure that `exhausted' will be true.
					  ]"
		deferred
		ensure
			object_found: (not exhausted and object_comparison)
				 implies v.is_equal (item)
			item_found: (not exhausted and not object_comparison)
				 implies v = item
		end

	index: INTEGER is
		indexing
			description: "Index of current position"
		deferred
		end

	occurrences (v: G): INTEGER is
		indexing
			description: "[
						Number of times `v' appears.
						(Reference or object equality,
						based on `object_comparison'.
						if True use `is_equal' else
						`reference_equal')
					  ]"
		deferred
		end

feature -- Status report

	exhausted: BOOLEAN is
		indexing
			description: "Has structure been completely explored?"
		deferred
		ensure
			exhausted_when_off: off implies Result
		end

	after: BOOLEAN is
		indexing
			description: "Is there no valid position to the right of current one?"
		deferred
		end

feature -- Cursor movement

	finish is
		indexing
			description: "Move to last position."
		deferred
		end

	forth is
		indexing
			description: "[
						Move to next position; if no next position,
						ensure that `exhausted' will be true.
					  ]"
		require
			not_after: not after
		deferred
		ensure
			-- moved_forth_before_end: (not after) implies index = old index + 1
		end

--invariant

--	after_constraint: after implies off

end -- class LINEAR



