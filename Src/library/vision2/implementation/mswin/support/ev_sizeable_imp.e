indexing
	description: "A class for MS-Windows to simulate resizing by children";
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 
 
deferred class
	EV_SIZEABLE_IMP

inherit
	EV_ANY_I

feature -- Measurement

	minimum_width: INTEGER 
			-- Minimum width of widget, `0' by default

	minimum_height: INTEGER
			-- Minimum height of widget, `0' by default

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
			move_and_resize (x, y, child_cell.width, height, True)
		end

	set_height (value: INTEGER) is
			-- Make `value' the new `height' and notify the
			-- parent of the change.
		do
			child_cell.set_height (value.max (minimum_height))
			move_and_resize (x, y, width, child_cell.height, True)
		end

	set_minimum_height (value: INTEGER) is
			-- Make `value' the new `minimum_height' and
			-- notify the parent of the change. If this new minimum is
			-- bigger than the Current `height' but smaller than the
			-- one of the cell, the widget is resized.
		local
			wid: EV_WIDGET
		do
			minimum_height := value
			if parent_imp /= Void then
				parent_imp.child_minheight_changed (value, Current)
				wid ?= interface
				if interface /= Void and then wid.managed then
					if value > height and then value <= child_cell.height then
						move_and_resize ((child_cell.width - width)//2 + child_cell.x, (child_cell.height - value)//2 + child_cell.y, width, value, True)
					end
				else
					if value > height then
						set_height (value)
					end
				end
			end
		end

	set_minimum_width (value: INTEGER) is
			-- Make `value' the new `minimum_width' and
			-- notify the parent of the change. If this new minimum is
			-- bigger than the Current `width', but smaller than the one
			-- of the cell, the widget is resized.
		local
			wid: EV_WIDGET
		do
			minimum_width := value
			if parent_imp /= Void then
				parent_imp.child_minwidth_changed (value, Current)
				wid ?= interface
				if wid.managed then
					if value > width and then value <= child_cell.width then
						move_and_resize ((child_cell.width - value)//2 + child_cell.x, (child_cell.height - height)//2 + child_cell.y, value, height, True)
					end
				else
					if value > width then
						set_width (value)
					end
				end
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
			Result := (width = new_width or else width = minimum_width) and then
				  (height = new_height or else height = minimum_height)
		end

	minimum_dimensions_set (new_width, new_height: INTEGER): BOOLEAN is
			-- Check if the dimensions of the widget are set to 
			-- the values given or the minimum values possible 
			-- for that widget.
		do
			if new_width = -1 then
				Result := new_height = minimum_height
			elseif new_height = -1 then
				Result := new_width = minimum_width
			else
				Result := new_width = minimum_width and new_height = minimum_height
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

feature {EV_SIZEABLE_IMP} -- Implementation

	child_cell: EV_CHILD_CELL_IMP
			-- The space that the parent allow to the current
			-- child.

	set_move_and_size (a_x, a_y, a_width, a_height: INTEGER) is
			-- Move and resize the widget. Only the parent can call this feature
			-- because it doesn't notify the parent of the change.
			-- Equivalent of `parent_ask_resize' with move.
		do
			child_cell.move (a_x, a_y)
			parent_ask_resize (a_width, a_height)
		end

	split_move_and_size (a_x, a_y, a_width, a_height: INTEGER) is
			-- Move and resize the widget when the parent is a split area.
		do
			child_cell.move (a_x, a_y)
			split_ask_resize (a_width, a_height)
		end

	parent_ask_resize (a_width, a_height: INTEGER) is
			-- When the parent asks the resize, it's not 
			-- necessary to send him back the information
			-- Do not redefine, except for windows.
		local
			cc: EV_CHILD_CELL_IMP
		do
			cc := child_cell
			cc.resize (minimum_width.max(a_width), minimum_height.max (a_height))
			if resize_type = 3 then
				move_and_resize (cc.x, cc.y, cc.width, cc.height, True)
			elseif resize_type = 2 then
				move_and_resize ((cc.width - minimum_width)//2 + cc.x, cc.y, minimum_width, cc.height, True)
			elseif resize_type = 1 then
				move_and_resize (cc.x, (cc.height - minimum_height)//2 + cc.y, cc.width, minimum_height, True)
			else
				move_and_resize ((cc.width - minimum_width)//2 + cc.x, (cc.height - minimum_height)//2 + cc.y, minimum_width, minimum_height, True)
			end
		end

	split_ask_resize (a_width, a_height: INTEGER) is
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
				move_and_resize (cc.x, cc.y, a_width, a_height, True)
			elseif resize_type = 2 then
				w := minimum_width.min (a_width)
				move_and_resize ((a_width - w)//2 + cc.x, cc.y, w, a_height, True)
			elseif resize_type = 1 then
				h := minimum_height.min (a_height)
				move_and_resize (cc.x, (a_height - h)//2 + cc.y, a_width, h, True)
			else
				w := minimum_width.min (a_width)
				h := minimum_height.min (a_height)
				move_and_resize ((a_width - w)//2 + cc.x, (a_height - h)//2 + cc.y, w, h, True)
			end
		end

feature {NONE} -- deferred feature

	parent_imp: EV_CONTAINER_IMP is
			-- Parent of this sizeable widget
		deferred
		end

	move (a_x, a_y: INTEGER) is
			-- Move the window to `a_x', `a_y'.
			-- Use move for a basic wel moving.
			-- Implemented dirsctly by wel.
		deferred
		end

	move_and_resize (a_x, a_y, a_width, a_height: INTEGER;
			repaint: BOOLEAN) is
			-- Move the window to `a_x', `a_y' position and
			-- resize it with `a_width', `a_height'.
			-- Use `move_and_resize' for a more specific
			-- change. ie, for a container, it change also
			-- the children status.
			-- Need to be redefine when necessary.
		deferred
		end

	resize (a_width, a_height: INTEGER) is
			-- Resize the window with `a_width', `a_height'.
			-- Use resize for a basic wel resizing.
			-- Implemented by wel.
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

