indexing
	description: "Edit the descriptions of the clusters"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	CLUSTER_CHART_PAGE

inherit
	SYSTEM_CHART_PAGE
		redefine
			make
		end

creation
	make

feature -- Initialization

	make (noteb: EV_NOTEBOOK; ent: ANY) is
		do
			precursor ( noteb, ent )
			noteb.append_page(page, "System Chart")
			update_from(system.clusters_in_system)
		end

feature -- update

	update is
		do
			update_from(system.clusters_in_system)
		end

end -- class CLUSTER_CHART_PAGE
