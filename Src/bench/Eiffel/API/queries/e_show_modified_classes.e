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

	execute is
			-- Show universe: clusters in class lists.
		local
			clusters: LINKED_LIST [CLUSTER_I];
			cursor: CURSOR;
		do
			clusters := Eiffel_universe.clusters;
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
			end
		end;

feature {NONE} -- Implementation

	display_a_cluster (cluster: CLUSTER_I) is
		local
			sorted_class_names: SORTED_TWO_WAY_LIST [STRING];
			classes: EXTEND_TABLE [CLASS_I, STRING];
			a_classi: CLASS_I;
			a_classe: E_CLASS
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
			if not sorted_class_names.empty then
				sorted_class_names.sort;
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
					a_classe := a_classi.compiled_eclass;
					if a_classe /= Void then
						a_classe.append_signature (output_window)
					else
						a_classi.append_name (output_window);
						output_window.put_string ("  (not in system)")
					end;
					output_window.new_line;
					sorted_class_names.forth
				end
			end
		end;

end -- class E_SHOW_MODIFIED_CLASSES
