indexing

	description: 
		"Command for moving the cluster tag.";
	date: "$Date$";
	revision: "$Revision $"

class WORKAREA_MOVE_TAG_COM 

inherit

	WORKAREA_MOVE_DATA_COM

creation

	make

feature -- Execution

	execute_button_release (notused: NONE; butrel_data: EV_BUTTON_EVENT_DATA) is
			-- Called when the mouse button is released.
		local
			move_cluster_tag_u: MOVE_CLUSTER_TAG_U
		do
			workarea.drawing_area.remove_motion_notify_commands
			workarea.drawing_area.remove_button_release_commands (1)
			if moving then
				erase
				if cluster.data.tag_is_south then
					!!move_cluster_tag_u.make
						(cluster.data, relative_x-start_rel_x,
						relative_y-start_rel_y < -(cluster.data.height // 2))
				else
					!!move_cluster_tag_u.make
						(cluster.data, relative_x-start_rel_x,
						relative_y-start_rel_y > (cluster.data.height // 2))
				end;
				moving := false
			end
		end

feature {NONE} -- Properties

	cluster: GRAPH_CLUSTER;
			-- Cluster to modify

feature {WORKAREA_SELECT_COM} -- Setting

	set_cluster (a_cluster: like cluster) is
			-- Set the cluster to modify
		require
			a_cluster_exists: a_cluster /= void
		do
			cluster := a_cluster
		ensure
			cluster = a_cluster
		end;

feature {NONE} -- Implementation

	draw is
			-- Draw figures
		local
			maximal_move : INTEGER;
			new_position_x : INTEGER;
		do
			new_position_x := relative_x - start_rel_x + 
				cluster.data.tag_relative_x;
			maximal_move := cluster.data.width - cluster.cluster_tag_width;
			if new_position_x > maximal_move then
				relative_x := maximal_move + start_rel_x - 
					cluster.data.tag_relative_x;
			elseif new_position_x < 0 then
				relative_x := start_rel_x - cluster.data.tag_relative_x;
			end;

			if cluster.data.tag_is_south then
				cluster.invert_tag (workarea.inverted_painter, relative_x - start_rel_x,
					relative_y-start_rel_y > -(cluster.data.height // 2))
			else
				cluster.invert_tag (workarea.inverted_painter, relative_x - start_rel_x,
					relative_y-start_rel_y > (cluster.data.height // 2))
			end
		end;

	erase is
			-- Erase figures
		do
			draw
		end

end -- class WORKAREA_MOVE_TAG_COM
