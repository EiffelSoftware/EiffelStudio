--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"Eiffel Vision sizeable primitive. Mswindows implementation of%N%
		%of resizing of primitives."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$" 
 
deferred class
	EV_SIZEABLE_PRIMITIVE_IMP

inherit
	EV_SIZEABLE_IMP

feature -- Access

	minimum_width: INTEGER is
			-- Lower bound on `width' in pixels.
		do
			Result := internal_minimum_width
		end

	minimum_height: INTEGER is
			-- Lower bound on `height' in pixels.
		do
			Result := internal_minimum_height
		end

	internal_set_minimum_width (value: INTEGER) is
			-- Make `value' the new `minimum_width'.
			-- Should check if the user didn't set the minimum width
			-- before to set the new value.
		local
			changed: BOOLEAN
		do
			if not is_minwidth_locked then
				if internal_minimum_width /= value then
					internal_minimum_width := value
					if managed then 
						if parent_imp /= Void then
							parent_imp.notify_change (Nc_minwidth)
						end
					else
						wel_move_and_resize (x_position, y_position, width.max (value), height, True)
					end
				end
			end
		end

	internal_set_minimum_height (value: INTEGER) is
			-- Make `value' the new `minimum_height'.
			-- Should check if the user didn't set the minimum width
			-- before to set the new value.
		local
			changed: BOOLEAN
		do
			if not is_minheight_locked then
				if internal_minimum_height /= value then
					internal_minimum_height := value
					if managed then 
						if parent_imp /= Void then
							parent_imp.notify_change (Nc_minheight)
						end
					else
						wel_move_and_resize (x_position, y_position, width, height.max (value), True)
					end
				end
			end
		end

	internal_set_minimum_size (mw, mh: INTEGER) is
			-- Make `mw' the new minimum_width and `mh' the new
			-- minimum_height.
			-- Should check if the user didn't set the minimum width
			-- before to set the new value.
		local
			w_cd, h_cd: BOOLEAN
			w_ok, h_ok: BOOLEAN
			w_ns, h_ns: BOOLEAN
		do
 			w_ok := not is_minwidth_locked
			h_ok := not is_minheight_locked
 
			if w_ok and h_ok then
				w_cd := internal_minimum_width /= mw
				h_cd := internal_minimum_height /= mh
				internal_minimum_width := mw
				internal_minimum_height := mh
				if managed then
					if parent_imp /= Void then
						if w_cd and h_cd then
							parent_imp.notify_change (Nc_minsize)
						elseif w_cd then
							parent_imp.notify_change (Nc_minwidth)
						elseif h_cd then
							parent_imp.notify_change (Nc_minheight)
						end
					end
				else
					wel_move_and_resize (x_position, y_position, width.max (mw), height.max (mh), True)
				end

			elseif w_ok then
				if internal_minimum_width /= mw then
					internal_minimum_width := mw
					if managed then
						if parent_imp /= Void then
							parent_imp.notify_change (Nc_minwidth)
						end
					else
						wel_move_and_resize (x_position, y_position, width.max (mw), height, True)
					end
				end

	 		elseif h_ok then
				if internal_minimum_height /= mh then
					internal_minimum_height := mh
					if managed then
						if parent_imp /= Void then
							parent_imp.notify_change (Nc_minheight)
						end
					else
						wel_move_and_resize (x_position, y_position, width, height.max (mh), True)
					end
				end
			end
		end

	integrate_changes is
			-- A fonction that simply recompute the minimum size if
			-- necessary. It do not resize the widget, only integrate
			-- the changes.
		do
			-- Do nothing here.
		end

end -- EV_SIZEABLE_PRIMITIVE_IMP
 
--!----------------------------------------------------------------
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
--!----------------------------------------------------------------


--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.2  2000/03/14 03:02:54  brendel
--| Merged changed from WINDOWS_RESIZING_BRANCH.
--|
--| Revision 1.1.2.3  2000/03/14 00:13:02  brendel
--| Changed all calls to wel_move_and_resize back to have repaint `True' at
--| every call. It seems to be inevitable to have every change redrawn.
--| This is what causes the flickering, though, so a workaround has to be
--| found or the entire design has to be redone.
--|
--| Revision 1.1.2.2  2000/03/09 21:56:42  brendel
--| Removed most features that are still in EV_SIZEABLE_IMP.
--| (this file was copied from EV_SIZEABLE_IMP)
--|
--| Revision 1.1  2000/03/09 16:58:55  brendel
--| New descendant of EV_SIZEABLE to make it more clear which features
--| apply only to primitives and containers, which are in
--| EV_SIZEABLE_CONTAINER.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

