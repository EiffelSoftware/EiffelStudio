-- Statistics

class SHOW_STATISTICS 

inherit

	SHARED_WORKBENCH;
	FORMATTER
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
			Result := bm_Showstatistics 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showstatistics
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Showstatistics end;

	title_part: STRING is do Result := l_Statistics_of end;

	file_name (stone: STONE): STRING is
		local
			filed_stone: FILED_STONE
		do
			filed_stone ?= stone;
			!!Result.make (0);
			if filed_stone /= Void then
				Result.append (filed_stone.file_name);
				Result.append (".");
				Result.append (post_fix) --| Should produce Ace.statistics
			end;
		end;
 
	display_info (i: INTEGER; c: CLASSC_STONE) is
			-- Show indexing clause of classes, in `text_window'.
		local
			ewb_statistics: EWB_STATISTICS
		do
			!! ewb_statistics;
			ewb_statistics.set_output_window (text_window)
			ewb_statistics.display
		end;

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			text_window.display_header ("Exploring system to compute statistics...")
		end;

end -- class SHOW_STATISTICS
