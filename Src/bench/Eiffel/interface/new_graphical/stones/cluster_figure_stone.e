indexing
	description: "CLUSTER_STONEs that originate from a CLUSTER_FIGURE."
	date: "$Date$"
	revision: "$Revision$"

class
	CLUSTER_FIGURE_STONE

inherit
	CLUSTER_STONE
		rename
			make as make_with_cluster
		end

create
	make

feature {NONE} -- Initialization

	make (a_figure: CLUSTER_FIGURE) is
		do
			make_with_cluster (a_figure.cluster_i)
			source := a_figure
		end

feature -- Access

	source: CLUSTER_FIGURE
			-- Source this stone was picked from.

end -- class CLUSTER_FIGURE_STONE
