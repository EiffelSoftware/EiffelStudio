indexing

	description: 
		"Command to resize the cluster area.";
	date: "$Date$";
	revision: "$Revision $"

class WORKAREA_RESIZE_CLUSTER_COM 

inherit

	WORKAREA_RESIZING_CLUSTER;
	WORKAREA_MOVE_DATA_COM;
	CONSTANTS

creation

	make

feature -- Execution

	execute_button_release (notused: NONE; butrel_data:  EV_BUTTON_EVENT_DATA) is
			-- Called when the mouse button is released.
		do
			workarea.drawing_area.remove_motion_notify_commands 
			workarea.drawing_area.remove_button_release_commands(1)
			if moving then
				erase
				resize_cluster (
					relative_width (
						align_grid (relative_x-start_rel_x),
						align_grid (relative_y-start_rel_y)),
					relative_height (align_grid (relative_y-start_rel_y)))
				moving := false
			end;
			cluster := void
		ensure then
			cluster = void
		end

feature {NONE} -- Implementation properties

	cluster: GRAPH_CLUSTER;
			-- Cluster to resize

	data: CLUSTER_DATA is
			-- `cluster'.data
		do
			Result := cluster.data
		end;

	coin: INTEGER
			-- Coin used to resize the cluster (1:ul, 2:ur, 3:dl, 4:dr)

feature {WORKAREA_SELECT_COM} -- Setting

	set_cluster (a_cluster: like cluster; a_coin: like coin) is
			-- Set the cluster to resize
		require
			has_cluster: a_cluster /= void
		do
			cluster := a_cluster;
			coin := a_coin;
			min_width := data.minimal_width;
			if min_width < cluster.cluster_tag_width then
				min_width := cluster.cluster_tag_width
			end;
			min_height := data.minimal_height;
			if coin = 1 then
				max_height :=
					data.maximal_top_extend (data.x+data.width-min_width, min_width)
			elseif coin = 2 then
				max_height :=
					data.maximal_top_extend (data.x, min_width)
			elseif coin = 3 then
				max_height :=
					data.maximal_bottom_extend(data.x+data.width-min_width,min_width)
			else
				max_height :=
					data.maximal_bottom_extend (data.x, min_width)
			end
		ensure
			correctly_set: cluster = a_cluster
		end

feature {NONE} -- Implementation

	draw is
		do
			cluster.invert_skeleton_resize (workarea.inverted_painter, coin,
				relative_width (relative_x-start_rel_x, relative_y-start_rel_y),
				relative_height (relative_y-start_rel_y))
		end;

	erase is
		do
			draw
		end

	resize_cluster (rel_x, rel_y: INTEGER) is
			-- Resize `cluster'
		require else
			exists_cluster: cluster /= void
		local
			resize_undoable: RESIZE_CLUSTER_U;
			a_new_content: LINKED_LIST[LINKABLE_DATA];
			rel_x1, rel_y1: INTEGER
		do
			if (rel_x /= 0) or (rel_y /= 0) then
			if coin = 1 then
				rel_x1 := data.x - rel_x;
				rel_y1 := data.y - rel_y
			elseif coin = 2 then
				rel_x1 := data.x;
				rel_y1 := data.y - rel_y
			elseif coin = 3 then
				rel_x1 := data.x - rel_x;
				rel_y1 := data.y
			else
				rel_x1 := data.x;
				rel_y1 := data.y
			end;
			a_new_content := data.parent_cluster.new_content_area (
					rel_x1, rel_y1,
					data.width + rel_x,
					data.height + rel_y,
					data);
			if a_new_content = Void then
		--		Windows.error (workarea.analysis_window, Message_keys.resize_cluster_er, Void)
			elseif a_new_content.empty then
				!!resize_undoable.make (data, coin, rel_x, rel_y)
			else
				!!resize_undoable.make_with_figures (data, coin, rel_x, rel_y, a_new_content)
			end;
		end
	end;

	relative_width (rel_x, rel_y: INTEGER): INTEGER is
		require else
			exists_cluster: cluster /= void
		local
			max_width: INTEGER
		do
			if (coin \\ 2) = 1 then
				Result := -rel_x
			else
				Result := rel_x
			end;
			if data.width+Result < min_width then
				Result := min_width-data.width
			end;
			if coin = 1 then
				max_width := data.maximal_left_extend (
					data.y-relative_height (rel_y),
			data.height+relative_height (rel_y))
			elseif coin = 2 then
				max_width := data.maximal_right_extend (
					data.y-relative_height (rel_y),
					data.height+relative_height (rel_y))
			elseif coin = 3 then
				max_width := data.maximal_left_extend
					(data.y, data.height+relative_height (rel_y))
			else
				max_width := data.maximal_right_extend
					(data.y, data.height+relative_height (rel_y))
			end;
			if data.width+Result > max_width then
				Result := max_width-data.width
			end
		end;

	relative_height (rel_y: INTEGER): INTEGER is
		require else
			exists_cluster: cluster /= void
		do
			if coin < 3 then
				Result := -rel_y
			else
				Result := rel_y
			end;
			if data.height+Result < min_height then
				Result := min_height-data.height
			end;
			if data.height+Result > max_height then
				Result := max_height-data.height
			end
		end

	scaled_factor (numerator, denominator, factor: INTEGER): INTEGER is
			-- factor is scaled by 'numerator'/'denominator', and rounded
		require
			positive_fraction: numerator > 0 and denominator > 0
		local
			fraction,
			half_fraction,
			scaled_fraction: REAL;
		do
			fraction := numerator / denominator;
			scaled_fraction := factor * fraction;
			Result := scaled_fraction.truncated_to_integer;
			half_fraction := Result + 0.5;
			if half_fraction < scaled_fraction then
				Result := Result + 1
			end
		end 

end -- class WORKAREA_RESIZE_CLUSTER_COM
