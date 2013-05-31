class 
	TEST

create

	make

feature {NONE} -- Initialization

	make
			-- Execute test.
		do
			linked_set_append
			linked_set_duplicate
			linked_set_merge_left
			linked_set_merge_right
			linked_set_put_i_th
			linked_set_put_front
			linked_set_put_left
			linked_set_put_right
			linked_set_replace
			linked_set_is_equal
		end
		
	linked_set_append
			-- `append' uses set rules when adding elements, contrary to its header comment.
			-- It is inconsistent with `append' from ARRAYED_SET, which uses the list rules.
			-- I think `append' should use list rules, but be hidden.
		local
			set1, set2: LINKED_SET [INTEGER]
		do
			create set1.make
			set1.extend (1)
			set1.extend (2)
			create set2.make
			set2.extend (1)
			set1.append (set2)
			check set1.count = 3 end
		end

	linked_set_duplicate
			-- See `arrayed_set_duplicate'.
			-- If preconditions are or-ed, the call produces unexpected result when the cursor is `before':
			-- empty set instead of the whole set.
		local
			set1: LINKED_SET [INTEGER]
			set2, set3: SUBSET [INTEGER]
		do
			create set1.make
			set1.extend (1)
			set1.extend (2)
			set1.go_i_th (0)
			set2 := set1
			set3 := set2.duplicate (2)
		end

	linked_set_merge_left
			-- `merge_left' introduces duplicates, should be hidden.
		local
			set1, set2: LINKED_SET [INTEGER]
		do
			create set1.make
			set1.extend (1)
			create set2.make
			set2.extend (1)
			set1.start
			set1.merge_left (set2)
			check
				no_duplicates: across set1 as c1 all (across set1 as c2 all c1 /~ c2 implies c1.item /= c2.item end) end
			end
		end

	linked_set_merge_right
			-- `merge_right' introduces duplicates, should be hidden.
		local
			set1, set2: LINKED_SET [INTEGER]
		do
			create set1.make
			set1.extend (1)
			create set2.make
			set2.extend (1)
			set1.start
			set1.merge_right (set2)
			check
				no_duplicates: across set1 as c1 all (across set1 as c2 all c1 /~ c2 implies c1.item /= c2.item end) end
			end
		end

	linked_set_put_i_th
			-- `put_i_th' introduces duplicates, should be hidden.
		local
			set: LINKED_SET [INTEGER]
		do
			create set.make
			set.extend (1)
			set.extend (2)
			set.put_i_th (1, 2)
			check
				no_duplicates: across set as c1 all (across set as c2 all c1 /~ c2 implies c1.item /= c2.item end) end
			end
		end

	linked_set_put_front
			-- `put_front' introduces duplicates, should be hidden.
		local
			set: LINKED_SET [INTEGER]
		do
			create set.make
			set.extend (1)
			set.put_front (1)
			check
				no_duplicates: across set as c1 all (across set as c2 all c1 /~ c2 implies c1.item /= c2.item end) end
			end
		end

	linked_set_put_left
			-- `put_left' introduces duplicates, should be hidden.
		local
			set: LINKED_SET [INTEGER]
		do
			create set.make
			set.extend (1)
			set.start
			set.put_left (1)
			check
				no_duplicates: across set as c1 all (across set as c2 all c1 /~ c2 implies c1.item /= c2.item end) end
			end
		end

	linked_set_put_right
			-- `put_right' introduces duplicates, should be hidden.
		local
			set: LINKED_SET [INTEGER]
		do
			create set.make
			set.extend (1)
			set.start
			set.put_right (1)
			check
				no_duplicates: across set as c1 all (across set as c2 all c1 /~ c2 implies c1.item /= c2.item end) end
			end
		end

	linked_set_replace
			-- `replace' introduces duplicates, should be hidden.
		local
			set: LINKED_SET [INTEGER]
		do
			create set.make
			set.extend (1)
			set.extend (2)
			set.finish
			set.replace (1)
			check
				no_duplicates: across set as c1 all (across set as c2 all c1 /~ c2 implies c1.item /= c2.item end) end
			end
		end

	linked_set_is_equal
			-- Order is taken into account when comparing sets.
			-- (See also: `arrayed_set_is_equal').
		local
			set1, set2: LINKED_SET [INTEGER]
		do
			create set1.make
			set1.extend (1)
			set1.extend (2)
			create set2.make
			set2.extend (2)
			set2.extend (1)
			check set1.is_equal (set2) end
		end
		
end
