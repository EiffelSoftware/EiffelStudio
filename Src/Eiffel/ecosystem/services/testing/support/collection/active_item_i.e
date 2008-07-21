indexing
	description: "[
		Interface of an object which stores information about earlier states.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ACTIVE_ITEM_I

inherit
	USABLE_I

feature -- Access

	memento: MEMENTO_I
			-- Memento describing in which way item has changed
			--
			-- {MEMENTO_I} is very general and is ment to provide more specific information through its
			-- implementors. In particular memento can be an earlier snapshot of `Current' or can describe
			-- the incremental changes that lead to its current state.
		require
			usable: is_interface_usable
			change_occured: has_changed
		deferred
		end

feature -- Status report

	has_changed: BOOLEAN
			-- Has `Current' changed its status?
		require
			usable: is_interface_usable
		deferred
		end

feature {ACTIVE_COLLECTION_I} -- Status report

	clear_changes
			-- Remove any change related information
		require
			usable: is_interface_usable
			change_occured: has_changed
		deferred
		ensure
			changes_removed: not has_changed
		end

end
