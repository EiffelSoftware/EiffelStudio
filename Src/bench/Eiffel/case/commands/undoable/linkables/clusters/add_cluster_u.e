indexing

	description: 
		"Undoable command to add a cluster data.";
	date: "$Date$";
	revision: "$Revision $"

class ADD_CLUSTER_U 

inherit

	ADD_ENTITY
		rename
			move_figure as old_move_figure,
			unmove_figure as old_unmove_figure
		end

creation

	make

feature 

	entity : CLUSTER_DATA;

	name: STRING is "New cluster"

	workarea: WORKAREA

feature 

	move_figure is
		local
			extra_height, extra_width: INTEGER
		do
			old_move_figure
			

			if (cluster_parent /= Void) and then ((not ((entity.x + entity.width) < (cluster_parent.width) -1))
				 or else
				 (not ((entity.y + entity.height) < (cluster_parent.width))))
			then
					 -- pascalf
					
						 extra_height := (entity.y + entity.height) - (cluster_parent.height) + 200 -- 10
						 extra_width := (entity.x + entity.width) - (cluster_parent.width) + 200 -- 10 befoire
					--

					if	extra_height < 0
					then
						extra_height	:= 0
					end
					if	extra_width < 0
					then
						extra_width	:= 0
					end
	    				 !! enlarge_cluster.make (cluster_parent, extra_height, extra_width)
						 enlarge_cluster.redo
			end
		end

	redo is
			-- Re-execute command (after it was undone)
		do
			move_figure;
			workarea.new_cluster (entity);		
			update
		end; -- redo

	unmove_figure is
		do
			old_unmove_figure

			--check
			--	enlarge_cluster_exists: enlarge_cluster /= Void
			--end
			if enlarge_cluster /= Void
			then
				enlarge_cluster.undo
			end
		end

	undo is
			-- Cancel effect of executing the command
		do
			unmove_figure;
			workareas.destroy_cluster (entity);
			update
		end -- undo

	update is
			-- Update
		do
			observer_management.update_observer (system)
			--graphicals_update;
			--Workarea.update_cluster_chart (entity, entity.stone_type);
			--Windows.update_cluster_info_in_windows (entity, True);
		end;

feature 

	make (cluster: like cluster_parent; a_cluster: like entity; w: like workarea) is
			-- Create a new cluster
		require
			has_a_cluster_parent: cluster /= void;
			cluster_exists: a_cluster /= void
		do
			record;
			cluster_parent := cluster;
			entity := a_cluster;
			workarea := w
			redo
		end -- make	


feature {NONE} -- Implementation

	enlarge_cluster: ENLARGE_CLUSTER

end -- class ADD_CLUSTER_U
