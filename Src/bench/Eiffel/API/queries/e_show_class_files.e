indexing
	description: "Command to display classes in the cluster,%
		%with their associated files"
	author: "Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	E_SHOW_CLASS_FILES

inherit
	E_CLUSTER_CMD

creation
	make, do_nothing

feature -- Execution

	work is
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
				structured_text.add_new_line
			else
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
					else
						a_classi.append_name (structured_text)
					end
					structured_text.add_string (" : ")		
					structured_text.add_string (a_classi.file_name)		
					structured_text.add_new_line
					sorted_class_names.forth
				end
			end
		end

end -- class E_SHOW_CLASS_FILES
