indexing

	description:	
		"Command to display class deferred routines.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_DEFERREDS 

inherit

	FORMATTER_2
		redefine
			dark_symbol, display_temp_header, post_fix
		end

creation

	make

feature -- Initialization

	make (a_text_window: CLASS_TEXT) is
		do
			init (a_text_window)
		end;

feature -- Properties

	symbol: PIXMAP is 
		once 
			Result := bm_Showdeferreds 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showdeferreds 
		end;
 
	
feature {NONE} -- Properties

	name: STRING is
		do
			Result := l_Showdeferreds
		end;

	title_part: STRING is
		do
			Result := l_Deferreds_of
		end;

	post_fix: STRING is "def";

feature {NONE} -- Implementation

	display_info (c: CLASSC_STONE) is
		local
			cmd: E_SHOW_DEFERRED_ROUTINES
		do
			!! cmd.make (c.e_class, text_window);
			cmd.execute
		end;

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			text_window.display_header ("Searching for deferred features...")
		end;

end -- class SHOW_DEFERREDS
