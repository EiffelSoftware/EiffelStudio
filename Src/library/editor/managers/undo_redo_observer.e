indexing
	description	: "Observer for UNDO_REDO_STACK"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	UNDO_REDO_OBSERVER

feature -- Updates

	on_changed is
			-- Undo/redo stack has just changed.
		do
		end

end -- class UNDO_REDO_OBSERVER