class 
	TWO_WAY_TREE_DEMO

inherit
	TOP_DEMO
		redefine
			cycle, execute, fill_menu
		end

create
	make

feature -- Creation

	make is
			-- Initialize and execute demonstration
		do
			create driver.make
			driver.new_menu ("%N%N* GENERAL TREE DEMO *%N%N[XX] Shows current node, (YY) shows child cursor%N")
			fill_menu
			create tree_root.make (0)
			active := tree_root
			cycle
		end

feature -- Attributes

	child, parent, right, left, root, child_forth, child_back,
	child_start, child_finish, child_put, put_left, put_right,
	child_remove, put, show, quit: INTEGER

	tree_root : TWO_WAY_TREE [INTEGER]

	active : TWO_WAY_TREE [INTEGER]

	active_child : TWO_WAY_TREE [INTEGER]

feature -- Routines

	cycle is
			-- Basic user interaction process.
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
				active_child := active.child
				driver.new_line
				driver.start_result
				tree_trace (tree_root, 0)
				driver.end_result
				new_command := driver.get_choice
			end
			driver.exit
		end

	tree_trace (t: TWO_WAY_TREE [INTEGER]; i: INTEGER) is
			-- Display t, indented by i positions
		require
			tree_not_void: t /= Void
		local
			j: INTEGER
			c: CURSOR
		do
			from
				j := 1
			until
				j > i
			loop
				driver.putstring (" ")
				j := j + 1
			end
			if t = active then
				driver.putstring ("[")
				driver.putint (t.item)
				driver.putstring ("]")
			elseif t = active_child then
				driver.putstring ("(")
				driver.putint (t.item)
				driver.putstring (")")
			else
				driver.putstring (" ")
				driver.putint (t.item)
				driver.putstring (" ")
			end
			driver.new_line
			from
				c := t.child_cursor
				t.child_start
			until
				t.exhausted
			loop
				tree_trace (t.child, i + 3)
				t.child_forth
			end
			t.child_go_to (c)
		end

	fill_menu is
			-- Fill the menu with available commands.
		do
			driver.add_entry ("IL (Insert at Left): Insert new child at left of cursor position",  "Change value of child to the left of child cursor position")
			put_left := driver.last_entry
			driver.add_entry ("IR (Insert at Right): Insert new child at right of cursor position",  "Change value of child to the right of child cursor position")
			put_right := driver.last_entry
			driver.add_entry ("PU (PUt): Change value of current node", "Change value of current node")
			put := driver.last_entry
			driver.add_entry ("CC (Change Child): Change value of child at cursor position", "Change value of child at child cursor position")
			child_put := driver.last_entry
			driver.add_entry ("RM (ReMove): Remove child at cursor position", "Remove active child at child cursor position")
			child_remove := driver.last_entry
			driver.add_entry ("LE (LEft): Go to left sibling", "Go to left sibling of current node")
			left := driver.last_entry
			driver.add_entry ("RI (RIght): Go to right sibling", "Go to right sibling of current node")
			right := driver.last_entry
			driver.add_entry ("CH (CHild): Go to child at cursor position", "Go to active child of current node")
			child := driver.last_entry
			driver.add_entry ("PA (PArent): Go to parent", "Go to parent of current node")
			parent := driver.last_entry
			driver.add_entry ("RO (ROot): Go to root", "Go to root of tree")
			root := driver.last_entry
			driver.add_entry ("CS (Cursor Start): Move cursor to first child", "Move child cursor to first child")
			child_start := driver.last_entry
			driver.add_entry ("CE (Cursor End): Move cursor to last child", "Move child cursor to last child")
			child_finish := driver.last_entry
			driver.add_entry ("CF (Cursor Forward): Move cursor to next child", "Move child cursor forward")
			child_forth := driver.last_entry
			driver.add_entry ("CB (Cursor Backward): Move cursor to previous child", "Move child cursor backward")
			child_back := driver.last_entry
			driver.add_entry ("SH (SHow): SHow tree in full", "Display the structure and contents of the tree")
			show := driver.last_entry
			driver.add_entry ("QU (QUit)", "Terminate this session")
			quit := driver.last_entry
			driver.complete_menu
		end

	execute (new_command: INTEGER) is
			-- Execute command corresponding to user's request.
		require else
			valid_command: new_command >= put_left and new_command <= quit
		local
			other : TWO_WAY_TREE [INTEGER]
		do
				--| parse and perform action
			if new_command = child then
				if active.is_leaf then
					driver.signal_error ("Cannot execute: no child.")
				else
					active := active.child
				end
			elseif new_command = parent then
				if active = tree_root then
					driver.signal_error ("Cannot execute: no parent.")
				else
					active := active.parent
				end
			elseif new_command = right then
				other := active.right_sibling
				if other = Void then
					driver.signal_error ("Cannot execute: no right sibling.")
				else
					active := active.right_sibling
					if not active.is_root then
						other := active.parent
						other.child_forth
					end
				end
			elseif new_command = left then
				other := active.left_sibling
				if other = Void then
					driver.signal_error ("Cannot execute: no left sibling.")
				else
					active := active.left_sibling
					if not active.is_root then
						other := active.parent
						other.child_back
					end
				end
			elseif new_command = root then
				active := tree_root
			elseif new_command = child_forth then
				if active.is_leaf or else active.child_islast then
					driver.signal_error ("Cannot execute: no child forward.")
				else
					active.child_forth
				end
			elseif new_command = child_back then
				if active.is_leaf or else active.child_isfirst then
					driver.signal_error ("Cannot execute: no child backward.")
				else
					active.child_back
				end
			elseif new_command = child_start then
				if active.is_leaf then
					driver.signal_error ("Cannot execute: no child.")
				else
					active.child_start
				end
			elseif new_command = child_finish then
				if active.is_leaf then
					driver.signal_error ("Cannot execute: no child.")
				else
					active.child_finish
				end
			elseif new_command = put_left then
					if active.child_before then active.child_forth end
					active.child_put_left (driver.get_integer ("item"))
					if active.arity = 1 then active.child_start end
			elseif new_command = put_right then
					active.child_put_right (driver.get_integer ("item"))
					if active.arity = 1 then active.child_start end
			elseif new_command = child_put then
				if active.child_off then
					driver.signal_error ("Cannot execute: no active child.")
				else
					active.child_put (driver.get_integer ("item"))
				end
			elseif new_command = put then
				active.put (driver.get_integer ("item"))
			elseif new_command = child_remove then
				if active.is_leaf then
					driver.signal_error ("Cannot execute: no child.")
				else
					active.remove_child
					if active.child_after and not
								active.empty then
						active.child_back
					end
				end
			elseif new_command /= show then
				driver.signal_error ("Unknown command")
			end
		end 

end -- class TWO_WAY_TREE_DEMO

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

