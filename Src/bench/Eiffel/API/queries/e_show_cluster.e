indexing
	description:
		"Command to show the a cluster in class list."
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	E_SHOW_CLUSTER

inherit

	E_CLUSTER_CMD
	SHARED_EIFFEL_PROJECT

creation

	make, do_nothing

feature -- Execution

	work is
			-- Show cluster in class lists.
		local
			classes: EXTEND_TABLE [CLASS_I, STRING]
			sorted_class_names: SORTED_TWO_WAY_LIST [STRING]
			a_classi: CLASS_I
			a_classe: CLASS_C
			nb_of_classes: INTEGER
		do
			create sorted_class_names.make
			classes := current_cluster.classes

			structured_text.add_string ("Cluster: ")
			structured_text.add_cluster (current_cluster, current_cluster.cluster_name)
			if current_cluster.is_precompiled then
				structured_text.add_string (" (Precompiled, ")
			else
				structured_text.add_string (" (")
			end
			nb_of_classes := classes.count
			structured_text.add_int (nb_of_classes)
			if nb_of_classes > 1 then
				structured_text.add_string (" classes)")
			else
				structured_text.add_string (" class)")
			end
			structured_text.add_new_line

			from
				classes.start
			until
				classes.after
			loop
				sorted_class_names.put_front (classes.key_for_iteration)
				classes.forth
			end
			sorted_class_names.sort
			from
				sorted_class_names.start
			until
				sorted_class_names.after
			loop
				structured_text.add_indent
				a_classi := classes.item (sorted_class_names.item)
				a_classe := a_classi.compiled_class
				if a_classe /= Void then
					a_classe.append_signature (structured_text)
				else
					a_classi.append_name (structured_text)
					structured_text.add_string ("  (not in system)")
				end
				structured_text.add_new_line
				sorted_class_names.forth
			end
		end

end -- class E_SHOW_CLUSTER
