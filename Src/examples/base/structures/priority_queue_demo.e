indexing

	description: "Demo class for priority queues. %
		% MY_SLP to demo SLP_QUEUE"

class 
	PRIORITY_QUEUE_DEMO 

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
			driver.new_menu ("%N%N* PRIORITY QUEUE DEMO *%N%N[XX] shows current element%N")
			fill_menu
			create a.make
			cycle
		end

feature -- Attributes

	wipe_out, empty, item_count: INTEGER

	remove, put, item: INTEGER

	show, quit: INTEGER

	a:  MY_SLP

feature -- Routines

	cycle is
			-- Basic interaction loop
		local
			new_command: INTEGER
		do
			from
				driver.print_menu
				driver.putstring (" ")
				driver.new_line
				queue_trace
				new_command := driver.get_choice
			until
				new_command = quit
			loop
				execute (new_command)
				driver.new_line
				driver.start_result
				queue_trace
				driver.end_result
				new_command := driver.get_choice
			end
			driver.exit
		end

	queue_trace is
			-- Display the queue.
		do
			driver.putstring ("a: ")
			a.display
			driver.new_line
		end;

	fill_menu is
			-- Fill the menu with the available commands.
		do
			driver.add_entry ("PU (PUt): Insert a new item", "Insert a new item in the queue")
			put := driver.last_entry
			driver.add_entry ("RM (ReMove): Remove highest priority item", "Remove the item with highest priority")
			remove := driver.last_entry
			driver.add_entry ("WI (WIpe out): Empty the queue", "Make the queue empty")
			wipe_out := driver.last_entry
			driver.add_entry ("HI (HIghest): Show item with highest priority", "Display Item with highest priority in the queue")
			item := driver.last_entry
			driver.add_entry ("CO (COunt): Show number of items in queue", "Display number of items in queue")
			item_count := driver.last_entry
			driver.add_entry ("EM (EMpty): Test for empty queue", "Is the queue empty?")
			empty := driver.last_entry
			driver.add_entry ("SH (SHow): Show full state of queue", "show queue")
			show := driver.last_entry
			driver.add_entry ("QU (QUit)", "Terminate this session")
			quit := driver.last_entry
			driver.complete_menu
		end

	execute (new_command: INTEGER) is
			-- Execute command corresponding to user's request.
		require else
			valid_command: new_command >= put and new_command <= quit
		do
				--| parse and perform action
			if new_command = wipe_out then
				a.wipe_out
			elseif new_command = empty then
				driver.putbool (a.empty)
			elseif new_command = item_count then
				driver.putint (a.count)
			elseif new_command = remove then
				if a.empty then
					driver.signal_error ("Cannot execute: queue is empty")
				else
					a.remove
				end
			elseif new_command = put then
				a.put (get_el)
			elseif new_command = item then
				if a.empty then
					driver.signal_error ("Cannot execute: queue is empty")
				else
					driver.putint (a.item.item)
				end
			elseif new_command /= show then
				driver.signal_error ("Unknown command")
			end
		end

	get_el: INTEGER is
		do
			Result := driver.get_integer ("which value")
		end

end -- class PRIORITY_QUEUE_DEMO

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

