indexing

	description:	
		"Command to display flat form of a class.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_FLAT 

inherit

	FILTERABLE
		rename
			create_structured_text as flat_context_text
		redefine
			dark_symbol, display_temp_header, post_fix
		end;
	SHARED_SERVER;
	SHARED_FORMAT_TABLES

creation

	make
	
feature -- Properties

	symbol: PIXMAP is 
		once 
			Result := bm_Showflat 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showflat 
		end;
 
feature {NONE} -- Properties

	name: STRING is
		do
			Result := l_Showflat
		end;

	title_part: STRING is
		do
			Result := l_Flat_form_of
		end;
	
	post_fix: STRING is "fla";

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Exploring ancestors to produce flat form...")
		end;

end -- class SHOW_FLAT
