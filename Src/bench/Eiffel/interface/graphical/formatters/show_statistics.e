indexing

	description:	
		"Statistics";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_STATISTICS 

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
			Result := bm_Showstatistics 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showstatistics
		end;
 
feature {NONE} -- Properties

	name: STRING is
		do
			Result := l_Showstatistics
		end;

	title_part: STRING is
		do
			Result := l_Statistics_of
		end;

	post_fix: STRING is "sta";

	create_structured_text (c: CLASSC_STONE): STRUCTURED_TEXT is
			-- Show statistics about the system.
		local
			cmd: E_SHOW_STATISTICS
		do
			!! Result.make;
			!! cmd.make (Result);
			cmd.execute
		end;

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Exploring system to compute statistics...")
		end;

end -- class SHOW_STATISTICS
