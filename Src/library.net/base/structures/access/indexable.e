indexing
	description: "Tables whose keys are integers in a contiguous interval"
	class_type: Interface
	external_name: "ISE.Base.Indexable"

deferred class 
	INDEXABLE [G, H -> INTEGER] 

inherit
	TABLE [G, H]

feature -- Measurement

	index_set: INTEGER_INTERVAL is
		indexing
			description: "Range of acceptable indexes"
		deferred
		ensure
			not_void: Result /= Void
		end

--invariant
--	index_set_not_void: index_set /= Void

end -- class INDEXABLE



