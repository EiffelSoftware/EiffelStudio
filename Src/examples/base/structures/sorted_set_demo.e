indexing
	desription: "Demo class for sorted sets. %
		% Just change the types of a, b and c to %
		% apply to other implementations of sets. %
		%		MSLS to demo SORTED_SET %
		%		MBSTS to demo BST_SET"

class 
	SORTED_SET_DEMO

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
			driver.new_menu ("%N%N        * SORTED SET DEMO%N%N[XX] shows current item *%N")
			fill_menu
			create a.make
			create b.make
			create c.make
			cycle
		end 

feature -- Attributes

	wipe_out, empty, item_count, minmax, remove, has,
	put, intersect, merge, subtract, is_superset, is_subset,
	show, quit: INTEGER

	a, b, c:  MSLS

feature -- Routines

	cycle is
			-- Basic user interaction process.
		local
			new_command: INTEGER
		do
			from
				driver.print_menu
				driver.putstring (" ")
				driver.new_line
				sets_trace
				new_command := driver.get_choice
			until
				new_command = quit
			loop
				execute (new_command)
				driver.new_line
				driver.start_result
				sets_trace
				driver.end_result
				new_command := driver.get_choice
			end
			driver.exit
		end

	sets_trace is
			-- Display the 3 sets.
		do
			driver.putstring ("a:")
			a.display
			driver.new_line
			driver.putstring ("b:")
			b.display
			driver.new_line
			driver.putstring ("c:")
			c.display
			driver.new_line
		end 

	fill_menu is
			-- Fill the menu with the available commands.
		do
			driver.add_entry ("PU (PUt): Insert item in set", "Put item in the set")
			put := driver.last_entry
			driver.add_entry ("IN (INtersection): Intersect with other set", "Remove from set1 all items not in set2")
			intersect := driver.last_entry
			driver.add_entry ("UN (UNion): Union with other set", "Add to set1 all items in set2")
			merge := driver.last_entry
			driver.add_entry ("SU (SUbtract): Subtract other set", "Remove from set1 all items in set2")
			subtract := driver.last_entry
			driver.add_entry ("RM (ReMove): Remove an item",  "Remove an item from the set")
			remove :=driver.last_entry
			driver.add_entry ("WO (Wipe Out): Empty the set", "Make the set empty")
			wipe_out := driver.last_entry
			driver.add_entry ("SP (SuPerset): Test if superset of other set", "Is set1 a superset of set2?")
			is_superset := driver.last_entry
			driver.add_entry ("SB (Subset): Test if subset of other set", "Is set1 a subset of set2?")
			is_subset := driver.last_entry
			driver.add_entry ("MX (Minmax): Test min and max", "Display minimum and maximum items of the set")
			minmax := driver.last_entry
			driver.add_entry ("HA (HAs): Test if item belongs to set", "Is item in the set?")
			has := driver.last_entry
			driver.add_entry ("CO (COunt): Show number of items in set", "Display number of items")
			item_count := driver.last_entry
			driver.add_entry ("EM (EMpty): Test if set is empty", "Is the set empty?")
			empty := driver.last_entry
			driver.add_entry ("SH (SHow): Show contents of sets", "Display contents of sets")
			show := driver.last_entry
			driver.add_entry ("QU (QUit)", "Terminate this session")
			quit := driver.last_entry
			driver.complete_menu
		end

	execute (new_command: INTEGER) is
			-- Execute command corresponding to user's request.
		require else
			valid_command: new_command >= put and new_command <= quit
		local
			set1, set2: like a
			element: INTEGER
		do
				--| parse and perform action
			if new_command = wipe_out then
				set1 := get_set
				if set1 /= Void then
					set1.wipe_out
				end
			elseif new_command = empty then
				set1 := get_set
				if set1 /= Void then
					driver.putbool (set1.is_empty)
				end
			elseif new_command = item_count then
				set1 := get_set
				if set1 /= Void then
					driver.putint (set1.count)
				end
			elseif new_command = minmax then
				set1 := get_set
				if set1 /= Void then
					if set1.is_empty then
						driver.signal_error ("Cannot execute: set empty")
					else
						driver.putint (set1.min.item)
						driver.new_line
						driver.putint (set1.max.item)
					end
				end
			elseif new_command = remove then
				set1 := get_set
				if set1 /= Void then
					element := get_el
					set1.prune (element)
				end
			elseif new_command = has then
				set1 := get_set
				if set1 /= Void then
					element := get_el
					driver.putbool (set1.has (element))
				end
			elseif new_command = put then
				set1 := get_set
				if set1 /= Void then
					element := get_el
					set1.put (element)
				end
			elseif new_command = intersect then
				set1 := get_set
				if set1 /= Void then
					set2 := get_set
					if set2 /= Void then
						set1.intersect (set2)
					end
				end
			elseif new_command = merge then
				set1 := get_set
				if set1 /= Void then
					set2 := get_set
					if set2 /= Void then
						set1.merge (set2)
					end
				end
			elseif new_command = subtract then
				set1 := get_set
				if set1 /= Void then
					set2 := get_set
					if set2 /= Void then
						set1.subtract (set2)
					end
				end
			elseif new_command = is_superset then
				set1 := get_set
				if set1 /= Void then
					set2 := get_set
					if set2 /= Void then
						driver.putbool (set1.is_superset (set2))
					end
				end
			elseif new_command = is_subset then
				set1 := get_set
				if set1 /= Void then
					set2 := get_set
					if set2 /= Void then
						driver.putbool (set1.is_subset (set2))
					end
				end
			elseif new_command /= show then
				driver.signal_error ("Unknown command")
			end 
		end 

	get_set: like a is
		local
			s: STRING
		do
			s := driver.get_string ("which set")
			if s.is_equal ("a") then
				Result := a
			elseif s.is_equal ("b") then
				Result := b
			elseif s.is_equal ("c") then
				Result := c
			else
				driver.signal_error ("Unknown set")
			end
		end

	get_el: INTEGER is
		do
			Result := driver.get_integer ("element")
		end

end -- class SORTED_SET_DEMO

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

