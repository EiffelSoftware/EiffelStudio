indexing

	description: 
		"Command to display indexing clause of classes in the universe.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_INDEXING_CLAUSE

inherit

	E_CMD;
	SHARED_SERVER
		export 
			{NONE} all 
		end

creation

	make, do_nothing

feature -- Execution

	execute is
			-- Show indexing clauses of clases in universe.
		local
			clusters: LINKED_LIST [CLUSTER_I];
			cursor: CURSOR
		do
			clusters := Universe.clusters;
			from 
				clusters.start 
			until 
				clusters.after 
			loop
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
			a_class: E_CLASS;
		do
			!!sorted_class_names.make;
			classes := cluster.classes;
			from 
				classes.start 
			until 
				classes.after 
			loop
				sorted_class_names.put_front (classes.key_for_iteration);
				classes.forth
			end;
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
				a_class := a_classi.compiled_eclass;
				if a_class /= Void then
					a_class.append_clickable_signature (output_window);
					display_indexing (a_class)
				else
					a_classi.append_clickable_name (output_window);
					output_window.put_string ("  (not in system)")
				end;
				output_window.new_line;
				sorted_class_names.forth
			end
		end;

	display_indexing (e_class: E_CLASS) is
			-- Display the indexing clause of `classc' if any.
		local
			indexes: EIFFEL_LIST [INDEX_AS];
			index_list: EIFFEL_LIST [ATOMIC_AS];
			index_tag: STRING;
			index: INDEX_AS;
			ast: CLASS_AS
		do
			ast := e_class.ast;
			if ast /= Void then
				indexes := ast.indexes;
				if indexes /= Void then
					from 
						indexes.start 
					until 
						indexes.after 
					loop
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
							from 
								index_list.start 
							until 
								index_list.after 
							loop
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

end -- class E_SHOW_INDEXING_CLAUSE
