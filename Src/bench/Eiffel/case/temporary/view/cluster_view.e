indexing

	description: "View information for a given cluster.";
	date: "$Date$";
	revision: "$Revision $"

class CLUSTER_VIEW

inherit

	LINKABLE_VIEW
		rename
			update_data as linkable_update_data
		end;
	LINKABLE_VIEW
		redefine
			update_data
		select
			update_data
		end

creation

	make

feature {NONE} -- Initialization

	make (cluster_data: CLUSTER_DATA) is
			-- Initialize Current with `cluster_data' view.
		require
			valid_cluster_data: cluster_data /= Void;
		do
			update_from (cluster_data);
			height := cluster_data.height;
			icon_height := cluster_data.icon_height;
			icon_width := cluster_data.icon_width;
			is_icon := cluster_data.is_icon;
			tag_is_south := cluster_data.tag_is_south;
			tag_relative_x := cluster_data.tag_relative_x;
			width := cluster_data.width;
		ensure
			set_from_data:
				height = cluster_data.height and then
				icon_height = cluster_data.icon_height and then
				icon_width = cluster_data.icon_width and then
				is_icon = cluster_data.is_icon and then
				tag_is_south = cluster_data.tag_is_south and then
				tag_relative_x = cluster_data.tag_relative_x and then
				width = cluster_data.width
		end;

feature -- Properties

	is_icon: BOOLEAN;
			-- Is current cluster iconified ?

	tag_relative_x: INTEGER;
			-- Relative horizontal position of tag

	tag_is_south: BOOLEAN;
			-- Is tag located to the south of cluster

	width: INTEGER;
			-- Cluster's physical width on drawing area

	height: INTEGER;
			-- Cluster's physical height on drawing area

	icon_width: INTEGER;
			-- Cluster's physical icon_width on drawing area

	icon_height: INTEGER;
			-- Cluster's physical icon_height on drawing area

	classes: FIXED_LIST [CLASS_VIEW];
			-- Not needed (to be removed)

feature {CLUSTER_DATA, CLUSTER_CONTENT, LINKABLES_SCATTERING} -- Implementation

	update_data (cluster_data: CLUSTER_DATA) is
			-- Update Current from `cluster_data'.
		do
			linkable_update_data (cluster_data);
			cluster_data.set_cluster_details (Current);
		end;

end -- CLUSTER_VIEW
