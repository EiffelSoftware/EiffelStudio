indexing

	description: 
		"Abstraction of referencable data based on world coordinates.";
	date: "$Date$";
	revision: "$Revision $"

class COORD_XY_DATA

inherit

	DATA;

feature -- Properties

	x, y: INTEGER
			-- Current's coordinates relative to its containing cluster.

	parent_cluster: CLUSTER_DATA;
			-- Cluster containing Current

	is_in_system: BOOLEAN is
			-- is current handle in system ?
		do
			Result := parent_cluster /= Void
		end;

	relative_center (parent_cl: PS_CLUSTER): EC_COORD_XY is
			-- Center relative to parent cluster `parent_cl'
		do
			!! Result;
			Result.set (parent_cl.x + x,
					parent_cl.y + y)
		end

	stone_type: INTEGER is do end

	focus: STRING is do end

feature -- Setting

	set_x (new_x: like x) is
			-- Set linkable's horizontal coordinate
			-- relative to its containing cluster.
		do
			x := new_x
		ensure
			x = new_x
		end;

	set_y (new_y: like y) is
			-- Set linkable's vertical coordinate
			-- relative to its containing cluster.
		do
			y := new_y
		ensure
			y = new_y
		end;

	set (other: COORD_XY_DATA) is
			-- Copy `x', `y' and `parent_cluster' from `other'.
		require
			other /= void
		do
			x := other.x;
			y := other.y;
			parent_cluster := other.parent_cluster
		end;

	put_in_cluster (cluster: like parent_cluster) is
			-- Remove the linkable of `parent_cluster' if exists, and
			-- put the linkable in `cluster'
		require
			cluster_exists: cluster /= Void
		do
			parent_cluster := cluster
		ensure
			correctly_set :	cluster = parent_cluster
		end; -- put_in_cluster

feature {CLUSTER_CONTENT, REAL_HANDLE_VIEW, ADV_COM, S_HANDLES_FOR_REVERSE} -- Implementation

	set_parent_cluster (cluster: like parent_cluster) is
			-- Set parent_cluster to `cluster'.
		do
			parent_cluster := cluster
		ensure
			parent_cluster_set: parent_cluster = cluster
		end;

end -- class COORD_XY_DATA
