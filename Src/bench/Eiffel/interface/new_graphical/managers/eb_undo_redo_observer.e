indexing
	description	: "Observer for UNDO_REDO_STACK"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_UNDO_REDO_OBSERVER

feature -- Updates

	on_changed is
			-- Undo/redo stack has just changed.
		do
		end

end -- class EB_UNDO_REDO_OBSERVER

