indexing
	description	: "Observer for EB_HISTORY_MANAGER"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_HISTORY_MANAGER_OBSERVER

feature -- Updates

	on_update is
			-- The history has been modified, by more than a simple add or remove.
			-- (typically called after a synchronization).
		do
		end

	on_position_changed is
			-- the position in history has changed.
		do
		end

	on_item_added (a_stone: STONE; a_stone_position: INTEGER) is
			-- Item `a_stone' has been added at place `a_stone_position'.
		do
		end

	on_item_removed (a_stone: STONE; index_item: INTEGER) is
			-- Item `a_stone' has been removed from history.
		do
		end

end -- class EB_HISTORY_MANAGER_OBSERVER
