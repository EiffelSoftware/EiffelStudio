indexing
	description: "";
	date: "$Date$";
	revision: "$Revision$"

class 
	SCROLLABLE_LIST_CLUSTERS

inherit 
	SCROLLABLE_LIST_ELEMENT

creation
	make

feature

	make (c: CLUSTER_I) is 
		do
			value := clone (c.cluster_name)
			cluster := c
		end

	value : STRING

	cluster : CLUSTER_I

end -- class SCROLLABLE_LIST_CLUSTERS
