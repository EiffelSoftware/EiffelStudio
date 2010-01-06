indexing
	description	: "System's root class"

class
	TEST

creation
	make

feature -- Initialization

	make is
			-- Creation procedure.
		do
			test_tree1
			test_tree2
			test_tree3
			test_tree4
			test_tree5
		end

feature {NONE} -- TWO_WAY_TREE Tree creation

	test_tree1 is
		local
			t1, t2: MY_TREE1
		do
			Io.put_string (" --- MY_TREE1 (TWO_WAY_TREE-based) --- ")
			Io.put_new_line

			t1 := two_way_tree_1_creation
--			Io.put_string ("Equality (same object): ")
			Io.put_boolean (equal (t1, t1))
			Io.put_new_line

			t2 := two_way_tree_1_creation
--			Io.put_string ("Equality (different object): ")
			Io.put_boolean (equal (t1, t2))
			Io.put_new_line

			t2 := two_way_tree_2_creation
--			Io.put_string ("Inequality (different structures): ")
			Io.put_boolean (not equal (t1, t2))
			Io.put_new_line

			t1 := two_way_tree_3_creation
--			Io.put_string ("Inequality (same structures\different `foo' node): ")
			Io.put_boolean (not equal (t1, t2))
			Io.put_new_line

			t1 := two_way_tree_4_creation
--			Io.put_string ("Equality (same items): ")
			Io.put_boolean (equal (t1, t1))
			Io.put_new_line

			t2 := two_way_tree_5_creation
--			Io.put_string ("Inequality (different items): ")
			Io.put_boolean (not equal (t1, t2))
			Io.put_new_line

			t1 := two_way_tree_3_creation
			t2 := t1.twin
--			Io.put_string ("Equality (twin): ")
			Io.put_boolean (equal (t1, t2))
			Io.put_new_line

			t1 := two_way_tree_4_creation
			t2 := t1.twin
--			Io.put_string ("Equality (twin): ")
			Io.put_boolean (equal (t1, t2))
			Io.put_new_line

			Io.put_new_line
		end

	two_way_tree_1_creation: MY_TREE1 is
			-- create a MY_TREE1.

			-- |        root
			-- |      /   |   \
			-- |   1      2     3
			-- | /   \
			-- |1.1  1.2
		local
			node: MY_TREE1
			cur: TWO_WAY_TREE [INTEGER]
		do
			create Result.make
			Result.set_foo ("root")
			create node.make
			node.set_foo ("1")
			Result.put_child (node)
			create node.make
			node.set_foo ("2")
			Result.put_child (node)
			create node.make
			node.set_foo ("3")
			Result.put_child (node)

			Result.child_go_i_th (1)
			cur := Result.child

			create node.make
			node.set_foo ("1.1")
			cur.put_child (node)
			create node.make
			node.set_foo ("1.2")
			cur.put_child (node)
		end

	two_way_tree_2_creation: MY_TREE1 is
			-- create a MY_TREE1.

			-- |        root
			-- |      /   |   \
			-- |   1      2     3
			-- |        /   \
			-- |      2.1   2.2
		local
			node: MY_TREE1
			cur: TWO_WAY_TREE [INTEGER]
		do
			create Result.make
			Result.set_foo ("root")
			create node.make
			node.set_foo ("1")
			Result.put_child (node)
			create node.make
			node.set_foo ("2")
			Result.put_child (node)
			create node.make
			node.set_foo ("3")
			Result.put_child (node)

			Result.child_go_i_th (2)
			cur := Result.child

			create node.make
			node.set_foo ("2.1")
			cur.put_child (node)
			create node.make
			node.set_foo ("2.2")
			cur.put_child (node)
		end

	two_way_tree_3_creation: MY_TREE1 is
			-- create a MY_TREE1.

			-- |        root
			-- |      /   |   \
			-- |   1      2     4
			-- |        /   \
			-- |      2.1   2.2
		local
			node: MY_TREE1
			cur: TWO_WAY_TREE [INTEGER]
		do
			create Result.make
			Result.set_foo ("root")
			create node.make
			node.set_foo ("1")
			Result.put_child (node)
			create node.make
			node.set_foo ("2")
			Result.put_child (node)
			create node.make
			node.set_foo ("4")
			Result.put_child (node)

			Result.child_go_i_th (2)
			cur := Result.child

			create node.make
			node.set_foo ("2.1")
			cur.put_child (node)
			create node.make
			node.set_foo ("2.2")
			cur.put_child (node)
		end

	two_way_tree_4_creation: MY_TREE1 is
			-- create a MY_TREE1.

			-- |        0
			-- |     /  |  \
			-- |   1    2    3
			-- | /   \
			-- |4     5
		local
			node: MY_TREE1
			cur: TWO_WAY_TREE [INTEGER]
		do
			create Result.make
			Result.put (0)
--			Result.set_foo ("root")

			create node.make
			node.put (1)
--			node.set_foo ("1")
			Result.put_child (node)
			create node.make
			node.put (2)
--			node.set_foo ("2")
			Result.put_child (node)
			create node.make
			node.put (3)
--			node.set_foo ("3")
			Result.put_child (node)

			Result.child_go_i_th (1)
			cur := Result.child

			create node.make
			node.put (4)
--			node.set_foo ("1.1")
			cur.put_child (node)
			create node.make
			node.put (5)
--			node.set_foo ("1.2")
			cur.put_child (node)
		end

	two_way_tree_5_creation: MY_TREE1 is
			-- create a MY_TREE1.

			-- |        0
			-- |     /  |  \
			-- |   1    8    3
			-- | /   \
			-- |4     5
		local
			node: MY_TREE1
			cur: TWO_WAY_TREE [INTEGER]
		do
			create Result.make
			Result.put (0)
--			Result.set_foo ("root")

			create node.make
			node.put (1)
--			node.set_foo ("1")
			Result.put_child (node)
			create node.make
			node.put (8)
--			node.set_foo ("2")
			Result.put_child (node)
			create node.make
			node.put (3)
--			node.set_foo ("3")
			Result.put_child (node)

			Result.child_go_i_th (1)
			cur := Result.child

			create node.make
			node.put (4)
--			node.set_foo ("1.1")
			cur.put_child (node)
			create node.make
			node.put (5)
--			node.set_foo ("1.2")
			cur.put_child (node)
		end

feature {NONE} -- BINARY_TREE Tree creation

	test_tree2 is
		local
			t1, t2: MY_TREE2
		do
			Io.put_string (" --- MY_TREE2 (BINARY_TREE-based) --- ")
			Io.put_new_line

			t1 := bin_tree_1_creation
--			Io.put_string ("Equality (same object): ")
			Io.put_boolean (equal (t1, t1))
			Io.put_new_line

			t2 := bin_tree_1_creation
--			Io.put_string ("Equality (different object): ")
			Io.put_boolean (equal (t1, t2))
			Io.put_new_line

			t2 := bin_tree_2_creation
--			Io.put_string ("Inequality (different structures): ")
			Io.put_boolean (not equal (t1, t2))
			Io.put_new_line

			t1 := bin_tree_3_creation
--			Io.put_string ("Inequality (same structures\different node): ")
			Io.put_boolean (not equal (t1, t2))
			Io.put_new_line

			t1 := bin_tree_4_creation
			t2 := bin_tree_4_creation
--			Io.put_string ("Equality (same items): ")
			Io.put_boolean (equal (t1, t2))
			Io.put_new_line

			t1 := bin_tree_4_creation
			t2 := bin_tree_5_creation
--			Io.put_string ("Inequality (different items): ")
			Io.put_boolean (not equal (t1, t2))
			Io.put_new_line

			t1 := bin_tree_3_creation
			t2 := t1.twin
--			Io.put_string ("Equality (twin): ")
			Io.put_boolean (equal (t1, t2))
			Io.put_new_line

			t1 := bin_tree_4_creation
			t2 := t1.twin
--			Io.put_string ("Equality (twin): ")
			Io.put_boolean (equal (t1, t2))
			Io.put_new_line

			t1 := bin_tree_5_creation
			t2 := t1.twin
--			Io.put_string ("Equality (twin): ")
			Io.put_boolean (equal (t1, t2))
			Io.put_new_line
			Io.put_new_line
		end

	bin_tree_1_creation: MY_TREE2 is
			-- create a MY_TREE2.

			-- |        root
			-- |      /      \
			-- |    1          2
			-- |  /   \
			-- |1.1   1.2
		local
			node: MY_TREE2
			cur: BINARY_TREE [INTEGER]
		do
			create Result.make
			Result.set_foo ("root")
			create node.make
			node.set_foo ("1")
			Result.put_left_child (node)
			create node.make
			node.set_foo ("2")
			Result.put_right_child (node)

			Result.child_go_i_th (1)
			cur := Result.child

			create node.make
			node.set_foo ("1.1")
			cur.put_left_child (node)
			create node.make
			node.set_foo ("1.2")
			cur.put_right_child (node)
		end

	bin_tree_2_creation: MY_TREE2 is
			-- create a MY_TREE2.

			-- |        root
			-- |      /      \
			-- |    1          2
			-- |             /   \
			-- |           2.1   2.2
		local
			node: MY_TREE2
			cur: BINARY_TREE [INTEGER]
		do
			create Result.make
			Result.set_foo ("root")
			create node.make
			node.set_foo ("1")
			Result.put_left_child (node)
			create node.make
			node.set_foo ("2")
			Result.put_right_child (node)

			Result.child_go_i_th (2)
			cur := Result.child

			create node.make
			node.set_foo ("2.1")
			cur.put_left_child (node)
			create node.make
			node.set_foo ("2.2")
			cur.put_right_child (node)
		end

	bin_tree_3_creation: MY_TREE2 is
			-- create a MY_TREE2.

			-- |        root
			-- |      /      \
			-- |    8          2
			-- |             /   \
			-- |           2.1   2.2
		local
			node: MY_TREE2
			cur: BINARY_TREE [INTEGER]
		do
			create Result.make
			Result.set_foo ("root")
			create node.make
			node.set_foo ("8")
			Result.put_left_child (node)
			create node.make
			node.set_foo ("2")
			Result.put_right_child (node)

			Result.child_go_i_th (2)
			cur := Result.child

			create node.make
			node.set_foo ("2.1")
			cur.put_left_child (node)
			create node.make
			node.set_foo ("2.2")
			cur.put_right_child (node)
		end

	bin_tree_4_creation: MY_TREE2 is
			-- create a MY_TREE2.

			-- |        0
			-- |      /   \
			-- |    1       2
			-- |  /   \
			-- | 3     4
		local
			node: MY_TREE2
			cur: BINARY_TREE [INTEGER]
		do
			create Result.make
			Result.put (0)
--			Result.set_foo ("root")
			create node.make
			node.put (1)
--			node.set_foo ("1")
			Result.put_left_child (node)
			create node.make
			node.put (2)
--			node.set_foo ("2")
			Result.put_right_child (node)

			cur := Result.left_child

			create node.make
			node.put (3)
--			node.set_foo ("1.1")
			cur.put_left_child (node)
			create node.make
			node.put (4)
--			node.set_foo ("1.2")
			cur.put_right_child (node)
		end

	bin_tree_5_creation: MY_TREE2 is
			-- create a MY_TREE2.

			-- |         0
			-- |          \
			-- |           1
			-- | 		  /
			-- | 		 2
			-- |          \
			-- |           3
		local
			node: MY_TREE2
			cur: BINARY_TREE [INTEGER]
		do
			create Result.make
			Result.put (0)

			cur := Result
			create node.make
			node.put (1)
			cur.put_right_child (node)

			cur := cur.right_child
			create node.make
			node.put (2)
			cur.put_left_child (node)

			cur := cur.left_child
			create node.make
			node.put (3)
			cur.put_right_child (node)
		end

feature {NONE} -- LINKED_TREE Tree creation

	test_tree3 is
		local
			t1, t2: MY_TREE3
		do
			Io.put_string (" --- MY_TREE3 (LINKED_TREE-based) --- ")
			Io.put_new_line

			t1 := linked_tree_1_creation
--			Io.put_string ("Equality (same object): ")
			Io.put_boolean (equal (t1, t1))
			Io.put_new_line

			t2 := linked_tree_1_creation
--			Io.put_string ("Equality (different object): ")
			Io.put_boolean (equal (t1, t2))
			Io.put_new_line

			t2 := linked_tree_2_creation
--			Io.put_string ("Inequality (different structures): ")
			Io.put_boolean (not equal (t1, t2))
			Io.put_new_line

			t1 := linked_tree_3_creation
--			Io.put_string ("Inequality (same structures\different `foo' node): ")
			Io.put_boolean (not equal (t1, t2))
			Io.put_new_line

			t1 := linked_tree_4_creation
--			Io.put_string ("Equality (same items): ")
			Io.put_boolean (equal (t1, t1))
			Io.put_new_line

			t2 := linked_tree_5_creation
--			Io.put_string ("Inequality (different items): ")
			Io.put_boolean (not equal (t1, t2))
			Io.put_new_line

			t1 := linked_tree_3_creation
			t2 := t1.twin
--			Io.put_string ("Equality (twin): ")
			Io.put_boolean (equal (t1, t2))
			Io.put_new_line

			t1 := linked_tree_4_creation
			t2 := t1.twin
--			Io.put_string ("Equality (twin): ")
			Io.put_boolean (equal (t1, t2))
			Io.put_new_line

			Io.put_new_line
		end

	linked_tree_1_creation: MY_TREE3 is
			-- create a MY_TREE3.

			-- |        root
			-- |      /   |   \
			-- |   1      2     3
			-- | /   \
			-- |1.1  1.2
		local
			node: MY_TREE3
			cur: LINKED_TREE [INTEGER]
		do
			create Result.make
			Result.set_foo ("root")
			create node.make
			node.set_foo ("1")
			Result.put_child (node)
			create node.make
			node.set_foo ("2")
			Result.put_child (node)
			create node.make
			node.set_foo ("3")
			Result.put_child (node)

			Result.child_go_i_th (1)
			cur := Result.child

			create node.make
			node.set_foo ("1.1")
			cur.put_child (node)
			create node.make
			node.set_foo ("1.2")
			cur.put_child (node)
		end

	linked_tree_2_creation: MY_TREE3 is
			-- create a MY_TREE3.

			-- |        root
			-- |      /   |   \
			-- |   1      2     3
			-- |        /   \
			-- |      2.1   2.2
		local
			node: MY_TREE3
			cur: LINKED_TREE [INTEGER]
		do
			create Result.make
			Result.set_foo ("root")
			create node.make
			node.set_foo ("1")
			Result.put_child (node)
			create node.make
			node.set_foo ("2")
			Result.put_child (node)
			create node.make
			node.set_foo ("3")
			Result.put_child (node)

			Result.child_go_i_th (2)
			cur := Result.child

			create node.make
			node.set_foo ("2.1")
			cur.put_child (node)
			create node.make
			node.set_foo ("2.2")
			cur.put_child (node)
		end

	linked_tree_3_creation: MY_TREE3 is
			-- create a MY_TREE3.

			-- |        root
			-- |      /   |   \
			-- |    8     2     3
			-- |        /   \
			-- |      2.1   2.2
		local
			node: MY_TREE3
			cur: LINKED_TREE [INTEGER]
		do
			create Result.make
			Result.set_foo ("root")
			create node.make
			node.set_foo ("8")
			Result.put_child (node)
			create node.make
			node.set_foo ("2")
			Result.put_child (node)
			create node.make
			node.set_foo ("3")
			Result.put_child (node)

			Result.child_go_i_th (2)
			cur := Result.child

			create node.make
			node.set_foo ("2.1")
			cur.put_child (node)
			create node.make
			node.set_foo ("2.2")
			cur.put_child (node)
		end

	linked_tree_4_creation: MY_TREE3 is
			-- create a MY_TREE3.

			-- |          0
			-- |      /   |   \
			-- |   1      2     3
			-- |        /   \
			-- |       4     5
		local
			node: MY_TREE3
			cur: LINKED_TREE [INTEGER]
		do
			create Result.make
			Result.put (0)
--			Result.set_foo ("root")

			create node.make
			node.put (1)
--			node.set_foo ("1")
			Result.put_child (node)
			create node.make
			node.put (2)
--			node.set_foo ("2")
			Result.put_child (node)
			create node.make
			node.put (3)
--			node.set_foo ("3")
			Result.put_child (node)

			Result.child_go_i_th (2)
			cur := Result.child

			create node.make
			node.put (4)
--			node.set_foo ("2.1")
			cur.put_child (node)
			create node.make
			node.put (5)
--			node.set_foo ("2.2")
			cur.put_child (node)
		end

	linked_tree_5_creation: MY_TREE3 is
			-- create a MY_TREE3.

			-- |          0
			-- |      /   |   \
			-- |   1      2     3
			-- |        /   \
			-- |       8     5
		local
			node: MY_TREE3
			cur: LINKED_TREE [INTEGER]
		do
			create Result.make
			Result.put (0)
--			Result.set_foo ("root")

			create node.make
			node.put (1)
--			node.set_foo ("1")
			Result.put_child (node)
			create node.make
			node.put (2)
--			node.set_foo ("2")
			Result.put_child (node)
			create node.make
			node.put (3)
--			node.set_foo ("3")
			Result.put_child (node)

			Result.child_go_i_th (2)
			cur := Result.child

			create node.make
			node.put (4)
--			node.set_foo ("2.1")
			cur.put_child (node)
			create node.make
			node.put (8)
--			node.set_foo ("2.2")
			cur.put_child (node)
		end

feature {NONE} -- FIXED_TREE Tree creation

	test_tree4 is
		local
			t1, t2: MY_TREE4
		do
			Io.put_string (" --- MY_TREE4 (FIXED_TREE-based) --- ")
			Io.put_new_line

			t1 := fixed_tree_1_creation
--			Io.put_string ("Equality (same object): ")
			Io.put_boolean (equal (t1, t1))
			Io.put_new_line

			t2 := fixed_tree_1_creation
--			Io.put_string ("Equality (different object): ")
			Io.put_boolean (equal (t1, t2))
			Io.put_new_line

			t2 := fixed_tree_2_creation
--			Io.put_string ("Inequality (different structures): ")
			Io.put_boolean (not equal (t1, t2))
			Io.put_new_line

			t1 := fixed_tree_3_creation
--			Io.put_string ("Inequality (same structures\different `foo' node): ")
			Io.put_boolean (not equal (t1, t2))
			Io.put_new_line

			t1 := fixed_tree_4_creation
--			Io.put_string ("Equality (same items): ")
			Io.put_boolean (equal (t1, t1))
			Io.put_new_line

			t2 := fixed_tree_5_creation
--			Io.put_string ("Inequality (different items): ")
			Io.put_boolean (not equal (t1, t2))
			Io.put_new_line

			t1 := fixed_tree_3_creation
			t2 := t1.twin
--			Io.put_string ("Equality (twin): ")
			Io.put_boolean (equal (t1, t2))
			Io.put_new_line

			t1 := fixed_tree_4_creation
			t2 := t1.twin
--			Io.put_string ("Equality (twin): ")
			Io.put_boolean (equal (t1, t2))
			Io.put_new_line

			-- Test with make_filled --
			t1 := fixed_tree_6_creation
			t2 := t1.twin
--			Io.put_string ("Equality (twin): ")
			Io.put_boolean (equal (t1, t2))
			Io.put_new_line

			Io.put_new_line
		end

	fixed_tree_1_creation: MY_TREE4 is
			-- create a MY_TREE4.

			-- |        root
			-- |      /   |   \
			-- |   1      2     3
			-- | /   \
			-- |1.1  1.2
		local
			node: MY_TREE4
			cur: FIXED_TREE [INTEGER]
		do
			create Result.make (3)
			Result.set_foo ("root")

			create node.make (2)
			node.set_foo ("1")
			Result.child_go_i_th (1)
			Result.put_child (node)
			create node.make (0)
			node.set_foo ("2")
			Result.child_go_i_th (2)
			Result.put_child (node)
			create node.make (0)
			node.set_foo ("3")
			Result.child_go_i_th (3)
			Result.put_child (node)

			Result.child_go_i_th (1)
			cur := Result.child

			create node.make (0)
			node.set_foo ("1.1")
			cur.child_go_i_th (1)
			cur.put_child (node)
			create node.make (0)
			node.set_foo ("1.2")
			cur.child_go_i_th (2)
			cur.put_child (node)
		end

	fixed_tree_2_creation: MY_TREE4 is
			-- create a MY_TREE4.

			-- |        root
			-- |      /   |   \
			-- |   1      2     3
			-- |        /   \
			-- |      2.1   2.2
		local
			node: MY_TREE4
			cur: FIXED_TREE [INTEGER]
		do
			create Result.make (3)
			Result.set_foo ("root")
			create node.make (0)
			node.set_foo ("1")
			Result.child_go_i_th (1)
			Result.put_child (node)
			create node.make (2)
			node.set_foo ("2")
			Result.child_go_i_th (2)
			Result.put_child (node)
			create node.make (0)
			node.set_foo ("3")
			Result.child_go_i_th (3)
			Result.put_child (node)

			Result.child_go_i_th (2)
			cur := Result.child

			create node.make (0)
			node.set_foo ("2.1")
			cur.child_go_i_th (1)
			cur.put_child (node)
			create node.make (0)
			node.set_foo ("2.2")
			cur.child_go_i_th (2)
			cur.put_child (node)
		end

	fixed_tree_3_creation: MY_TREE4 is
			-- create a MY_TREE4.

			-- |        root
			-- |      /   |   \
			-- |   8      2     3
			-- |        /   \
			-- |      2.1   2.2
		local
			node: MY_TREE4
			cur: FIXED_TREE [INTEGER]
		do
			create Result.make (3)
			Result.set_foo ("root")
			create node.make (0)
			node.set_foo ("8")
			Result.child_go_i_th (1)
			Result.put_child (node)
			create node.make (2)
			node.set_foo ("2")
			Result.child_go_i_th (2)
			Result.put_child (node)
			create node.make (0)
			node.set_foo ("3")
			Result.child_go_i_th (3)
			Result.put_child (node)

			Result.child_go_i_th (2)
			cur := Result.child

			create node.make (0)
			node.set_foo ("2.1")
			cur.child_go_i_th (1)
			cur.put_child (node)
			create node.make (0)
			node.set_foo ("2.2")
			cur.child_go_i_th (1)
			cur.put_child (node)
		end

	fixed_tree_4_creation: MY_TREE4 is
			-- create a MY_TREE4.

			-- |          0
			-- |      /   |   \
			-- |   1      2     3
			-- |        /   \
			-- |       4     5
		local
			node: MY_TREE4
			cur: FIXED_TREE [INTEGER]
		do
			create Result.make (3)
			Result.put (0)
--			Result.set_foo ("root")

			create node.make (0)
			node.put (1)
--			node.set_foo ("1")
			Result.child_go_i_th (1)
			Result.put_child (node)
			create node.make (2)
			node.put (2)
--			node.set_foo ("2")
			Result.child_go_i_th (2)
			Result.put_child (node)
			create node.make (0)
			node.put (3)
--			node.set_foo ("3")
			Result.child_go_i_th (3)
			Result.put_child (node)

			Result.child_go_i_th (2)
			cur := Result.child

			create node.make (0)
			node.put (4)
--			node.set_foo ("2.1")
			cur.child_go_i_th (1)
			cur.put_child (node)
			create node.make (0)
			node.put (5)
--			node.set_foo ("2.2")
			cur.child_go_i_th (1)
			cur.put_child (node)
		end

	fixed_tree_5_creation: MY_TREE4 is
			-- create a MY_TREE4.

			-- |          0
			-- |      /   |   \
			-- |   1      8     3
			-- |        /   \
			-- |       4     5
		local
			node: MY_TREE4
			cur: FIXED_TREE [INTEGER]
		do
			create Result.make (3)
			Result.put (0)
--			Result.set_foo ("root")

			create node.make (0)
			node.put (1)
--			node.set_foo ("1")
			Result.child_go_i_th (1)
			Result.put_child (node)
			create node.make (2)
			node.put (8)
--			node.set_foo ("2")
			Result.child_go_i_th (2)
			Result.put_child (node)
			create node.make (0)
			node.put (3)
--			node.set_foo ("3")
			Result.child_go_i_th (3)
			Result.put_child (node)

			Result.child_go_i_th (2)
			cur := Result.child

			create node.make (0)
			node.put (4)
--			node.set_foo ("2.1")
			cur.child_go_i_th (1)
			cur.put_child (node)
			create node.make (0)
			node.put (5)
--			node.set_foo ("2.2")
			cur.child_go_i_th (1)
			cur.put_child (node)
		end

	fixed_tree_6_creation: MY_TREE4 is
			-- create a MY_TREE4 - with make_filled.

			-- |          0
			-- |   /  /   |   \  \
			-- |  0  1    8    3  0
			-- |        /   \
			-- |       4     5
		local
			node: MY_TREE4
			cur: FIXED_TREE [INTEGER]
		do
			create Result.make_filled (5)
			Result.put (0)
--			Result.set_foo ("root")

			create node.make_filled (0)
			node.put (1)
--			node.set_foo ("1")
			Result.child_go_i_th (2)
			Result.replace_child (node)
			create node.make_filled (2)
			node.put (8)
--			node.set_foo ("2")
			Result.child_go_i_th (3)
			Result.replace_child (node)
			create node.make_filled (0)
			node.put (3)
--			node.set_foo ("3")
			Result.child_go_i_th (4)
			Result.replace_child (node)

			Result.child_go_i_th (3)
			cur := Result.child

			create node.make_filled (0)
			node.put (4)
--			node.set_foo ("2.1")
			cur.child_go_i_th (1)
			cur.replace_child (node)
			create node.make_filled (0)
			node.put (5)
--			node.set_foo ("2.2")
			cur.child_go_i_th (2)
			cur.replace_child (node)
		end


feature {NONE} -- ARRAYED_TREE Tree creation

	test_tree5 is
		local
			t1, t2: MY_TREE5
		do
			Io.put_string (" --- MY_TREE5 (ARRAYED_TREE-based) --- ")
			Io.put_new_line

			t1 := arrayed_tree_1_creation
--			Io.put_string ("Equality (same object): ")
			Io.put_boolean (equal (t1, t1))
			Io.put_new_line

			t2 := arrayed_tree_1_creation
--			Io.put_string ("Equality (different object): ")
			Io.put_boolean (equal (t1, t2))
			Io.put_new_line

			t2 := arrayed_tree_2_creation
--			Io.put_string ("Inequality (different structures): ")
			Io.put_boolean (not equal (t1, t2))
			Io.put_new_line

			t1 := arrayed_tree_3_creation
--			Io.put_string ("Inequality (same structures\different `foo' node): ")
			Io.put_boolean (not equal (t1, t2))
			Io.put_new_line

			t1 := arrayed_tree_4_creation
--			Io.put_string ("Equality (same items): ")
			Io.put_boolean (equal (t1, t1))
			Io.put_new_line

			t2 := arrayed_tree_5_creation
--			Io.put_string ("Inequality (different items): ")
			Io.put_boolean (not equal (t1, t2))
			Io.put_new_line

			t1 := arrayed_tree_3_creation
			t2 := t1.twin
--			Io.put_string ("Equality (twin): ")
			Io.put_boolean (equal (t1, t2))
			Io.put_new_line

			t1 := arrayed_tree_4_creation
			t2 := t1.twin
--			Io.put_string ("Equality (twin): ")
			Io.put_boolean (equal (t1, t2))
			Io.put_new_line

			Io.put_new_line
		end

	arrayed_tree_1_creation: MY_TREE5 is
			-- create a MY_TREE5.

			-- |        root
			-- |      /   |   \
			-- |   1      2     3
			-- | /   \
			-- |1.1  1.2
		local
			node: MY_TREE5
			cur: ARRAYED_TREE [INTEGER]
		do
			create Result.make
			Result.set_foo ("root")
			create node.make
			node.set_foo ("1")
			Result.put_child (node)
			create node.make
			node.set_foo ("2")
			Result.put_child (node)
			create node.make
			node.set_foo ("3")
			Result.put_child (node)

			Result.child_go_i_th (1)
			cur := Result.child

			create node.make
			node.set_foo ("1.1")
			cur.put_child (node)
			create node.make
			node.set_foo ("1.2")
			cur.put_child (node)
		end

	arrayed_tree_2_creation: MY_TREE5 is
			-- create a MY_TREE5.

			-- |        root
			-- |      /   |   \
			-- |    1     2     3
			-- |        /   \
			-- |      2.1   2.2
		local
			node: MY_TREE5
			cur: ARRAYED_TREE [INTEGER]
		do
			create Result.make
			Result.set_foo ("root")
			create node.make
			node.set_foo ("1")
			Result.put_child (node)
			create node.make
			node.set_foo ("2")
			Result.put_child (node)
			create node.make
			node.set_foo ("3")
			Result.put_child (node)

			Result.child_go_i_th (2)
			cur := Result.child

			create node.make
			node.set_foo ("2.1")
			cur.put_child (node)
			create node.make
			node.set_foo ("2.2")
			cur.put_child (node)
		end

	arrayed_tree_3_creation: MY_TREE5 is
			-- create a MY_TREE5.

			-- |        root
			-- |      /   |   \
			-- |   8      2     3
			-- |        /   \
			-- |      2.1   2.2
		local
			node: MY_TREE5
			cur: ARRAYED_TREE [INTEGER]
		do
			create Result.make
			Result.set_foo ("root")

			create node.make
			node.set_foo ("8")
			Result.put_child (node)
			create node.make
			node.set_foo ("2")
			Result.put_child (node)
			create node.make
			node.set_foo ("3")
			Result.put_child (node)

			Result.child_go_i_th (2)
			cur := Result.child

			create node.make
			node.set_foo ("2.1")
			cur.put_child (node)
			create node.make
			node.set_foo ("2.2")
			cur.put_child (node)
		end

	arrayed_tree_4_creation: MY_TREE5 is
			-- create a MY_TREE5.

			-- |          0
			-- |      /   |   \
			-- |   1      2     3
			-- |        /   \
			-- |       4     5
		local
			node: MY_TREE5
			cur: ARRAYED_TREE [INTEGER]
		do
			create Result.make
			Result.put (0)
--			Result.set_foo ("root")

			create node.make
			node.put (1)
--			node.set_foo ("1")
			Result.put_child (node)
			create node.make
			node.put (2)
--			node.set_foo ("2")
			Result.put_child (node)
			create node.make
			node.put (3)
--			node.set_foo ("3")
			Result.put_child (node)

			Result.child_go_i_th (2)
			cur := Result.child

			create node.make
			node.put (4)
--			node.set_foo ("2.1")
			cur.put_child (node)
			create node.make
			node.put (5)
--			node.set_foo ("2.2")
			cur.put_child (node)
		end

	arrayed_tree_5_creation: MY_TREE5 is
			-- create a MY_TREE5.

			-- |          0
			-- |      /   |   \
			-- |   1      2     3
			-- |        /   \
			-- |       8     9
		local
			node: MY_TREE5
			cur: ARRAYED_TREE [INTEGER]
		do
			create Result.make
			Result.put (0)
--			Result.set_foo ("root")

			create node.make
			node.put (1)
--			node.set_foo ("1")
			Result.put_child (node)
			create node.make
			node.put (2)
--			node.set_foo ("2")
			Result.put_child (node)
			create node.make
			node.put (3)
--			node.set_foo ("3")
			Result.put_child (node)

			Result.child_go_i_th (2)
			cur := Result.child

			create node.make
			node.put (8)
--			node.set_foo ("2.1")
			cur.put_child (node)
			create node.make
			node.put (9)
--			node.set_foo ("2.2")
			cur.put_child (node)
		end

end
