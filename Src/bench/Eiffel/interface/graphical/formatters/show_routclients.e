indexing

	description:	
		"Command to display the routines clients.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_ROUTCLIENTS

inherit

	FORMATTER_2
		redefine
			dark_symbol, display_temp_header
		end;
	SHARED_SERVER

creation

	make
	
feature -- Initialization

	make (a_text_window: TEXT_WINDOW) is
		do
			init (a_text_window)
		end;

feature -- Properties

	symbol: PIXMAP is 
		once 
			Result := bm_Showcallers 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showcallers 
		end;
 
feature {NONE} -- Properties

	name: STRING is
		do
			Result := l_Showsenders
		end;

	title_part: STRING is
		do
			Result := l_Senders
		end;

feature {NONE} -- Implementation

	display_info (f: FEATURE_STONE)  is
			-- Display Senders of `c'.
		local
			cmd: E_SHOW_CALLERS;
		do
			!! cmd.make (f.e_feature, f.e_class, text_window);
			if cmd.has_valid_feature then
				cmd.execute
			end
		end;

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			text_window.display_header ("Searching system for callers...")
		end;

end -- class SHOW_ROUTCLIENTS
