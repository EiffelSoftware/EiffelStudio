-- Indexing clause of classes in the universe.

class SHOW_INDEXING 

inherit

	SHARED_WORKBENCH;
	LONG_FORMATTER
		redefine
			file_name, dark_symbol, display_temp_header
		end

creation

	make
	
feature 

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is 
		do 
			init (c, a_text_window)
		end; 

	symbol: PIXMAP is 
		once 
			Result := bm_Showindexing 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showindexing 
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Showindexing end;

	title_part: STRING is do Result := l_Indexing_of end;

	file_name (stone: STONE): STRING is
		local
			filed_stone: FILED_STONE
		do
			filed_stone ?= stone;
			!!Result.make (0);
			if filed_stone /= Void then
				Result.append (filed_stone.file_name);
				Result.append (".");
				Result.append (post_fix) --| Should produce Ace.indexing
			end;
		end;
 
	display_info (i: INTEGER; c: CLASSC_STONE) is
			-- Show indexing clause of classes, in `text_window'.
		local
			ewb_indexing: EWB_INDEXING
		do
			!! ewb_indexing;
			ewb_indexing.set_output_window (text_window)
			ewb_indexing.display
		end;

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			text_window.display_header ("Searching system for indexing clauses...")
		end;

end -- class SHOW_INDEXING
