indexing

	description: 
		"Command to show the universe: clusters in class lists.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_CLUSTERS 

inherit

	E_OUTPUT_CMD;
	SHARED_EIFFEL_PROJECT

creation

	make, do_nothing

feature -- Execution

	work is
			-- Show universe: clusters in class lists.
		local
			clusters: LINKED_LIST [CLUSTER_I];
			cursor: CURSOR;
			nb_of_classes: INTEGER;
			nb_of_clusters: INTEGER;
		do
			clusters := Eiffel_universe.clusters;
			if not clusters.is_empty then
			
				nb_of_clusters := clusters.count;
				structured_text.add_int (nb_of_clusters);
				if nb_of_clusters > 1 then
					structured_text.add_string (" clusters containing ")
				else
					structured_text.add_string (" cluster containing ")
				end;
				from clusters.start until clusters.after loop
					nb_of_classes := nb_of_classes + clusters.item.classes.count;
					clusters.forth
				end;
				structured_text.add_int (nb_of_classes);
				if nb_of_classes > 1 then
					structured_text.add_string (" classes");
				else
					structured_text.add_string (" class");
				end;
				structured_text.add_new_line;
				structured_text.add_string ("root: ");
				Eiffel_system.root_class.compiled_class.append_signature (structured_text);
				structured_text.add_string (" (cluster: ");
				structured_text.add_cluster (
					Eiffel_system.root_cluster,
					Eiffel_system.root_cluster.cluster_name);
				structured_text.add_string (")");
				structured_text.add_new_line;
				structured_text.add_new_line;

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
			a_classe: CLASS_C;
			nb_of_classes: INTEGER;
		do
			!! sorted_class_names.make;
			classes := cluster.classes;

			structured_text.add_string ("Cluster: ");
			structured_text.add_cluster (cluster, cluster.cluster_name);
			if cluster.is_precompiled then
				structured_text.add_string (" (Precompiled, ")
			else
				structured_text.add_string (" (")
			end;
			nb_of_classes := classes.count;
			structured_text.add_int (nb_of_classes);
			if nb_of_classes > 1 then
				structured_text.add_string (" classes)")
			else
				structured_text.add_string (" class)")
			end;
			structured_text.add_new_line;

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
				structured_text.add_indent;
				a_classi := classes.item (sorted_class_names.item);
				a_classe := a_classi.compiled_class;
				if a_classe /= Void then
					a_classe.append_signature (structured_text);
				else
					a_classi.append_name (structured_text);
					structured_text.add_string ("  (not in system)");
				end;
				structured_text.add_new_line;
				sorted_class_names.forth
			end;
		end

end -- class E_SHOW_CLUSTERS
