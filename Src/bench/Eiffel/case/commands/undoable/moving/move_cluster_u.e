indexing

	description: 
		"Undoable command for moving a cluster.";
	date: "$Date$";
	revision: "$Revision $"

class MOVE_CLUSTER_U

inherit

	TRANSLATE_FIGURE_U
		rename
			move_figure as trans_move_figure,
			unmove_figure as trans_unmove_figure,
			make as old_make
		redefine
			entity
		end;
	TRANSLATE_FIGURE_U
		redefine
			entity, move_figure, unmove_figure,
			make
		select
			unmove_figure, move_figure,
			make
		end;

creation

	make

feature {NONE} -- Initialization

	make (figure: like entity; x, y: like relative_x) is
		do
			if not (figure.parent_cluster.is_root and then
				(figure.x + x < 0 or else figure.y + y < 0))
			then
				old_make (figure, x, y)
			end;			
		end;

feature {NONE} -- Implementation

	entity: CLUSTER_DATA

	enlarge_cluster: ENLARGE_CLUSTER
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
			trans_unmove_figure;
			enlarge_cluster.undo
		end;

end -- class MOVE_CLUSTER_U
