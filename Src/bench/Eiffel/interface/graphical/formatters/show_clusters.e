
-- Command to display clusters in lists.

class SHOW_CLUSTERS 

inherit

	SHARED_WORKBENCH;
	FORMATTER
		redefine
			file_name
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
			clusters: LINKED_LIST [CLUSTER_I];
			classes: EXTEND_TABLE [CLASS_I, STRING];
			sorted_class_names: SORTED_TWO_WAY_LIST [STRING];
			a_classi: CLASS_I;
			a_classc: CLASS_C;
		do
			clusters := Universe.clusters;
			if not clusters.empty then
				-- system has a universe
				from
					!!sorted_class_names.make;
					clusters.start
				until
					clusters.after
				loop
					text_window.put_string ("Cluster: ");
					text_window.put_string (clusters.item.cluster_name);
					if clusters.item.is_precompiled then
						text_window.put_string (" (Precompiled)")
					end;
					text_window.new_line;
					classes := clusters.item.classes;

					sorted_class_names.wipe_out;
					from
						classes.start
					until
						classes.offright
					loop
						sorted_class_names.add (classes.key_for_iteration);
						classes.forth
					end;
					from
						sorted_class_names.start
					until
						sorted_class_names.after
					loop
						text_window.put_char ('%T');
						a_classi := classes.item (sorted_class_names.item);
						a_classc := a_classi.compiled_class;
						if a_classc /= Void  then
							a_classc.append_clickable_signature (text_window);
						else
							a_classi.append_clickable_name (text_window);
							text_window.put_string ("  (not in system)");
						end;
						text_window.new_line;
						sorted_class_names.forth
					end;
					clusters.forth
				end
			end
		end

end
