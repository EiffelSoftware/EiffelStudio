indexing

	description: 
		"List of system clusters for Postscript generation.";
	date: "$Date$";
	revision: "$Revision $"

class PS_CLUSTER_LIST

inherit

	LINKED_LIST [PS_CLUSTER]

creation

	make

feature -- Access

	find_cluster (cluster: CLUSTER_DATA): PS_CLUSTER is
			-- PostScript cluster description associated with
			-- `cluster'
		require
			cluster /= void
		local
			cur: CURSOR
		do
			cur := cursor;
			from
				start
			until
				after or (Result /= void)
			loop
				if item.data = cluster then
					Result := item
				end;
				forth
			end;
			go_to (cur)
		end 

end -- class PS_CLUSTER_LIST
