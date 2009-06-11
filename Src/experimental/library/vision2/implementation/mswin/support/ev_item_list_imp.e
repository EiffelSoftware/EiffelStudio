note
	description:
			" EiffelVision item container. This class%
			% has been created to centralise the%
			% implementation of several features for%
			% EV_LIST_IMP and EV_MENU_ITEM_HOLDER%
			% Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ITEM_LIST_IMP [G -> detachable EV_ITEM, H -> detachable EV_ITEM_IMP]

inherit
	EV_ITEM_LIST_I [G]
		redefine
			make,
			interface
		end

	EV_DYNAMIC_LIST_IMP [G, H]
		redefine
			insert_i_th,
			remove_i_th,
			interface
		end

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			create new_item_actions
			create remove_item_actions
			set_is_initialized (True)
		end

feature {NONE} -- Implementation

	insert_i_th (v: attached like item; i: INTEGER)
			-- Insert `v' at position `i'.
		local
			v_imp: detachable H
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
			v_imp: detachable H
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

feature {EV_ANY_I} -- implementation

	insert_item (v_imp: EV_ITEM_IMP; pos: INTEGER)
			-- Graphically insert `v_imp' at `pos'.
		require
			v_imp_not_void: v_imp /= Void
			pos_within_bounds: pos > 0 and pos <= count + 1
		deferred
		end

	remove_item (v_imp: EV_ITEM_IMP)
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

feature {EV_PICK_AND_DROPABLE_IMP} -- Implementation

	find_item_at_position (x_pos, y_pos: INTEGER): detachable EV_ITEM_IMP
			-- `Result' is item at pixel position `x_pos', `y_pos'.
		deferred
		end

	screen_x: INTEGER
			-- Horizontal offset of `Current' relative to screen.
		deferred
		end

	screen_y: INTEGER
			-- Vertical offset of `Current' relative to screen.
		deferred
		end

invariant
	new_item_actions_not_void: is_usable implies new_item_actions /= Void
	remove_item_actions_not_void: is_usable implies remove_item_actions /= Void

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




end -- class EV_ITEM_LIST_IMP












