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
			child_has_resized,
			parent_ask_resize
		end

creation
	make


feature {NONE} -- Implementation

	child_has_resized (child_width, child_height: INTEGER; child: EV_WIDGET_IMP) is
			-- Resize and replace all its children according to the resize of one of them.
			-- If the  child has a minimal size which is bigger than the minimum size of
			-- the others
		do
			if child_height >= (minimum_height - total_children_padding - total_spacing) // children.count 
					or child_width > minimum_width then

					-- first, we set the minimum_size of the window to the proper value
				if is_homogeneous then
					set_minimum_size (minimum_width.max(child.minimum_width),
						                minimum_height.max(child.minimum_height * children.count + total_children_padding + total_spacing))
				else
					set_minimum_size (minimum_width.max(child.minimum_width),
										add_children_height + total_children_padding + total_spacing)
				end

					-- Then, we resize the container
				parent_ask_resize (child_width, (child_height * children.count) + total_children_padding + total_spacing)

					-- To finish, we inform the parent of this change
				if parent_imp /= Void then
					parent_imp.child_has_resized (width, height, Current)
				end
			else
				child.parent_ask_resize (minimum_width, (minimum_height - total_children_padding - total_spacing ) // children.count)
			end
		end


	parent_ask_resize (new_box_width:INTEGER; new_box_height: INTEGER) is
			-- Resize the box and all the children inside
		local
			mark, temp_width, temp_height: INTEGER
		do
			temp_width := minimum_width.max (new_box_width)
			temp_height := minimum_height.max (new_box_height)
			if not children.empty then
				wel_window.initialize_erase_region
				from
					children.start
				until
					children.islast
				loop
					mark := mark + children.item.padding
					adapt_child_size (children.item, temp_width, temp_height)		
					children.item.widget.set_y (mark)
					wel_window.remove_child_rectangle (children.item.widget) 
					mark := mark + children.item.widget.height + children.item.padding + spacing 
					children.forth
				end
				mark := mark + children.item.padding	
				adapt_last_child_size (children.item, temp_width, temp_height, mark)
				children.item.widget.set_y (mark)
				wel_window.remove_child_rectangle (children.item.widget) 
			end
			wel_window.resize (temp_width, temp_height)
		end
		
feature {NONE} -- Usefull features

	adapt_child_size (a_child: EV_BOX_CHILD; a_width, a_height:INTEGER) is
			-- Adapt the attributes of the child according to the options of the box and the child :
			-- homogeneous, expand, fill, spacing.
			-- `a_width', `a_height' are the size of the container.
		local
			temp_height: INTEGER
		do
			if a_child.is_expand then
				if is_homogeneous and a_child.is_fill then
					temp_height := (a_height - total_spacing - total_children_padding) // children.count
				elseif is_homogeneous and not a_child.is_fill then
					temp_height := (minimum_height - total_spacing - total_children_padding)// children.count  -- max of minimum size of children
				elseif not is_homogeneous and a_child.is_fill then
					temp_height := a_child.widget.minimum_height + (a_height - minimum_height) // children.count 
				end
				a_child.widget.parent_ask_resize (a_width, temp_height)
			end
		end


	adapt_last_child_size (a_child: EV_BOX_CHILD; a_width, a_height, a_mark:INTEGER) is
			-- Adapt the attributes of the last child according to the options of the box.
		local
			temp_height: INTEGER
		do
			if a_child.is_expand then
				if a_child.is_fill then
					temp_height := a_height - a_mark - a_child.padding
				elseif is_homogeneous then
					temp_height := (minimum_height - total_spacing - total_children_padding)// children.count  -- max of minimum size of children
				end
				a_child.widget.parent_ask_resize (a_width, temp_height)
			end
		end


	add_children_height: INTEGER is
			-- Give the sum of the height of all the children
		local
			temp_result: INTEGER
		do
			if not children.empty then
				from
					children.start
				until
					children.after
				loop
					temp_result := temp_result + children.item.widget.minimum_height
					children.forth
				end
			end
			Result := temp_result
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
