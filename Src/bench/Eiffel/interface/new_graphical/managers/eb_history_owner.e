indexing
	description: "Container for an history manager"
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_HISTORY_OWNER

inherit
	EB_STONABLE

	EB_RECYCLABLE

	EB_RECYCLER
		rename
			destroy as recycle
		redefine
			recycle
		end

feature -- Access

	window: EV_WINDOW is
			-- A window that can receive warnings and other dialogs.
		deferred
		end

	history_manager: EB_HISTORY_MANAGER
			-- Manager for history. It encapsulates the history.

feature -- Removal

	recycle is
			-- Free references to `Current'.
		do
			Precursor {EB_RECYCLER}
			history_manager.recycle
		end

feature -- Status setting

	advanced_set_stone (a_stone: STONE) is
			-- 'Special' set_stone, which may do more than a basic `set_stone'.
		do
			set_stone (a_stone)
		end

end -- class EB_HISTORY_OWNER
