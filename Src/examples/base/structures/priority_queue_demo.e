-- Demo class for priority queues.
--		MY_SLP to demo SLP_QUEUE

class PRIORITY_QUEUE_DEMO inherit

	TOP_DEMO
		redefine
			cycle, fill_menu, execute
		end

creation
	make

feature

	Wipe_out, Empty, Item_count: INTEGER;
	Remove, Put, Item: INTEGER;
	Show, Quit: INTEGER;

	a:  MY_SLP;

	make is
			-- Initialize and execute demonstration
		do
			!!driver.make;
			driver.new_menu ("%N%N* PRIORITY QUEUE DEMO *%N%N[XX] shows current element%N");
			fill_menu;
			!!a.make;
			cycle
		end; -- create

	cycle is
			-- Basic interaction loop
		local
			new_command: INTEGER
		do
			from
				driver.print_menu;
				driver.putstring (" ");
				driver.new_line;
				queue_trace;
				new_command := driver.get_choice
			until
				new_command = Quit
			loop
				execute (new_command);
				driver.new_line;
				driver.start_result;
				queue_trace;
				driver.end_result;
				new_command := driver.get_choice;
			end; 
			driver.exit
		end;

	queue_trace is
			-- Display the queue.
		do
			driver.putstring ("a: ");
			a.display;
			driver.new_line;
		end; 

	fill_menu is
		do
			driver.add_entry ("PU (PUt): Insert a new item", "Insert a new item in the queue");
			Put := driver.last_entry;
			driver.add_entry ("RM (ReMove): Remove highest priority item", "Remove the item with highest priority");
			Remove := driver.last_entry;
			driver.add_entry ("WI (WIpe out): Empty the queue", "Make the queue empty");
			Wipe_out := driver.last_entry;
			driver.add_entry ("HI (HIghest): Show item with highest priority", "Display Item with highest priority in the queue");
			Item := driver.last_entry;
			driver.add_entry ("CO (COunt): Show number of items in queue", "Display number of items in queue");
			Item_count := driver.last_entry;
			driver.add_entry ("EM (EMpty): Test for empty queue", "Is the queue empty?");
			Empty := driver.last_entry;
			driver.add_entry ("SH (SHow): Show full state of queue", "show queue");
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
		do
		-- parse and perform action
			if new_command = Wipe_out then
				a.wipe_out
			elseif new_command = Empty then
				driver.putbool (a.empty)
			elseif new_command = Item_count then
				driver.putint (a.count)
			elseif new_command = Remove then
				if a.empty then
					driver.signal_error ("Cannot execute: queue is empty")
				else
					a.remove
				end
			elseif new_command = Put then
				a.put (get_el)
			elseif new_command = Item then
				if a.empty then
					driver.signal_error ("Cannot execute: queue is empty")
				else
					driver.putint (a.item.item)
				end
			elseif new_command /= Show then
				driver.signal_error ("Unknown command")
			end
		end;

	get_el: INTEGER is
		do
			Result := driver.get_integer ("which value");
		end;

end -- class PRIORITY_QUEUE_DEMO
