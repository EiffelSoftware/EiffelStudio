indexing

	description: 
		"Specify undoable actions for translation of figure(s)%
		%in same cluster.";
	date: "$Date$";
	revision: "$Revision $"

deferred class TRANSLATE_U

inherit

	SINGLE_MOVE_U;

feature {NONE} -- Implementation properties

	entity : COORD_XY_DATA
			-- entity moved

	relative_x : INTEGER;
			-- Relative horizontal translation for 'entity'

	relative_y : INTEGER
			-- Relative vertical translation for 'entity'

feature {NONE} -- Implementation

	move_figure is
			-- Translate 'entity' to 'relative_x', 'relative_y'
		do
			entity.set_x (entity.x + relative_x)
			entity.set_y (entity.y + relative_y)
		end

	unmove_figure is
			-- Untranslate 'entity' to 'relative_x', 'relative_y'
		do
			entity.set_x (entity.x - relative_x)
			entity.set_y (entity.y - relative_y)
		end

	graphical_update is
			-- Update all graphic representations of entity
			-- after its translations
		do
			workareas.change_data (entity)
			workareas.update_cluster_chart (entity.parent_cluster, entity.stone_type)
			workareas.refresh
			System.set_is_modified
		end

invariant

	has_relative_x : relative_x /= Void;
	has_relative_y : relative_y /= Void

end -- class TRANSLATE_U
