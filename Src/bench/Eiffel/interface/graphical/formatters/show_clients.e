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
			Result := bm_Showclients 
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Showclients end;

	title_part: STRING is do Result := l_Clients_of end;

	display_info (i: INTEGER; c: CLASSC_STONE) is
			-- Display clients of `c' in tree form.
		local
			ewb_clients: EWB_CLIENTS
		do
			!! ewb_clients.null;
			ewb_clients.display_clients (text_window, c.class_c);
		end

end
