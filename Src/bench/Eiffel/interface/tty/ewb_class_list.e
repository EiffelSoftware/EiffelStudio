-- List of the classes in the universe, in alphabetical order

class EWB_CLASS_LIST 

inherit

	EWB_CMD
		rename
			name as class_list_cmd_name,
			help_message as class_list_help,
			abbreviation as class_list_abb
		end

feature

	execute is
		do
			init_project;
			if not (error_occurred or project_is_new) then
				retrieve_project;
				if not error_occurred then
					display
				end;
			end;
		end;

	display is
			-- Show classes in universe
		local
			clusters: LINKED_LIST [CLUSTER_I];
			cursor: CURSOR;
			classes: EXTEND_TABLE [CLASS_I, STRING];
			sorted_classes: SORTED_TWO_WAY_LIST [CLASS_I];
			a_classi: CLASS_I;
			a_classc: CLASS_C;
		do
			clusters := Universe.clusters;
			if not clusters.empty then
				!!sorted_classes.make;
				from clusters.start until clusters.after loop
					cursor := clusters.cursor;
					classes := clusters.item.classes;
					from classes.start until classes.after loop
						sorted_classes.extend (classes.item_for_iteration);
						classes.forth
					end;
					clusters.go_to (cursor);
					clusters.forth
				end;
				from sorted_classes.start until sorted_classes.after loop
					a_classi := sorted_classes.item;
					a_classc := a_classi.compiled_class;
					if a_classc /= Void then
						a_classc.append_clickable_signature (output_window)
					else
						a_classi.append_clickable_name (output_window)
					end;
					output_window.new_line;
					output_window.put_string ("%T-- cluster: ");
					output_window.put_string (a_classi.cluster.cluster_name);
					output_window.new_line;
					sorted_classes.forth
				end
			end
		end;

end
