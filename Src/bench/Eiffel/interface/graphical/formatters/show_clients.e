-- Command to display class clients.

class SHOW_CLIENTS 

inherit

	FORMATTER
		redefine
			dark_symbol, display_temp_header, post_fix
		end

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
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showclients 
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
			ewb_clients.set_output_window (text_window);
			ewb_clients.display (c.class_c);
		end

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			text_window.display_header ("Searching for clients...")
		end;

	post_fix: STRING is "clt";

end
