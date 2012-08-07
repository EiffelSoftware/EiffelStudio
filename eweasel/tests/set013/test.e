class 
	TEST

create

	make

feature {NONE} -- Initialization

	make
			-- Execute test.
		do
			two_way_sorted_set_duplicate
			two_way_sorted_set_intersect_1
			two_way_sorted_set_intersect_2
			two_way_sorted_set_merge
			two_way_sorted_set_merge_left_1
			two_way_sorted_set_merge_left_2
			two_way_sorted_set_merge_right_1
			two_way_sorted_set_merge_right_2
			two_way_sorted_set_move_item
			two_way_sorted_set_put_i_th_1
			two_way_sorted_set_put_i_th_2
			two_way_sorted_set_put_front_1
			two_way_sorted_set_put_front_2
			two_way_sorted_set_put_left_1
			two_way_sorted_set_put_left_2
			two_way_sorted_set_put_right_1
			two_way_sorted_set_put_right_2
			two_way_sorted_set_replace_1
			two_way_sorted_set_replace_2
			two_way_sorted_set_subtract_1
			two_way_sorted_set_subtract_2
			two_way_sorted_set_swap
		end
		
	two_way_sorted_set_duplicate
			-- See `arrayed_set_duplicate'.
		local
			set1: TWO_WAY_SORTED_SET [INTEGER]
			set2, set3: SUBSET [INTEGER]
		do
			create set1.make
			set1.extend (1)
			set1.extend (2)
			set1.go_i_th (0)
			set2 := set1
			set3 := set2.duplicate (2)
		end

	two_way_sorted_set_intersect_1
			-- `intersect' always compares objects, even when `object_comparison' is False.
		local
			set1, set2: TWO_WAY_SORTED_SET [STRING]
		do
			create set1.make
			set1.extend ("hello")
			set1.extend ("hello")
			-- This is correct, because of reference comparison.
			check set1.count = 2 end
			create set2.make
			set2.extend ("hello")
			set1.intersect (set2)
		end

	two_way_sorted_set_intersect_2
			-- When Current = `other', `forth' is called twice in a row and the second time the cursor can be off.
		local
			set: TWO_WAY_SORTED_SET [STRING]
		do
			create set.make
			set.extend ("hello")
			set.intersect (set)
		end

	two_way_sorted_set_merge
			-- When Current = `other', `forth' is called twice in a row and the second time the cursor can be off.
		local
			set: TWO_WAY_SORTED_SET [STRING]
		do
			create set.make
			set.extend ("hello")
			set.merge (set)
		end

	two_way_sorted_set_merge_left_1
			-- `merge_left' violates sortedness, should be hidden.
		local
			set1, set2: TWO_WAY_SORTED_SET [INTEGER]
		do
			create set1.make
			set1.extend (1)
			create set2.make
			set2.extend (2)
			set1.start
			set1.merge_left (set2)
			check
				sorted: across set1 as c1 all (across set1 as c2 all c1.cursor_index < c2.cursor_index implies c1.item <= c2.item end) end
			end
		end

	two_way_sorted_set_merge_left_2
			-- `merge_left' introduces duplicates, should be hidden.
			-- See also `linked_set_merge_left'.
		local
			set1, set2: TWO_WAY_SORTED_SET [INTEGER]
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

	two_way_sorted_set_merge_right_1
			-- `merge_right' violates sortedness, should be hidden.
		local
			set1, set2: TWO_WAY_SORTED_SET [INTEGER]
		do
			create set1.make
			set1.extend (2)
			create set2.make
			set2.extend (1)
			set1.start
			set1.merge_right (set2)
			check
				sorted: across set1 as c1 all (across set1 as c2 all c1.cursor_index < c2.cursor_index implies c1.item <= c2.item end) end
			end
		end

	two_way_sorted_set_merge_right_2
			-- `merge_right' introduces duplicates, should be hidden.
			-- See also `linked_set_merge_right'.
		local
			set1, set2: TWO_WAY_SORTED_SET [INTEGER]
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

	two_way_sorted_set_move_item
			-- `move_item' violates sortedness, should be hidden.
		local
			set: TWO_WAY_SORTED_SET [INTEGER]
		do
			create set.make
			set.extend (1)
			set.extend (2)
			set.start
			set.move_item (2)
			check
				sorted: across set as c1 all (across set as c2 all c1.cursor_index < c2.cursor_index implies c1.item <= c2.item end) end
			end
		end

	two_way_sorted_set_put_i_th_1
			-- `put_i_th' violates sortedness, should be hidden.
		local
			set: TWO_WAY_SORTED_SET [INTEGER]
		do
			create set.make
			set.extend (1)
			set.extend (2)
			set.put_i_th (0, 2)
			check
				sorted: across set as c1 all (across set as c2 all c1.cursor_index < c2.cursor_index implies c1.item <= c2.item end) end
			end
		end

	two_way_sorted_set_put_i_th_2
			-- `put_i_th' introduces duplicates, should be hidden.
			-- See also `linked_set_put_i_th'.
		local
			set: TWO_WAY_SORTED_SET [INTEGER]
		do
			create set.make
			set.extend (1)
			set.extend (2)
			set.put_i_th (1, 2)
			check
				no_duplicates: across set as c1 all (across set as c2 all c1 /~ c2 implies c1.item /= c2.item end) end
			end
		end

	two_way_sorted_set_put_front_1
			-- `put_front' violates sortedness, should be hidden.
		local
			set: TWO_WAY_SORTED_SET [INTEGER]
		do
			create set.make
			set.extend (1)
			set.put_front (2)
			check
				sorted: across set as c1 all (across set as c2 all c1.cursor_index < c2.cursor_index implies c1.item <= c2.item end) end
			end
		end

	two_way_sorted_set_put_front_2
			-- `put_front' introduces duplicates, should be hidden.
			-- See also `linked_set_put_front'.
		local
			set: TWO_WAY_SORTED_SET [INTEGER]
		do
			create set.make
			set.extend (1)
			set.put_front (1)
			check
				no_duplicates: across set as c1 all (across set as c2 all c1 /~ c2 implies c1.item /= c2.item end) end
			end
		end

	two_way_sorted_set_put_left_1
			-- `put_left' violates sortedness, should be hidden.
		local
			set: TWO_WAY_SORTED_SET [INTEGER]
		do
			create set.make
			set.extend (1)
			set.start
			set.put_left (2)
			check
				sorted: across set as c1 all (across set as c2 all c1.cursor_index < c2.cursor_index implies c1.item <= c2.item end) end
			end
		end

	two_way_sorted_set_put_left_2
			-- `put_left' introduces duplicates, should be hidden.
			-- See also `linked_set_put_left'.
		local
			set: TWO_WAY_SORTED_SET [INTEGER]
		do
			create set.make
			set.extend (1)
			set.start
			set.put_left (1)
			check
				no_duplicates: across set as c1 all (across set as c2 all c1 /~ c2 implies c1.item /= c2.item end) end
			end
		end

	two_way_sorted_set_put_right_1
			-- `put_right' violates sortedness, should be hidden.
		local
			set: TWO_WAY_SORTED_SET [INTEGER]
		do
			create set.make
			set.extend (1)
			set.start
			set.put_right (0)
			check
				sorted: across set as c1 all (across set as c2 all c1.cursor_index < c2.cursor_index implies c1.item <= c2.item end) end
			end
		end

	two_way_sorted_set_put_right_2
			-- `put_right' introduces duplicates, should be hidden.
			-- See also `linked_set_put_right'.
		local
			set: TWO_WAY_SORTED_SET [INTEGER]
		do
			create set.make
			set.extend (1)
			set.start
			set.put_right (1)
			check
				no_duplicates: across set as c1 all (across set as c2 all c1 /~ c2 implies c1.item /= c2.item end) end
			end
		end

	two_way_sorted_set_replace_1
			-- `replace' violates sortedness, should be hidden.
		local
			set: TWO_WAY_SORTED_SET [INTEGER]
		do
			create set.make
			set.extend (1)
			set.extend (2)
			set.start
			set.replace (3)
			check
				sorted: across set as c1 all (across set as c2 all c1.cursor_index < c2.cursor_index implies c1.item <= c2.item end) end
			end
		end

	two_way_sorted_set_replace_2
			-- `replace' introduces duplicates, should be hidden.
			-- See also `linked_set_replace'.
		local
			set: TWO_WAY_SORTED_SET [INTEGER]
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

	two_way_sorted_set_subtract_1
			-- `subtract' always compares objects, even when `object_comparison' is False.
		local
			set1, set2: TWO_WAY_SORTED_SET [STRING]
		do
			create set1.make
			set1.extend ("hello")
			set1.extend ("hello")
			-- This is correct, because of reference comparison.
			check set1.count = 2 end
			create set2.make
			set2.extend ("hello")
			set1.subtract (set2)
			check set1.count = 2 end
		end

	two_way_sorted_set_subtract_2
			-- When Current = `other', `other.forth' is called after `remove', when the cursor is `after'.
		local
			set: TWO_WAY_SORTED_SET [STRING]
		do
			create set.make
			set.extend ("hello")
			set.subtract (set)
		end

	two_way_sorted_set_swap
			-- `swap' violates sortedness, should be hidden.
		local
			set: TWO_WAY_SORTED_SET [INTEGER]
		do
			create set.make
			set.extend (1)
			set.extend (2)
			set.start
			set.swap (2)
			check
				sorted: across set as c1 all (across set as c2 all c1.cursor_index < c2.cursor_index implies c1.item <= c2.item end) end
			end
		end
		
end