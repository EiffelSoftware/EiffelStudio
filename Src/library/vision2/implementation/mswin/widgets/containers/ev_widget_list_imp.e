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
			interface,
			propagate_syncpaint
		end

	EV_DYNAMIC_LIST_IMP [EV_WIDGET, EV_WIDGET_IMP]
		redefine
			interface,
			insert_i_th,
			remove_i_th
		end

feature {NONE} -- Implementation

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		local
			v_imp: EV_WIDGET_IMP
			wel_win: WEL_WINDOW
		do
				-- Should `v' be a pixmap,
				-- promote implementation to EV_WIDGET_IMP.
			v.implementation.on_parented

			v_imp ?= v.implementation

			check
				v_imp_not_void: v_imp /= Void
			end
			ev_children.go_i_th (i)
			ev_children.put_left (v_imp)
			wel_win ?= Current
			check
				wel_win_not_void: wel_win /= Void
			end
			v_imp.wel_set_parent (wel_win)
			v_imp.set_top_level_window_imp (top_level_window_imp)
			notify_change (Nc_minsize, Current)
			new_item_actions.call ([v])
		end

	remove_i_th (i: INTEGER) is
			-- Remove item at `i'-th position.
		local
			v_imp: EV_WIDGET_IMP
		do
			v_imp ?= i_th (i).implementation
			check
				v_imp_not_void: v_imp /= Void
			end
			remove_item_actions.call ([v_imp.interface])
			ev_children.go_i_th (i)
			ev_children.remove
			notify_change (Nc_minsize, Current)

				-- Unlink the widget from its parent and
				-- signal it.
			v_imp.set_parent (Void)
			v_imp.on_orphaned
		end

feature {EV_ANY_I} -- WEL Implementation

	is_control_in_window (hwnd_control: POINTER): BOOLEAN is
			-- Is the control of handle `hwnd_control'
			-- located inside the current window?
		local	
			loc_cursor: CURSOR
		do
			if hwnd_control = wel_item then
				Result := True
			else
				loc_cursor := ev_children.cursor
				from
					ev_children.start
				until
					Result or ev_children.after
				loop
					Result := ev_children.item.
						is_control_in_window (hwnd_control)
					ev_children.forth
				end
				ev_children.go_to (loc_cursor)
			end
		ensure then
			index_not_changed: old ev_children.index = ev_children.index
		end
		
	propagate_syncpaint is
			-- Propagate `wm_syncpaint' message recevived by `top_level_window_imp' to
			-- children. See "WM_SYNCPAINT" in MSDN for more information.
		local
			loc_cursor: CURSOR
		do
			from
				loc_cursor := ev_children.cursor
				ev_children.start
			until
				ev_children.off
			loop
				ev_children.item.propagate_syncpaint
				ev_children.forth
			end
				-- Restore the original cursor position.
			ev_children.go_to (loc_cursor)
		ensure then
			index_not_changed: old ev_children.index = ev_children.index
		end
		
	update_for_pick_and_drop (starting: BOOLEAN) is
			-- Pick and drop status has changed so notify all children.
		local
			loc_cursor: CURSOR
		do
			from
				loc_cursor := ev_children.cursor
				ev_children.start
			until
				ev_children.off
			loop
				ev_children.item.update_for_pick_and_drop (starting)
				ev_children.forth
			end
			ev_children.go_to (loc_cursor)
		ensure then
			index_not_changed: old ev_children.index = ev_children.index
		end
		
	adjust_tab_ordering (ordered_widgets: ARRAYED_LIST [WEL_WINDOW]; widget_depths: ARRAYED_LIST [INTEGER]; depth: INTEGER) is
			-- Adjust tab ordering of children in `Current'.
			-- used when `Current' is a child of an EV_DIALOG_IMP_MODAL
			-- or an EV_DIALOG_IMP_MODELESS.
		local
			child: WEL_WINDOW
			widget_imp: EV_WIDGET_IMP
			container: EV_CONTAINER_IMP
			old_cursor: like cursor
		do
			old_cursor := clone (cursor)
			from
				go_i_th (1)
			until
				index = count + 1
			loop
				container ?= item.implementation
				if container /= Void then
					container.adjust_tab_ordering (ordered_widgets, widget_depths, depth + 1)
				end
					-- Add `child' to `ordered_widgets'
				widget_imp ?= item.implementation
				child ?= widget_imp
				check
					child_not_void: child /= Void
				end
				ordered_widgets.force (child)
				widget_depths.force (depth)

				index := index + 1
			end
				-- Restore cursor of `Current'.
			go_to (old_cursor)
		end
		

feature {NONE} -- Implementation

	interface: EV_WIDGET_LIST

end -- class EV_WIDGET_LIST_IMP

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

