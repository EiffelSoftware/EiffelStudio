indexing
	description	: "Observer for EB_FAVORITES"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_FAVORITES_OBSERVER

inherit
	EB_SHARED_MANAGERS
			-- For the Favorites.

feature -- Updates

	on_item_added (a_item: EB_FAVORITES_ITEM; a_path: ARRAYED_LIST [EB_FAVORITES_FOLDER]) is
			-- `a_item' has been added
			-- `a_item' is situated in the path `a_path'. The first item of the path list
			-- is a folder situated in the root. If `a_item' is in the root, `a_path' can
			-- be set to an empty list or `Void'
		do
		end

	on_item_removed (a_item: EB_FAVORITES_ITEM; a_path: ARRAYED_LIST [EB_FAVORITES_FOLDER]) is
			-- `a_item' has been removed. 
			-- `a_item' is situated in the path `a_path'. The first item of the path list
			-- is a folder situated in the root. If `a_item' is in the root, `a_path' can
			-- be set to an empty list or `Void'
		do
		end

	on_update is
			-- Completely recompute the observer state.
		do
		end

feature -- Status stetting

	disable_sensitive is
			-- Make `Current' insensitive.
		deferred
		end

	enable_sensitive is
			-- Make `Current' sensitive.
		deferred
		end

end -- class EB_FAVORITES_OBSERVER
