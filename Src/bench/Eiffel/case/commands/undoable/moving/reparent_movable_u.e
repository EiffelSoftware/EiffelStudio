indexing

	description: 
		"Undoable command to reparent a figure with others%
		%in a list (movables_list).";
	date: "$Date$";
	revision: "$Revision $"

class REPARENT_MOVABLE_U

inherit

	MOVABLE_U;

	REPARENT_U
		export
			{MULTIPLE_MOVE_U, MOVE_FIGURES_U} entity;
			{MOVE_FIGURES_U} new_parent
		undefine
			graphical_update
		end


creation

	make

feature -- Initialization

	make (an_entity : like entity; cluster : like new_parent; x, y : like new_x) is
			-- Reparent 'an_entity'
		require
			has_entity : an_entity /= Void;
			has_parent : cluster /= Void
		do
			entity := an_entity;
			new_x := x;
			new_y := y;
			new_parent := cluster;
			old_x := entity.x;
			old_y := entity.y;
			old_parent := entity.parent_cluster
		ensure
			entity_correctly_set : entity = an_entity;
			new_x_correctly_set : new_x = x;
			new_y_correctly_set : new_y = y
		end -- make

end -- class REPARENT_MOVABLE_U
