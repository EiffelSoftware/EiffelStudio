-- Demo class for binary search trees

class BINARY_SEARCH_TREE_DEMO inherit

	TOP_DEMO
		redefine
			cycle, execute, fill_menu
		end

creation
	make

feature

	Put, Has: INTEGER;
	Show, Quit: INTEGER;

	tree_root : BINARY_SEARCH_TREE [INTEGER];

	make is
			-- Initialize and execute demonstration
		do
			!!driver.make;
			driver.new_menu ("%N%N* BINARY SEARCH TREE DEMO *%N%N[XX] shows current node%N");
			fill_menu;
			!!tree_root.make (0);
			cycle;
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

	tree_trace (t : BINARY_SEARCH_TREE [INTEGER]; i : INTEGER) is
			-- Display t, indented by i positions
		require
			t /= Void
		local
			j: INTEGER
		do
			if t.has_right then
				tree_trace (t.right_child, i + 3);
			end;
			from
				j := 1
			until
				j > i
			loop
				driver.putstring (" ");
				j := j + 1
			end;
			driver.putint (t.item.item);
			driver.new_line;
			if t.has_left then
				tree_trace (t.left_child, i + 3);
			end;
		end; 

	fill_menu is
		do
			driver.add_entry ("PU (PUt): Put item in the tree", "Put item in the tree");
			Put := driver.last_entry;
			driver.add_entry ("HA (HAs): Look for item in tree",  "Is item in the tree?");
			Has := driver.last_entry;
			driver.add_entry ("HE (HEight): Display height of tree", "Show height of the tree");
			Show := driver.last_entry;
			driver.add_entry ("QU (QUit)", "Terminate this session");
			Quit := driver.last_entry;
			driver.complete_menu
		end;

	execute (new_command: INTEGER) is
			-- Execute command corresponding to user's request.
		require else
			new_command >= Put;
			new_command <= Quit
		local
			ic: INTEGER
		do
		-- parse and perform action
			if new_command = Put then
				ic := get_element;
				tree_root.put (ic)
			elseif new_command = Has then
				ic := get_element;
				driver.putstring ("Has: ");
				driver.putbool (tree_root.has (ic));
				driver.new_line
			elseif new_command /= Show then
				driver.signal_error ("Unknown command")
			end; 
		end; 

	get_element: INTEGER is
		do
			Result := driver.get_integer ("item");
		end;

end -- class BINARY_SEARCH_TREE_DEMO
