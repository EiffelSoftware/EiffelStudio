-- Demo class for binary trees

class BINARY_TREE_DEMO inherit

	TOP_DEMO
		redefine 
			cycle, fill_menu, execute
		end;

creation
	make

feature

	Root, Left, Right, Parent: INTEGER;
	Put, Child_status: INTEGER;
	Add_left, Add_right: INTEGER;
	Remove_left_child, Remove_right_child: INTEGER;
	Child_put_left, Child_put_right: INTEGER;
	Show, Quit: INTEGER;


	tree_root : BINARY_TREE [INTEGER];

	active : BINARY_TREE [INTEGER];

	make is
			-- Initialize and execute demonstration
		do
			!!driver.make;
			driver.new_menu ("%N%N* BINARY TREE DEMO *%N%N[XX] shows current node%N");
			fill_menu;
			!!tree_root.make (0);
			active := tree_root;
			cycle
		end; 

	cycle is
		local
			new_command: INTEGER
		do
			from
				driver.print_menu;
				tree_trace (tree_root, 0);
				new_command := driver.get_choice
			until
				new_command = Quit
			loop
				execute (new_command);
				driver.new_line;
				driver.start_result;
				tree_trace (tree_root, 0);
				driver.end_result;
				new_command := driver.get_choice;
			end; 
			driver.exit;
		end; 

	tree_trace (t : BINARY_TREE [INTEGER]; i : INTEGER) is
			-- Display t, indented by i positions
		require
			t /= Void
		local
			j: INTEGER
		do
			if t.has_left then
				tree_trace (t.left_child, i + 3);
			end;
			from
				j := 1
			until
				j > i
			loop
				driver.putstring (" ");
				j := j + 1
			end;
			if t = active then
				driver.putstring ("[");
				driver.putint (t.item);
				driver.putstring ("]");
			else
				driver.putstring (" ");
				driver.putint (t.item);
				driver.putstring (" ");
			end;
			driver.new_line;
			if t.has_right then
				tree_trace (t.right_child, i + 3);
			end;
		end; 

	fill_menu is
		do
			driver.add_entry ("AL (Add Left): Add a left child", "Add a sub-tree on the left of the current node");
			Add_left := driver.last_entry
			driver.add_entry ("AR (Add Right): Add a right child", "Add a sub-tree on the right of the current node");
			Add_right := driver.last_entry
			driver.add_entry ("CL (Child Left): Change value of left child", "Change item at left child of current node");
			Child_put_left := driver.last_entry;
			driver.add_entry ("CR (Child Right): Change value of right child", "Change item at right child of current node");
			Child_put_right := driver.last_entry;
			driver.add_entry ("PU (PUt): Change value of active node", "Change value of active node");
			Put := driver.last_entry;
			driver.add_entry ("RL (Remove Left): Remove left child", "Remove left child of current node");
			Remove_left_child := driver.last_entry;
			driver.add_entry ("RR (Remove Right): Remove right child", "Remove right child of current node");
			Remove_right_child := driver.last_entry;
			driver.add_entry ("RO (Root): Go to root", "Go to root node");
			Root := driver.last_entry;
			driver.add_entry ("LE (Left): Go to left child", "Go to left child");
			Left := driver.last_entry;
			driver.add_entry ("RI (Right): Go to right child", "Go to right child");
			Right := driver.last_entry;
			driver.add_entry ("PA (Parent): Go to parent", "Go to parent of current node");
			Parent := driver.last_entry
			driver.add_entry ("CS (Child Status): Information on current node", "Print information on current node");
			Child_status := driver.last_entry;
			driver.add_entry ("SH (SHow): Show tree", "Display tree contents");
			Show := driver.last_entry;
			driver.add_entry ("QU (QUit)", "Terminate this session");
			Quit := driver.last_entry;
			driver.complete_menu
		end;

	execute (new_command: INTEGER) is
			-- Execute command corresponding to user's request.
		require else 
			new_command >= Child_put_left;
			new_command <= Quit
		local
			new : like active
		do
		-- parse and perform action
			if new_command = Left then
				if active.has_left then
					active := active.left_child
				else
					driver.signal_error ("Cannot execute: no left child.")
				end; 
			elseif new_command = Right then
				if active.has_right then
					active := active.right_child
				else
					driver.signal_error ("Cannot execute: no right child.")
				end; 
			elseif new_command = Root then
				active := tree_root
			elseif new_command = Parent then
				if active.parent /= Void then
					active := active.parent
				else
					driver.signal_error ("Cannot execute: no parent.")
				end
			elseif new_command = Child_status then
				driver.putstring ("has_right ");
				driver.putbool (active.has_right);
				driver.new_line;
				driver.putstring ("has_left ");
				driver.putbool (active.has_left);
				driver.new_line;
				driver.putstring ("has_none ");
				driver.putbool (active.has_none);
				driver.new_line;
				driver.putstring ("has_both ");
				driver.putbool (active.has_both);
				driver.new_line;
			elseif new_command = Add_left then
				!!new.make (driver.get_integer ("item"))
				active.put_left_child (new)
			elseif new_command = Add_right then 
				!!new.make (driver.get_integer ("item"))
				active.put_right_child (new)
			elseif new_command = Put then
				active.put (driver.get_integer ("item"))
			elseif new_command = Remove_right_child then
				active.remove_right_child
			elseif new_command = Remove_left_child then
				active.remove_left_child
			elseif new_command = Child_put_right then
				if active.has_right then
					active.child_go_i_th (2)
					active.child_replace (driver.get_integer ("item"))
				else
					driver.signal_error ("Cannot execute: no right child");
				end
			elseif new_command = Child_put_left then
				if active.has_left then
					active.child_go_i_th (1)
					active.child_replace (driver.get_integer ("item"))
				else
					driver.signal_error ("cannot execute: no left child")
				end
			elseif new_command /= Show then
				driver.signal_error ("Unknown command")
			end;
		end;

end -- class BINARY_TREE_DEMO
