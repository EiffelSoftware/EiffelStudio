indexing

	description:	
		"Command to display class ancestors.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_ANCESTORS 

inherit

	FORMATTER_2
		redefine
			dark_symbol, display_temp_header, post_fix
		end

creation

	make
	
feature -- Initialization

	make (a_text_window: CLASS_TEXT) is
			-- Initialize the command. Default indentation is 4.
		do
			init (a_text_window);
			indent := 4
		ensure
			default_indent: indent = 4
		end;

feature -- Properties

	symbol: PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := bm_Showancestors 
		end;
 
	dark_symbol: PIXMAP is 
			-- Dark version of `symbol'.
		once 
			Result := bm_Dark_showancestors
		end;
 
feature {NONE} -- Properties

	name: STRING is
			-- Name of the command.
		do
			Result := l_Showancestors
		end;

	title_part: STRING is
		do
			Result := l_Ancestors_of
		end;

	post_fix: STRING is "anc";

feature {NONE} -- Implementation

	display_info (c: CLASSC_STONE) is
			-- Display parents of `c' in tree form.
		local
			cmd: E_SHOW_ANCESTORS
		do
			!! cmd.make (c.e_class, text_window);
			cmd.execute
		end;

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			text_window.display_header ("Searching for ancestors...")
		end;

end -- class SHOW_ANCESTORS
