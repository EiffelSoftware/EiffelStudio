indexing
	description: "Eiffel Vision widget list. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_WIDGET_LIST_IMP

inherit
	EV_WIDGET_LIST_I
		redefine
			interface
		end

	EV_CONTAINER_IMP
		redefine
			interface
		end

feature -- Access

	item: EV_WIDGET is
			-- Current item.
		do
			if ev_children.item /= Void then
				Result ?= ev_children.item.interface
				check
					Result_not_void: Result /= Void
				end
			end
		end

	cursor: CURSOR is
			-- Current cursor position.
		do
			Result := ev_children.cursor
		end

	index: INTEGER is
			-- Current cursor index.
		do
			Result := ev_children.index
		end

	ev_children: ARRAYED_LIST [EV_WIDGET_IMP] is
			-- Internal list of children.
		deferred
		end

feature -- Measurement

	count: INTEGER is
			-- Number of items.
		do
			Result := ev_children.count
		end

feature -- Status report

	valid_cursor (p: CURSOR): BOOLEAN is
			-- Is `p' a valid cursor position?
		do
			Result := ev_children.valid_cursor (p)
		end

feature -- Cursor movement

	back is
			-- Move to previous item.
		do
			ev_children.back
		end
	
	forth is
			-- Move cursor to next position.
		do
			ev_children.forth
		end

	go_to (p: CURSOR) is
			-- Move cursor to position `p'.
		do
			ev_children.go_to (p)	
		end

	move (i: INTEGER) is
			-- Move cursor `i' positions.
		do
			ev_children.move (i)
		end

feature -- Element change

	extend (v: like item) is
			-- Add `v' to end.
			-- Do not move cursor.
		local
			v_imp: EV_WIDGET_IMP
			ww: WEL_WINDOW
			was_after: BOOLEAN
		do
			v_imp ?= v.implementation
			check
				v_imp_not_void: v /= Void
			end
			was_after := ev_children.after
			ev_children.extend (v_imp)
			if was_after then
				ev_children.go_i_th (ev_children.count + 1)
			end
			ww ?= Current
			check
				ww_not_void: ww /= Void
			end
			v_imp.wel_set_parent (ww)
			v_imp.set_top_level_window_imp (top_level_window_imp)
			notify_change (2 + 1)
			new_item_actions.call ([v])
		end

	replace (v: like item) is
			-- Replace current item by `v'.
		local
			ww: WEL_WINDOW
			v_imp: EV_WIDGET_IMP
			a_parent_imp: EV_CONTAINER_IMP
		do
			remove
			v_imp ?= v.implementation
			check
				v_imp_not_void: v_imp /= Void
			end
			ev_children.put_left (v_imp)
			ev_children.move (-1)
			ww ?= Current
			check
				ww_not_void: ww /= Void
			end
			v_imp.wel_set_parent (ww)
			v_imp.set_top_level_window_imp (top_level_window_imp)
			notify_change (2 + 1)
			new_item_actions.call ([item])
		end

	put_front (v: like item) is
			-- Add `v' to beginning.
			-- Do not move cursor.
		local
			v_imp: EV_WIDGET_IMP
			ww: WEL_WINDOW
		do
			if v.parent /= Void then
				v.parent.prune (v)
			end
			v_imp ?= v.implementation
			check
				v_imp_not_void: v_imp /= Void
			end
			ev_children.put_front (v_imp)
			notify_change (Nc_minsize)
			ww ?= Current
			check
				ww_not_void: ww /= Void
			end
			v_imp.wel_set_parent (ww)
			v_imp.set_top_level_window_imp (top_level_window_imp)
			new_item_actions.call ([v])
		end

	put_right (v: like item) is
			-- Add `v' to the right of cursor position.
			-- Do not move cursor.
		local
			v_imp: EV_WIDGET_IMP
			ww: WEL_WINDOW
		do
			if v.parent /= Void then
				v.parent.prune (v)
			end
			v_imp ?= v.implementation
			check
				v_imp_not_void: v_imp /= Void
			end
			ev_children.put_right (v_imp)
			notify_change (Nc_minsize)
			ww ?= Current
			v_imp.wel_set_parent (ww)
			v_imp.set_top_level_window_imp (top_level_window_imp)
			new_item_actions.call ([v])
		end

	put_left (v: like item) is
			-- Add `v' to the right of cursor position.
			-- Do not move cursor.
		local
			v_imp: EV_WIDGET_IMP
			ww: WEL_WINDOW
		do
			if v.parent /= Void then
				v.parent.prune (v)
			end
			v_imp ?= v.implementation
			check
				v_imp_not_void: v_imp /= Void
			end
			ev_children.put_left (v_imp)
			notify_change (Nc_minsize)
			ww ?= Current
			v_imp.wel_set_parent (ww)
			v_imp.set_top_level_window_imp (top_level_window_imp)
			new_item_actions.call ([v])
		end

feature -- Removal

	prune (v: like item) is
			-- Remove `v' if present.
		local
			v_imp: EV_WIDGET_IMP
			pos: INTEGER
			old_index: INTEGER
		do
			v_imp ?= v.implementation
			check
				v_imp_not_void: v_imp /= Void
			end
			if ev_children.has (v_imp) then
				old_index := ev_children.index
				ev_children.start
				pos := ev_children.index_of (v_imp, 1)
				ev_children.go_i_th (pos)
				remove
				if old_index > pos then
					ev_children.go_i_th (old_index - 1)
				else
					ev_children.go_i_th (old_index)
				end
			end
		end

	remove is
			-- Remove current item.
			-- Move cursor to right neighbour.
			-- (or `after' if no right neighbour)
		local
			item_imp: EV_WIDGET_IMP
			item_parent_imp: EV_CONTAINER_IMP
			old_index: INTEGER
		do
			remove_item_actions.call ([item])
			old_index := index
			item_imp ?= item.implementation
			check
				item_imp_not_void: item_imp /= Void
			end
			item_parent_imp ?= item_imp.parent_imp
			check
				item_parent_imp_not_void: item_parent_imp /= Void
			end
			item_parent_imp.remove_child (item_imp)
			ev_children.go_i_th (old_index)
		end

	remove_left is
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
		local
			old_index: INTEGER
				-- `Index' value at entry.
		do
			old_index := index
			back
			remove
			ev_children.go_i_th (old_index - 1)
		end

	remove_right is
			-- Remove item the the right of cursor position.
			-- Do not move cursor.
		local
			old_index: INTEGER
				-- `Index' value at entry.
		do
				old_index := index
				forth
				remove
				ev_children.go_i_th (old_index)
		end

feature {NONE} -- Implementation

	interface: EV_WIDGET_LIST

end -- class EV_WIDGET_LIST_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.11  2000/03/03 18:34:43  brendel
--| Implemented feature `put_left'.
--|
--| Revision 1.10  2000/03/03 00:56:33  brendel
--| Cosmetics.
--|
--| Revision 1.9  2000/03/02 21:58:45  brendel
--| Reviewed.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

