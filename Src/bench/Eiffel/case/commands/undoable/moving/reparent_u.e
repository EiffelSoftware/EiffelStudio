indexing

	description: 
		"Specify undoable actions for reparent figure(s)%
		%in other cluster";
	date: "$Date$";
	revision: "$Revision $"

deferred class REPARENT_U

inherit

	CONSTANTS;
	SINGLE_MOVE_U;

feature {NONE} -- Implementation

	entity: COORD_XY_DATA
			-- entity_moved
	new_x : INTEGER;
			-- New horizontal position of 'entity'
	new_y : INTEGER;
			-- New vertical position of 'entity'
	old_x : INTEGER;
			-- Old horizontal position of 'entity'
	old_y : INTEGER;
			-- Old vertical position of 'entity'
	new_parent : CLUSTER_DATA;
			-- New parent cluster of 'entity'
	old_parent : CLUSTER_DATA
			-- Old parent cluster of 'entity'

feature {NONE} -- Implementation

	move_figure is
			-- reparent 'entity' to 'new_x', 'new_y' 
			-- with 'new_parent'
		do
			entity.put_in_cluster (new_parent);
			entity.set_x (new_x);
			entity.set_y (new_y)
		end; -- move_figure

	unmove_figure is
			-- reparent 'entity' to 'old_x', 'old_y'
			-- with 'old_parent'
		do
			entity.put_in_cluster (old_parent);
			entity.set_x (old_x);
			entity.set_y (old_y)
		end; -- unmove_figure

	graphical_update is
			-- update all graphic representations of entity
			-- after its reparent actions
		do
			workareas.change_data (entity);
			workareas.update_cluster_chart (entity.parent_cluster, entity.stone_type);
			workareas.refresh;
			--windows.system_window.update_page (Stone_types.class_type);
			System.set_is_modified
		end -- graphicals_update

invariant

	has_new_x : new_x /= Void;
	has_new_y : new_y /= Void;
	has_old_x : old_x /= Void;
	has_old_y : old_y /= Void;
	has_new_parent : new_parent /= Void;
	has_old_parent : old_parent /= Void

end -- class REPARENT_U
