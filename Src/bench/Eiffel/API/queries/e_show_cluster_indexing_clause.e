indexing
	description: 
		"Command to display indexing clause of classes in a cluster."
	date: "$Date$"
	revision: "$Revision $"

class
	E_SHOW_CLUSTER_INDEXING_CLAUSE

inherit
	E_CLUSTER_CMD
	SHARED_SERVER
		export 
			{NONE} all 
		end

creation

	make, do_nothing

feature -- Execution

	work is
			-- Show indexing clauses of clases in current cluster.
		local
			sorted_class_names: SORTED_TWO_WAY_LIST [STRING]
			classes: HASH_TABLE [CLASS_I, STRING]
			a_classi: CLASS_I
			a_class: CLASS_C
		do
			create sorted_class_names.make
			classes := current_cluster.classes
			from 
				classes.start 
			until 
				classes.after 
			loop
				sorted_class_names.put_front (classes.key_for_iteration)
				classes.forth
			end
			sorted_class_names.sort
			structured_text.add_string ("Cluster: ")
			structured_text.add_cluster (current_cluster, current_cluster.cluster_name)
			if current_cluster.is_precompiled then
				structured_text.add_string (" (Precompiled)")
			end
			structured_text.add_new_line
			from
				sorted_class_names.start
			until
				sorted_class_names.after
			loop
				structured_text.add_indent
				a_classi := classes.item (sorted_class_names.item)
				a_class := a_classi.compiled_class
				if a_class /= Void then
					a_class.append_signature (structured_text)
					display_indexing (a_class, structured_text)
				else
					a_classi.append_name (structured_text)
					structured_text.add_string ("  (not in system)")
				end
				structured_text.add_new_line
				sorted_class_names.forth
			end
		end

	display_indexing (e_class: CLASS_C; st: STRUCTURED_TEXT) is
			-- Display the indexing clause of `classc' if any.
		local
			indexes: EIFFEL_LIST [INDEX_AS]
			index_list: EIFFEL_LIST [ATOMIC_AS]
			index_tag: STRING
			index: INDEX_AS
			ast: CLASS_AS
		do
			ast := e_class.ast
			if ast /= Void then
				indexes := ast.indexes
				if indexes /= Void then
					from 
						indexes.start 
					until 
						indexes.after 
					loop
						index := indexes.item
						index_tag := index.tag
						if 
							index_tag /= Void and then
							(not index_tag.is_equal ("status") and
							not index_tag.is_equal ("date") and
							not index_tag.is_equal ("revision"))
						then
							structured_text.add_new_line
							structured_text.add_indent
							structured_text.add_indent
							structured_text.add_string (index_tag)
							structured_text.add_string (": ")
							index_list := index.index_list
							from 
								index_list.start 
							until 
								index_list.after 
							loop
								structured_text.add_string (index_list.item.string_value)
								if not index_list.islast then
									structured_text.add_string (", ")
								end
								index_list.forth
							end
						end
						indexes.forth
					end
				end
			end
		end

end -- class E_SHOW_CLUSTER_INDEXING_CLAUSE
