indexing

	description: 
		"Command to display list of the classes in the%
		%universe, in alphabetical order.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_CLASSES

inherit
	E_OUTPUT_CMD;
	SHARED_EIFFEL_PROJECT

creation
	make, do_nothing

feature -- Execution

	work is
			-- Show classes in universe
		local
			clusters: LINKED_LIST [CLUSTER_I];
			cursor: CURSOR;
			classes: HASH_TABLE [CLASS_I, STRING];
			sorted_classes: SORTED_TWO_WAY_LIST [CLASS_I];
			a_classi: CLASS_I;
			a_classe: CLASS_C;
		do
			clusters := Eiffel_universe.clusters;
			if not clusters.is_empty then
				!! sorted_classes.make;
				from 
					clusters.start 
				until 
					clusters.after 
				loop
					cursor := clusters.cursor;
					classes := clusters.item.classes;
					from 
						classes.start 
					until 
						classes.after 
					loop
						sorted_classes.put_front (classes.item_for_iteration);
						classes.forth
					end;
					clusters.go_to (cursor);
					clusters.forth
				end;
				sorted_classes.sort;
				from 
					sorted_classes.start 
				until 
					sorted_classes.after 
				loop
					a_classi := sorted_classes.item;
					a_classe := a_classi.compiled_class;
					if a_classe /= Void then
						a_classe.append_signature (structured_text)
					else
						a_classi.append_name (structured_text)
					end;
					structured_text.add_new_line;
					structured_text.add_indent;
					structured_text.add_string ("-- Cluster: ");
					structured_text.add_cluster (a_classi.cluster, a_classi.cluster.cluster_name);
					structured_text.add_new_line;
					sorted_classes.forth
				end
			end
		end;

end -- class E_SHOW_CLASSES
