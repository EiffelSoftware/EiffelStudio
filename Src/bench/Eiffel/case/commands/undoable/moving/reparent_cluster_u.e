indexing

	description: 
		"Undoable command to reparent a cluster.";
	date: "$Date$";
	revision: "$Revision $"

class REPARENT_CLUSTER_U

inherit

	REPARENT_FIGURE_U
		rename
			move_figure as trans_move_figure,
			unmove_figure as trans_unmove_figure,
			make as old_make
		redefine
			entity
		end;
	REPARENT_FIGURE_U
		redefine
			entity, move_figure, unmove_figure,
			make
		select
			unmove_figure, move_figure, make
		end;

creation

	make

feature {NONE} -- Initialization

	make (figure, cluster: like entity; x, y: like new_x) is
		do
			if not (cluster.is_root and then
				(x < 0 or else y < 0))
			then
				old_make (figure, cluster, x, y);
			end;
		end;

feature {NONE} -- Implementation

	entity: CLUSTER_DATA;

	enlarge_cluster: ENLARGE_CLUSTER;
			-- Command to ensure the moved cluster
			-- has area to move to

	move_figure is
		do
			trans_move_figure;
			if enlarge_cluster = Void then
				!! enlarge_cluster.make (entity, 0, 0)
			end;
			enlarge_cluster.redo
		end;

	unmove_figure is
		do
				-- This needs to be undo before reparenting 
				-- the entity
			enlarge_cluster.undo;
			trans_unmove_figure;
		end;

end -- class REPARENT_CLUSTER_U
