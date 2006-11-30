class
	TEST

create
	make

feature


   	make is
		do
			test_arrayed_tree
			test_linked_tree
			test_two_way_tree
			test_binary_tree
			test_binary_search_tree
			test_fixed_tree
			test_test1_tree
		end

	test_arrayed_tree is
		local
			foo, bar: ARRAYED_TREE [STRING]
		do
			create foo.make (2, "Root")
			foo.compare_objects
			foo.child_extend ("child one")
			foo.child_extend ("child two")
			create bar.make (1, Void)
			bar.compare_objects
			bar.copy (foo)
			check is_equal: bar.is_equal (foo) end


			create foo.make (2, "Root")
			foo.compare_objects
			foo.child_extend ("child one")
			foo.child_extend ("child two")
			foo.child_start
			foo.child.child_extend ("grandchild one") -- added a grandchild
			create bar.make (2, Void)
			bar.compare_objects
			bar.copy (foo)
			check is_equal: bar.is_equal (foo) end
		end

	test_linked_tree is
		local
			foo, bar: LINKED_TREE [STRING]
		do
			create foo.make ("Root")
			foo.compare_objects
			foo.child_extend ("child one")
			foo.child_extend ("child two")
			create bar.make (Void)
			bar.compare_objects
			bar.copy (foo)
			check is_equal: bar.is_equal (foo) end


			create foo.make ("Root")
			foo.compare_objects
			foo.child_extend ("child one")
			foo.child_extend ("child two")
			foo.child_start
			foo.child.child_extend ("grandchild one") -- added a grandchild
			create bar.make (Void)
			bar.compare_objects
			bar.copy (foo)
			check is_equal: bar.is_equal (foo) end
		end

	test_two_way_tree is
		local
			foo, bar: TWO_WAY_TREE [STRING]
		do
			create foo.make ("Root")
			foo.compare_objects
			foo.child_extend ("child one")
			foo.child_extend ("child two")
			create bar.make (Void)
			bar.compare_objects
			bar.copy (foo)
			check is_equal: bar.is_equal (foo) end


			create foo.make ("Root")
			foo.compare_objects
			foo.child_extend ("child one")
			foo.child_extend ("child two")
			foo.child_start
			foo.child.child_extend ("grandchild one") -- added a grandchild
			create bar.make (Void)
			bar.compare_objects
			bar.copy (foo)
			check is_equal: bar.is_equal (foo) end
		end

	test_binary_tree is
		local
			foo, bar: BINARY_TREE [STRING]
		do
			create foo.make ("Root")
			foo.compare_objects
			foo.put_left_child (create {BINARY_TREE [STRING]}.make ("child one"))
			foo.put_right_child (create {BINARY_TREE [STRING]}.make ("child two"))
			create bar.make (Void)
			bar.compare_objects
			bar.copy (foo)
			check is_equal: bar.is_equal (foo) end


			create foo.make ("Root")
			foo.compare_objects
			foo.put_left_child (create {BINARY_TREE [STRING]}.make ("child one"))
			foo.put_right_child (create {BINARY_TREE [STRING]}.make ("child two"))
			foo.child_start
			foo.child.put_left_child (create {BINARY_TREE [STRING]}.make ("grandchild one"))	-- added a grandchild
			create bar.make (Void)
			bar.compare_objects
			bar.copy (foo)
			check is_equal: bar.is_equal (foo) end
		end

	test_binary_search_tree is
		local
			foo, bar: BINARY_SEARCH_TREE [STRING]
		do
			create foo.make ("Root")
			foo.compare_objects
			foo.extend ("child one")
			foo.extend ("child two")
			create bar.make ("")
			bar.compare_objects
			bar.copy (foo)
			check is_equal: bar.is_equal (foo) end


			create foo.make ("Root")
			foo.compare_objects
			foo.extend ("child one")
			foo.extend ("child two")
			foo.child_start
			foo.child.extend ("grandchild one")	-- added a grandchild
			create bar.make ("")
			bar.compare_objects
			bar.copy (foo)
			check is_equal: bar.is_equal (foo) end
		end

	test_fixed_tree is
		local
			foo, bar: FIXED_TREE [STRING]
		do
			create foo.make (2, "Root")
			foo.compare_objects
			foo.put_child (create {FIXED_TREE [STRING]}.make (0, "child one"))
			foo.put_child (create {FIXED_TREE [STRING]}.make (0, "child two"))
			create bar.make (1, Void)
			bar.compare_objects
			bar.copy (foo)
			check is_equal: bar.is_equal (foo) end


			create foo.make (2, "Root")
			foo.compare_objects
			foo.put_child (create {FIXED_TREE [STRING]}.make (1, "child one"))
			foo.put_child (create {FIXED_TREE [STRING]}.make (0, "child two"))
			foo.child_start
			foo.child.put_child (create {FIXED_TREE [STRING]}.make (0, "grandchild one")) -- added a grandchild
			create bar.make (2, Void)
			bar.compare_objects
			bar.copy (foo)
			check is_equal: bar.is_equal (foo) end
		end

	test_test1_tree is
		local
			foo, bar: TEST1 [STRING]
		do
			create foo.make (2, "Root")
			foo.compare_objects
			foo.child_extend ("child one")
			foo.child_extend ("child two")
			create bar.make (1, Void)
			bar.compare_objects
			bar.copy (foo)
			check is_equal: bar.is_equal (foo) end


			create foo.make (2, "Root")
			foo.compare_objects
			foo.child_extend ("child one")
			foo.child_extend ("child two")
			foo.child_start
			foo.child.child_extend ("grandchild one") -- added a grandchild
			create bar.make (2, Void)
			bar.compare_objects
			bar.copy (foo)
			check is_equal: bar.is_equal (foo) end
		end


end
