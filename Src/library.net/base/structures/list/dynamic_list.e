indexing
	description: "[
				Sequential, dynamically modifiable lists,
				without commitment to a particular representation
			  ]"
	external_name: "ISE.Base.DynamicList"

deferred class
	DYNAMIC_LIST [G]
		
inherit

	LIST [G]
		undefine
			remove
		redefine
			prune_all, wipe_out
		end
		
	DYNAMIC_CHAIN [G]
		undefine
			is_equal
		redefine
			merge_left, merge_right, new_chain,
			put_front, put_left, remove_right
		end
		
feature -- Element change

	put_right (v: G) is
		indexing
			description: "Add `v' to the right of cursor position. Do not move cursor."
		deferred
		end

feature -- Removal

	prune_all (v: G) is
		indexing
			description: "[
						Remove all occurrences of `v'.
						(Reference or object equality,
						based on `object_comparison'.
						if True use `is_equal' else
						`reference_equal')
						Leave structure `exhausted'.
				  ]"
		do
			from
				start
				search (v)
			until
				exhausted
			loop
				remove
				search (v)
			end
		ensure then
			is_exhausted: exhausted
		end

	remove is
		indexing
			description: "[
						Remove current item.
						Move cursor to right neighbor
						(or `after' if no right neighbor).
					  ]"
		deferred
		ensure then
			after_when_empty: is_empty implies after
		end

	remove_left is
		indexing
			description: "Remove item to the left of cursor position. Do not move cursor."
		require else
			not_before: not before
		deferred
		end

	wipe_out is
		indexing
			description: "Remove all items."
		do
			Precursor {LIST}
		ensure then
			is_before: before
		end

feature -- Duplication

	duplicate (n: INTEGER): CHAIN [G] is
		indexing
			description: "[
						Copy of sub-chain beginning at current position
						and having min (`n', `from_here') items,
						where `from_here' is the number of items
						at or to the right of current position.
					  ]"
		local
			pos: CURSOR
			counter: INTEGER
		do
			from
				Result := new_chain
				if object_comparison then
					Result.compare_objects
				end
				pos := cursor
			until
				(counter = n) or else exhausted
			loop
				Result.extend (item)
				forth
				counter := counter + 1
			end
			go_to (pos)
		end

feature -- Bug fix?

	merge_left (other: DYNAMIC_LIST [G]) is
		indexing
			description: "[
						Merge `other' into current structure before cursor
						position. Do not move cursor. Empty `other'.
					  ]"
		deferred
		end
		
	merge_right (other: DYNAMIC_LIST [G]) is
		indexing	
			description: "[
						Merge `other' into current structure after cursor
						position. Do not move cursor. Empty `other'.
					  ]"
		deferred
		end
		
	new_chain: DYNAMIC_CHAIN [G] is
		indexing
			description: "[
						A newly created instance of the same type.
						This feature may be redefined in descendants so as to
						produce an adequately allocated and initialized object.
					  ]"
		deferred
		end
		
	put_front (v: G) is
		indexing
			description: "Add `v' at beginning. Do not move cursor."
		deferred
		end
		
	put_left (v: G) is
		indexing
			description: "Add `v' to the left of cursor position. Do not move cursor."
		deferred
		end
		
	remove_right is
		indexing
			description: "[
						Remove item to the right of cursor position.
						 Do not move cursor.
						(from DYNAMIC_CHAIN)
					  ]"
		deferred
		end

end -- class DYNAMIC_LIST
