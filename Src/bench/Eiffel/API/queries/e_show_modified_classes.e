indexing

	description: 
		"Command to display modified classes since last compilation.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_MODIFIED_CLASSES

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
		do
			structured_text.add_string ("Classes modified since last compilation");
			structured_text.add_new_line;
			structured_text.add_new_line;
			clusters := Eiffel_universe.clusters;
			if not clusters.is_empty then
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
			end
		end;

feature {NONE} -- Implementation

	display_a_cluster (cluster: CLUSTER_I) is
		local
			sorted_class_names: SORTED_TWO_WAY_LIST [STRING];
			classes: HASH_TABLE [CLASS_I, STRING];
			a_classi: CLASS_I;
			a_classe: CLASS_C
		do
			!! sorted_class_names.make;
			classes := cluster.classes;
			from 
				classes.start 
			until 
				classes.after 
			loop
				if classes.item_for_iteration.date_has_changed then
					sorted_class_names.put_front (classes.key_for_iteration)
				end;
				classes.forth
			end;
			if not sorted_class_names.is_empty then
				sorted_class_names.sort;
				structured_text.add_string ("Cluster: ");
				structured_text.add_string (cluster.cluster_name);
				if cluster.is_precompiled then
					structured_text.add_string (" (Precompiled)")
				end;
				structured_text.add_new_line;
				from
					sorted_class_names.start
				until
					sorted_class_names.after
				loop
					structured_text.add_indent;
					a_classi := classes.item (sorted_class_names.item);
					a_classe := a_classi.compiled_class;
					if a_classe /= Void then
						a_classe.append_signature (structured_text)
					else
						a_classi.append_name (structured_text);
						structured_text.add_string ("  (not in system)")
					end;
					structured_text.add_new_line;
					sorted_class_names.forth
				end
			end;
		end;

end -- class E_SHOW_MODIFIED_CLASSES
