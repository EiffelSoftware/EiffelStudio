note
	description: "[
		Active lists that provide internal actions only exported to the
		EiffelVision2 implementation.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ACTIVE_LIST [G]

inherit
	ACTIVE_LIST [G]
		redefine
			default_create,
			make_filled,
			on_item_added_at,
			on_item_removed_at
		end

create
	default_create

create {EV_ACTIVE_LIST}
	make_filled

feature {NONE} -- Initialization

	default_create
			-- Initialize.
		do
			create internal_add_actions
			create internal_remove_actions
			Precursor {ACTIVE_LIST}
		end

	make_filled (n: INTEGER)
			-- Make filled.
		do
			create internal_add_actions
			create internal_remove_actions
			Precursor {ACTIVE_LIST} (n)
		end

feature {EV_ANY_I, EV_ANY} -- Implementation

	on_item_added_at (an_item: like item; item_index: INTEGER)
			-- `an_item' has just been added at index `item_index'.
		local
			a_index: INTEGER
		do
			a_index := index
			internal_add_actions.call ([an_item])
			add_actions.call ([an_item])
			index := a_index
		end

	on_item_removed_at (an_item: like item; item_index: INTEGER)
			-- `an_item' has just been removed at index `item_index'.
		local
			a_index: INTEGER
		do
			a_index := index
			internal_remove_actions.call ([an_item])
			remove_actions.call ([an_item])
			index := a_index
		end

	internal_add_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [like item]]
			-- Actions performed when an item has just been added.
			-- Internal version not accessible by users, used by the
			-- EiffelVision implementation.

	internal_remove_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [like item]]
			-- Actions performed when an item has just been removed.
			-- Internal version not accessible by users, used by the
			-- EiffelVision implementation.

invariant
	internal_add_actions_not_void: internal_add_actions /= Void
	internal_remove_actions_not_void: internal_remove_actions /= Void

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_ACTIVE_LIST












