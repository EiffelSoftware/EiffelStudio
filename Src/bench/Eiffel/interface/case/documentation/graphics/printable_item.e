indexing
	description: "Item for the Ace Window List"
	author: "Kolli Reda"
	date: "$Date$"
	revision: "$Revision$"

class
	PRINTABLE_ITEM

inherit
	EV_LIST_ITEM

creation
	make_spc

feature -- Initialization

	make_spc(list: EV_LIST; cl: CLUSTER_DATA) is
		-- Initialization
		require
			list_exists: list /= Void
			cluster_exists: cl /= Void
		do
			cluster := cl
			make_with_text(list,cluster.name)
		ensure
			cluster_set: cluster = cl	
		end

feature -- Implementation

	cluster: CLUSTER_DATA

end -- class PRINTABLE_ITEM
