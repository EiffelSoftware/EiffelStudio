-- Indexing clause of classes in the universe.

class EWB_INDEXING

inherit

	EWB_CMD
		rename
			name as indexing_cmd_name, 
			help_message as indexing_help, 
			abbreviation as indexing_abb
		end;

	SHARED_SERVER
		export {NONE} all end

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
			-- Show indexing clauses of clases in universe.
		local
			clusters: LINKED_LIST [CLUSTER_I];
			cursor: CURSOR
		do
			clusters := Universe.clusters;
			from clusters.start until clusters.after loop
				cursor := clusters.cursor;
				display_a_cluster (clusters.item);
				clusters.go_to (cursor);
				clusters.forth
			end
		end;

	display_a_cluster (cluster: CLUSTER_I) is
		local
			sorted_class_names: SORTED_TWO_WAY_LIST [STRING];
			classes: EXTEND_TABLE [CLASS_I, STRING];
			a_classi: CLASS_I;
			a_classc: CLASS_C;
		do
			!!sorted_class_names.make;
			classes := cluster.classes;
			from classes.start until classes.after loop
				sorted_class_names.extend (classes.key_for_iteration);
				classes.forth
			end;
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
				if a_classc /= Void then
					a_classc.append_clickable_signature (output_window);
					display_indexing (a_classc)
				else
					a_classi.append_clickable_name (output_window);
					output_window.put_string ("  (not in system)")
				end;
				output_window.new_line;
				sorted_class_names.forth
			end
		end;

	display_indexing (classc: CLASS_C) is
			-- Display the indexing clause of `classc' if any.
		local
			indexes: EIFFEL_LIST [INDEX_AS];
			index_list: EIFFEL_LIST [ATOMIC_AS];
			index_tag: STRING;
			index: INDEX_AS
		do
			if Ast_server.has (classc.id) then
				indexes := Ast_server.item (classc.id).indexes;
				if indexes /= Void then
					from indexes.start until indexes.after loop
						index := indexes.item;
						index_tag := index.tag;
						if 
							index_tag /= Void and then
							(not index_tag.is_equal ("status") and
							not index_tag.is_equal ("date") and
							not index_tag.is_equal ("revision"))
						then
							output_window.put_string ("%N%T%T");
							output_window.put_string (index_tag);
							output_window.put_string (": ")
							index_list := index.index_list;
							from index_list.start until index_list.after loop
								output_window.put_string (index_list.item.string_value);
								if not index_list.islast then
									output_window.put_string (", ")
								end;
								index_list.forth
							end
						end;
						indexes.forth
					end
				end
			end
		end;

end -- class EWB_INDEXING
