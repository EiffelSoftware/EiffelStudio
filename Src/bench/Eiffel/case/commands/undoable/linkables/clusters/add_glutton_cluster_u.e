indexing

	description: 
		"Undoable command to add a cluster encompassing classes.";
	date: "$Date$";
	revision: "$Revision $"

class ADD_GLUTTON_CLUSTER_U 

inherit

	ADD_ENTITY
		undefine
			graphicals_update
		end;

	GLUTTON_CLUSTER
		redefine
			redo, undo
		end

creation

	make

feature 

	name : STRING is "New boxing cluster"

feature 

	redo is
			-- Re-execute command (after it was undone).
		do
--			move_figure;
--			workareas.new_cluster (entity);
--			move_children (-distance_x, -distance_y, entity);
--			graphicals_update;
--			windows.namer_window.update;
		end; -- redo

	undo is
			-- Cancel effect of executing the command.
		do
--			move_children (distance_x, distance_y, old_children_parent);
--			unmove_figure;
--			workareas.destroy_cluster (entity);
--			graphicals_update;
--			workareas.refresh;
--			windows.namer_window.update;
		end -- undo

feature 

	make (cluster: like cluster_parent; a_cluster: like entity;
		figures : LINKED_LIST[LINKABLE_DATA]) is
			-- Create a new glutton cluster
		require
			has_a_cluster_parent: cluster /= void;
			cluster_exists: a_cluster /= void
		do
			record;
			cluster_parent := cluster;
			entity := a_cluster;
			new_children := figures;
			old_children_parent := cluster_parent;
			distance_x := a_cluster.x;
			distance_y := a_cluster.y;
			redo
		end -- make

end -- class ADD_GLUTTON_CLUSTER_U
