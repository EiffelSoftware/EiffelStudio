indexing

	description: 
		"Ancestor of undoable classes for translation moving.";
	date: "$Date$";
	revision: "$Revision $"

deferred class TRANSLATE_MOVE

inherit

	MOVE

feature -- Update

	move_figure is
			-- Translate 'entity' to 'relative_x', 'relative_y'
		do
			entity.set_x (entity.x + relative_x);
			entity.set_y (entity.y + relative_y)
		end; -- move_figure

	unmove_figure is
			-- Untranslate 'entity' to 'relative_x', 'relative_y'
		do
			entity.set_x (entity.x - relative_x);
			entity.set_y (entity.y - relative_y)
		end; -- unmove_figure

	graphicals_update is
			-- Update all graphic representations of entity
			-- after its translations
		do
			workareas.change_data (entity);
			workareas.refresh;
			System.set_is_modified
		end; -- graphicals_update

feature {NONE} -- Implementation

	relative_x : INTEGER;
			-- Relative horizontal translation for 'entity'
	relative_y : INTEGER
			-- Relative vertical translation for 'entity'

invariant

	has_relative_x : relative_x /= Void;
	has_relative_y : relative_y /= Void

end -- class TRANSLATE_MOVE
