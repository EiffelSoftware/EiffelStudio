indexing

	description:	
		"Command to display class routines.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_ROUTINES 

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
			Result := bm_Showroutines 
		end;
	
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showroutines 
		end;
	
feature {NONE} -- Properties

	name: STRING is
		do
			Result := l_Showroutines
		end;

	title_part: STRING is
		do
			Result := l_Routines_of
		end;

	post_fix: STRING is "rou";

	create_structured_text (c: CLASSC_STONE): STRUCTURED_TEXT is
		local
			cmd: E_SHOW_ROUTINES;
		do
			!! Result.make;
			!! cmd.make (c.e_class, Result);
			cmd.execute
		end;

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Searching for routines...")
		end;

end -- class SHOW_ROUTINES
