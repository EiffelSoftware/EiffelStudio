-- Classes modified since last compilation.

class SHOW_MODIFS 

inherit

	SHARED_WORKBENCH;
	FORMATTER
		redefine
			file_name, dark_symbol
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
			Result := bm_Showmodifs 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showmodifs 
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Showmodifs end;

	title_part: STRING is do Result := l_Modifs_of end;

	file_name (stone: STONE): STRING is
		local
			filed_stone: FILED_STONE
		do
			filed_stone ?= stone;
			!!Result.make (0);
			if filed_stone /= Void then
				Result.append (filed_stone.file_name);
				Result.append (".");
				Result.append (post_fix) --| Should produce Ace.modifs
			end;
		end;
 
	display_info (i: INTEGER; c: CLASSC_STONE) is
			-- Show modified classes list, in `text_window'.
		local
			ewb_modifs: EWB_MODIFS
		do
			text_window.put_string ("Classes modified since last compilation:");
			text_window.new_line;
			text_window.new_line;
			!! ewb_modifs;
			ewb_modifs.set_output_window (text_window)
			ewb_modifs.display
		end;

end
