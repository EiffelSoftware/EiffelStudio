indexing

	description: 
		"Abstraction of cluster according to postscript generation.";
	date: "$Date$";
	revision: "$Revision $"

class PS_CLUSTER

creation

	make

feature -- Initialization

	make (a_cluster: CLUSTER_DATA; a_x, a_y: INTEGER) is
			-- Make a cluster description for `a_cluster'.
			-- Absolute coordinates are `a_x' and `a_y'.
		require
			has_cluster_associated: a_cluster /= void;
			x_positive: a_x >= 0;
			y_positive: a_y >= 0
		do
			data := a_cluster;
			x := a_x;
			y := a_y
		ensure
			data_correctly_set: data = a_cluster;
			x_correctly_set: x = a_x;
			y_correctly_set: y = a_y
		end -- make

feature -- Properties

	data: CLUSTER_DATA;
			-- Cluster associated

	x, y: INTEGER
			-- Absolute coordinates

invariant

	has_cluster_associated: data /= void;
	x_positive: x >= 0;
	y_positive: y >= 0

end -- class PS_CLUSTER
