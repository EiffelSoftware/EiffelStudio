indexing

	description:	
		"Command to display exported features of a class.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_EXPORTED

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
			Result := bm_Showexported 
		end;
	
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showexported 
		end;
	
feature {NONE} -- Properties

	name: STRING is
		do
			Result := l_Showexported
		end;

	title_part: STRING is
		do
			Result := l_Exported_of
		end;

	post_fix: STRING is "exp";

	create_structured_text (c: CLASSC_STONE): STRUCTURED_TEXT is
		local
			cmd: E_SHOW_EXPORTED_ROUTINES
		do
			!! Result.make;
			!! cmd.make (c.e_class, Result);
			cmd.execute
		end;

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Searching for exported features...")
		end;

end -- class SHOW_EXPORTED
