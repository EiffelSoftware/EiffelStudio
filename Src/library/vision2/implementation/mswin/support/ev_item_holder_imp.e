indexing
	description:
			" EiffelVision item container. This class%
			% has been created to centralise the%
			% implementation of several features for%
			% EV_LIST_IMP and EV_MENU_ITEM_HOLDER%
			% Mswindows implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ITEM_LIST_IMP [G -> EV_ITEM]

inherit
	EV_ITEM_LIST_I [G]
		redefine
			initialize,
			interface
		select
			interface
		end

	EV_DYNAMIC_LIST_IMP [G, EV_ITEM_IMP]
		redefine
			interface,
			item,
			insert_i_th,
			remove_i_th
		end

	EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP
		rename
			interface as old_interface
		end

feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current'.
		do
			create new_item_actions
			create remove_item_actions
			is_initialized := True
		end

feature {NONE} -- Implementation

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		local
			v_imp: EV_ITEM_IMP
		do
			v_imp ?= v.implementation
			check
				v_imp_not_void: v /= Void
			end
			Precursor {EV_DYNAMIC_LIST_IMP} (v, i)
			v_imp.set_parent_imp (Current)
			insert_item (v_imp, i)
			v_imp.on_parented
			new_item_actions.call ([v_imp.interface])
		end

	remove_i_th (i: INTEGER) is
			-- Remove item at `i'-th position.
		local
			v_imp: EV_ITEM_IMP
		do
			v_imp ?= i_th (i).implementation
			check
				v_imp_not_void: v_imp /= Void
			end
			v_imp.on_orphaned
			remove_item_actions.call ([v_imp.interface])
			remove_item (v_imp)
			v_imp.set_parent_imp (Void)
			Precursor (i)
		end

feature {EV_ANY_I} -- implementation

	insert_item (v_imp: EV_ITEM_IMP; pos: INTEGER) is
			-- Graphically insert `v_imp' at `pos'.
		require
			v_imp_not_void: v_imp /= Void
			pos_within_bounds: pos > 0 and pos <= count + 1
		deferred
		end

	remove_item (v_imp: EV_ITEM_IMP) is
			-- Graphically remove `v_imp'.
		require
			v_imp_not_void: v_imp /= Void
		deferred
		end

feature -- Event handling

	new_item_actions: ACTION_SEQUENCE [TUPLE [EV_ITEM]]
			-- Actions to be performed after an item is added.

	remove_item_actions: ACTION_SEQUENCE [TUPLE [EV_ITEM]]
			-- Actions to be performed before an item is removed.

feature {EV_ANY_I} -- Implementation

	interface: EV_ITEM_LIST [G]

invariant
	new_item_actions_not_void: is_usable implies new_item_actions /= Void
	remove_item_actions_not_void: is_usable implies remove_item_actions /= Void

end -- class EV_ITEM_LIST_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

