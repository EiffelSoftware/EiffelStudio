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
			-- Set `new_width' to the box and all the children.
		local
			temp_width: INTEGER
		do
			temp_width := minimum_width.max (new_width)
			if not children.empty then
				from
					children.start
				until
					children.after
				loop
					children.item.parent_ask_resize(temp_width, children.item.height)		
					children.forth
				end
			end
			wel_window.resize (temp_width, height)
	end

	set_local_height (new_height: INTEGER) is
			-- Set 'new_height' to the box and adapt the children height.
		local
			mark, temp_height: INTEGER
		do
			temp_height := minimum_height.max (new_height)
			if not children.empty then
				from
					children.start
				until
					children.islast
				loop
					adapt_child (children.item, width, temp_height, mark)
					mark := mark + children.item.height + spacing 
					children.forth
				end
				adapt_last_child_size (children.item, width, temp_height, mark)
			end
			wel_window.resize (width, temp_height)
		end		

	adapt_child (a_child: EV_WIDGET_IMP; a_width, a_height, a_mark:INTEGER) is
			-- Adapt the attributes of the child according to the options of the box and the child.
		local
			temp_height: INTEGER
		do
			if a_child.automatic_resize or a_child.automatic_position then
				if is_homogeneous and a_child.automatic_resize then
					temp_height := (a_height - total_spacing) // children.count
				elseif is_homogeneous and not a_child.automatic_position then
					temp_height := (minimum_height - total_spacing)// children.count  -- max of minimum size of children
				elseif not is_homogeneous and a_child.automatic_resize then
					temp_height := a_child.minimum_height + (a_height - minimum_height) // children.count 
				end
				a_child.set_move_and_size (0, a_mark, a_width, temp_height)
			end
		end

	adapt_last_child_size (a_child: EV_WIDGET_IMP; a_width, a_height, a_mark:INTEGER) is
			-- Adapt the attributes of the last child according to the options of the box.
		local
			temp_height: INTEGER
		do
			if a_child.automatic_resize or a_child.automatic_position then
				if a_child.automatic_resize then
					temp_height := a_height - a_mark
				elseif is_homogeneous then
					temp_height := (minimum_height - total_spacing)// children.count  -- max of minimum size of children
				end
				a_child.set_move_and_size (0, a_mark, a_width, temp_height)
			end
		end

	add_children_height: INTEGER is
			-- Give the sum of the `height' of all the children
			-- Maybe not necessary.
		do
			if not children.empty then
				from
					children.start
				until
					children.after
				loop
					Result := Result + children.item.minimum_height
					children.forth
				end
			end
		end

	add_children_minimum_height: INTEGER is
			-- Give the sum of the `minimum_height' of all the children
		do
			if not children.empty then
				from
					children.start
				until
					children.after
				loop
					Result := Result + children.item.minimum_height
					children.forth
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
			if shown and child_new_height >= (minimum_height - total_spacing) // children.count then
				set_local_height ((child_new_height * children.count) + total_spacing)
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
			if is_homogeneous and child_new_minimum > (minimum_height - total_spacing) // children.count then
				set_minimum_height (child_new_minimum * children.count + total_spacing)
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
