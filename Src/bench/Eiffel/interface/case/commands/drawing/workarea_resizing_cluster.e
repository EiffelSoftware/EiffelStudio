indexing

	description: 
		"Abstract class for resizing clusters.";
	date: "$Date$";
	revision: "$Revision $"

deferred class WORKAREA_RESIZING_CLUSTER 

feature {NONE} -- Properties

	data: CLUSTER_DATA is
			-- data of resized cluster
		deferred
		end; -- data

	cluster: GRAPH_GROUP is
			-- resized cluster
		deferred
		end; -- cluster

	min_width, min_height: INTEGER;
			-- Minimal size of resized cluster

	max_height: INTEGER;
			-- Maximal size of resized cluster

	coin: INTEGER is
			-- Coin used to resize the cluster (1:ul, 2:ur, 3:dl, 4:dr)
		deferred
		end -- coin

feature {NONE} -- Implementation

	resize_cluster (rel_x, rel_y: INTEGER) is
			-- Resize 'cluster' with relative position
			-- `rel_x' and `rel_y'.
		require
			exists_cluster: cluster /= Void
		deferred
		end; -- resize_cluster

	relative_width (rel_x, rel_y: INTEGER): INTEGER is
			-- Width relative to `rel_x' and `rel_y'.
		require
			exists_cluster: cluster /= Void
		deferred
		end; -- relative_width

	relative_height (rel_y: INTEGER): INTEGER is
			-- Height relative to `rel_x' and `rel_y'.
		require
			exists_cluster: cluster /= Void
		deferred
		end; -- relative_height

end -- class WORKAREA_RESIZING_CLUSTER
