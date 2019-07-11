note
	description: "Demo class for binary search trees."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	BINARY_SEARCH_TREE_DEMO

inherit
	TOP_DEMO
		redefine
			cycle,
			execute,
			fill_menu,
			make
		end

create
	make

feature {NONE} -- Creation

	make
			-- Initialize and execute demonstration.
		do
			Precursor
			driver.new_menu ("%N%N* BINARY SEARCH TREE DEMO *%N%N[XX] shows current node%N")
			fill_menu
			create tree_root.make (0)
			cycle
		end

feature {NONE} -- Attributes

	put, has: INTEGER
			-- Command code.

	show, quit: INTEGER
			-- Command code.

	tree_root: BINARY_SEARCH_TREE [INTEGER]
			-- Structure to operate on.

feature {NONE} -- Basic operations

	cycle
			-- <Precursor>
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

	tree_trace (t: BINARY_SEARCH_TREE [INTEGER]; i: INTEGER)
			-- Display `t`, indented by `i` positions.
		require
			tree_not_void: t /= Void
		local
			j: INTEGER
		do
			if attached t.right_child as c then
				tree_trace (c, i + 3)
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
			if attached t.left_child as c then
				tree_trace (c, i + 3)
			end
		end

	fill_menu
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

	execute (new_command: INTEGER)
			-- Execute command corresponding to user's request.
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

	get_element: INTEGER
			-- Read a value.
		do
			Result := driver.get_integer ("item")
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
