indexing

	description:	
		"Command to display class clients.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_CLIENTS 

inherit

	FILTERABLE
		redefine
			dark_symbol, display_temp_header, post_fix
		end

creation

	make

feature -- Properties

	symbol: PIXMAP is 
		once 
			Result := bm_Showclients 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showclients 
		end;
 
feature {NONE} -- Properties

	name: STRING is
		do
			Result := l_Showclients
		end;

	title_part: STRING is
		do
			Result := l_Clients_of
		end;

	post_fix: STRING is "clt";

	create_structured_text (c: CLASSC_STONE): STRUCTURED_TEXT is
		local
			cmd: E_SHOW_CLIENTS
		do
			!! Result.make;
			!! cmd.make (c.e_class, Result);
			cmd.execute
		end;

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Searching for clients...")
		end;

end -- class SHOW_CLIENTS
