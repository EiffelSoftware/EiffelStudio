
-- Command to display clusters in lists.

class SHOW_CLUSTERS 

inherit

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
			Result := bm_Showclusters 
		end;
 
	dark_symbol: PIXMAP is 
		once 
			Result := bm_Dark_showclusters 
		end;
 
	
feature {NONE}

	command_name: STRING is do Result := l_Showclusters end;

	title_part: STRING is do Result := l_Clusters_of end;

	display_info (c: CLASSC_STONE) is
			-- Show universe: clusters in class lists, in `text_window'.
		local
			cmd: E_SHOW_CLUSTERS;
		do
			!! cmd.make (text_window);
			cmd.execute
		end;

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			text_window.display_header ("Exploring the system's clusters...")
		end;

	post_fix: STRING is "clu";

end
