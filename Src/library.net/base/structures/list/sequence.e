indexing	
	description: "[
					Finite sequences: structures where existing items are arranged
					and accessed sequentially, and new ones can be added at the end.
			  ]"
	class_type: Interface
	external_name: "ISE.Base.Sequence"

deferred class
	SEQUENCE [G]

inherit

	ACTIVE [G]

	BILINEAR [G]

	FINITE [G]

feature -- Element change

	force (v: G) is
		indexing
			description: "Add `v' to end."
		require
			extendible: extendible
		deferred
		ensure
	 		new_count: count = old count + 1
			item_inserted: has (v)
		end

	append (s: SEQUENCE [G]) is
		indexing
			description: "Append a copy of `s'."
		require
			argument_not_void: s /= Void
		deferred
		ensure
	 		new_count: count >= old count
		end

feature -- Removal

	prune (v: G) is
		indexing
			description: "[
						Remove the first occurrence of `v' if any.
						If no such occurrence go `off'.
					  ]"
		deferred
		end

end -- class SEQUENCE



