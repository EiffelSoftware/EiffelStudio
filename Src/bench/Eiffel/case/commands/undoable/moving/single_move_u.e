indexing

	description: 
		"Specify undoable actions to move one figure.";
	date: "$Date$";
	revision: "$Revision $"

deferred class SINGLE_MOVE_U

inherit

	MOVE_U

feature -- Update

	redo is
			-- Re-execute command (after it was undone)
		do
			move_figure;
			graphical_update
		end; -- redo

	undo is
			-- Cancel effect of executing the command
		do
			unmove_figure;
			graphical_update
		end -- undo

feature {NONE} -- Implementation property

	entity: DATA is
			-- Entity moved
		deferred
		end -- entity

feature {NONE} -- Implementation

	move_figure is
			-- Moving of 'entity'
		deferred
		end; -- move_figure

	unmove_figure is
			-- Unmoving of 'entity'
		deferred
		end -- unmove_figure


invariant

	has_entity : entity /= Void

end -- class SINGLE_MOVE_U
