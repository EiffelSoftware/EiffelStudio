indexing

	description: 
		"Command to show the universe: clusters in class lists.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_CLUSTERS 

inherit

	E_CMD;
	SHARED_WORKBENCH

creation

	make, do_nothing

feature -- Execution

	execute is
			-- Show universe: clusters in class lists.
		local
			clusters: LINKED_LIST [CLUSTER_I];
			cursor: CURSOR;
			nb_of_classes: INTEGER;
			nb_of_clusters: INTEGER;
			root_cluster: CLUSTER_I
		do
			clusters := Universe.clusters;
			if not clusters.empty then
			
				nb_of_clusters := clusters.count;
				output_window.put_int (nb_of_clusters);
				if nb_of_clusters > 1 then
					output_window.put_string (" clusters containing ")
				else
					output_window.put_string (" cluster containing ")
				end;
				from clusters.start until clusters.after loop
					nb_of_classes := nb_of_classes + clusters.item.classes.count;
					clusters.forth
				end;
				output_window.put_int (nb_of_classes);
				if nb_of_classes > 1 then
					output_window.put_string (" classes");
				else
					output_window.put_string (" class");
				end;
				output_window.new_line;
				output_window.put_string ("root: ");
				System.root_class.compiled_class.append_clickable_signature (output_window);
				output_window.put_string (" (cluster: ");
				output_window.put_string (System.root_cluster.cluster_name);
				output_window.put_string (")");
				output_window.new_line;
				output_window.new_line;

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
			classes: EXTEND_TABLE [CLASS_I, STRING];
			sorted_class_names: SORTED_TWO_WAY_LIST [STRING];
			a_classi: CLASS_I;
			a_classc: CLASS_C;
			nb_of_classes: INTEGER
		do
			!!sorted_class_names.make;
			classes := cluster.classes;

			output_window.put_string ("Cluster: ");
			output_window.put_string (cluster.cluster_name);
			if cluster.is_precompiled then
				output_window.put_string (" (Precompiled, ")
			else
				output_window.put_string (" (")
			end;
			nb_of_classes := classes.count;
			output_window.put_int (nb_of_classes);
			if nb_of_classes > 1 then
				output_window.put_string (" classes)")
			else
				output_window.put_string (" class)")
			end;
			output_window.new_line;

			from
				classes.start
			until
				classes.after
			loop
				sorted_class_names.put_front (classes.key_for_iteration);
				classes.forth
			end;
			sorted_class_names.sort;
			from
				sorted_class_names.start
			until
				sorted_class_names.after
			loop
				output_window.put_char ('%T');
				a_classi := classes.item (sorted_class_names.item);
				a_classc := a_classi.compiled_class;
				if a_classc /= Void then
					a_classc.append_clickable_signature (output_window);
				else
					a_classi.append_clickable_name (output_window);
					output_window.put_string ("  (not in system)");
				end;
				output_window.new_line;
				sorted_class_names.forth
			end;
		end

end -- class E_SHOW_CLUSTERS
