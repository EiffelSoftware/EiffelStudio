--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "A class for MS-Windows to simulate resizing by children";
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 
 
deferred class
	EV_SIZEABLE_IMP

inherit
	EV_ANY_I

	EV_BIT_OPERATIONS_I

feature -- Access

	minimum_width: INTEGER is
			-- Minimum width of the window.
			-- We recompute it if necessary.
		do
			Result := internal_minimum_width
		end

	minimum_height: INTEGER is
			-- Minimum height of the window.
			-- We recompute it if necessary.
		do
			Result := internal_minimum_height
		end

	Nc_minwidth: INTEGER is 1
			-- Used only in the `notify_change' feature to
			-- notify the parent that the minimum width of 
			-- the current widget has changed.

	Nc_minheight: INTEGER is 2
			-- Used only in the `notify_change' feature to
			-- notify the parent that the minimum height of 
			-- the current widget has changed.

	Nc_minsize: INTEGER is 3
			-- Used only in the `notify_change' feature to
			-- notify the parent that both the minimum width
			-- and height of the current widget have changed.

feature -- Status report

	horizontal_resizable: BOOLEAN is
			-- Does the widget change its width when the parent
			-- want to resize the widget
		do
			Result := bit_set (internal_changes, 16)
		end

	vertical_resizable: BOOLEAN is
			-- Does the widget change its width when the parent
			-- want to resize the widget?
		do
			Result := bit_set (internal_changes, 32)
		end

	is_minwidth_recomputation_needed: BOOLEAN is
			-- Does the minimum width need to be recomputed?
		do
			Result := bit_set (internal_changes, 1)
		end

	is_minheight_recomputation_needed: BOOLEAN is
			-- Does the minimum height need to be recomputed?
		do
			Result := bit_set (internal_changes, 2)
		end

	is_minwidth_locked: BOOLEAN is
			-- Did the user set the minimum width?
			-- In this case, the minimum width cannot be
			-- changed by the system.
		do
			Result := bit_set (internal_changes, 4)
		end

	is_minheight_locked: BOOLEAN is
			-- Did the user set the minimum height?
			-- In this case, the minimum width cannot be
			-- changed by the system.
		do
			Result := bit_set (internal_changes, 8)
		end

feature -- Status setting

	set_horizontal_resize (flag: BOOLEAN) is
			-- Make `flag' the new horizontal_resizable status.
		do
			internal_changes := set_bit (internal_changes, 16, flag)
			if is_displayed then
				parent_ask_resize (child_cell.width, child_cell.height)
			end
		end

	set_vertical_resize (flag: BOOLEAN) is
			-- Make `flag' the new vertical_resizable status.
		do
			internal_changes := set_bit (internal_changes, 32, flag)
			if is_displayed then
				parent_ask_resize (child_cell.width, child_cell.height)
			end
		end

	set_minwidth_recomputation_needed (flag: BOOLEAN) is
			-- Make `flag' the new is_minwidth_recomputation_needed?
		do
			internal_changes := set_bit (internal_changes, 1, flag)
		end

	set_minheight_recomputation_needed (flag: BOOLEAN) is
			-- Make `flag' the new is_minheight_recomputation_needed?
		do
			internal_changes := set_bit (internal_changes, 2, flag)
		end

	set_minwidth_locked (flag: BOOLEAN) is
			-- Make `flag' the new is_minwidth_locked?
		do
			internal_changes := set_bit (internal_changes, 4, flag)
		end

	set_minheight_locked (flag: BOOLEAN) is
			-- Make `flag' the new is_minwidth_locked?
		do
			internal_changes := set_bit (internal_changes, 8, flag)
		end

feature -- Resizing

	set_size (w, h: INTEGER) is
			-- Resize the widget when it is not managed.
		do
			move_and_resize (x, y, w.max (minimum_width), h.max (minimum_height), True)
		end

	set_width (value:INTEGER) is
			-- Make `value' the new width of the widget when
			-- it is not managed.
		do
			move_and_resize (x, y, value.max (minimum_width), height, True)
		end

	set_height (value: INTEGER) is
			-- Make `value' the new height of the widget when
			-- it is not managed.
		do
			move_and_resize (x, y, width, value.max (minimum_height), True)
		end

	set_minimum_width (value: INTEGER) is
			-- Make `value' the new `minimum_width'.
			-- There is no need to grow the object if its size is
			-- too small, the parent will do it if necessary.
		do
			set_minwidth_locked (False)
			internal_set_minimum_width (value)
			set_minwidth_locked (True)
		end

	set_minimum_height (value: INTEGER) is
			-- Make `value' the new `minimum_height'.
			-- There is no need to grow the object if its size is
			-- too small, the parent will do it if necessary.
		do
			set_minheight_locked (False)
			internal_set_minimum_height (value)
			set_minheight_locked (True)
		end

	set_minimum_size (mw, mh: INTEGER) is
			-- Make `mw' the new minimum_width and `mh' the new
			-- minimum_height.
		do
			set_minwidth_locked (False)
			set_minheight_locked (False)
			internal_set_minimum_size (mw, mh)
			set_minwidth_locked (True)
			set_minheight_locked (True)
		end

feature -- Position

	set_x_y, set_position (new_x: INTEGER; new_y: INTEGER) is
			-- Put at horizontal position `new_x' and at
			-- vertical position `new_y' relative to parent.
		do
			move_to (new_x, new_y)
		end

feature -- Assertion features

	dimensions_set (new_width, new_height: INTEGER): BOOLEAN is
		-- Check if the dimensions of the widget are set to 
		-- the values given or the minimum values possible 
		-- for that widget.
		local
			temp: INTEGER
		do
			Result := (width = new_width or else width = internal_minimum_width) and then
				  (height = new_height or else height = internal_minimum_height)
		end

	minimum_dimensions_set (new_width, new_height: INTEGER): BOOLEAN is
			-- Check if the dimensions of the widget are set to 
			-- the values given or the minimum values possible 
			-- for that widget.
		do
			if new_width = -1 then
				Result := new_height = internal_minimum_height
			elseif new_height = -1 then
				Result := new_width = internal_minimum_width
			else
				Result := new_width = internal_minimum_width
					and new_height = internal_minimum_height
			end
		end		

	position_set (new_x, new_y: INTEGER): BOOLEAN is
			-- Check if the dimensions of the widget are set to 
			-- the values given or the minimum values possible 
			-- for that widget.
		do
			if new_x = -1 then
				Result := new_y = y
			elseif new_y = -1 then
				Result := new_x = x
			else
				Result := new_x = x and new_y = y
			end
		end

feature -- Basic operation

	set_move_and_size (a_x, a_y, a_width, a_height: INTEGER) is
			-- Move and resize the widget. Only the parent can call this feature
			-- because it doesn't notify the parent of the change.
			-- Equivalent of `parent_ask_resize' with move.
		do
			child_cell.move (a_x, a_y)
			parent_ask_resize (a_width, a_height)
		end

	parent_ask_resize (a_width, a_height: INTEGER) is
			-- When the parent is a splitter, the children is
			-- always resized.
		local
			cc: EV_CHILD_CELL_IMP
			w, h: INTEGER
			wc, hc: BOOLEAN
		do
			cc := child_cell
			cc.resize (a_width, a_height)
			wc := horizontal_resizable
			hc := vertical_resizable
			if wc and hc then
				move_and_resize (cc.x, cc.y, a_width, a_height, True)
			elseif hc then
				w := minimum_width.min (a_width)
				move_and_resize ((a_width - w) // 2 + cc.x, cc.y, w, a_height, True)
			elseif wc then
				h := minimum_height.min (a_height)
				move_and_resize (cc.x, (a_height - h) // 2 + cc.y, a_width, h, True)
			else
				w := minimum_width.min (a_width)
				h := minimum_height.min (a_height)
				move_and_resize ((a_width - w) // 2 + cc.x, (a_height - h) // 2 + cc.y, w, h, True)
			end
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
						move_and_resize (x, y, width.max (value), height, True)
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
						move_and_resize (x, y, value, height.max (value), True)
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
					move_and_resize (x, y, width.max (mw), height.max (mh), True)
				end

			elseif w_ok then
				if internal_minimum_width /= mw then
					internal_minimum_width := mw
					if managed then
						if parent_imp /= Void then
							parent_imp.notify_change (Nc_minwidth)
						end
					else
						move_and_resize (x, y, width.max (mw), height, True)
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
						move_and_resize (x, y, width, height.max (mh), True)
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

feature {EV_SIZEABLE_IMP} -- Implementation

	child_cell: EV_CHILD_CELL_IMP
			-- The space that the parent allow to the current
			-- child.

	internal_minimum_width: INTEGER
			-- Last computed minimum width.

	internal_minimum_height: INTEGER
			-- Last computed minimum height.

	internal_changes: INTEGER
			-- What kind of changes have been done on the object.
			-- Binary integer whith the following meaning :
			-- bit 1 -> the minimum width needs to be recomputed	(1)
			-- bit 2 -> the minimum height needs to be recomputed	(2)
			-- bit 3 -> the user has set the minimum width			(4)
			-- bit 4 -> the user has set the minimum height			(8)
			-- bit 5 -> the child only resize its width				(16)
			-- bit 6 -> the child only resize its height			(32)

feature {EV_ANY_I} -- deferred feature

	parent_imp: EV_CONTAINER_IMP is
			-- Parent of this sizeable widget
		deferred
		end

	width: INTEGER is
			-- Width of widget
			-- Implemented by wel.
		deferred
		end

	height: INTEGER is
			-- Height of widget
			-- Implemented by wel.
		deferred
		end

	x: INTEGER is
			-- Horizontal position relative to parent
			-- Implemented by wel.
		deferred
		end

	y: INTEGER is
			-- Vertical position relative to parent
			-- Implemented by wel.
		deferred
		end

	move_to (a_x, a_y: INTEGER) is
			-- Move the window to `a_x', `a_y'.
			-- Use move for a basic wel moving.
			-- Implemented by wel.
		deferred
		end

	move_and_resize (a_x, a_y, a_width, a_height: INTEGER;
			repaint: BOOLEAN) is
			-- Move the window to `a_x', `a_y' position and
			-- resize it with `a_width', `a_height'.
			-- This feature must be redefine by the containers to readjust its
			-- children too.
		deferred
		end

	resize (a_width, a_height: INTEGER) is
			-- Resize the window with `a_width', `a_height'.
			-- Use resize for a basic wel resizing.
			-- Implemented by wel.
		deferred
		end

	is_show_requested: BOOLEAN is
			-- Is the widget shown?
			-- Implemented by wel.
		deferred
		end

	--shown: BOOLEAN is obsolete "is_show_requested" do Result := is_show_requested end

	managed: BOOLEAN is
			-- Is the current widget managed?
		deferred
		end

	is_displayed: BOOLEAN is
			-- Is the window displayed on the screen?
			-- ie : both the parent and the widget are shown.
		deferred
		end

	displayed: BOOLEAN is obsolete "is_displayed" do Result := is_displayed end

end -- EV_SIZEABLE_IMP
 
--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
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
--|----------------------------------------------------------------


--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.17  2000/02/14 11:40:41  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.16.10.4  2000/02/07 18:26:40  rogers
--| Replaced all calls to displayed by is_displayed.
--|
--| Revision 1.16.10.3  2000/01/27 19:30:16  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.16.10.2  1999/12/17 01:06:58  rogers
--| Altered to fit in with the review branch. Shown replaced with is_show_requested.
--|
--| Revision 1.16.10.1  1999/11/24 17:30:22  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.16.6.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
