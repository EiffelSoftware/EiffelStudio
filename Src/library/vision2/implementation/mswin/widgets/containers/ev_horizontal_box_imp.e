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
			child_has_resized,
			parent_ask_resize
		end
		

creation
	make


feature {NONE} -- Implementation

	child_has_resized (child_width, child_height:INTEGER; child: EV_WIDGET_IMP) is
			-- Resize and replace all its children according
			-- to the resize of one of them.
		do
				if child_width >= (minimum_width - total_children_padding - total_spacing) // children.count 
						or child_height >= minimum_height then

				-- first, we set the minimum_size of the window to the proper value
				if is_homogeneous then 
					set_minimum_size (minimum_width.max(child.minimum_width * children.count + total_children_padding + total_spacing),
										minimum_height.max(child.minimum_height))
				else
					set_minimum_size (add_children_width + total_children_padding + total_spacing,
										minimum_height.max(child.minimum_height))
				end

					-- Then, we resize the container
				parent_ask_resize ( (child_width * children.count) + total_children_padding + total_spacing, child_height)

					-- To finish, we inform the parent of this change
				if parent_imp /= Void then
					parent_imp.child_has_resized (width, height, Current)
				end
			else
				child.parent_ask_resize ((minimum_width - total_children_padding - total_spacing ) // children.count, minimum_height)
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
				from
					children.start
				until
					children.islast
				loop
					mark := mark + children.item.padding
					adapt_child_size (children.item, temp_width, temp_height)
					children.item.widget.set_x (mark)
					mark := mark + children.item.widget.width + children.item.padding + spacing
					children.forth
				end
				mark := mark + children.item.padding
				adapt_last_child_size (children.item, temp_width, temp_height, mark)
				children.item.widget.set_x (mark)
			end
			wel_window.resize (temp_width, temp_height) 
		end


feature {NONE} -- Usefull features

	adapt_child_size (a_child: EV_BOX_CHILD; a_width, a_height:INTEGER) is
			-- Adapt the attributes of the child according to the options of the box and the child :
			-- homogeneous, expand, fill, spacing.
			-- `a_width', `a_height' are the size of the container.
		local
			temp_width: INTEGER
		do
			if a_child.is_expand then
				if is_homogeneous and a_child.is_fill then
					temp_width := (a_width - total_spacing - total_children_padding) // children.count
				elseif is_homogeneous and not a_child.is_fill then
					temp_width := (minimum_width - total_spacing - total_children_padding)// children.count  -- max of minimum size of children
				elseif not is_homogeneous and a_child.is_fill then
					temp_width := a_child.widget.minimum_width + (a_width - minimum_width) // children.count 
				end
				a_child.widget.parent_ask_resize (temp_width, a_height)
			end
		end


	adapt_last_child_size (a_child: EV_BOX_CHILD; a_width, a_height, a_mark:INTEGER) is
			-- Adapt the attributes of the last child according to the options of the box.
		local
			temp_width: INTEGER
		do
			if a_child.is_expand then
				if a_child.is_fill then
					temp_width := a_width - a_mark - a_child.padding
				elseif is_homogeneous then
					temp_width := (minimum_width - total_spacing - total_children_padding)// children.count  -- max of minimum size of children
				end
				a_child.widget.parent_ask_resize (temp_width, a_height)
			end
		end


	add_children_width: INTEGER is
			-- Give the sum of the width of all the children
		local
			temp_result: INTEGER
		do
			if not children.empty then
				from
					children.start
				until
					children.after
				loop
					temp_result := temp_result + children.item.widget.minimum_width
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
