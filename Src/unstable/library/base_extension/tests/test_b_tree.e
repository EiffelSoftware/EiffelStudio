note
	description: "Test cases for B-Tree"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_B_TREE

inherit
	EQA_TEST_SET

feature -- Test routines

	test_b_tree_order_3
			-- 2-3 Tree.
		local
			btree: B_TREE [INTEGER]
			l_child: B_TREE [INTEGER]
			representation: LINEAR [INTEGER]
			expected_representation: ARRAYED_LIST [INTEGER]
		do
			create btree.make (3)
			btree.put (5)
			btree.put (3)
			btree.put (2)

				--	    (3)
				--     /   \
				--   (2)   (5)

			create expected_representation.make_from_array ({ARRAY[INTEGER]}<<2, 3, 5>>)
			expected_representation.compare_objects

			representation := btree.linear_representation
			representation.compare_objects

			assert ("Expected sorted", representation.is_equal (expected_representation))

			assert ("Expected 2", btree.arity = 2)
			assert ("Expected 1", btree.height = 1)
			assert ("Expected min 2", btree.min = 2)
			assert ("Expected max 5", btree.max = 5)

			assert ("Expected Not Parent", not attached btree.parent)
			assert ("Expected is root", btree.is_root)
			assert ("Number of items", btree.count = 3)

			if attached {B_TREE [INTEGER]} btree.first_child as l_first then
				l_first.item_start
				assert ("Expected first child 2", l_first.item = 2)
				assert ("Expected not before", not l_first.item_before)
				l_first.item_forth
				assert ("Expected off", l_first.off)
			end

			if attached {B_TREE [INTEGER]} btree.last_child as l_last then
				l_last.item_start
				assert ("Expected last child 5", l_last.item = 5)
				assert ("Expected not before", not l_last.item_before)
				l_last.item_forth
				assert ("Expected off", l_last.off)
			end

			btree.put (6)

				--	    (3)
				--     /   \
				--   (2)   (5, 6)

			if attached {B_TREE [INTEGER]} btree.last_child as l_last then
				l_last.item_start
				assert ("Expected last child 5", l_last.item = 5)
				l_last.item_forth
				assert ("Expected not off", not l_last.off)
				assert ("Expected last child 5", l_last.item = 6)
			end
			assert ("Number of items", btree.count = 4)

			create expected_representation.make_from_array ({ARRAY[INTEGER]}<<2, 3, 5, 6>>)
			expected_representation.compare_objects

			representation := btree.linear_representation
			representation.compare_objects
			assert ("Exptected same representation", representation.is_equal (expected_representation))


			btree.put (4)

				--	    (3,5)
				--     /  |  \
				--   (2) (4) (6)

			btree.item_start
			assert ("Expected value 3", btree.item = 3)
			btree.item_forth
			assert ("Expected value 5", btree.item = 5)
			assert ("Number of items", btree.count = 5)
			l_child := btree.first_child
			l_child.item_start
			assert ("Expected value 2", l_child.item = 2)
			if attached l_child.right_sibling as right_sibling then
				right_sibling.item_start
				assert ("Expected value 4", right_sibling.item = 4)
				l_child := right_sibling
			end

			if attached l_child.right_sibling as right_sibling then
				right_sibling.item_start
				assert ("Expected value 6", right_sibling.item = 6)
				l_child := right_sibling
			end
			assert ("Expected Void", l_child.right_sibling = Void)

			create expected_representation.make_from_array ({ARRAY[INTEGER]}<<2, 3, 4, 5, 6>>)
			expected_representation.compare_objects

			representation := btree.linear_representation
			representation.compare_objects
			assert ("Exptected same representation", representation.is_equal (expected_representation))

			btree.put (1)

				--	     (3,5)
				--     /   |   \
				--  (1,2) (4)  (6)
			assert ("Number of items", btree.count = 6)

			btree.put (7)
				--	     (3,5)
				--     /   |   \
				--  (1,2) (4)  (6,7)
			assert ("Number of items", btree.count = 7)

				-- Class invariant contract violation
				--  from class TREE: tree_consistency: child_readable implies (attached child as c and then c.parent = Current)
				--  c.parent = Current = False, but Current.is_equal (l_parent) = True
				--  turn off invariant checkging to make it work.

			create expected_representation.make_from_array ({ARRAY[INTEGER]}<<1, 2, 3, 4, 5, 6, 7>>)
			expected_representation.compare_objects

			representation := btree.linear_representation
			representation.compare_objects
			assert ("Exptected same representation", representation.is_equal (expected_representation))


			btree.put (8)
				--	      (5)
				--       /   \
				--    (3)     (7)
				--   /  \    /   \
				--(1,2) (4) (6)  (8)

			assert ("Number of items", btree.count = 8)
			assert ("Height expected 2", btree.height = 2)
			btree.item_start
			assert ("Root item expected 5", btree.item = 5)
			l_child := btree.first_child
			l_child.item_start
			assert ("Child item expected 3", l_child.item = 3)
			l_child := l_child.first_child
			l_child.item_start
			assert ("Child item expected 1", l_child.item = 1)
			if attached l_child.right_sibling as right_sibling then
				right_sibling.item_start
				assert ("Expected value 4", right_sibling.item = 4)
			end

			create expected_representation.make_from_array ({ARRAY[INTEGER]}<<1, 2, 3, 4, 5, 6, 7, 8>>)
			expected_representation.compare_objects

			representation := btree.linear_representation
			representation.compare_objects
			assert ("Exptected same representation", representation.is_equal (expected_representation))


			l_child := btree.last_child
			l_child.item_start
			assert ("Child item expected 7", l_child.item = 7)

			btree.prune (5)
				--
				--	      (4)
				--       /   \
				--    (2)     (7)
				--   /  \    /   \
				--(1)   (3) (6)  (8)

			assert ("Height expected 2", btree.height = 2)
			btree.item_start
			assert ("Root item expected 4", btree.item = 4)
			l_child := btree.first_child
			l_child.item_start
			assert ("Child item expected 2", l_child.item = 2)
			l_child := l_child.first_child
			l_child.item_start
			assert ("Child item expected 1", l_child.item = 1)
			if attached l_child.right_sibling as right_sibling then
				right_sibling.item_start
				assert ("Expected value 3", right_sibling.item = 3)
			end
			create expected_representation.make_from_array ({ARRAY[INTEGER]}<<1, 2, 3, 4, 6, 7, 8>>)
			expected_representation.compare_objects

			representation := btree.linear_representation
			representation.compare_objects

			assert ("Exptected same representation", representation.is_equal (expected_representation))
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
