-----------------------------------------------------------------
--   Copyright (C) Interactive Software Engineering, Inc.      --
--    270 Storke Road, Suite 7 Goleta, California 93117        --
--                   (805) 685-1006                            --
-- All rights reserved. Duplication or distribution prohibited --
-----------------------------------------------------------------

class SORT_DEMO

inherit

	TOP_DEMO
		redefine 
			cycle, execute, fill_menu
		end

creation
	make

feature

	Put, Remove, Forth, Back, Start, Finish, Remove_all,
	Search, Search_before, Search_after, Quit: INTEGER;

	l: SORTED_TWO_WAY_LIST [INTEGER]

	make is
		do
			!!l.make;
			!!driver.make;
			driver.new_menu ("SORTED LIST DEMO%N%N[XX] shows element at cursor position%N");
			fill_menu;
			cycle;
		end; 

	cycle is
			-- Basic user interaction process.
		local
			command: INTEGER
		do
			from
				driver.print_menu;
				trace;
				command := driver.get_choice;
			until
				command = Quit
			loop
				execute (command);
				trace;
				command := driver.get_choice;
			end; 
			driver.exit;
		end; 

	fill_menu is
			-- Fill menu items with text.
		do
			driver.add_entry ("PU (PUt): Insert item and move cursor to it", "put item, move cursor under it");
			Put := driver.last_entry;
			driver.add_entry ("RM (ReMove): Remove item at cursor position", "Remove item at cursor position");
			Remove := driver.last_entry;
			driver.add_entry ("RA (Remove All): Remove all items of a certain value", "Remove all items of a certain value");
			Remove_all := driver.last_entry;
			driver.add_entry ("ST (STart): Move cursor to first position", "Move to beginning of list");
			Start := driver.last_entry;
			driver.add_entry ("FI (FInish): Move cursor to last position", "Move cursor to end of list");
			Finish := driver.last_entry;
			driver.add_entry ("FO (FOrth): Advance cursor one position", "Move cursor one position forward");
			Forth := driver.last_entry;
			driver.add_entry ("BA (BAck): Move cursor one position back", "Move cursor one position backward");
			Back := driver.last_entry;
			driver.add_entry ("SE (Search): Move cursor to nearest occurrence of a value", "Move cursor to nearest occurence of a value");
			Search := driver.last_entry;
			driver.add_entry ("SB (Search Before): Go to rightmost position with item <= given value", "Go to first position with item less than or equal to given value");
			Search_before := driver.last_entry;
			driver.add_entry ("SA (Search After): Go to leftmost position with item >= given value", "Go to first position with item less than or equal to given value");
			Search_after := driver.last_entry;
			driver.add_entry ("QU (QUit)", "Terminate this session");
			Quit := driver.last_entry;
			driver.complete_menu
		end; 

	get_comparable: INTEGER is
		do
			Result :=  (driver.get_integer ("item"));
		end;

	execute (new_command: INTEGER) is
			-- Execute operation corresponding to the user's command.
		local
			comp, occ : INTEGER;
		do
			if new_command = Put then
				l.extend (get_comparable);
			elseif new_command = SEarch then
				comp := get_comparable;
				l.compare_objects
				l.search (comp)
			elseif new_command = Search_before then
				l.search_before (get_comparable)
			elseif new_command = Search_after then
				l.search_after (get_comparable)
			elseif new_command = Remove_all then
				l.prune_all (get_comparable)
			elseif new_command = Remove then
				if  l.off then
					driver.putstring ("No active element: cannot remove");
					driver.new_line
				else
					l.remove
				end
			elseif new_command = Forth then
				if l.after then
					driver.putstring ("Cannot go any further");
					driver.new_line
				else
					l.forth
				end
			elseif new_command = Back then
				if l.before then
					driver.putstring ("Cannot go any further");
					driver.new_line
				else
					l.back
				end
			elseif new_command = Start then
				l.start
			elseif new_command = Finish then
				l.finish
			end
		end; 

	space is
		do
			driver.putstring (" ");
		end; 

	put_comp is
		do
			driver.putint (l.item)
		end;

	trace is
				-- Ouput the state of the sorted list
		local
			position : INTEGER
			c : CURSOR
		do
			driver.start_result;
			position := l.index;
			if l.before then
				driver.putstring ("[]");
				space;
			end;
			c := l.cursor
			from
				l.start
			until
				l.exhausted
			loop
				if position = l.index then
					driver.putstring ("[");
					put_comp;
					driver.putstring ("]");
				else
					put_comp
				end; 
				space;
				l.forth
			end; 
			l.go_to (c);
			if l.after and not l.empty then
				driver.putstring ("[]");
				driver.new_line
			else
				driver.putstring ("");
				driver.new_line
			end; 
			driver.end_result;
		end; 

end -- class SORT_DEMO
