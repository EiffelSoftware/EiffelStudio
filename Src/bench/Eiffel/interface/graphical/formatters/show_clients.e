-- Command to display class clients.

class SHOW_CLIENTS 

inherit

	FORMATTER

creation

	make

feature 

	make (c: COMPOSITE; a_text_window: CLASS_TEXT) is
		do
			init (c, a_text_window);
			indent := 4
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
		local
			clients: LINKED_LIST [CLASS_C];
			class_c, a_client: CLASS_C
		do
			text_window.put_string ("Clients of class ");
			class_c := c.class_c;
			class_c.append_clickable_signature (text_window);
			text_window.put_string (":%N%N");
			from
				clients := class_c.clients;
				clients.start
			until
				clients.after
			loop
				a_client := clients.item;
				if (class_c /= a_client) then
					text_window.put_string (tabs (1));
					a_client.append_clickable_signature (text_window);
					text_window.new_line;
				end;
				clients.forth
			end
		end

end
