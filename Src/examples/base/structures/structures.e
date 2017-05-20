note
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	STRUCTURES

inherit
	EXCEPTIONS

create
	make

feature {NONE} -- Creation

	make
			-- Run the application.
		do
			create chosen_demo.make
			io.set_error_default
				--| no_message_on_failure
			io.putstring ("%N%N     * Class demos from the Eiffel Data Structure Library *%N%N")
			session
		end

feature -- Attributes

	chosen_demo: TOP_DEMO
			-- Currently selected demo.

	saved_file_name: STRING_32 = "demo.S"
			-- A name of a file where a demo is saved.

feature -- Routines

	one_demo
			-- Execute a new session, possibly from a previously saved one.
			-- Then store it if requested.
		local
			saved_demo_file: RAW_FILE
			resume_session: BOOLEAN
		do
			create saved_demo_file.make_with_name (saved_file_name)
			if saved_demo_file.exists then
				io.putstring ("Do you want to retrieve the last saved demo (y/n)?: ")
				io.readchar
				if io.lastchar = 'y' then
					io.next_line
					create chosen_demo.make
					saved_demo_file.open_read
					if attached {TOP_DEMO} chosen_demo.retrieved (saved_demo_file) as d then
						chosen_demo := d
						saved_demo_file.close
						chosen_demo.cycle
						resume_session := true
					else
						saved_demo_file.close
						io.putstring ("Cannot load saved demo. Using the new one.%N")
						io.put_new_line
					end
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

	session
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
				over := io.lastchar /= 'y'
				io.next_line
			end
		end

	print_menu
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

	new_demo
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
				create {SORT_DEMO} chosen_demo.make
			when 2 then
				create {TWO_WAY_TREE_DEMO} chosen_demo.make
			when 3 then
				create {BINARY_TREE_DEMO} chosen_demo.make
			when 4 then
				create {BINARY_SEARCH_TREE_DEMO} chosen_demo.make
			when 5 then
				io.putstring ("This is temporarily disabled%N")
			when 6 then
				create {SET_DEMO} chosen_demo.make
			when 7 then
				create {SORTED_SET_DEMO} chosen_demo.make
			else
				io.putstring ("Demo number should be between 1 and 7")
			end
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
