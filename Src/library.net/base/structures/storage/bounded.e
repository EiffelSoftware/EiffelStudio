indexing
	description: "Bounded data structures, with a notion of capacity."
	class_type: Interface
	external_name: "ISE.Base.Bounded"

deferred class 
	BOUNDED [G] 

inherit
	FINITE [G]

feature -- Measurement

	capacity: INTEGER is
		indexing
			description: "Number of items that may be stored"
		deferred
		end

feature -- Status report

	resizable: BOOLEAN is
		indexing
			description: "May `capacity' be changed?"
		deferred
		end

--invariant

--	valid_count: count <= capacity
--	full_definition: full = (count = capacity)

end -- class BOUNDED



