indexing
	description: "[
					General container data structures, 
					characterized by the membership properties of their items.
			  ]"
	class_type: Interface
	external_name: "ISE.Base.Collection"

deferred class
	COLLECTION [G]

inherit

	CONTAINER [G]

feature -- Status report

	extendible: BOOLEAN is
		indexing
			description: "May new items be added?"
		deferred
		end

	prunable: BOOLEAN is
		indexing
			description: "May items be removed?"
		deferred
		end

	is_inserted (v: G): BOOLEAN is
		indexing
			description: "[
						Has `v' been inserted by the most recent insertion?
						(By default, the value returned is equivalent to calling 
						`has (v)'. However, descendants might be able to provide more
						efficient implementations.)
					  ]"
		deferred
		end

feature -- Element change

	put (v: G) is
		indexing
			description: "Ensure that structure includes `v'."
		require
			extendible: extendible
		deferred
		ensure
			item_inserted: is_inserted (v)
		end

	extend (v: G) is
		indexing
			description: "Ensure that structure includes `v'."
		require
			extendible: extendible
		deferred
		ensure
			item_inserted: is_inserted (v)
		end
		
	fill (other: CONTAINER [G]) is
		indexing
			description: "[
						Fill with as many items of `other' as possible.
						The representations of `other' and current structure
						need not be the same.
					  ]"
		require
			other_not_void: other /= Void
			extendible
		deferred
		end

feature -- Removal

	prune (v: G) is
		indexing
			description: "[
						Remove one occurrence of `v' if any.
						(Reference or object equality,
						based on `object_comparison'.
						if True use `is_equal' else
						`reference_equal')
					  ]"
		require
			prunable: prunable
		deferred
		end

	prune_all (v: G) is
			--| Default implementation, usually inefficient.
		indexing
			description: "[
						Remove all occurrences of `v'.
						(Reference or object equality,
						based on `object_comparison'.
						if True use `is_equal' else
						`reference_equal')
					  ]"
		require
			prunable
		deferred
		ensure
			no_more_occurrences: not has (v)
		end

	wipe_out is
		indexing
			description: "Remove all items."
		require
			prunable
		deferred
		ensure
			wiped_out: is_empty
		end

end -- class COLLECTION


