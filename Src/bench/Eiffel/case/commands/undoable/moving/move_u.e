indexing

	description: 
		"Specify undoable actions to move one or several figures.";
	date: "$Date$";
	revision: "$Revision $"

deferred class MOVE_U

inherit

	UNDOABLE_EFC

feature {NONE} -- Implementation

	graphical_update is
			-- Update all graphic representations of entity
			-- after its moving or unmoving
		deferred
		end -- graphical_update

end -- class MOVE_U
