indexing
	description: "[
		ES_WIDGET displaying an active collection of TAGABLE_I where the items can be selected.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_TAGABLE_WIDGET [G -> TAGABLE_I]

inherit
	ES_WINDOW_WIDGET [EV_VERTICAL_BOX]
		undefine
			is_interface_usable
		redefine
			make
		end

feature {NONE} -- Initialization

	make (a_window: like develop_window)
			-- <Precursor>
		do
			Precursor (a_window)
			create item_selected_actions
			create item_deselected_actions
			create internal_selected_items.make_default
		end

feature -- Access

	collection: !ACTIVE_COLLECTION_I [G]
			-- Collection of tagables shown by widget.
		require
			usable: is_interface_usable
			connected: is_connected
		deferred
		end

	selected_items: !DS_LINEAR [G]
			-- Selected items in widget
		require
			usable: is_interface_usable
		do
			Result := internal_selected_items
		ensure
			not_connected_implies_empty: not is_connected implies Result.is_empty
			items_in_collection: is_connected implies Result.for_all (agent (collection.items).has)
		end

feature {NONE} -- Access

	internal_selected_items: !DS_HASH_SET [G]
			-- Internal storage for `selected_items'

feature -- Status report

	is_connected: BOOLEAN
			-- Is `Current' connected to an active collection?
		require
			usable: is_interface_usable
		deferred
		end

feature -- Events

	item_selected_actions: !ACTION_SEQUENCE [TUPLE [G]]
			-- Events called when a item is selected in `widget'

	item_deselected_actions: !ACTION_SEQUENCE [TUPLE [G]]
			-- Events called when an item is deselected in `widget'

end
