
-- Command to display clusters in lists.

class SHOW_CLUSTERS 

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

	file_name (stone: STONE): STRING is
		local
			filed_stone: FILED_STONE
		do
			filed_stone ?= stone;
			!!Result.make (0);
			if filed_stone /= Void then
				Result.append (filed_stone.file_name);
				Result.append (".");
				Result.append (post_fix); --| Should produce Ace.clusters
			end;
		end;
 
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

end
