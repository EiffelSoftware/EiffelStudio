indexing
	description: "Finite structures whose item count is subject to change"
	class_type: Interface
	external_name: "ISE.Base.Resizable"

deferred class 
	RESIZABLE [G] 

inherit
	BOUNDED [G]

feature -- Measurement

	Growth_percentage: INTEGER is 
		indexing
			description: "Percentage by which structure will grow automatically"
		deferred
		end

	Minimal_increase: INTEGER is 
		indexing
			description: "Minimal number of additional items"
		deferred
		end

	additional_space: INTEGER is
			--| Result is a reasonable value, resulting from a space-time tradeoff.
		indexing
			description: "Proposed number of additional items"		
		deferred
		ensure
			At_least_one: Result >= 1
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
		deferred
		ensure
			increased_capacity:
				capacity >= old capacity + old capacity * Growth_percentage // 100
		end

	grow (i: INTEGER) is
		indexing
			description: "Ensure that capacity is at least `i'."
		deferred
		ensure
			new_capacity: capacity >= i
		end

--invariant

--	increase_by_at_least_one: Minimal_increase >= 1

end -- class RESIZABLE


