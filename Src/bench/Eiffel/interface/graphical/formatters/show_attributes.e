indexing

	description:	
		"Command to display class attributes.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_ATTRIBUTES 

inherit

	FILTERABLE
		redefine
			dark_symbol, display_temp_header, post_fix
		end

creation

	make
	
feature -- Initialization

	make (a_text_window: CLASS_TEXT) is
			-- Initialize the command.
		do
			init (a_text_window)
		end;

feature -- Properties

	symbol: PIXMAP is 
			-- Pixmap for the button.
		once 
			Result := bm_Showattributes 
		end;
 
	dark_symbol: PIXMAP is 
			-- Dark version of `symbol'.
		once 
			Result := bm_Dark_showattributes 
		end;
 
	
feature {NONE} -- Properties

	name: STRING is
			-- Name of the command.
		do
			Result := l_Showattributes
		end;

	title_part: STRING is
		do
			Result := l_Attributes_of
		end;

	post_fix: STRING is "att";

	create_structured_text (c: CLASSC_STONE): STRUCTURED_TEXT is
		local
			cmd: E_SHOW_ATTRIBUTES
		do
			!! Result.make;
			!! cmd.make (c.e_class, Result);
			cmd.execute
		end;

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			text_window.display_header ("Finding attributes...")
		end;

end -- SHOW_ATTRIBUTES
