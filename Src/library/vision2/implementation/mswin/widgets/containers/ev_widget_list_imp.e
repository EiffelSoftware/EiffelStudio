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

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.26  2001/07/14 12:16:30  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.25  2001/06/13 22:28:45  rogers
--| `adjust_tab_ordering' now restores the cursor of `Current'.
--|
--| Revision 1.24  2001/06/07 23:08:16  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.22.2.11  2001/03/29 18:45:22  rogers
--| Simplified and optimized adjust_tab_ordering.
--|
--| Revision 1.22.2.10  2001/03/29 18:22:53  rogers
--| Renamed reverse_tab_order to adjust_tab_ordering.
--|
--| Revision 1.22.2.9  2001/03/28 21:39:12  rogers
--| Changed signature of reverse_tab_order, and implemented depth storage.
--|
--| Revision 1.22.2.8  2001/03/28 19:52:49  rogers
--| Fixed bug in reverse_tab_order. We now add the containers to
--| `ordered_widgets' for modification of the tab order.
--|
--| Revision 1.22.2.7  2001/03/28 19:18:01  rogers
--| Added reverse_tab_order which reverses the tab order of all the children.
--|
--| Revision 1.22.2.6  2001/03/16 19:11:37  rogers
--| Previous commit should have read : Added update_for_pick_and_drop.
--| Comment.
--|
--| Revision 1.22.2.5  2001/03/16 19:07:19  rogers
--| Added update_for
--|
--| Revision 1.22.2.4  2001/03/14 19:20:14  rogers
--| Added `propagate_syncpaint' which calls `propagate_syncpaint' on all
--| children of `Current'. Aded postoncdition to is_control_in_window.
--|
--| Revision 1.22.2.3  2000/08/08 15:58:15  manus
--| New sizing policy
--|
--| Revision 1.22.2.2  2000/06/05 21:08:04  manus
--| Updated call to `notify_parent' because it requires now an extra parameter which is
--| tells the parent which children did request the change. Usefull in case of NOTEBOOK
--| for performance reasons (See EV_NOTEBOOK_IMP log for more details)
--|
--| Revision 1.22.2.1  2000/05/03 19:09:47  oconnor
--| mergred from HEAD
--|
--| Revision 1.22  2000/05/01 19:36:41  pichery
--| Added feature `is_control_in_window' used
--| to determine if a certain control is contained
--| inside the current window.
--|
--| Revision 1.21  2000/04/28 23:40:44  brendel
--| Improved remove_i_th and insert_i_th.
--|
--| Revision 1.20  2000/04/14 20:46:55  brendel
--| Fixed parenting of widget. on_parented is now called for every widget
--| before trying to conform the implementation to EV_WIDGET_IMP.
--| This is for the new way EV_PIXMAP is done.
--|
--| Revision 1.19  2000/04/12 01:30:21  pichery
--| - added pixmap promoting when adding
--|   a pixmap in a container
--|
--| Revision 1.18  2000/04/06 00:06:57  brendel
--| Corrected argument of action sequence.
--|
--| Revision 1.17  2000/04/05 21:16:12  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.16.2.2  2000/04/05 19:58:51  brendel
--| Improved implementation.
--|
--| Revision 1.16.2.1  2000/04/03 18:23:53  brendel
--| Revised with new EV_DYNAMIC_LIST.
--|
--| Revision 1.16  2000/03/21 18:38:57  rogers
--| Item now check ev_children.readable instead of ev_children.item /= Void.
--|
--| Revision 1.15  2000/03/21 02:31:04  brendel
--| Replaced unnecessary assignment attempt with assignment.
--|
--| Revision 1.14  2000/03/14 16:22:48  brendel
--| Fixed bug in put_front.
--|
--| Revision 1.13  2000/03/03 20:02:28  brendel
--| Fixed bug in replace, where before it did not remove the item from the
--| old list if it had one.
--|
--| Revision 1.12  2000/03/03 19:41:05  brendel
--| Removed feature `put_left'.
--|
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
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------

