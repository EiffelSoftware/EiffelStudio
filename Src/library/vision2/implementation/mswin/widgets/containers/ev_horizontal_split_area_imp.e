indexing
	description: "EiffelVision horizontal split. Mswindows implementation."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	
	EV_HORIZONTAL_SPLIT_AREA_IMP
	
inherit
	
	EV_HORIZONTAL_SPLIT_AREA_I
		
	EV_SPLIT_AREA_IMP
		redefine
			child_minheight_changed,
			child_minwidth_changed,
			child_width_changed,
			wel_window
		end
	
creation
	
	make

feature -- Initilization

	make (par: EV_CONTAINER) is
			-- Create a fixed widget. 
		do
			test_and_set_parent (par)
			!! wel_window.make (parent_imp.wel_window, Current)
		end

feature {EV_WEL_SPLIT_WINDOW} -- Access

	level: INTEGER is
			-- Position of the splitter in the window
		do
			if child1 /= Void then
				Result := child1.width
			else
				Result := 0
			end
		end

	minimum_level: INTEGER is
			-- Minimum level that the splitter is allowed to go
			-- Depends of the first child minimum size
		do
			if child1 = Void then
				Result := 0
			else
				Result := child1.minimum_width
			end
		end	

	maximum_level: INTEGER is
			-- Maximum level that the splitter is allowed to go
			-- Depends of the second child minimum size
		do
			if child2 = Void then
				Result := width - wel_window.size
			else
				Result := width - child2.minimum_width - wel_window.size
			end
		end

feature -- Implementation

	child_width_changed (new_width: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Resize the window and redraw the split according to
			-- the resize of a child.
		local
			temp_width: INTEGER
		do
			if the_child = child1 then
				wel_window.refresh
			else
				temp_width := wel_window.size + child1.width
				if child2 /= Void then
					child2.set_x (temp_width)
					temp_width := temp_width + child2.width
					wel_window.set_width (temp_width)
				end
				parent_imp.child_width_changed (width, Current)
			end
		end

	set_local_height (new_height: INTEGER) is
			-- Make `new_height' the new `height' of the 
			-- container and both children.
		do
			if new_height > minimum_height then
				wel_window.set_height (new_height)
				resize_children (level)
			end
		end

	set_local_width (new_width: INTEGER) is
			-- Make `new_width' the new `width' of the 
			-- container and both children.
		do
			if new_width > width then
				wel_window.set_width (new_width)
				if child2 /= Void then
					child2.parent_ask_resize (new_width - child1.width - wel_window.size, child2.height)
				end
			end
		end

	child_minwidth_changed (child_new_minimum: INTEGER) is
			-- Change the current minimum_width because the child did.
		local
			local_width: INTEGER
		do
			if child1 /= Void then
				local_width := local_width + child1.minimum_width
			end
			if child2 /= Void then
				local_width := local_width + child2.minimum_width
			end
			set_minimum_width (local_width + wel_window.size)
		end

	child_minheight_changed (child_new_minimum: INTEGER) is
			-- Change the current minimum_height because onr of the children did.
		do
			set_minimum_height (child_new_minimum.max(minimum_height))
		end

feature {EV_WEL_SPLIT_WINDOW} -- Implementation

	resize_children (a_level: INTEGER) is
			-- Resize the two children according to the new level of the 
			-- splitter.
		do
			if child1 /= Void then
				child1.parent_ask_resize (a_level, height)
			end
			if child2 /= Void then
				child2.set_move_and_size (a_level + wel_window.size, 0, 
							width - a_level - wel_window.size, height)
			end
		end

feature {NONE} -- Implementation

	wel_window: EV_WEL_HORIZONTAL_SPLIT_WINDOW

end -- EV_HORIZONTAL_SPLIT_AREA_IMP

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
