indexing

	description: 
		"Ancestor of undoable classes for moving.";
	date: "$Date$";
	revision: "$Revision $"

deferred class MOVE

inherit

	ONCES;

	UNDOABLE_EFC

feature -- Property

	entity : COORD_XY_DATA is
			-- Entity moved
		deferred
		end; -- entity

feature -- Update

	move_figure is
			-- Moving of 'entity'
		deferred
		end; -- move_figure

	unmove_figure is
			-- Unmoving of 'entity'
		deferred
		end; -- unmove_figure

	graphicals_update is
			-- Update all graphic representations of entity
			-- after its moving or unmoving
		deferred
		end; -- graphicals_update

	redo is
			-- Re-execute command (after it was undone)
		do
			move_figure;
			graphicals_update
		end; -- redo

	undo is
			-- Cancel effect of executing the command
		do
			unmove_figure;
			graphicals_update
		end -- undo

invariant

	has_entity : entity /= Void

end -- class MOVE
