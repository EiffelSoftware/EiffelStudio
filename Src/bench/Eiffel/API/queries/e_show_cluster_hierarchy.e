indexing

	description: 
		"Command to display hierarchical structure of the system.";
	date: "$Date$";
	revision: "$Revision $"

class E_SHOW_CLUSTER_HIERARCHY

inherit
	E_OUTPUT_CMD

	SHARED_EIFFEL_PROJECT

create
	make, do_nothing

feature -- Execution

	work is
			-- Show classes in universe
		do
			display_clusters (Eiffel_system.sub_clusters, 0)
		end;

feature {NONE} -- Implementation

	display_clusters (a_list: ARRAYED_LIST [CLUSTER_I]; indent: INTEGER) is
			-- Display the `a_list' of cluster to `structured_text'.
		local
			a_cluster: CLUSTER_I
		do
			from
				a_list.start
			until
				a_list.after
			loop
				add_tabs (structured_text, indent);
				a_cluster := a_list.item;
				structured_text.add_cluster (a_cluster, a_cluster.cluster_name);
				structured_text.add_new_line;
				display_clusters (a_cluster.sub_clusters, indent + 1)
				a_list.forth
			end
		end;

end -- class E_SHOW_CLUSTER_HIERARCHY
