indexing

	description:	
		"Command to display class onces.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_ONCES 

inherit

	FILTERABLE
		redefine
			dark_symbol, display_temp_header, post_fix
		end

creation

	make

feature -- Properties

	symbol: PIXMAP is 
		once 
			Result := bm_Showonces 
		end;
	
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showonces 
		end;
	
feature {NONE} -- Properties

	name: STRING is
		do
			Result := l_Showonces
		end;

	title_part: STRING is
		do
			Result := l_Onces_of
		end;

	post_fix: STRING is "onc";

	create_structured_text (c: CLASSC_STONE): STRUCTURED_TEXT is
		local
			cmd: E_SHOW_ONCES
		do
			!! Result.make;
			!! cmd.make (c.e_class, Result);
			cmd.execute
		end;

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Searching for once routines...")
		end;

end -- class SHOW_ONCES
