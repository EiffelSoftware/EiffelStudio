indexing

	description: 
		"Abstract class of linkable entity creation.";
	date: "$Date$";
	revision: "$Revision $"

deferred class WORKAREA_MAKE_COM

inherit

	CONSTANTS;
	ONCES;
	ALIGN_GRID;
	WORKAREA_COM


feature -- Properties

	main_window: EV_WINDOW

feature -- Setting

	set_main_window (m: like main_window) is
		do
			main_window := m
		end

		
feature {NONE} -- Implementation

	make_entity (cluster_parent: CLUSTER_DATA; x_coord, y_coord: INTEGER) is
			-- Make linkable with parent `cluster_parent' at coordinates
			-- `x_coord' and `y_coord'.
		require
			has_cluster_parent: cluster_parent /= void
		deferred
		end

feature  -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Execution for linkable creation.
		local
			graph_cluster_parent: GRAPH_CLUSTER;
			cluster_parent: CLUSTER_DATA;
			x_coord, y_coord: INTEGER

			button_data: EV_BUTTON_EVENT_DATA
		do
			button_data ?= data

			if button_data /= Void then
				if workarea.data /= Void then
					x_coord := button_data.x;
					y_coord := button_data.y;
					x_coord := align_grid (x_coord);
					y_coord := align_grid (y_coord);
					graph_cluster_parent := workarea.cluster_at (x_coord, y_coord);
					if (graph_cluster_parent = Void) then
						cluster_parent := workarea.data
					else
						cluster_parent := graph_cluster_parent.data;
						x_coord := x_coord-graph_cluster_parent.local_x;
						y_coord := y_coord-graph_cluster_parent.local_y
					end;
					make_entity (cluster_parent, x_coord, y_coord);
				else
					Windows_manager.popup_message("Mf",Void, main_window)
				end;
			end
		end;

end -- class WORKAREA_MAKE_COM
