indexing

	description: "List of cluster data.";
	date: "$Date$";
	revision: "$Revision $"

class CLUSTER_LIST

inherit

	LINKED_LIST [CLUSTER_DATA]

creation

	make

feature -- Storage

	store_information (storer: S_CLUSTER_DATA) is
		require
			valid_storer: storer /= Void;
			not_empty: not empty
		local
			clust_l: FIXED_LIST [S_CLUSTER_DATA];
		do
			if not empty then
				!! clust_l.make_filled (count);
				from
					start;
					clust_l.start
				until
					after
				loop
					clust_l.replace (item.storage_info);
					clust_l.forth;
					forth
				end
				storer.set_clusters (clust_l);
			end
		end;

end -- class CLUSTER_LIST
