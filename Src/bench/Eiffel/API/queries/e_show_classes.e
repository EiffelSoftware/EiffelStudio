indexing

	description: 
		"Command to display list of the classes in the%
		%universe, in alphabetical order.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_CLASSES

inherit

	E_CMD;
	SHARED_EIFFEL_PROJECT

creation

	make, do_nothing

feature -- Execution

	execute is
			-- Show classes in universe
		local
			clusters: LINKED_LIST [CLUSTER_I];
			cursor: CURSOR;
			classes: EXTEND_TABLE [CLASS_I, STRING];
			sorted_classes: SORTED_TWO_WAY_LIST [CLASS_I];
			a_classi: CLASS_I;
			a_classe: E_CLASS;
		do
			clusters := Eiffel_universe.clusters;
			if not clusters.empty then
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
					a_classe := a_classi.compiled_eclass;
					if a_classe /= Void then
						a_classe.append_clickable_signature (output_window)
					else
						a_classi.append_clickable_name (output_window)
					end;
					output_window.new_line;
					output_window.put_string ("%T-- Cluster: ");
					output_window.put_string (a_classi.cluster.cluster_name);
					output_window.new_line;
					sorted_classes.forth
				end
			end
		end;

end -- class E_SHOW_CLASSES
