indexing

	description: 
		"Specify action of moving and dragging a cluster on workarea.";
	date: "$Date$";
	revision: "$Revision $"

class WORKAREA_MOVE_CLUSTER_COM

inherit

	WORKAREA_MOVE_DATUM_COM
		redefine
			data_moved, move_data
		end;
	CONSTANTS

creation

	make

feature -- Properties

	data_moved: GRAPH_CLUSTER
			-- Cluster moved

	no_icon: INTEGER is 1;

feature {NONE} -- Implementation

	move_data (rel_x, rel_y: INTEGER) is
			-- Move `data_moved`.
		local
			move_figure: MOVE_CLUSTER_U;
			reparent_figure: REPARENT_CLUSTER_U;
			parent_group: GRAPH_GROUP;
			x_coord, y_coord: INTEGER;
			a_new_content : LINKED_LIST[LINKABLE_DATA]
	do
			x_coord := align_grid (data_moved.local_x - start_rel_x + rel_x);
			y_coord := align_grid (data_moved.local_y - start_rel_y + rel_y);
			parent_group := workarea.cluster_at (x_coord, y_coord);
			if parent_group /= Void and then 
				parent_group.data = data_moved.data
			then
				parent_group ?= workarea.find
							(data_moved.data.parent_cluster)
			end;
			if parent_group = void then
				parent_group := workarea
			end
			if (parent_group = data_moved.parent_group) then
				!!move_figure.make
					(data_moved.data,
					x_coord - data_moved.local_x,
					y_coord - data_moved.local_y)
					workarea.unselect_all_without_update
			else
				if not data_moved.data.contains_linkable (parent_group.data) then
					!!reparent_figure.make
						(data_moved.data,
						parent_group.data,
						x_coord - parent_group.local_x,
						y_coord - parent_group.local_y)
						workarea.unselect_all_without_update
				else
			--		Windows.error
			--			(pointed_workarea.analysis_window,
			--			Message_keys.Cluster_moved_into_content_er,
			--			Void);
				end
			end
	end

end -- class WORKAREA_MOVE_CLUSTER_COM
