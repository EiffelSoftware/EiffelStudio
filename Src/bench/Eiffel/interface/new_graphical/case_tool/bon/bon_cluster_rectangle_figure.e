indexing
	description: "Rectangle figures used to display clusters in EiffelStudio diagram tool."
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	BON_CLUSTER_RECTANGLE_FIGURE

inherit
	EV_FIGURE_ROUNDED_RECTANGLE
		export
			{BON_CLUSTER_FIGURE} polygon_array
		end

create
	default_create,
	make_with_points

end -- class BON_CLUSTER_BODY_FIGURE
