indexing
	description:
		"Eiffel Vision sizeable container. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$" 

deferred class
	EV_SIZEABLE_CONTAINER_IMP

inherit
	EV_SIZEABLE_IMP
		undefine
			ev_apply_new_size
		redefine
			minimum_width,
			minimum_height,
			initialize_sizeable
		end

feature {NONE} -- Initialization

	initialize_sizeable is
			-- Initialize sizing attributes of `Current'.
		do
			create child_cell
			set_minwidth_recomputation_needed (True)
			set_minheight_recomputation_needed (True)
		end

feature -- Status report

	is_minwidth_recomputation_needed: BOOLEAN
			-- Does minimum width need to be recomputed?

	is_minheight_recomputation_needed: BOOLEAN
			-- Does minimum height need to be recomputed?

	is_notify_originator: BOOLEAN
			-- Did Current launch `notification process'?

	is_in_min_height: BOOLEAN
			-- Is current recomputing its minimum height?

	is_in_min_width: BOOLEAN
			-- Is current recomputing its minimum width?

	is_in_notify: BOOLEAN_REF is
			-- Is current already notified from a change in its children?
		once
			create Result
		end

feature -- Status setting

	set_minwidth_recomputation_needed (flag: BOOLEAN) is
			-- Set `is_minwidth_recomputation_needed' with `flag'?
		do
			is_minwidth_recomputation_needed := flag
		end

	set_minheight_recomputation_needed (flag: BOOLEAN) is
			-- Set `is_minheight_recomputation_needed' with `flag'?
		do
			is_minheight_recomputation_needed := flag
		end

feature -- Access

	minimum_width: INTEGER is
			-- Lower bound on `width' in pixels.
		do
			if is_minwidth_recomputation_needed then
				set_minwidth_recomputation_needed (False)
				is_in_min_width := True
				if is_minheight_recomputation_needed then
					set_minheight_recomputation_needed (False)
					is_in_min_height := True
					compute_minimum_size
				else
					compute_minimum_width
				end
				is_in_min_height := False
				is_in_min_width := False
			end
			Result := child_cell.minimum_width
		end

	minimum_height: INTEGER is
			-- Lower bound on `height' in pixels.
		do
			if is_minheight_recomputation_needed then
				set_minheight_recomputation_needed (False)
				is_in_min_height := True
				if is_minwidth_recomputation_needed then
					set_minwidth_recomputation_needed (False)
					is_in_min_width := True
					compute_minimum_size
				else
					compute_minimum_height
				end
				is_in_min_height := False
				is_in_min_width := False
			end
			Result := child_cell.minimum_height
		end

feature -- Basic operations

	ev_set_minimum_width (value: INTEGER) is
			-- Assign `value' to `minimum_width'.
			-- Should check if the user didn't set the minimum width
			-- before we set the new value.
		local
			mw, rw: INTEGER
			p_imp: like parent_imp
			do_change: BOOLEAN
			top_imp: like top_level_window_imp
		do
			mw := child_cell.minimum_width
			if mw /= value then
				internal_set_minimum_width (value)
				p_imp := parent_imp
				if p_imp /= Void and then (not is_in_notify.item or else is_notify_originator) then
					p_imp.notify_change (Nc_minwidth, Current)
					do_change := True
				end
			end
			top_imp := top_level_window_imp
			if
				not do_change and then
				top_imp /= Void and then top_imp.is_displayed
			then
					-- Current width
				rw := child_cell.width
				if value > rw then
					ev_move_and_resize (x_position, y_position,
							value, child_cell.height, True)
				elseif is_initialized then
						-- Apply changes to descendant only
					ev_apply_new_size (x_position, y_position,
							rw.max (value), child_cell.height, True)
				end
			end
		end

	ev_set_minimum_height (value: INTEGER) is
			-- Assign `value' to `minimum_height'.
			-- Should check if the user didn't set the minimum width
			-- before we set the new value.
		local
			mh, rh: INTEGER
			p_imp: like parent_imp
			do_change: BOOLEAN
			top_imp: like top_level_window_imp
		do
			mh := child_cell.minimum_height
			if mh /= value then
				internal_set_minimum_height (value)
				p_imp := parent_imp
				if p_imp /= Void and then (not is_in_notify.item or else is_notify_originator) then
					p_imp.notify_change (Nc_minheight, Current)
					do_change := True
				end
			end
			top_imp := top_level_window_imp
			if
				not do_change and then
				top_imp /= Void and then top_imp.is_displayed
			then
				rh := child_cell.height
				if value > rh then
						-- Apply changes to current and descendant
					ev_move_and_resize (x_position, y_position,
							child_cell.width, value, True)
				elseif is_initialized then
						-- Apply changes to descendant only
					ev_apply_new_size (x_position, y_position,
							child_cell.width, rh.max (value), True)
				end
			end
		end

	ev_set_minimum_size (a_width, a_height: INTEGER) is
			-- Assign `mw' to minimum_width and `mh' to minimum_height.
			-- Should check if the user didn't set the minimum width
			-- before to set the new value.
		local
			w_cd, h_cd, do_change: BOOLEAN
			mw, mh: INTEGER
			rw, rh: INTEGER
			p_imp: like parent_imp
			top_imp: like top_level_window_imp
		do
				-- Then, we properly set the values and propagate the
				-- change if necessary.
				-- The user didn't set the minimum_width nor the minimum_height.
			mw := child_cell.minimum_width
			mh := child_cell.minimum_height
 			w_cd := mw /= a_width
 			h_cd := mh /= a_height
			if w_cd or h_cd then
				internal_set_minimum_size (a_width, a_height)
				p_imp := parent_imp
				if p_imp /= Void and then (not is_in_notify.item or else is_notify_originator) then
					if w_cd then
						if h_cd then
							p_imp.notify_change (Nc_minsize, Current)
						else
							p_imp.notify_change (Nc_minwidth, Current)
						end
					else
						p_imp.notify_change (Nc_minheight, Current)
					end
					do_change := True
				end
			end
			top_imp := top_level_window_imp
			if
				not do_change and then
				top_imp /= Void and then top_imp.is_displayed
			then
				rw := child_cell.width
				rh := child_cell.height
				if a_width > rw or a_height > rh then
						-- Apply changes to current and descendant
					ev_move_and_resize (x_position, y_position,
							a_width, a_height, True)
				elseif is_initialized then
						-- Apply changes to descendant only
					ev_apply_new_size (x_position, y_position,
							rw.max (a_width), rh.max (a_height), True)
				end
			end
		end

	notify_change (type: INTEGER; child: EV_SIZEABLE_IMP) is
			-- Notify the current widget that the change identify by
			-- type have been done. For types, see `internal_changes'
			-- in class EV_SIZEABLE_IMP. If the container is shown, 
			-- we integrate the changes immediatly, otherwise, we postpone
			-- them.
			-- Use the constants defined in EV_SIZEABLE_IMP
		local
			p_imp: like parent_imp
			top_imp: like top_level_window_imp
			t: EV_SIZEABLE_CONTAINER_IMP
		do
			if not is_in_min_height and not is_in_min_width then
			if is_in_notify.item then
				t ?= child
				if t /= Void and then t.is_notify_originator then
						-- `notify_change' call has finished its work on descendants,
						-- we go up to parents.
					is_in_notify.set_item (False)
				end
			end
			if not is_in_notify.item then
				is_notify_originator := True
				is_in_notify.set_item (True)
				top_imp := top_level_window_imp
				if top_imp /= Void and then top_imp.is_displayed then
					inspect type
					when Nc_minwidth then
						set_minwidth_recomputation_needed (False)
						compute_minimum_width
					when Nc_minheight then
						set_minheight_recomputation_needed (False)
						compute_minimum_height
					when Nc_minsize then
						set_minwidth_recomputation_needed (False)
						set_minheight_recomputation_needed (False)
						compute_minimum_size
					end
				else
					inspect type
					when Nc_minwidth then
						set_minwidth_recomputation_needed (True)
					when Nc_minheight then
						set_minheight_recomputation_needed (True)
					when Nc_minsize then
						set_minwidth_recomputation_needed (True)
						set_minheight_recomputation_needed (True)
					end
					p_imp := parent_imp
					if p_imp /= Void then
						p_imp.notify_change (type, Current)
					end
				end
				is_notify_originator := False
				is_in_notify.set_item (False)
			end
			end
		end

	top_level_window_imp: EV_WINDOW_IMP is
			-- Top window of Current.
		deferred
		end

	compute_minimum_width, compute_minimum_height, compute_minimum_size is
			-- Recompute the minimum_width of the object.
			-- Should call only ev_set_minimum_xxxx.
		deferred
		end

end -- class EV_CONTAINER_SIZEABLE_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision: library of reusable components for ISE Eiffel.
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
--| Revision 1.19  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.18  2001/06/07 23:08:13  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.9.8.12  2001/04/04 17:27:50  rogers
--| Fixed ev_Set_minimum_size. When we call ev_move_and_resize, we now
--| pass `a_width' and `a_height'. This fixes a bug where calling
--| seT_minimum_size after `Current' was displayed, would not resize it
--| immediately.
--|
--| Revision 1.9.8.11  2000/12/11 18:44:44  manus
--| Improved performance of first time computation of minimum size by not
--| doing the `notify_change' action if Current widget is in the process
--| of computing its minimum size.
--|
--| Revision 1.9.8.10  2000/10/20 01:11:26  manus
--| Fixed a bug in resizing code of EV_CONTAINERs. It happens with the following code:
--| 	b1, b2, b3: EV_BUTTON
--| 	box1: EV_VERTICAL_BOX
--| 	box2: EV_HORIZONTAL_BOX
--| 	first_window: EV_TITLED_WINDOW
--| 	nb: EV_NOTEBOOK
--|
--| 	manu_test is
--| 		do
--|  			create first_window.make_with_title ("Eiffel Vision Widgets")
--| 			first_window.show
--| 			create nb
--| 			create b1.make_with_text ("Crash")
--| 			nb.extend (b1)
--| 			nb.set_item_text (b1, "button")
--| 			first_window.extend (nb)
--|
--| 			create b2.make_with_text ("hello")
--| 			create b3
--| 			create box2
--| 			create box1
--| 			box2.extend (b2)
--| 			box2.extend (b3)
--| 			box1.extend (box2)
--| 			nb.extend (box1)	--<<< Was violating a precondition violation in EV_POS_INFO
--| 								-- When doing resizing.
--| 		end
--|
--| The reason is due to the way `ev_set_minimum_size' can call `notify_change' on its
--| parent even if it was not needed because the parent was already doing its own notify_change.
--| Now we have `is_in_notify' a global once that tells if a `notify_change' is under process, we
--| also have `is_notify_originator' which tells who requested for a `notify_change' call. That
--| way we have a very good control on what is going on during insertion/removal of widgets.
--|
--| Basically we cannot call `parent.notify_change' if we are `is_in_notify' since it is going
--| to be processed anyway at some point. However we have to call `parent.notify_change' if we
--| are the widget that requested the notify_change call (is_notify_originator).
--|
--| Revision 1.9.8.9  2000/08/11 22:03:45  rogers
--| Removed unreferenced locals from notify_change.
--|
--| Revision 1.9.8.8  2000/08/11 19:01:25  rogers
--| Fixed copyright clause. Now use ! instead of |. Formatting.
--|
--| Revision 1.9.8.7  2000/08/08 01:49:01  manus
--| New resizing policy which always do a minimum_size computation when needed,
--| but not always. See `vision2/implementation/mswin/doc/sizing_how_to.txt'
--| for more details.
--|
--| Revision 1.9.8.6  2000/06/21 21:33:47  manus
--| Fixed a bug where within `internal_set_minimum_xxx' a call to itself was
--| done through the call to `minimum_xxx'. Solved it by setting to False the
--| flags that says if we need to compute minimum_size or not.
--|
--| Revision 1.9.8.5  2000/06/13 00:36:59  rogers
--| Removed FIXME_notify_change. Removed --| FIXME as was not relevent.
--|
--| Revision 1.9.8.4  2000/06/06 00:08:39  manus
--| `compute_minimum_size' will compute something only if a window is visible, and will just
--| notify the parent otherwise.
--| New signature for `notify_change' that takes `child' which request the change as 2 parameter.
--| The rational is that it is used only for EV_NOTEBOOK_IMP where we do not want to resize a
--| page if it is not visible. This largely improves the resizing performance.
--|
--| Revision 1.9.8.3  2000/06/02 16:44:18  rogers
--| Comments, formatting.
--|
--| Revision 1.9.8.2  2000/05/30 16:27:43  rogers
--| Removed unreferenced local variables.
--|
--| Revision 1.9.8.1  2000/05/03 19:09:18  oconnor
--| mergred from HEAD
--|
--| Revision 1.16  2000/04/17 22:50:37  brendel
--| Uncommented the lines again because problems have showed up.
--|
--| Revision 1.15  2000/04/17 17:28:58  brendel
--| Commented out every line that calls wel_move_and_resize.
--|
--| Revision 1.14  2000/03/14 16:17:05  brendel
--| Removed check since it was incorrect.
--|
--| Revision 1.13  2000/03/14 03:02:54  brendel
--| Merged changed from WINDOWS_RESIZING_BRANCH.
--|
--| Revision 1.12.2.3  2000/03/14 00:16:52  brendel
--| Changed all calls to wel_move_and_resize back to have repaint `True' at
--| every call. It seems to be inevitable to have every change redrawn.
--| This is what causes the flickering, though, so a workaround has to be
--| found or the entire design has to be redone.
--| Introduced a smaller implementation of notify_change. It is hardly any
--| less efficient than the old one.
--|
--| Revision 1.12.2.2  2000/03/11 00:12:42  brendel
--| Replaced is_displayed with is_show_requested.
--| Most calls to wel_move_and_resize are now called with False as repaint
--| parameter.
--|
--| Revision 1.12.2.1  2000/03/09 20:26:40  brendel
--| Improved comments.
--| Replaced x with x_position, y with y_position
--|
--| Revision 1.12  2000/03/06 21:18:26  brendel
--| Fixed bug in minimum_width
--|
--| Revision 1.11  2000/02/19 05:45:00  oconnor
--| released
--|
--| Revision 1.10  2000/02/14 11:40:41  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.9.10.5  2000/02/07 18:27:04  rogers
--| Replaced all calls to displayed by is_show_requested.
--|
--| Revision 1.9.10.4  2000/01/27 19:30:16  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.9.10.3  2000/01/26 22:35:06  rogers
--| Altered minimum_width and minimum_height so they will not be called
--| recursively.
--|
--| Revision 1.9.10.2  1999/12/17 01:07:45  rogers
--| Altered to fit in with the review branch. Shown replaced with
--| is_show_requested.
--|
--| Revision 1.9.10.1  1999/11/24 17:30:22  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.9.6.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
