indexing

	description:	
		"Command to display class external routines.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_EXTERNALS 

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

	create_structured_text (c: CLASSC_STONE): STRUCTURED_TEXT is
		local
			cmd: E_SHOW_EXTERNALS
		do
			!! Result.make;
			!! cmd.make (c.e_class, Result);
			cmd.execute
		end;

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Searching for external features...")
		end;

end -- class SHOW_EXTERNALS
