indexing
	description: "[
		Memento for {TAGABLE_I} containing description which tags have been added or removed.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TAGABLE_MEMENTO_I

inherit
	MEMENTO_I

feature -- Access

	added_tags: !DS_LINEAR [!STRING]
			-- Tags which have been added to item
		require
			usable: is_interface_usable
		deferred
		end

	removed_tags: !DS_LINEAR [!STRING]
			-- Tags which have been removed from item
		require
			usable: is_interface_usable
		deferred
		end

end
