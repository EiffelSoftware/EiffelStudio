
-- Command to display clusters in lists.

class SHOW_CLUSTERS 

inherit

	SHARED_WORKBENCH;
	LONG_FORMATTER
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

	display_info (i: INTEGER; c: CLASSC_STONE) is
			-- Show universe: clusters in class lists, in `text_window'.
		local
			ewb_clusters: EWB_CLUSTERS;
			clusters: LINKED_LIST [CLUSTER_I];
		do
			!! ewb_clusters;
			ewb_clusters.set_output_window (text_window)
			ewb_clusters.display
		end;

	display_temp_header (stone: STONE) is
			-- Display a temporary header during the format processing.
		do
			text_window.display_header ("Exploring the system's clusters...")
		end;

	post_fix: STRING is "clu";

end
