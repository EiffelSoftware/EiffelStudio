class TEST inherit

	BINARY_SEARCH_TREE_SET [INTEGER]
		rename
			make as set_make
		export
			{NONE} all
		end

	EXCEPTIONS
		export
			{NONE} all
		end

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		local
			i: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				from
					i := 1
				until
					i > Number_of_nodes
				loop
					fill_set
					prune (i)
					Io.put_string ("Pruning " + i.out + "... ")
					check_tree (tree)
					Io.put_string ("OK%N")
					i := i + 1
				end
			end
		rescue
			if is_developer_exception then
				Io.put_string (developer_exception_name)
				Io.put_new_line
				retried := True
				retry
			end
		end

feature {NONE} -- Constants

	Number_of_nodes: INTEGER is 100
	
feature {NONE} -- Implementation

	fill_set is
			-- Fill set.
		local
			i: INTEGER
		do
			set_make
			from
				i := 0
			until
				i = Number_of_nodes
			loop
				if i \\ 2 = 0 then
					extend (Number_of_nodes + 1 - (i // 2))
				else
					extend (1 + (i // 2))
				end
				i := i + 1
			end
		end

	check_tree (t: like tree) is
			-- Check consistency of node connections of `t'.
		require
			non_void_tree: t /= Void
		do
			if t.has_left then
				if t.left_child.parent /= t then
					raise ("Broken node: " + t.left_child.item.out)
				end
				check_tree (t.left_child)
			end
			if t.has_right then
				if t.right_child.parent /= t then
					raise ("Broken node: " + t.right_child.item.out)
				end
				check_tree (t.right_child)
			end
		end

end -- class TEST
