indexing

	description:	
		"Classes modified since last compilation.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_MODIFIED 

inherit

	FORMATTER
		redefine
			dark_symbol, display_temp_header, post_fix
		end

creation

	make
	
feature -- Initialization

	make (a_text_window: TEXT_WINDOW) is 
		do 
			init (a_text_window);
			do_format := true
		end; 

feature -- Properties

	symbol: PIXMAP is 
		once 
			Result := bm_Showmodified 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showmodified 
		end;
 
	
feature {NONE} -- Properties

	name: STRING is
		do
			Result := l_Showmodified
		end;

	title_part: STRING is
		do
			Result := l_Modified_of
		end;

	post_fix: STRING is "mod";

feature {NONE} -- Implementation

	display_info (c: CLASSC_STONE) is
			-- Show modified classes list, in `text_window'.
		local
			cmd: E_SHOW_MODIFIED_CLASSES
		do
			text_window.put_string ("Classes modified since last compilation:");
			text_window.new_line;
			text_window.new_line;
			!! cmd.make (text_window);
			cmd.execute
		end;

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			text_window.display_header ("Searching system for modified classes...")
		end;

end -- class SHOW_MODIFIED
