-- Classes modified since last compilation.

class EWB_MODIFIED

inherit

	EWB_CMD
		rename
			name as modified_cmd_name, 
			help_message as modified_help, 
			abbreviation as modified_abb
		end

feature

	execute is
		do
			init_project;
			if not (error_occurred or project_is_new) then
				retrieve_project;
				if not error_occurred then
					display
				end
			end
		end;

	display is
			-- Show universe: clusters in class lists.
		local
			clusters: LINKED_LIST [CLUSTER_I];
			cursor: CURSOR;
		do
			clusters := Universe.clusters;
			if not clusters.empty then
					--| Skip precompile clusters for now
				from
					clusters.start
				until
					clusters.after or else not (clusters.item.is_precompiled)
				loop
					clusters.forth
				end;
				from
					--| Print user defined clusters
				until
					clusters.after
				loop
					cursor := clusters.cursor;
					display_a_cluster (clusters.item);
					clusters.go_to (cursor);
					clusters.forth
				end
				from
					--| Print precompiled clusters.
					clusters.start
				until
					clusters.after or else not (clusters.item.is_precompiled)
				loop
					cursor := clusters.cursor;
					display_a_cluster (clusters.item)
					clusters.go_to (cursor);
					clusters.forth
				end
			end
		end;

	display_a_cluster (cluster: CLUSTER_I) is
		local
			sorted_class_names: SORTED_TWO_WAY_LIST [STRING];
			classes: EXTEND_TABLE [CLASS_I, STRING];
			a_classi: CLASS_I;
			a_classc: CLASS_C
		do
			!!sorted_class_names.make;
			classes := cluster.classes;
			from classes.start until classes.after loop
				if classes.item_for_iteration.date_has_changed then
					sorted_class_names.extend (classes.key_for_iteration)
				end;
				classes.forth
			end;
			if not sorted_class_names.empty then
				output_window.put_string ("Cluster: ");
				output_window.put_string (cluster.cluster_name);
				if cluster.is_precompiled then
					output_window.put_string (" (Precompiled)")
				end;
				output_window.new_line;
				from
					sorted_class_names.start
				until
					sorted_class_names.after
				loop
					output_window.put_string ("%T");
					a_classi := classes.item (sorted_class_names.item);
					a_classc := a_classi.compiled_class;
					if a_classc /= Void  then
						a_classc.append_clickable_signature (output_window)
					else
						a_classi.append_clickable_name (output_window);
						output_window.put_string ("  (not in system)")
					end;
					output_window.new_line;
					sorted_class_names.forth
				end
			end
		end;

end -- class EWB_MODIFIED
