indexing
	description: "Sets implemented by linked lists"
	external_name: "ISE.Base.LinkedSet"

class 
	LINKED_SET [G] 

inherit

	LINEAR_SUBSET [G]
		undefine
			is_equal
		end

	LINKED_LIST [G]
		redefine
			changeable_comparison_criterion, is_inserted,
			extend, put, prune, merge_left, merge_right,
			duplicate, new_chain
		end

create

	make
	
feature -- Status report

	changeable_comparison_criterion: BOOLEAN is
		indexing
			description: "[
						May `object_comparison' be changed?
						(Answer: only if set empty; otherwise insertions might
						introduce duplicates, destroying the set property.)
					  ]"
		do
			Result := is_empty
		ensure then
			only_on_empty: Result = is_empty
		end

	is_inserted (v: G): BOOLEAN is
		indexing
			description: "[
						Has `v' been inserted by the most recent insertion?
						(By default, the value returned is equivalent to calling 
						`has (v)'. However, descendants might be able to provide more
						efficient implementations.)
					  ]"
		do
			Result := has (v)
		end

feature -- Comparison

	is_subset (other: TRAVERSABLE_SUBSET [G]): BOOLEAN is
		indexing
			description: "Is current set a subset of `other'?"
		do
			if not other.is_empty and then count <= other.count then
				from
					start
				until
					off or else not other.has (item)
				loop
					forth
				end
				if off then Result := True end
			elseif is_empty then
				Result := True
			end
		end

	is_superset (other: SUBSET [G]): BOOLEAN is
		indexing
			description: "Is current set a superset of `other'?"
		do
			Result := other.is_subset (Current)
		end

	disjoint (other: TRAVERSABLE_SUBSET [G]): BOOLEAN is
		indexing
			description: "Do current set and `other' have no items in common?"
		local
			s: SUBSET_STRATEGY [G]
		do
			if not is_empty and not other.is_empty then
				s := subset_strategy (other)
				Result := s.disjoint (Current, other)
			else
				Result := True
			end
		end

feature -- Element change

	extend (v: G) is
		indexing
			description: "Ensure that set includes `v'."
		do
			if is_empty or else not has (v) then
				Precursor (v)
			end
		ensure then
			in_set_already: old has (v) implies (count = old count)
			added_to_set: not old has (v) implies (count = old count + 1)
		end

	put (v: G) is
		indexing
			description: "Ensure that set includes `v'."
		do
			if is_empty or else not has (v) then
				Precursor (v)
			end
		ensure then
			in_set_already: old has (v) implies (count = old count)
			added_to_set: not old has (v) implies (count = old count + 1)
		end

	merge (other: CONTAINER [G]) is
		indexing
			description: "Add all items of `other'."
		local
			lin_rep: LINEAR [G]
		do 
			lin_rep ?= other
			if lin_rep = Void then
					-- `other' is not a descendant of LINEAR, therefore  we
					-- must convert its contents into a linear representation.
				lin_rep := other.linear_representation
			end
			from
				lin_rep.start
			until
				lin_rep.off
			loop
				extend (lin_rep.item)
				lin_rep.forth
			end
		end

	merge_left (other: LINKED_SET [G]) is
		indexing
			description: "[
						Merge `other' into current structure before cursor
						position. Do not move cursor. Empty `other'.
					  ]"
		local
			other_first_element: LINKABLE [G]
			other_last_element: LINKABLE [G]
			p: LINKABLE [G]
			other_count: INTEGER
		do
			if not other.is_empty then
				other_first_element := other.first_element
				other_last_element := other.last_element
				other_count := other.count
					check
						other_first_element /= Void
						other_last_element /= Void
					end
				if is_empty then
					first_element := other_first_element
					active := first_element
				elseif isfirst then
					p := first_element
					other_last_element.put_right (p)
					first_element := other_first_element
				else
					p := previous
					if p /= Void then
						p.put_right (other_first_element)
					end
					other_last_element.put_right (active)
				end
				internal_count := count + other_count
				other.wipe_out
			end
		end

	merge_right (other: LINKED_SET [G]) is
		indexing
			description: "[
						Merge `other' into current structure after cursor
						position. Do not move cursor. Empty `other'.
					  ]"
		local
			other_first_element: LINKABLE [G]
			other_last_element: LINKABLE [G]
			other_count: INTEGER
		do
			if not other.is_empty then
				other_first_element := other.first_element
				other_last_element := other.last_element
				other_count := other.count
					check
						other_first_element /= Void
						other_last_element /= Void
					end
				if is_empty then
					first_element := other_first_element
					active := first_element
				else
					if not islast then
						other_last_element.put_right (active.right)
					end
					active.put_right (other_first_element)
				end
				internal_count := count + other_count
				other.wipe_out
			end
		end
		
feature -- Removal

	prune (v : G) is
		indexing
			description: "Remove `v' if present."
		do
			start
			Precursor (v)
		end

feature -- Basic operations

	intersect (other: TRAVERSABLE_SUBSET [G]) is
		indexing
			description: "[
						Remove all items not in `other'.
						No effect if `other' `is_empty'.
					  ]"
		do
			if not other.is_empty then
				from
					start
					other.start
				until
					off
				loop
					if other.has (item) then
						forth
					else
						remove
					end
				end
			else
				wipe_out
			end
		end

	subtract (other: TRAVERSABLE_SUBSET [G]) is
		indexing
			description: "Remove all items also in `other'."
		do
			if not (other.is_empty or is_empty) then
				from
					start
					other.start
				until
					off
				loop
					if other.has (item) then
						remove
					else
						forth
					end
				end
			end
		end

	symdif (other: TRAVERSABLE_SUBSET [G]) is
		indexing
			description: "[
						Remove all items also in `other', and add all
						items of `other' not already present.
					  ]"
		local
			s: SUBSET_STRATEGY [G]
		do
			if not other.is_empty then
				if is_empty then
--					copy (other)
				else
					s := subset_strategy (other)
					s.symdif (Current, other)
				end
			end
		end
		
feature -- Duplication

	duplicate (n: INTEGER): LINKED_SET [G] is
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
		
feature -- Implementation

	new_chain: LINKED_SET [G] is
		indexing
			description: "[
						A newly created instance of the same type.
						This feature may be redefined in descendants so as to
						produce an adequately allocated and initialized object.
					  ]"
		do
			create Result.make
		end

feature {NONE} -- Implementation

	subset_strategy_selection (v: G; other: TRAVERSABLE_SUBSET [G]): 
							SUBSET_STRATEGY [G] is
		indexing
			description: "[
						Strategy to calculate several subset features selected depending
						on the dynamic type of `v'
					  ]"
		do
			create {SUBSET_STRATEGY_HASHABLE [G]} Result
		end

	subset_strategy (other: TRAVERSABLE_SUBSET [G]): SUBSET_STRATEGY [G] is
		indexing
			description: "Subset strategy suitable for the type of the contained elements."
		do
			start
			check
				not_off: not off
					-- Because we are at the first element of structure and the
					-- structure is not empty.
			end
			Result := subset_strategy_selection (item, other)
		end

--feature {NONE} -- Inapplicable
--
--	subset_duplicate (n: INTEGER): SUBSET [G] is
--		do
--		end		

end -- class LINKED_SET



