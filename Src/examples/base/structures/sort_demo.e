class SORT_DEMO

inherit

	TOP_DEMO
		redefine 
			cycle, execute, fill_menu
		end

create
	make

feature

	put, remove, forth, back, start, finish, remove_all,
	search, search_before, search_after, quit: INTEGER

	l: SORTED_TWO_WAY_LIST [INTEGER]

	make is
		do
			create l.make
			create driver.make
			driver.new_menu ("SORTED LIST DEMO%N%N[XX] shows element at cursor position%N")
			fill_menu
			cycle
		end 

	cycle is
			-- Basic user interaction process.
		local
			command: INTEGER
		do
			from
				driver.print_menu
				trace
				command := driver.get_choice
			until
				command = quit
			loop
				execute (command)
				trace
				command := driver.get_choice
			end 
			driver.exit
		end 

	fill_menu is
			-- Fill menu items with text.
		do
			driver.add_entry ("PU (PUt): Insert item and move cursor to it", "put item, move cursor under it")
			put := driver.last_entry
			driver.add_entry ("RM (ReMove): Remove item at cursor position", "Remove item at cursor position")
			remove := driver.last_entry
			driver.add_entry ("RA (Remove All): Remove all items of a certain value", "Remove all items of a certain value")
			remove_all := driver.last_entry
			driver.add_entry ("ST (STart): Move cursor to first position", "Move to beginning of list")
			start := driver.last_entry
			driver.add_entry ("FI (FInish): Move cursor to last position", "Move cursor to end of list")
			finish := driver.last_entry
			driver.add_entry ("FO (FOrth): Advance cursor one position", "Move cursor one position forward")
			forth := driver.last_entry
			driver.add_entry ("BA (BAck): Move cursor one position back", "Move cursor one position backward")
			back := driver.last_entry
			driver.add_entry ("SE (Search): Move cursor to nearest occurrence of a value", "Move cursor to nearest occurence of a value")
			search := driver.last_entry
			driver.add_entry ("SB (Search Before): Go to rightmost position with item <= given value", "Go to first position with item less than or equal to given value")
			search_before := driver.last_entry
			driver.add_entry ("SA (Search After): Go to leftmost position with item >= given value", "Go to first position with item less than or equal to given value")
			search_after := driver.last_entry
			driver.add_entry ("QU (QUit)", "Terminate this session")
			quit := driver.last_entry
			driver.complete_menu
		end 

	get_comparable: INTEGER is
		do
			Result :=  (driver.get_integer ("item"))
		end

	execute (new_command: INTEGER) is
			-- Execute operation corresponding to the user's command.
		local
			comp: INTEGER
		do
			if new_command = put then
				l.extend (get_comparable)
			elseif new_command = SEarch then
				comp := get_comparable
				l.compare_objects
				l.search (comp)
			elseif new_command = search_before then
				l.search_before (get_comparable)
			elseif new_command = search_after then
				l.search_after (get_comparable)
			elseif new_command = remove_all then
				l.prune_all (get_comparable)
			elseif new_command = remove then
				if  l.off then
					driver.putstring ("No active element: cannot remove")
					driver.new_line
				else
					l.remove
				end
			elseif new_command = forth then
				if l.after then
					driver.putstring ("Cannot go any further")
					driver.new_line
				else
					l.forth
				end
			elseif new_command = back then
				if l.before then
					driver.putstring ("Cannot go any further")
					driver.new_line
				else
					l.back
				end
			elseif new_command = start then
				l.start
			elseif new_command = finish then
				l.finish
			end
		end 

	space is
		do
			driver.putstring (" ")
		end 

	put_comp is
		do
			driver.putint (l.item)
		end

	trace is
				-- Ouput the state of the sorted list
		local
			position : INTEGER
			c : CURSOR
		do
			driver.start_result
			position := l.index
			if l.before then
				driver.putstring ("[]")
				space
			end
			c := l.cursor
			from
				l.start
			until
				l.exhausted
			loop
				if position = l.index then
					driver.putstring ("[")
					put_comp
					driver.putstring ("]")
				else
					put_comp
				end 
				space
				l.forth
			end 
			l.go_to (c)
			if l.after and not l.is_empty then
				driver.putstring ("[]")
				driver.new_line
			else
				driver.putstring ("")
				driver.new_line
			end 
			driver.end_result
		end 

end -- class SORT_DEMO

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

