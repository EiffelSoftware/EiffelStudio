indexing

	description: 
		"Command to multiselect a group of entities.";
	date: "$Date$";
	revision: "$Revision $"

class WORKAREA_MULTISELECT_COM

inherit

	WORKAREA_COM
		rename
			make as old_make
		end

	ONCES

	CONSTANTS

creation

	make

feature {NONE} -- Initialization
	make (parent: like workarea) is
			-- Make Current with parent `parent'.
		require
			has_parent: parent /= void
		do
			old_make (parent);
			!! workarea_select_lasso_com.make (workarea)
		end

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_BUTTON_EVENT_DATA) is
			-- Start selection in workarea.
		local
			active_cluster: GRAPH_CLUSTER;
		do
			active_cluster ?= workarea.active_entity	
			if (workarea.active_entity /= void and then
				(active_cluster = Void or else 
				active_cluster.is_on_tag (data.x,data.y)))	then
					if workarea.active_entity.selected then
						workarea.active_entity.unselect
					else
						workarea.active_entity.select_it
					end
					workarea.refresh
			else
					workarea.unselect_all
					workarea_select_lasso_com.init (data);
				--	workarea.drawing_area.add_button_motion_command (1, workarea_select_lasso_com, void);
				--	workarea.add_button_release_action (1, workarea_select_lasso_com, void);
			end
		end

feature {NONE} -- Properties

	context_data_useful: BOOLEAN is True;

	workarea_select_lasso_com: WORKAREA_SELECT_LASSO_COM;
			-- Command used to draw lasso of selected graphical objects

end -- class WORKAREA_MULTISELECT_COM
