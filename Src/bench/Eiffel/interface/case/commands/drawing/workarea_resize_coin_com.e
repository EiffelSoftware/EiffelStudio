indexing

	description: 
		"Command to resize the coin for a given cluster.";
	date: "$Date$";
	revision: "$Revision $"

class WORKAREA_RESIZE_COIN_COM 

inherit

	WORKAREA_RESIZING_CLUSTER;
	WORKAREA_MOVE_DATA_COM
		rename
		--	init as old_init
		end;
	WORKAREA_MOVE_DATA_COM
		redefine
		--	init
		select
		--	init
		end;
	CONSTANTS

creation

	make

feature {WORKAREA_SELECT_COM} -- Initialization

	--init (button_data: BUTTON_DATA) is
	--		-- Initialize command.
	--	do
	--		if data/= Void then
	--			old_init (button_data);
	--			cluster_x := cluster.real_x;
	--			cluster_y := cluster.real_y;
	--			min_width := data.minimal_width;
	--			min_height := data.minimal_height;
	--			max_height := data.maximal_bottom_extend (data.x, min_width)
	--			if not Environment.is_motif then
	--				workarea.grab (Void)
	--			end
	--		else
	--			Windows.message (Windows.main_graph_window, "Me", Void )
	--		end
	--	end

feature -- Execution

	execute_button_release (notused: NONE; butrel_data: EV_BUTTON_EVENT_DATA) is
			-- Called when the mouse button is released.
		local
	--		bool : BOOLEAN
		do
	--	if not bool then
	--		cluster.remove_button_motion_action (1, Current, void);
	--		cluster.remove_button_release_action (1, Current, void);
	--		if moving then
	--			erase;
	--			resize_cluster (relative_width (absolute_x-start_abs_x, absolute_y-start_abs_y),
	--							relative_height (absolute_y-start_abs_y));
	--			moving := false
	--		end;
	--		if Environment.is_motif then
	--			Windows.restore_cursor;
	--		else
	--			workarea.ungrab
	--		end
	--	else
	--		Windows.message(Windows.main_graph_window, "Md", Void )
	--	end
	--	Rescue
	--		bool := TRUE
	--		retry
		end

feature {NONE} -- Private data

	cluster_x, cluster_y: INTEGER;
			-- Real absolute position of cluster as workarea

	cluster: WORKAREA is
			-- resized cluster
		do
			Result := workarea
		end; -- cluster

	data: CLUSTER_DATA is
			-- `workarea'.data
		do
			Result := workarea.data
		end;

	coin: INTEGER is 8

feature {NONE} -- Implementation

	draw is
			-- Draw figures
		local
			err : BOOLEAN
		do
			if not err then
				painter.draw_rectangle_from_to
				(cluster_x, cluster_y,
				start_abs_x+relative_width
					(absolute_x-start_abs_x, absolute_y-start_abs_y),
				start_abs_y+relative_height (absolute_y-start_abs_y))
			else
--				Windows.message(Windows.main_graph_window, "Md", Void )
			end
			Rescue
				err := TRUE
				retry
		end;

	erase is
			-- Erase figures
		do
			draw
		end

	resize_cluster (rel_x, rel_y: INTEGER) is
			-- resize 'cluster'
		require else
			exists_cluster: cluster /= Void
		local
			resize_undoable: RESIZE_CLUSTER_U;
			rel_x1, rel_y1: INTEGER;
			a_new_content: LINKED_LIST[LINKABLE_DATA];
		do	
			if data /= Void
			then
				if data.is_root then
					!!resize_undoable.make (data, coin, rel_x, rel_y)
				else
					if data.is_icon then
						!! a_new_content.make
					else
						a_new_content := data.parent_cluster.new_content_area
							(data.x, data.y,
							data.width + rel_x,
							data.height + rel_y,
							data);
					end;
					if a_new_content = Void then
				--		Windows.error (workarea.analysis_window,
				--			Message_keys.resize_cluster_er, Void)
					elseif a_new_content.empty then
						!!resize_undoable.make (data, coin, rel_x, rel_y)
					else
						!!resize_undoable.make_with_figures
						(data, coin, rel_x, rel_y, a_new_content)
					end
				end;
			end
		end; -- resize_cluster

	relative_width (rel_x, rel_y: INTEGER): INTEGER is
		local
			max_width: INTEGER
		do
			if data /= Void 
			then
				if data.width+rel_x < min_width then
					Result := min_width-data.width
				else
					Result := rel_x
				end;
				max_width := data.maximal_right_extend
					(data.y, data.height+relative_height (rel_y));
				if data.width+Result > max_width then
					Result := max_width-data.width
				end
			end
		end;

	relative_height (rel_y: INTEGER): INTEGER is
		do
			if data /= Void
			then
				if data.height+rel_y < min_height then
					Result := min_height-data.height
				else
					Result := rel_y
				end;
				if data.height+Result > max_height then
					Result := max_height-data.height
				end
			end
		end

end -- class WORKAREA_RESIZE_COIN_COM
