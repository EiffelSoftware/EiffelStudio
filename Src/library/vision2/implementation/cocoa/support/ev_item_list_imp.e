note
	description: "Eiffel Vision item list. Cocoa implementation."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ITEM_LIST_IMP [reference G -> EV_ITEM, reference G_IMP -> EV_ITEM_IMP]

inherit
	EV_ITEM_LIST_I [G]
		redefine
			interface
		end

	EV_DYNAMIC_LIST_IMP [G, G_IMP]
		rename
			initialize as initialize_item_list
		redefine
			insert_i_th,
			remove_i_th,
			initialize_item_list,
			interface
		end

	DISPOSABLE

feature {NONE} -- Initialization

	initialize_item_list
			-- Initialize `Current'.
		do
			Precursor {EV_DYNAMIC_LIST_IMP}
			create new_item_actions
			create remove_item_actions
			set_is_initialized (True)
		end

feature {NONE} -- Implementation

	insert_i_th (v: attached like item; i: INTEGER)
			-- Insert `v' at position `i'.
		local
			v_imp: detachable G_IMP
		do
			Precursor {EV_DYNAMIC_LIST_IMP} (v, i)
			v_imp ?= v.implementation
			check
				v_imp_not_void: v_imp /= Void
			end
			v_imp.set_parent_imp (Current)
			insert_item (v_imp, i)
			v_imp.on_parented
			new_item_actions.call ([v_imp.attached_interface])
		end

	remove_i_th (i: INTEGER)
			-- Remove item at `i'-th position.
		local
			v_imp: detachable G_IMP
		do
			v_imp ?= interface_i_th (i).implementation
			check
				v_imp_not_void: v_imp /= Void
			end
			v_imp.on_orphaned
			remove_item_actions.call ([v_imp.attached_interface])
			remove_item (v_imp)
			v_imp.set_parent_imp (Void)
			Precursor {EV_DYNAMIC_LIST_IMP} (i)
		end

feature {EV_ANY_I} -- Implementation

	insert_item (v_imp: G_IMP; pos: INTEGER)
			-- Graphically insert `v_imp' at `pos'.
		require
			v_imp_not_void: v_imp /= Void
			pos_within_bounds: pos > 0 and pos <= count + 1
		deferred
		end

	remove_item (v_imp: G_IMP)
			-- Graphically remove `v_imp'.
		require
			v_imp_not_void: v_imp /= Void
		deferred
		end

feature -- Event handling

	new_item_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_ITEM]]
			-- Actions to be performed after an item is added.

	remove_item_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_ITEM]]
			-- Actions to be performed before an item is removed.

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_ITEM_LIST [G] note option: stable attribute end;
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'

end -- class EV_ITEM_LIST_IMP
