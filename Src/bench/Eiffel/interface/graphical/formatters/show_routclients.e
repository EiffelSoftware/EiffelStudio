indexing

	description:	
		"Command to display the routines clients.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_ROUTCLIENTS

inherit

	FILTERABLE
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

	create_structured_text (f: FEATURE_STONE): STRUCTURED_TEXT is
			-- Display Senders of `f`.
		local
			cmd: E_SHOW_CALLERS;
		do
			!! Result.make;
			!! cmd.make (f.e_feature, f.e_class, Result);
			-- **** FIXME make this configurable
			cmd.set_all_callers;
			if cmd.has_valid_feature then
				cmd.execute
			end
		end;

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Searching system for callers...")
		end;

end -- class SHOW_ROUTCLIENTS
