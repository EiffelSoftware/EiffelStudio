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

feature -- Access

		-- `minimum_width' has been entered and not exited yet.
		-- Used to stop excessive recursion in calculations.
	in_minimum_width: BOOLEAN

		-- `minimum_height' has been entered and not exited yet.
		-- Used to stop excessive recursion in calculations.
	in_minimum_height: BOOLEAN

	minimum_width: INTEGER is
			-- Lower bound on `width' in pixels.
		do
			--| According to Raphael, the actual resizing done here had
			--| a good reason.

			if not in_minimum_width then
				in_minimum_width := True
				if is_minwidth_recomputation_needed then
					if is_minheight_recomputation_needed then
						compute_minimum_size
						set_minheight_recomputation_needed (False)
					else
						compute_minimum_width
					end
					set_minwidth_recomputation_needed (False)
				end
				in_minimum_width := False
			end
			Result := internal_minimum_width
		end

	minimum_height: INTEGER is
			-- Lower bound on `height' in pixels.
		do
			if not in_minimum_height then
				in_minimum_height := True
				if is_minheight_recomputation_needed then
					if is_minwidth_recomputation_needed then
						compute_minimum_size
						set_minwidth_recomputation_needed (False)
					else
						compute_minimum_height
					end
					set_minheight_recomputation_needed (False)
				end
				in_minimum_height := False
			end
			Result := internal_minimum_height
		end

feature -- Basic operations

	internal_set_minimum_width (value: INTEGER) is
			-- Assign `value' to `minimum_width'.
			-- Should check if the user didn't set the minimum width
			-- before we set the new value.
		local
			changed: BOOLEAN
		do
			if not is_minwidth_locked then
				changed := internal_minimum_width /= value
				internal_minimum_width := value
				if parent_imp /= Void then
					if managed then
						if changed then 
							parent_imp.notify_change (Nc_minwidth, Current)
						elseif is_show_requested then
							wel_move_and_resize (x_position, y_position, width,
								height, True)
						end
					else
						-- Only for fixed containers.
						wel_move_and_resize (x_position, y_position,
							width.max (value), height, True)
					end
				end
			elseif is_show_requested then
				wel_move_and_resize (x_position, y_position, width, height,
					True)
			end
		end

	internal_set_minimum_height (value: INTEGER) is
			-- Assign `value' to `minimum_height'.
			-- Should check if the user didn't set the minimum width
			-- before we set the new value.
		local
			changed: BOOLEAN
		do
			if not is_minheight_locked then
				changed := internal_minimum_height /= value
				internal_minimum_height := value
				if parent_imp /= Void then
					if managed then
						if changed then 
							parent_imp.notify_change (Nc_minheight, Current)
						elseif is_show_requested then
							wel_move_and_resize (x_position, y_position, width,
								height, True)
						end
					else
						wel_move_and_resize (x_position, y_position, width,
							height.max (value), True)
					end
				end
			elseif is_show_requested then
				wel_move_and_resize (x_position, y_position, width, height,
					True)
			end
		end

	internal_set_minimum_size (mw, mh: INTEGER) is
			-- Assign `mw' to minimum_width and `mh' to minimum_height.
			-- Should check if the user didn't set the minimum width
			-- before to set the new value.
		local
			w_cd, h_cd: BOOLEAN
			w_ok, h_ok: BOOLEAN
		do
			-- First, we set some local variable
 			w_ok := not is_minwidth_locked
 			h_ok := not is_minheight_locked
 
			-- We check that we are in a coherent status.
			check
				-- If we come here, both of the bits are necessarily set
				-- therefore, we chack only one.
				same_value: is_minwidth_recomputation_needed =
					is_minheight_recomputation_needed
			end

			-- Then, we properly set the values and propagate the
			-- change if necessary.
			-- The user didn't set the minimum_width nor the minimum_height.
 			if w_ok and h_ok then
 				w_cd := internal_minimum_width /= mw
 				h_cd := internal_minimum_height /= mh
 				internal_minimum_width := mw
 				internal_minimum_height := mh
				if parent_imp /= Void then
	 				if managed then
						if w_cd and h_cd then
							parent_imp.notify_change (Nc_minsize, Current)
						elseif w_cd then
							parent_imp.notify_change (Nc_minwidth, Current)
						elseif h_cd then
							parent_imp.notify_change (Nc_minheight, Current)
						elseif is_show_requested then
							wel_move_and_resize (x_position, y_position, width,
								height, True)
						end
					else
						wel_move_and_resize (x_position, y_position,
							width.max (mw), height.max (mh), True)
					end
				end

			-- The user did set the minimum_height already.
			elseif w_ok then
				w_cd := internal_minimum_width /= mw
				internal_minimum_width := mw
				if parent_imp /= Void then
					if managed then
						if w_cd then
							parent_imp.notify_change (Nc_minwidth, Current)
						elseif is_show_requested then
							wel_move_and_resize (x_position, y_position, width,
								height, True)
						end
					else
						wel_move_and_resize (x_position, y_position,
							width.max (mw), height, True)
					end
				end

			-- The user did set the minimum_height already.
			elseif h_ok then
				h_cd := internal_minimum_height /= mh
				internal_minimum_height := mh
				if parent_imp /= Void then
					if managed then
						if h_cd then
							parent_imp.notify_change (Nc_minheight, Current)
						elseif is_show_requested then
							wel_move_and_resize (x_position, y_position, width,
								height, True)
						end
					else
						wel_move_and_resize (x_position, y_position, width,
							height.max (mh), True)
					end
				end

			-- The user did set everything already.
 			elseif is_show_requested then
				wel_move_and_resize (x_position, y_position, width, height,
					True)
 			end
		end

	FIXME_notify_change (type: INTEGER) is
			-- Called by a child of `Current'.
			-- - a child has been added/removed.
			-- - a child's minimum size has in/decreased.
			-- We have to notify all the way up to the window, because the
			-- minimum size has to available to WEL at anytime.
		do
			compute_minimum_size
			if parent_imp /= Void then
				parent_imp.notify_change (type, Current)
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
			mw_not_needed, mh_not_needed: BOOLEAN
		do
			inspect type
			when Nc_minwidth then
				if not is_minwidth_recomputation_needed then
					set_minwidth_recomputation_needed (True)
					if is_displayed then
						compute_minimum_width
						set_minwidth_recomputation_needed (False)
					--|FIXME was like this before.
					else
						if parent_imp /= Void then
							parent_imp.notify_change (Nc_minwidth, Current)
						end
					end
				end
			when Nc_minheight then
				if not is_minheight_recomputation_needed then
					set_minheight_recomputation_needed (True)
					if is_displayed then
						compute_minimum_height
						set_minheight_recomputation_needed (False)
					else
						if parent_imp /= Void then
							parent_imp.notify_change (Nc_minheight, Current)
						end
					end
				end
			when Nc_minsize then
				mw_not_needed := not is_minwidth_recomputation_needed
				mh_not_needed := not is_minheight_recomputation_needed

				if mw_not_needed and mh_not_needed then
					set_minwidth_recomputation_needed (True)
					set_minheight_recomputation_needed (True)
					if is_displayed then
						compute_minimum_size
						set_minwidth_recomputation_needed (False)
						set_minheight_recomputation_needed (False)
					else
						if parent_imp /= Void then
							parent_imp.notify_change (Nc_minsize, Current)
						end
					end
				elseif mw_not_needed then
					set_minwidth_recomputation_needed (True)
					if is_displayed then
						compute_minimum_width
						set_minwidth_recomputation_needed (False)
					else
						if parent_imp /= Void then
							parent_imp.notify_change (Nc_minwidth, Current)
						end
					end
				elseif mh_not_needed then
					set_minheight_recomputation_needed (True)
					if is_displayed then
						compute_minimum_height
						set_minheight_recomputation_needed (False)
					else
						if parent_imp /= Void then
							parent_imp.notify_change (Nc_minheight, Current)
						end
					end
				end
			end
		end

	integrate_changes is
			-- A fonction that simply recompute the minimum size if
			-- necessary. It do not resize the widget, only integrate
			-- the changes.
		local
			mw_needed, mh_needed: BOOLEAN
		do
			mw_needed := is_minwidth_recomputation_needed
			mh_needed := is_minheight_recomputation_needed

			-- We recompute what is necessary
			if mw_needed and mh_needed then
				compute_minimum_size
			elseif mw_needed then
				compute_minimum_width
			elseif mh_needed then
				compute_minimum_height
			end
		end

	compute_minimum_width, compute_minimum_height, compute_minimum_size is
			-- Recompute the minimum_width of the object.
			-- Should call only set_internal_minimum_width.
		do
			if is_show_requested then
				wel_move_and_resize (x_position, y_position, width, height,
					True)
			end
		end

end -- class EV_CONTAINER_SIZEABLE_IMP

--|-----------------------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.17  2000/06/07 17:27:57  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
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
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
