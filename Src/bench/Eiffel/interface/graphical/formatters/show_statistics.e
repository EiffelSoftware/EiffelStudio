-- Statistics

class SHOW_STATISTICS 

inherit

	SHARED_WORKBENCH;
	FORMATTER
		redefine
			dark_symbol, display_temp_header, post_fix
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

	post_fix: STRING is "sta";

end -- class SHOW_STATISTICS
