-- Command to display class clients.

class SHOW_CLIENTS 

inherit

	FORMATTER

creation

	make

feature 

	make (c: COMPOSITE; a_text_window: CLASS_TEXT) is
		do
			init (c, a_text_window)
		end;

	symbol: PIXMAP is 
		once 
			!!Result.make; 
			Result.read_from_file (bm_Showclients) 
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Showclients end;

	title_part: STRING is do Result := l_Clients_of end;

	display_info (i: INTEGER; c: CLASSC_STONE) is
			-- Display clients of `c' in tree form.
--		local
--			clients: LINKED_LIST [CLASSC_STONE];
--			d: CLASSC_STONE
		do
--			from
--				clients := c.clients;
--				clients.start
--			until
--				clients.offright
--			loop
--				d := clients.item;
--				if d /= c then
--					text_window.put_string ("%T");
--					text_window.put_clickable_string (d, d.signature);
--					text_window.put_string ("%N")
--				end;
--				clients.forth
--			end
		end

end
