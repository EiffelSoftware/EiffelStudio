indexing

	description:	
		"Command to display class external routines.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_EXTERNALS 

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
			Result := bm_Showexternals 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showexternals 
		end;

feature {NONE} -- Properties

	name: STRING is
		do
			Result := l_Showexternals
		end;

	title_part: STRING is
		do
			Result := l_Externals_of
		end;

	post_fix: STRING is "ext";

feature {NONE} -- Implementation

	display_info (c: CLASSC_STONE) is
		local
			cmd: E_SHOW_EXTERNALS
		do
			!! cmd.make (c.e_class, text_window);
			cmd.execute
		end;

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			text_window.display_header ("Searching for external features...")
		end;

end -- class SHOW_EXTERNALS
