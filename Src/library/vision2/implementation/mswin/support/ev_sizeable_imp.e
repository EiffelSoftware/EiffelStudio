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

feature -- Resizing

	set_size (new_width:INTEGER; new_height: INTEGER) is
			-- Resize the widget and notify the parent of 
			-- the resize which must be bigger than the
			-- minimal size or nothing happens
		do
			set_width (new_width)
			set_height (new_height)
		end

	set_width (value:INTEGER) is
			-- Make `value' the new width and notify the parent
			-- of the change.
		do
			child_cell.set_width (value.max (minimum_width))
			internal_resize (x, y, child_cell.width, height)
		end

	set_height (value: INTEGER) is
			-- Make `value' the new `height' and notify the
			-- parent of the change.
		do
			child_cell.set_height (value.max (minimum_height))
			internal_resize (x, y, width, child_cell.height)
		end

	set_minimum_width (value: INTEGER) is
			-- Make `value' the new `minimum_width'.
			-- There is no need to grow the object if its size is
			-- too small, the parent will do it if necessary.
		local
			wid: EV_WIDGET
		do
			internal_changes := set_bit (internal_changes, 16, False)
			internal_set_minimum_width (value)
			internal_changes := set_bit (internal_changes, 16, True)
			if parent_imp /= Void then
				parent_imp.notify_change (1)
			end
		end

	set_minimum_height (value: INTEGER) is
			-- Make `value' the new `minimum_height'.
			-- There is no need to grow the object if its size is
			-- too small, the parent will do it if necessary.
		local
			wid: EV_WIDGET
		do
			internal_changes := set_bit (internal_changes, 32, False)
			internal_set_minimum_height (value)
			internal_changes := set_bit (internal_changes, 32, True)
			if parent_imp /= Void then
				parent_imp.notify_change (2)
			end
		end

	set_minimum_size (min_width, min_height: INTEGER) is
			-- set `minimum_width' to `min_width'
			-- set `minimum_height' to `min_height'
		do
			set_minimum_width (min_width)
			set_minimum_height (min_height)
		end

feature -- Position

	set_x_y (new_x: INTEGER; new_y: INTEGER) is
			-- Put at horizontal position `new_x' and at
			-- vertical position `new_y' relative to parent.
		do
			child_cell.move (new_x, new_y)
			move (new_x, new_y)
		end

feature -- Assertion features

	dimensions_set (new_width, new_height: INTEGER): BOOLEAN is
		-- Check if the dimensions of the widget are set to 
		-- the values given or the minimum values possible 
		-- for that widget.
		local
			temp: INTEGER
		do
			Result := True
			Result := (width = new_width or else width = internal_minimum_width) and then
				  (height = new_height or else height = internal_minimum_height)
		end

	minimum_dimensions_set (new_width, new_height: INTEGER): BOOLEAN is
			-- Check if the dimensions of the widget are set to 
			-- the values given or the minimum values possible 
			-- for that widget.
		do
			Result := True
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
			w: INTEGER
			h: INTEGER
		do
			cc := child_cell
			cc.resize (a_width, a_height)
			if resize_type = 3 then
				internal_resize (cc.x, cc.y, a_width, a_height)
			elseif resize_type = 2 then
				w := minimum_width.min (a_width)
				internal_resize ((a_width - w)//2 + cc.x, cc.y, w, a_height)
			elseif resize_type = 1 then
				h := minimum_height.min (a_height)
				internal_resize (cc.x, (a_height - h)//2 + cc.y, a_width, h)
			else
				w := minimum_width.min (a_width)
				h := minimum_height.min (a_height)
				internal_resize ((a_width - w)//2 + cc.x, (a_height - h)//2 + cc.y, w, h)
			end
		end

	internal_set_minimum_width (value: INTEGER) is
			-- Make `value' the new `minimum_width'.
			-- Should check if the user didn't set the minimum width
			-- before to set the new value.
		do
			if not bit_set (internal_changes, 16) then
				internal_minimum_width := value
				if parent_imp /= Void and then not managed then
					move_and_resize ((child_cell.width - value)//2 + child_cell.x, (child_cell.height - height)//2 + child_cell.y, value, height, True)
				end
			end
		end

	internal_set_minimum_height (value: INTEGER) is
			-- Make `value' the new `minimum_height'.
			-- Should check if the user didn't set the minimum width
			-- before to set the new value.
		do
			if not bit_set (internal_changes, 32) then
				internal_minimum_height := value
				if parent_imp /= Void and then not managed then
					move_and_resize ((child_cell.width - width)//2 + child_cell.x, (child_cell.height - value)//2 + child_cell.y, width, value, True)
				end
			end
		end

	notify_change (type: INTEGER) is
			-- Notify the current widget that the change identify by
			-- type have been done. For types, see `internal_changes'
			-- in class EV_SIZEABLE_IMP. If the container is shown, 
			-- we integrate the changes immediatly, otherwise, we postpone
			-- them.
		require
			valid_type: (type = 1) or (type = 2) or (type = 3) or (type = 4)
					or (type = 8) or (type = 16) or (type = 32)
		do
			if type = 3 then
				internal_changes := set_bit (internal_changes, 1, True)
				internal_changes := set_bit (internal_changes, 2, True)
			else
				internal_changes := set_bit (internal_changes, type, True)
			end
			if shown then
				internal_resize (x, y, width, height)
			end

			-- It is importante to notify the parent
			-- after having adapted the internal_size in
			-- a shown case.
			if parent_imp /= Void then
				parent_imp.notify_change (type)
			end
		end

	internal_resize (a_x, a_y, a_width, a_height: INTEGER) is
			-- Make `x' and `y' the new position of the current object and
			-- `w' and `h' the new width and height of it.
			-- If there is any child, it also adapt them to fit to the given
			-- value.
		do
			move_and_resize (a_x, a_y, a_width, a_height, True)
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
			-- bit 1 -> the minimum width need to be recomputed		(1)
			-- bit 2 -> the minimum height need to be recomputed	(2)
			-- bit 3 -> the minimum width have been recomputed		(4)
			-- bit 4 -> the minimum height have been recomputed		(8)
			-- bit 5 -> the user has set the minimum width		(16)
			-- bit 6 -> the user has set the minimum height		(32)

feature {NONE} -- deferred feature

	parent_imp: EV_CONTAINER_IMP is
			-- Parent of this sizeable widget
		deferred
		end

	resize_type: INTEGER is
			-- How the widget resize itself in the cell
			-- 0 : no resizing, the widget move
			-- 1 : only the width changes
			-- 2 : only the height changes
			-- 3 : both width and height change
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

	move (a_x, a_y: INTEGER) is
			-- Move the window to `a_x', `a_y'.
			-- Use move for a basic wel moving.
			-- Implemented by wel.
		deferred
		end

	move_and_resize (a_x, a_y, a_width, a_height: INTEGER;
			repaint: BOOLEAN) is
			-- Move the window to `a_x', `a_y' position and
			-- resize it with `a_width', `a_height'.
			-- Implemented by wel.
		deferred
		end

	resize (a_width, a_height: INTEGER) is
			-- Resize the window with `a_width', `a_height'.
			-- Use resize for a basic wel resizing.
			-- Implemented by wel.
		deferred
		end

	shown: BOOLEAN is
			-- Is the widget shown?
			-- Implemented by wel.
		deferred
		end

	managed: BOOLEAN is
			-- Is the current widget managed?
		deferred
		end

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

