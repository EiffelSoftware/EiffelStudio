indexing
	description: "Demo class for binary trees."

class 
	BINARY_TREE_DEMO 

inherit
	TOP_DEMO
		redefine 
			cycle, fill_menu, execute
		end

create
	make

feature -- Creation

	make is
			-- Initialize and execute demonstration
		do
			create driver.make
			driver.new_menu ("%N%N* BINARY TREE DEMO *%N%N[XX] shows current node%N")
			fill_menu
			create tree_root.make (0)
			active := tree_root
			cycle
		end

feature -- Attributes

	root, left, right, parent: INTEGER
	put, child_status: INTEGER
	add_left, add_right: INTEGER
	remove_left_child, remove_right_child: INTEGER
	child_put_left, child_put_right: INTEGER
	show, quit: INTEGER

	tree_root: BINARY_TREE [INTEGER]

	active: BINARY_TREE [INTEGER]

feature -- Implementation

	cycle is
		local
			new_command: INTEGER
		do
			from
				driver.print_menu
				tree_trace (tree_root, 0)
				new_command := driver.get_choice
			until
				new_command = quit
			loop
				execute (new_command)
				driver.new_line
				driver.start_result
				tree_trace (tree_root, 0)
				driver.end_result
				new_command := driver.get_choice
			end
			driver.exit
		end

	tree_trace (t: BINARY_TREE [INTEGER]; i: INTEGER) is
			-- Display t, indented by i positions
		require
			tree_not_void: t /= Void
		local
			j: INTEGER
		do
			if t.has_left then
				tree_trace (t.left_child, i + 3)
			end
			from
				j := 1
			until
				j > i
			loop
				driver.putstring (" ")
				j := j + 1
			end;
			if t = active then
				driver.putstring ("[")
				driver.putint (t.item)
				driver.putstring ("]")
			else
				driver.putstring (" ")
				driver.putint (t.item)
				driver.putstring (" ")
			end
			driver.new_line
			if t.has_right then
				tree_trace (t.right_child, i + 3)
			end
		end

	fill_menu is
			-- Fill the menu with the available commands.
		do
			driver.add_entry ("AL (Add Left): Add a left child", "Add a sub-tree on the left of the current node")
			add_left := driver.last_entry
			driver.add_entry ("AR (Add Right): Add a right child", "Add a sub-tree on the right of the current node")
			add_right := driver.last_entry
			driver.add_entry ("CL (Child Left): Change value of left child", "Change item at left child of current node")
			child_put_left := driver.last_entry
			driver.add_entry ("CR (Child Right): Change value of right child", "Change item at right child of current node")
			child_put_right := driver.last_entry
			driver.add_entry ("PU (PUt): Change value of active node", "Change value of active node")
			put := driver.last_entry
			driver.add_entry ("RL (Remove Left): Remove left child", "Remove left child of current node")
			remove_left_child := driver.last_entry
			driver.add_entry ("RR (Remove Right): Remove right child", "Remove right child of current node")
			remove_right_child := driver.last_entry
			driver.add_entry ("RO (): Go to root", "Go to root node")
			root := driver.last_entry
			driver.add_entry ("LE (Left): Go to left child", "Go to left child")
			left := driver.last_entry
			driver.add_entry ("RI (Right): Go to right child", "Go to right child")
			right := driver.last_entry
			driver.add_entry ("PA (Parent): Go to parent", "Go to parent of current node")
			parent := driver.last_entry
			driver.add_entry ("CS (Child Status): Information on current node", "Print information on current node")
			child_status := driver.last_entry
			driver.add_entry ("SH (SHow): Show tree", "Display tree contents")
			show := driver.last_entry
			driver.add_entry ("QU (QUit)", "Terminate this session")
			quit := driver.last_entry
			driver.complete_menu
		end

	execute (new_command: INTEGER) is
			-- Execute command corresponding to user's request.
		require else 
			valid_command: new_command >= child_put_left and new_command <= quit
		local
			new : like active
		do
				--| parse and perform action
			if new_command = left then
				if active.has_left then
					active := active.left_child
				else
					driver.signal_error ("Cannot execute: no left child.")
				end 
			elseif new_command = right then
				if active.has_right then
					active := active.right_child
				else
					driver.signal_error ("Cannot execute: no right child.")
				end
			elseif new_command = root then
				active := tree_root
			elseif new_command = parent then
				if active.parent /= Void then
					active := active.parent
				else
					driver.signal_error ("Cannot execute: no parent.")
				end
			elseif new_command = child_status then
				driver.putstring ("has_right ")
				driver.putbool (active.has_right)
				driver.new_line
				driver.putstring ("has_left ")
				driver.putbool (active.has_left)
				driver.new_line
				driver.putstring ("has_none ")
				driver.putbool (active.has_none)
				driver.new_line
				driver.putstring ("has_both ")
				driver.putbool (active.has_both)
				driver.new_line
			elseif new_command = add_left then
				create new.make (driver.get_integer ("item"))
				active.put_left_child (new)
			elseif new_command = add_right then 
				create new.make (driver.get_integer ("item"))
				active.put_right_child (new)
			elseif new_command = put then
				active.put (driver.get_integer ("item"))
			elseif new_command = remove_right_child then
				active.remove_right_child
			elseif new_command = remove_left_child then
				active.remove_left_child
			elseif new_command = child_put_right then
				if active.has_right then
					active.child_go_i_th (2)
					active.child_replace (driver.get_integer ("item"))
				else
					driver.signal_error ("Cannot execute: no right child");
				end
			elseif new_command = child_put_left then
				if active.has_left then
					active.child_go_i_th (1)
					active.child_replace (driver.get_integer ("item"))
				else
					driver.signal_error ("cannot execute: no left child")
				end
			elseif new_command /= show then
				driver.signal_error ("Unknown command")
			end
		end

end -- class BINARY_TREE_DEMO

--|----------------------------------------------------------------
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://www.eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

