-----------------------------------------------------------------
--   Copyright (C) Interactive Software Engineering, Inc.      --
--    270 Storke Road, Suite 7 Goleta, California 93117        --
--                   (805) 685-1006                            --
-- All rights reserved. Duplication or distribution prohibited --
-----------------------------------------------------------------
class TWO_WAY_TREE_DEMO

inherit
	TOP_DEMO
		redefine
			cycle, execute, fill_menu
		end

creation
	make

feature

	Child, Parent, Right, Left, Root, Child_forth, Child_back,
	Child_start, Child_finish, Child_put, Put_left, Put_right,
	Child_remove, Put, Show, Quit: INTEGER;

	tree_root : TWO_WAY_TREE [INTEGER];

	active : TWO_WAY_TREE [INTEGER];

	active_child : TWO_WAY_TREE [INTEGER];

	make is
			-- Initialize and execute demonstration
		do
			!!driver.make;
			driver.new_menu ("%N%N* GENERAL TREE DEMO *%N%N[XX] Shows current node, (YY) shows child cursor%N");
			fill_menu;
			!!tree_root.make (0);
			active := tree_root;
			cycle
		end;

	cycle is
			-- Basic user interaction process.
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
				active_child := active.child;
				driver.new_line;
				driver.start_result;
				tree_trace (tree_root, 0);
				driver.end_result;
				new_command := driver.get_choice;
			end;
			driver.exit;
		end;

	tree_trace (t : TWO_WAY_TREE [INTEGER]; i : INTEGER) is
			-- Display t, indented by i positions
		require
			t /= Void
		local
			j: INTEGER
			c: CURSOR
		do
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
			elseif t = active_child then
				driver.putstring ("(");
				driver.putint (t.item);
				driver.putstring (")");
			else
				driver.putstring (" ");
				driver.putint (t.item);
				driver.putstring (" ");
			end;
			driver.new_line;
			from
				c := t.child_cursor;
				t.child_start
			until
				t.exhausted
			loop
				tree_trace (t.child, i + 3);
				t.child_forth;
			end;
			t.child_go_to (c);
		end;

	fill_menu is
		do
			driver.add_entry ("IL (Insert at Left): Insert new child at left of cursor position",  "Change value of child to the left of child cursor position");
			Put_left := driver.last_entry;
			driver.add_entry ("IR (Insert at Right): Insert new child at right of cursor position",  "Change value of child to the right of child cursor position");
			Put_right := driver.last_entry;
			driver.add_entry ("PU (PUt): Change value of current node", "Change value of current node");
			Put := driver.last_entry;
			driver.add_entry ("CC (Change Child): Change value of child at cursor position", "Change value of child at child cursor position");
			Child_put := driver.last_entry;
			driver.add_entry ("RM (ReMove): Remove child at cursor position", "Remove active child at child cursor position");
			Child_remove := driver.last_entry;
			driver.add_entry ("LE (LEft): Go to left sibling", "Go to left sibling of current node");
			Left := driver.last_entry;
			driver.add_entry ("RI (RIght): Go to right sibling", "Go to right sibling of current node");
			Right := driver.last_entry;
			driver.add_entry ("CH (CHild): Go to child at cursor position", "Go to active child of current node");
			Child := driver.last_entry;
			driver.add_entry ("PA (PArent): Go to parent", "Go to parent of current node");
			Parent := driver.last_entry;
			driver.add_entry ("RO (ROot): Go to root", "Go to root of tree");
			Root := driver.last_entry;
			driver.add_entry ("CS (Cursor Start): Move cursor to first child", "Move child cursor to first child");
			Child_start := driver.last_entry;
			driver.add_entry ("CE (Cursor End): Move cursor to last child", "Move child cursor to last child");
			Child_finish := driver.last_entry;
			driver.add_entry ("CF (Cursor Forward): Move cursor to next child", "Move child cursor forward");
			Child_forth := driver.last_entry;
			driver.add_entry ("CB (Cursor Backward): Move cursor to previous child", "Move child cursor backward");
			Child_back := driver.last_entry;
			driver.add_entry ("SH (SHow): SHow tree in full", "Display the structure and contents of the tree");
			Show := driver.last_entry;
			driver.add_entry ("QU (QUit)", "Terminate this session");
			Quit := driver.last_entry;
			driver.complete_menu
		end;

	execute (new_command: INTEGER) is
			-- Execute command corresponding to user's request.
		require else
			new_command >= Put_left;
			new_command <= Quit
		local
			other : TWO_WAY_TREE [INTEGER]
		do
		-- parse and perform action
			if new_command = Child then
				if active.is_leaf then
					driver.signal_error ("Cannot execute: no child.")
				else
					active := active.child
				end
			elseif new_command = Parent then
				if active = tree_root then
					driver.signal_error ("Cannot execute: no parent.")
				else
					active := active.parent
				end
			elseif new_command = Right then
				other := active.right_sibling;
				if other = Void then
					driver.signal_error ("Cannot execute: no right sibling.")
				else
					active := active.right_sibling;
					if not active.is_root then
						other := active.parent;
						other.child_forth;
					end
				end
			elseif new_command = Left then
				other := active.left_sibling;
				if other = Void then
					driver.signal_error ("Cannot execute: no left sibling.")
				else
					active := active.left_sibling;
					if not active.is_root then
						other := active.parent;
						other.child_back;
					end
				end
			elseif new_command = Root then
				active := tree_root
			elseif new_command = Child_forth then
				if active.is_leaf or else active.child_islast then
					driver.signal_error ("Cannot execute: no child forward.")
				else
					active.child_forth
				end
			elseif new_command = Child_back then
				if active.is_leaf or else active.child_isfirst then
					driver.signal_error ("Cannot execute: no child backward.")
				else
					active.child_back
				end
			elseif new_command = Child_start then
				if active.is_leaf then
					driver.signal_error ("Cannot execute: no child.")
				else
					active.child_start
				end
			elseif new_command = Child_finish then
				if active.is_leaf then
					driver.signal_error ("Cannot execute: no child.")
				else
					active.child_finish
				end
			elseif new_command = Put_left then
					if active.child_before then active.child_forth end
					active.child_put_left (driver.get_integer ("item"));
					if active.arity = 1 then active.child_start end
			elseif new_command = Put_right then
					active.child_put_right (driver.get_integer ("item"));
					if active.arity = 1 then active.child_start end
			elseif new_command = Child_put then
				if active.child_off then
					driver.signal_error ("Cannot execute: no active child.")
				else
					active.child_put (driver.get_integer ("item"));
				end
			elseif new_command = Put then
				active.put (driver.get_integer ("item"));
			elseif new_command = Child_remove then
				if active.is_leaf then
					driver.signal_error ("Cannot execute: no child.")
				else
					active.remove_child;
					if active.child_after and not
								active.empty then
						active.child_back
					end
				end
			elseif new_command /= Show then
				driver.signal_error ("Unknown command")
			end
		end; 

end -- class TWO_WAY_TREE_DEMO
