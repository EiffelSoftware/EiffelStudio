indexing
	description: "Dynamically modifiable chains"
	class_type: Interface
	external_name: "ISE.Base.DynamicChain"

deferred class 
	DYNAMIC_CHAIN [G] 

inherit
	CHAIN [G]
		export
			{ANY} remove, prune_all, prune
		end

feature -- Status report

	extendible: BOOLEAN is 
		indexing
			description: "May new items be added? (Answer: yes.)"
		deferred
		end

feature -- Element change

	put_front (v: G) is
		indexing
			description: "Add `v' at beginning. Do not move cursor."
		deferred
		ensure
	 		new_count: count = old count + 1
			item_inserted: first = v
		end

	put_left (v: G) is
		indexing
			description: "Add `v' to the left of cursor position. Do not move cursor."
		require
			extendible: extendible
			not_before: not before
		deferred
		ensure
	 		new_count: count = old count + 1
	 		new_index: index = old index + 1
		end

	put_right (v: G) is
		indexing
			description: "Add `v' to the right of cursor position. Do not move cursor."
		require
			extendible: extendible
			not_after: not after
		deferred
		ensure
	 		new_count: count = old count + 1
	 		same_index: index = old index
		end

	merge_left (other: DYNAMIC_CHAIN [G]) is
		indexing
			description: "[
						Merge `other' into current structure before cursor
						position. Do not move cursor. Empty `other'.
					  ]"
		require
			extendible: extendible
			not_off: not before
			other_exists: other /= Void
		deferred
		ensure
	 		new_count: count = old count + old other.count
	 		new_index: index = old index + old other.count
			other_is_empty: other.is_empty
		end

	merge_right (other: DYNAMIC_CHAIN [G]) is
		indexing
			description: "[
						Merge `other' into current structure after cursor
						position. Do not move cursor. Empty `other'.
					  ]"
		require
			extendible: extendible
			not_off: not after
			other_exists: other /= Void
		deferred
		ensure
	 		new_count: count = old count + old other.count
	 		same_index: index = old index
			other_is_empty: other.is_empty
		end

feature -- Removal

	remove_left is
		indexing
			description: "Remove item to the left of cursor position. Do not move cursor."
		require
			left_exists: index > 1
		deferred
		ensure
	 		new_count: count = old count - 1
	 		new_index: index = old index - 1
		end

	remove_right is
		indexing
			description: "Remove item to the right of cursor position. Do not move cursor."
		require
			right_exists: index < count
		deferred
		ensure
	 		new_count: count = old count - 1
	 		same_index: index = old index
		end

feature {DYNAMIC_CHAIN} -- Implementation

	new_chain: DYNAMIC_CHAIN [G] is
		indexing
			description: "[
						A newly created instance of the same type.
						This feature may be redefined in descendants so as to
						produce an adequately allocated and initialized object.
					  ]"
		deferred
		ensure
			result_exists: Result /= Void
		end

--invariant
--	extendible: extendible

end -- class DYNAMIC_CHAIN



