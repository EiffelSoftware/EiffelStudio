indexing
	description: "Subsets that are traversable linearly without commitment to a concrete implementation."
	class_type: Interface
	external_name: "ISE.Base.LinearSubset"

deferred class 
	LINEAR_SUBSET [G] 

inherit
	TRAVERSABLE_SUBSET [G]

feature -- Access

	index: INTEGER is
		indexing
			description: "Index of current item"
		deferred
		end
	 
feature -- Status report

	valid_index (i: INTEGER): BOOLEAN is
		indexing
			description: "Is `i' a valid index?"
		deferred
		end
	
feature -- Cursor movement

	go_i_th (i: INTEGER) is
		indexing
			description: "Move cursor to `i'-th item."
		require
			valid_index: valid_index (i)
		deferred
		ensure
			index_set: index = i
		end

end -- class LINEAR_SUBSET
