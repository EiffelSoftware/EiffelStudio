--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|        Interactive Software Engineering Building            --
--|            270 Storke Road, California 93117                --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	description: "Demo class for binary search trees."

class 
	BINARY_SEARCH_TREE_DEMO 

inherit
	TOP_DEMO
		redefine
			cycle, execute, fill_menu
		end

creation
	make


feature -- Creation

	make is
			-- Initialize and execute demonstration
		do
			!!driver.make
			driver.new_menu ("%N%N* BINARY SEARCH TREE DEMO *%N%N[XX] shows current node%N")
			fill_menu
			!!tree_root.make (0)
			cycle
		end

feature -- Attributes

	put, has: INTEGER

	show, quit: INTEGER

	tree_root: BINARY_SEARCH_TREE [INTEGER]

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

	tree_trace (t: BINARY_SEARCH_TREE [INTEGER]; i: INTEGER) is
			-- Display t, indented by i positions
		require
			tree_not_void: t /= Void
		local
			j: INTEGER
		do
			if t.has_right then
				tree_trace (t.right_child, i + 3)
			end
			from
				j := 1
			until
				j > i
			loop
				driver.putstring (" ")
				j := j + 1
			end
			driver.putint (t.item.item)
			driver.new_line
			if t.has_left then
				tree_trace (t.left_child, i + 3)
			end
		end

	fill_menu is
			-- Fill the menu with the available commands.
		do
			driver.add_entry ("PU (PUt): Put item in the tree", "Put item in the tree")
			Put := driver.last_entry
			driver.add_entry ("HA (HAs): Look for item in tree",  "Is item in the tree?")
			Has := driver.last_entry
			driver.add_entry ("HE (HEight): Display height of tree", "Show height of the tree")
			Show := driver.last_entry
			driver.add_entry ("QU (QUit)", "Terminate this session")
			quit := driver.last_entry
			driver.complete_menu
		end

	execute (new_command: INTEGER) is
			-- Execute command corresponding to user's request.
		require else
			valid_command: new_command >= put and new_command <= quit
		local
			ic: INTEGER
		do
				--| parse and perform action
			if new_command = put then
				ic := get_element
				tree_root.put (ic)
			elseif new_command = has then
				ic := get_element
				driver.putstring ("Has: ")
				driver.putbool (tree_root.has (ic))
				driver.new_line
			elseif new_command /= show then
				driver.signal_error ("Unknown command")
			end
		end

	get_element: INTEGER is
		do
			Result := driver.get_integer ("item");
		end

end -- class BINARY_SEARCH_TREE_DEMO
