indexing

	description:	
		"Command to display the short version of a class.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_SHORT

inherit

	FILTERABLE
		rename
			create_structured_text as short_context_text
		redefine
			dark_symbol, display_temp_header, post_fix
		end;
	SHARED_FORMAT_TABLES

creation

	make
	
feature -- Properties

	symbol: PIXMAP is 
		once 
			Result := bm_Showshort 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showshort 
		end;
 
feature {NONE} -- Properties

	name: STRING is
		do
			Result := l_Showshort
		end;

	title_part: STRING is
		do
			Result := l_Short_form_of
		end;

	post_fix: STRING is "sho";

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Producing short form...")
		end;

end -- class SHOW_SHORT
