indexing
	description: "EiffelVision vertical box. The children stand%
				  %one under the other. Mswindows implementation"
	author: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_BOX_IMP

inherit
	EV_VERTICAL_BOX_I
	
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

	set_local_width (new_width: INTEGER) is
			-- Make `new_width' the `width' of the box and all the children.
		local
			temp_width: INTEGER
		do
			temp_width := minimum_width.max (new_width)
			if not ev_children.empty then
				from
					ev_children.start
				until
					ev_children.after
				loop
					ev_children.item.parent_ask_resize(temp_width, ev_children.item.height)		
					ev_children.forth
				end
			end
			resize (temp_width, height)
	end

	set_local_height (new_height: INTEGER) is
			-- Make 'new_height' the `height' of the box and adapt 
			-- the children height.
		local
			mark, temp_height: INTEGER
		do
			temp_height := minimum_height.max (new_height)
			if not ev_children.empty then
				from
					mark := spacing // 2
					ev_children.start
				until
					ev_children.islast
				loop
					adapt_child (ev_children.item, width, temp_height, mark)
					if is_homogeneous then
						mark := mark + spacing + (temp_height - total_spacing) // ev_children.count
					else
						mark := mark + spacing + ev_children.item.height 
					end
					ev_children.forth
				end
				adapt_last_child_size (ev_children.item, width, temp_height, mark)
			end
			resize (width, temp_height)
		end		

	adapt_child (a_child: EV_WIDGET_IMP; a_width, a_height, a_mark:INTEGER) is
			-- Adapt the attributes of the child according to the options of the box and the child :
			-- (`homogeneous',`spacing') and of the child (`automatic_position',
			-- `automatic_resize').
			-- `a_width', `a_height' are the size of the container.
		local
			temp_height: INTEGER
			temp_mark: INTEGER
		do
			if is_homogeneous then
				if a_child.automatic_resize then
					temp_height := (a_height - total_spacing) // ev_children.count
					temp_mark := a_mark
				elseif a_child.automatic_position then
					temp_height := a_child.height
					temp_mark := a_mark + ((a_height - total_spacing) // ev_children.count - a_child.height)//2
				else
					temp_height := a_child.height
					temp_mark := a_mark
				end
			else
				if a_child.automatic_resize then
					temp_height := a_child.minimum_height + (a_height - minimum_height) // ev_children.count 
					temp_mark := a_mark
				else
					temp_height := a_child.height
					temp_mark := a_mark
				end
			end
			a_child.set_move_and_size (0, temp_mark, a_width, temp_height)
		end

	adapt_last_child_size (a_child: EV_WIDGET_IMP; a_width, a_height, a_mark:INTEGER) is
			-- Adapt the attributes of the last child according to the options of the box.
	local
			temp_height: INTEGER
			temp_mark: INTEGER
		do
			if a_child.automatic_resize then
				temp_height := a_height - a_mark - (spacing // 2)
				temp_mark := a_mark
			elseif is_homogeneous and a_child.automatic_position then
				temp_height := a_child.height
				temp_mark := a_mark + ((a_height - total_spacing) // ev_children.count - a_child.height)//2
			else
				temp_height := a_child.height
				temp_mark := a_mark
			end
			a_child.set_move_and_size (0, temp_mark, a_width, temp_height)
		end

	add_children_height: INTEGER is
			-- Give the sum of the `height' of all the children
			-- Maybe not necessary.
		do
			if not ev_children.empty then
				from
					ev_children.start
				until
					ev_children.after
				loop
					Result := Result + ev_children.item.minimum_height
					ev_children.forth
				end
			end
		end

	add_children_minimum_height: INTEGER is
			-- Give the sum of the `minimum_height' of all the children
		do
			if not ev_children.empty then
				from
					ev_children.start
				until
					ev_children.after
				loop
					Result := Result + ev_children.item.minimum_height
					ev_children.forth
				end
			end
		end

feature {NONE} -- Implementation

	child_width_changed (child_new_width: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Resize and replace all its children according 
			-- to the resize of one of them.
		do
			if child_new_width > minimum_width then
				set_local_width (child_new_width)
				parent_imp.child_width_changed (width, Current)
			else
				the_child.set_width (minimum_width)
			end
		end

	child_height_changed (child_new_height: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Resize and replace all its children according 
			-- to the resize of one of them.
		do
			if shown and child_new_height >= (minimum_height - total_spacing) // ev_children.count then
				set_local_height ((child_new_height * ev_children.count) + total_spacing)
				parent_imp.child_height_changed (height, Current)
			end
		end

	child_minwidth_changed (child_new_minimum: INTEGER) is
			-- Change the current minimum_width because the child did.
		do
			if child_new_minimum > minimum_width then
				set_minimum_width (child_new_minimum)
			end
		end

	child_minheight_changed (child_new_minimum: INTEGER) is
			-- Change the current minimum_height because the child did.
		do
			if is_homogeneous and child_new_minimum > (minimum_height - total_spacing) // ev_children.count then
				set_minimum_height (child_new_minimum * ev_children.count + total_spacing)
			else
				set_minimum_height (add_children_minimum_height + total_spacing)
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
