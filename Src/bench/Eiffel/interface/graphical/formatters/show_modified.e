-- Classes modified since last compilation.

class SHOW_MODIFIED 

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
			init (c, a_text_window);
			do_format := true
		end; 

	symbol: PIXMAP is 
		once 
			Result := bm_Showmodified 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showmodified 
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Showmodified end;

	title_part: STRING is do Result := l_Modified_of end;

	display_info (i: INTEGER; c: CLASSC_STONE) is
			-- Show modified classes list, in `text_window'.
		local
			ewb_modified: EWB_MODIFIED
		do
			text_window.put_string ("Classes modified since last compilation:");
			text_window.new_line;
			text_window.new_line;
			!! ewb_modified;
			ewb_modified.set_output_window (text_window)
			ewb_modified.display
		end;

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			text_window.display_header ("Searching system for modified classes...")
		end;

	post_fix: STRING is "mod";

end
