indexing
	description	: "Observer for EB_WINDOW_MANAGER"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_WINDOW_MANAGER_OBSERVER

feature -- Updates

	on_item_added (a_item: EB_WINDOW) is
			-- `a_item' has been added.
		do
		end

	on_item_changed (a_item: EB_WINDOW) is
			-- `a_item' has changed. 
			-- (Typically the current edited class in a development tool has changed)
		do
		end

	on_item_removed (a_item: EB_WINDOW) is
			-- `a_item' has been removed. 
		do
		end

	on_item_shown (a_item: EB_WINDOW) is
			-- `a_item' has been shown. 
		do
		end

	on_item_hidden (a_item: EB_WINDOW) is
			-- `a_item' has been hidden. 
		do
		end

end -- class EB_FAVORITES_OBSERVER
