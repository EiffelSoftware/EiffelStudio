indexing

	description:	
		"Indexing clause of classes in the universe.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_INDEXING 

inherit

	LONG_FORMATTER
		redefine
			dark_symbol, display_temp_header, post_fix
		end

creation

	make
	
feature -- Properties

	symbol: PIXMAP is 
		once 
			Result := bm_Showindexing 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showindexing 
		end;

feature {NONE} -- Properties

	name: STRING is
		do
			Result := l_Showindexing
		end;

	title_part: STRING is
		do
			Result := l_Indexing_of
		end;

	post_fix: STRING is "ind";

	create_structured_text (c: CLASSC_STONE): STRUCTURED_TEXT is
			-- Show indexing clause of classes.
		local
			cmd: E_SHOW_INDEXING_CLAUSE;
		do
			!! Result.make;
			!! cmd.make (Result);
			cmd.execute;
		end;

feature {NONE} -- Implementation

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			tool.set_title ("Searching system for indexing clauses...")
		end;

end -- class SHOW_INDEXING
