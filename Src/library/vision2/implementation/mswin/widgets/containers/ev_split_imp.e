indexing
	description: "EiffelVision split. Mswindows implementation."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_SPLIT_IMP
	
inherit
	EV_SPLIT_I

	EV_CONTAINER_IMP
		redefine
			wel_window,
			set_insensitive,
			set_size,
			parent_ask_resize,
			set_move_and_size
		end

feature -- Access

	child1: EV_WIDGET_IMP
			-- First child of the split area

	child2: EV_WIDGET_IMP
			-- Second child of the split area

feature -- Status settings

	set_insensitive (flag: BOOLEAN) is
			-- Set current widget in insensitive mode if
   			-- `flag'.
		do
			if child1 /= Void then
				child1.set_insensitive (flag)
			end
			if child2 /= Void then
				child2.set_insensitive (flag)
			end
			Precursor (flag)
		end

feature -- Resizing

	set_size (new_width, new_height: INTEGER) is
		-- Resize the box and all the children inside
		do
			parent_ask_resize (new_width, new_height)
			notify_size_to_parent
		end

feature {NONE} -- Implementation
	
	add_child1 (child_i: EV_WIDGET_I) is
			-- Add the first child of the split.
		do
			child1 ?= child_i
			child_minwidth_changed (child1.minimum_width)
			child_minheight_changed (child1.minimum_height)
		ensure then
			child1 /= Void
		end
	
	add_child2 (child_i: EV_WIDGET_I) is
			-- Add the second child.
		do
			child2 ?= child_i
			child_minwidth_changed (child2.minimum_width)
			child_minheight_changed (child2.minimum_height)
		ensure then
			child2 /= Void
		end

	parent_ask_resize (new_width, new_height: INTEGER) is
			-- Resize the box and all the children inside
		local
   			temp_width, temp_height: INTEGER
   		do
  			wel_window.resize (minimum_width.max (new_width), minimum_height.max (new_height))
			resize_children (wel_window.level)
		end

	set_move_and_size (a_x, a_y, new_width, new_height: INTEGER) is
			-- When the parent asks to move and resize, it does it
			-- and the notice the child.
		do
			Precursor (a_x, a_y, new_width, new_height)
			resize_children (wel_window.level)
		end

feature {EV_WEL_SPLIT_WINDOW} -- Implementation

	resize_children (level: INTEGER) is
			-- Resize both children according to the new level
			-- `level' of the splitter.
		deferred
		end

feature -- Implementation

	wel_window: EV_WEL_SPLIT_WINDOW

end -- class EV_SPLIT_IMP

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
