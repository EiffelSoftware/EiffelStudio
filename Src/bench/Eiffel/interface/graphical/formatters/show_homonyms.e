indexing

	description:	
		"Command to display the homonyms of the routine.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_HOMONYMS

inherit

	LONG_FORMATTER
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

feature -- Porperties

	symbol: PIXMAP is 
		once 
			Result := bm_Showhomonyms 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showhomonyms 
		end;
 
feature {NONE} -- Properties

	name: STRING is
		do
			Result := l_Showhomonyms
		end;

	title_part: STRING is
		do
			Result := l_Homonyms_of
		end;

feature {NONE} -- Implementation

	display_info (f: FEATURE_STONE)  is
			-- Display homonyms of the routine.
		local
			cmd: E_SHOW_ROUTINE_HOMONYMNS;
		do
			!! cmd.make (f.e_feature, f.e_class, text_window);
			cmd.execute
		end;

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			text_window.display_header ("Searching system for homonyms...")
		end;

end -- class SHOW_HOMONYMS
