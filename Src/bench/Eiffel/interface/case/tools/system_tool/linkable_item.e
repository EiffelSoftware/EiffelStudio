indexing
	description: "Item which points on a linkable data."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	LINKABLE_ITEM

inherit
	EV_LIST_ITEM

creation
	make_spc

feature -- Initialization

	make_spc (par: EV_LIST; linkab: LINKABLE_DATA) is
		require
			linkable_exists: linkab /= Void
		local
			s: STRING
			cl : CLUSTER_DATA
		do
			!! s.make ( 20 )
			if linkab.is_class then
				s.append("Class   ")
			else
				s.append("Cluster ")
			end
			s.append(linkab.name)
			cl ?= linkab
			if cl=Void or else not cl.is_root then
				s.append(" from Cluster ")
				s.append(linkab.parent_cluster.name)
			end
			make_with_text(par,s)
			linkable := linkab
		end

feature -- Implementation

	linkable : LINKABLE_DATA

invariant
	linkable_exists: linkable /= Void
end -- class LINKABLE_ITEM
