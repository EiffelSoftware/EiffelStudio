indexing
	description: "EiffelVision horizontal box. The children stand%
				  %one beside an other. Mswindows implementation"
	author: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HORIZONTAL_BOX_IMP

inherit
	EV_HORIZONTAL_BOX_I
	
	EV_BOX_IMP
		redefine
			child_width_changed,
			child_height_changed,
			child_minwidth_changed,
			child_minheight_changed
		end
		
creation
	make

feature {NONE} -- Basic operation

	set_local_height (new_height: INTEGER) is
			-- Set `new_height' to the box and all the children.
		local
			temp_height: INTEGER
		do
			temp_height := minimum_height.max (new_height)
			if not ev_children.empty then
				from
					ev_children.start
				until
					ev_children.after
				loop
					ev_children.item.parent_ask_resize(ev_children.item.width, temp_height)
					ev_children.forth
				end
			end
			resize (width, temp_height)
		end

	set_local_width (new_width: INTEGER) is
		-- Set `new_width' to the box and adapt the children width.
		local
			mark, temp_width: INTEGER
		do
			temp_width := minimum_width.max (new_width)
			if not ev_children.empty then
				from
					mark := spacing // 2
					ev_children.start
				until
					ev_children.islast
				loop
					adapt_child (ev_children.item, temp_width, height, mark)
					if is_homogeneous then
						mark := mark + spacing + (temp_width - total_spacing) // ev_children.count
					else
						mark := mark + spacing + ev_children.item.width
					end
					ev_children.forth
				end
				adapt_last_child_size (ev_children.item, temp_width, height, mark)
			end
			resize (temp_width, height) 
		end
		
	adapt_child (a_child: EV_WIDGET_IMP; a_width, a_height, a_mark:INTEGER) is
			-- Adapt the attributes of the child according to the options of the box and the child :
			-- (`homogeneous',`spacing') and of the child (`automatic_position',
			-- `automatic_resize').
			-- `a_width', `a_height' are the size of the container.
		local
			temp_width: INTEGER
			temp_mark: INTEGER
		do
			if is_homogeneous then
				if a_child.automatic_resize then
					temp_width := (a_width - total_spacing) // ev_children.count
					temp_mark := a_mark
				elseif a_child.automatic_position then
					temp_width := a_child.width
					temp_mark := a_mark + ((a_width - total_spacing) // ev_children.count - a_child.width)//2
				else
					temp_width := a_child.width
					temp_mark := a_mark
				end
			else
				if a_child.automatic_resize then
					temp_width := a_child.minimum_width + (a_width - minimum_width) // ev_children.count 
					temp_mark := a_mark
				else
					temp_width := a_child.width
					temp_mark := a_mark
				end
			end
			a_child.set_move_and_size (temp_mark, 0, temp_width, a_height)
		end

	adapt_last_child_size (a_child: EV_WIDGET_IMP; a_width, a_height, a_mark:INTEGER) is
			-- Adapt the attributes of the last child according to the options of the box.
	local
			temp_width: INTEGER
			temp_mark: INTEGER
		do
			if a_child.automatic_resize then
				temp_width := a_width - a_mark - (spacing // 2)
				temp_mark := a_mark
			elseif is_homogeneous and a_child.automatic_position then
				temp_width := a_child.width
				temp_mark := a_mark + ((a_width - total_spacing) // ev_children.count - a_child.width)//2
			else
				temp_width := a_child.width
				temp_mark := a_mark
			end
			a_child.set_move_and_size (temp_mark, 0, temp_width, a_height)
		end

	add_children_width: INTEGER is
			-- Give the sum of the `width' of all the children
			-- Maybe not necessary
		do
			if not ev_children.empty then
				from
					ev_children.start
				until
					ev_children.after
				loop
					Result := Result + ev_children.item.width
					ev_children.forth
				end
			end
		end

	add_children_minimum_width: INTEGER is
			-- Give the sum of the `minimum_width' of all the children
		do
			if not ev_children.empty then
				from
					ev_children.start
				until
					ev_children.after
				loop
					Result := Result + ev_children.item.minimum_width
					ev_children.forth
				end
			end
		end

feature {NONE} -- Implementation

	child_height_changed (child_new_height: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Resize and replace all its children according 
			-- to the resize of one of them.
		do
			if child_new_height > minimum_height then
				set_local_height (child_new_height)
				parent_imp.child_width_changed (height, Current)
			else
				the_child.set_height (minimum_height)
			end
		end

	child_width_changed (child_width:INTEGER; the_child: EV_WIDGET_IMP) is
			-- Resize and replace all its children according
			-- to the resize of one of them.
		do
			if shown and child_width >= (minimum_width - total_spacing) // ev_children.count then
					set_local_width ((child_width * ev_children.count) + total_spacing)
					parent_imp.child_width_changed (width, Current)
			end
		end

	child_minheight_changed (child_new_minimum: INTEGER) is
			-- Change the current minimum_width because the child did.
		do
			if child_new_minimum > minimum_height then
				set_minimum_height (child_new_minimum)
			end
		end

	child_minwidth_changed (child_new_minimum: INTEGER) is
			-- Change the current minimum_height because the child did.
		do
			if is_homogeneous and child_new_minimum > (minimum_width - total_spacing) // ev_children.count then
				set_minimum_width (child_new_minimum * ev_children.count + total_spacing)
			else
				set_minimum_width (add_children_minimum_width + total_spacing)
			end
		end
	
end -- class EV_VERTICAL_BOX_IMP

--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
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
