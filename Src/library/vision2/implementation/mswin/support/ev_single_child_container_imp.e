indexing
	description: 
		"A common class for Mswindows containers with one child without%N%
		%commitment to a WEL control."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SINGLE_CHILD_CONTAINER_IMP

inherit
	EV_CONTAINER_IMP
		redefine
			enable_sensitive,
			disable_sensitive,
			propagate_foreground_color,
			propagate_background_color,
			extend,
			propagate_syncpaint,
			update_for_pick_and_drop,
			on_size
		end

feature -- Access

	item: EV_WIDGET
			-- The child of `Current'.

	item_imp: EV_WIDGET_IMP is
			-- `item'.`implementation'.
		do
			if item /= Void then
				Result ?= item.implementation
			end
		end

feature -- Status setting

	enable_sensitive is
			-- Set `item' sensitive to user actions.
		do
			if item_imp /= Void and not item_imp.internal_non_sensitive then
				item_imp.enable_sensitive
			end
			Precursor {EV_CONTAINER_IMP}
		end

	disable_sensitive is
			-- Set `item' insensitive to user actions.
		do
			if item_imp /= Void then
				item_imp.disable_sensitive
			end
			Precursor {EV_CONTAINER_IMP}
		end
	
feature -- Element change

	remove is
			-- Remove `item' from `Current' if present.
		local
			v_imp: EV_WIDGET_IMP
		do
			if item /= Void then
				remove_item_actions.call ([item])
				v_imp ?= item_imp
				check
					v_imp_not_void: v_imp /= Void
				end	
				v_imp.set_parent (Void)
				v_imp.on_orphaned
				item := Void
				notify_change (2 + 1, Current)
			end
		end

	insert (v: like item) is
			-- Assign `v' to `item'.
		local
			v_imp: EV_WIDGET_IMP
		do
			if v /= Void then
				check
					has_no_item: item = Void
				end
				v.implementation.on_parented
				v_imp ?= v.implementation
				check
					v_imp_not_void: v_imp /= Void
				end
				item := v
				v_imp.set_parent (interface)
				notify_change (2 + 1, Current)
				new_item_actions.call ([item])
			end
		end

	put, replace (v: like item) is
			-- Replace `item' with `v'.
		do
			remove
			if v /= Void then
				insert (v)
			end
		end

feature -- Basic operations

	propagate_background_color is
			-- Propagate the current background color of `Current'
			-- to the children.
		do
			if item /= Void then
				item.set_background_color (background_color)
			end
		end

	propagate_foreground_color is
			-- Propagate the current foreground color of `Current'
			-- to the children.
		do
			if item /= Void then
				item.set_foreground_color (foreground_color)
			end
		end

feature {EV_ANY_I} -- WEL Implementation

	adjust_tab_ordering (ordered_widgets: ARRAYED_LIST [WEL_WINDOW]; widget_depths: ARRAYED_LIST [INTEGER]; depth: INTEGER) is
			-- Adjust tab ordering of children in `Current'.
			-- used when `Current' is a child of an EV_DIALOG_IMP_MODAL
			-- or an EV_DIALOG_IMP_MODELESS.
		local
			widget_imp: EV_WIDGET_IMP
			child: WEL_WINDOW
			container: EV_CONTAINER_IMP
		do
			if item /= Void then
				container ?= item.implementation
				if container /= Void then
						-- Reverse tab order of `widget_list'.
					container.adjust_tab_ordering (ordered_widgets, widget_depths, depth + 1)
				end
					-- Add `child' to `ordered_widgets'.
				widget_imp ?= item.implementation
				child ?= widget_imp
				check
					child_not_void: child /= Void
				end
				ordered_widgets.force (child)
				widget_depths.force (depth)
			end
		end

	propagate_syncpaint is
			-- Propagate `wm_syncpaint' message recevived by `top_level_window_imp' to
			-- child. See "WM_SYNCPAINT" in MSDN for more information.
		do
			if item_imp /= Void then
				item_imp.propagate_syncpaint		
			end
		end
		
	update_for_pick_and_drop (starting: BOOLEAN) is
			-- Pick and drop status has changed so notify `item_imp'.
		do
			if item_imp /= Void then
				item_imp.update_for_pick_and_drop (starting)	
			end
		end
		

	is_control_in_window (hwnd_control: POINTER): BOOLEAN is
			-- Is the control of handle `hwnd_control'
			-- located inside the current window?
		local
			hwnd_current: POINTER
		do
			hwnd_current := wel_item
			if hwnd_control = hwnd_current then
				Result := True
			else
				if item_imp /= Void then
					Result := item_imp.is_control_in_window (hwnd_control)
				else
					Result := False
				end
			end
		end

	on_size (size_type, a_width, a_height: INTEGER) is
			-- Called when `Current' is resized.
		do
			if size_type /= Wel_window_constants.Size_minimized then
				if item /= Void then
					item_imp.set_move_and_size (client_x, client_y,
						client_width, client_height)
				end
				Precursor {EV_CONTAINER_IMP} (size_type, a_width, a_height)
			end
		end

	ev_apply_new_size (a_x_position, a_y_position,
				a_width, a_height: INTEGER; repaint: BOOLEAN) is
		do
			ev_move_and_resize (a_x_position, a_y_position, a_width, a_height, repaint)
			if item /= Void then
				item_imp.ev_apply_new_size (client_x, client_y,
					client_width, client_height, True)
			end
		end
		
feature {NONE} -- Implementation

	is_child (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Is `a_child' a child of the container?
		do
			Result := a_child = item.implementation
		end

end -- class EV_SINGLE_CHILD_CONTAINER_IMP

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
--| Revision 1.17  2001/06/08 21:50:26  rogers
--| `is_child' is no longer obsolete.
--|
--| Revision 1.16  2001/06/07 23:08:13  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.4.8.20  2001/03/29 18:50:47  rogers
--| Optimized and simplified adjust_tab_ordering.
--|
--| Revision 1.4.8.19  2001/03/29 18:21:28  rogers
--| Renamed reverse_tab_order to adjust_tab_ordering.
--|
--| Revision 1.4.8.18  2001/03/28 21:46:22  rogers
--| Chnaged signature of reverse_tab_order. We now also store the depths of
--| widgets and containers.
--|
--| Revision 1.4.8.17  2001/03/28 19:59:01  rogers
--| Fixed reverse_tab_order. We now add containers to `widget_list'.
--|
--| Revision 1.4.8.16  2001/03/28 19:33:35  rogers
--| Fixed reverse_tab_order. Previously would crash if `item' was Void.
--|
--| Revision 1.4.8.15  2001/03/28 19:22:51  rogers
--| Implemented reverse_tab_order.
--|
--| Revision 1.4.8.14  2001/03/16 19:27:06  rogers
--| Redefined update_for_pick_and_drop.
--|
--| Revision 1.4.8.13  2001/03/14 19:26:17  rogers
--| Fixed propagate_syncpaint to only propagate to `child_imp' if
--| `child_imp' /= Void.
--|
--| Revision 1.4.8.12  2001/03/14 19:24:03  rogers
--| Redefined `propagate_syncpaint' to call `propagate_syncpaint' on child.
--|
--| Revision 1.4.8.11  2000/09/13 22:13:46  rogers
--| Changed the style of Precursor.
--|
--| Revision 1.4.8.10  2000/08/16 00:04:10  rogers
--| Fixed enable_sensitive. Now reference item_imp instead of item.
--|
--| Revision 1.4.8.9  2000/08/15 23:46:07  rogers
--| enable_sensitive and disable_sensitive now call enable_sensitive and
--| disable_sensitive on the implementation of the child, instead of the
--| interface. Enable sensitive also now only enables children which have been
--| made insensitive non directly. i.e. placed in a container which has had
--| sensitivity disabled.
--|
--| Revision 1.4.8.8  2000/08/08 01:48:07  manus
--| Added correct definition of `on_size' for correct resizing of enclosing item.
--| Added implementation of `ev_apply_new_size' as required by EV_SIZEABLE_CONTAINER_IMP.
--|
--| Revision 1.4.8.7  2000/07/21 23:07:11  rogers
--| Removed add_child and add_child_ok as no longer used in Vision2.
--|
--| Revision 1.4.8.6  2000/07/21 19:01:58  rogers
--| Removed remove_child as it is no longer required in Vision2.
--|
--| Revision 1.4.8.5  2000/06/13 00:00:50  rogers
--| Removed FIXME NOT_REVIEWED. Comments, formatting.
--|
--| Revision 1.4.8.4  2000/06/06 00:08:39  manus
--| `compute_minimum_size' will compute something only if a window is visible,
--| and will just notify the parent otherwise.
--| New signature for `notify_change' that takes `child' which request the
--| change as 2 parameter. The rational is that it is used only for
--| EV_NOTEBOOK_IMP where we do not want to resize a page if it is not
--| visible. This largely improves the resizing performance.
--|
--| Revision 1.4.8.3  2000/05/09 00:48:27  manus
--| `insert' can now accept a Void argument (and does nothing in this case).
--| Done because `replace' call `insert' and `replace' can be called with
--| a Void argument.
--|
--| Revision 1.4.8.2  2000/05/08 17:32:49  brendel
--| Fixed bug in put, replace.
--|
--| Revision 1.4.8.1  2000/05/03 19:09:18  oconnor
--| mergred from HEAD
--|
--| Revision 1.13  2000/05/01 19:33:24  pichery
--| Added feature `is_control_in_window' used
--| to determine if a certain control is contained
--| inside the current window.
--|
--| Revision 1.12  2000/04/28 23:38:55  brendel
--| Improved all features in obsolete clause (My idea of a good time.)
--|
--| Revision 1.11  2000/04/26 22:16:50  rogers
--| Rplace now calls insert instead of extend.
--|
--| Revision 1.10  2000/04/26 21:51:06  brendel
--| Revised.
--|
--| Revision 1.9  2000/04/26 18:36:48  brendel
--| First attempt to fix cell.
--|
--| Revision 1.8  2000/04/14 21:41:18  brendel
--| Fixed put for PIXMAP's.
--|
--| Revision 1.7  2000/02/28 16:30:56  brendel
--| Added action sequence calls for on-remove and on-add of items.
--| Since this class has not been reviewed yet, I did not know exactly
--| where to put the calls and where not. Needs reviewing!
--|
--| Revision 1.6  2000/02/19 05:45:00  oconnor
--| released
--|
--| Revision 1.5  2000/02/14 11:40:41  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.10.7  2000/02/08 20:29:26  rogers
--| Implemented replace.
--|
--| Revision 1.4.10.6  2000/02/08 18:05:53  king
--| Added replace feature that needs implementing
--|
--| Revision 1.4.10.5  2000/02/02 21:02:28  rogers
--| Altered put. See comment in feature for full explanation.
--|
--| Revision 1.4.10.4  2000/01/27 19:30:16  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.10.3  2000/01/18 17:07:03  king
--| Added redefine of propagate_*_color to inh.
--|
--| Revision 1.4.10.2  1999/12/17 01:09:05  rogers
--| Altered to fit in with the review branch. set_insensitive has been split
--| into two.
--|
--| Revision 1.4.10.1  1999/11/24 17:30:22  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.6.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
