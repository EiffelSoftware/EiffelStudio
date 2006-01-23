indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class 
	STRUCTURES

inherit
	EXCEPTIONS

create
	make

feature -- Creation

	make is
		do
			io.set_error_default
			
				--| no_message_on_failure
			io.putstring ("%N%N     * Class demos from the Eiffel Data Structure Library *%N%N")
			session
		end

feature -- Attributes

	a_two_way_tree_demo: TWO_WAY_TREE_DEMO

	a_sort_demo: SORT_DEMO

	a_binary_search_tree_demo: BINARY_SEARCH_TREE_DEMO

	a_binary_tree_demo: BINARY_TREE_DEMO

	--a_priority_queue_demo: PRIORITY_QUEUE_DEMO

	a_set_demo: SET_DEMO

	a_sorted_set_demo: SORTED_SET_DEMO

	chosen_demo: TOP_DEMO

	saved_demo_file: RAW_FILE

	saved_file_name: STRING is "demo.S"

feature -- Routines

	one_demo is
			-- Execute a new session, possibly from a previously saved one.
			-- Then store it if requested.
		local
			resume_session: BOOLEAN
		do
			create saved_demo_file.make (saved_file_name)
			if saved_demo_file.exists then
				io.putstring ("Do you want to retrieve the last saved demo (y/n)?: ")
				io.readchar 
				if io.lastchar = 'y' then
					create chosen_demo
					saved_demo_file.open_read
					chosen_demo ?= chosen_demo.retrieved (saved_demo_file)
					saved_demo_file.close
					io.next_line
					chosen_demo.cycle
					resume_session := true
				else
					io.next_line
				end
			end
			if not resume_session then
				new_demo
			end
			if saved_demo_file.is_creatable then
				io.new_line
				io.putstring ("Save this demo to be resumed later? (y/n): ")
				io.readchar
				if io.lastchar = 'y' then
					saved_demo_file.open_write
					chosen_demo.independent_store (saved_demo_file)
					saved_demo_file.close
					io.putstring ("%TDemo saved%N")
				end
				io.next_line
			end
		end

	session is
			-- Execute one or more demo sessions.
		local
			over: BOOLEAN
		do
			from
			until
				over
			loop
				one_demo
				io.new_line
				io.putstring ("Another demo? (y/n): ")
				io.readchar
				over := (io.lastchar /= 'y')
				io.next_line
			end
		end

	print_menu is
			-- Display all possible choices.
		do
			io.putstring ("	1: Sorted lists.")
			io.new_line
			io.putstring ("	2: General trees.")
			io.new_line
			io.putstring ("	3: Binary trees.")
			io.new_line
			io.putstring ("	4: Binary search trees.")
			io.new_line
			io.putstring ("	5: Priority queues.")
			io.new_line
			io.putstring ("	6: Sets.")
			io.new_line
			io.putstring ("	7: Sorted sets.")
			io.new_line
			io.putstring ("")
			io.new_line
			io.putstring ("Please choose demo number: ")
		end

	new_demo is
				-- Set up a new demo session.
		local
			choice: INTEGER
		do
			print_menu
			io.readint
			choice := io.lastint
			inspect
				choice
			when 1 then
				create a_sort_demo.make
				chosen_demo := a_sort_demo
			when 2 then
				create a_two_way_tree_demo.make
				chosen_demo := a_two_way_tree_demo
			when 3 then
				create a_binary_tree_demo.make
				chosen_demo := a_binary_tree_demo
			when 4 then
				create a_binary_search_tree_demo.make
				chosen_demo := a_binary_search_tree_demo
			when 5 then
				io.putstring ("This is temporarily disabled%N")
				--create a_priority_queue_demo.make
				--chosen_demo := a_priority_queue_demo
			when 6 then
				create a_set_demo.make
				chosen_demo := a_set_demo
			when 7 then
				create a_sorted_set_demo.make
				chosen_demo := a_sorted_set_demo
			else
				io.putstring ("Demo number should be between 1 and 7")
			end
		end 

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class STRUCTURES

