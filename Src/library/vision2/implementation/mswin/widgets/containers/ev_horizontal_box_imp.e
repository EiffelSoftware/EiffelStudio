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
			if not children.empty then
				from
					children.start
				until
					children.after
				loop
					children.item.parent_ask_resize(children.item.width, temp_height)
					children.forth
				end
			end
			wel_window.resize (width, temp_height)
		end

	set_local_width (new_width: INTEGER) is
		-- Set `new_width' to the box and adapt the children width.
		local
			mark, temp_width: INTEGER
		do
			temp_width := minimum_width.max (new_width)
			if not children.empty then
				wel_window.disable_default_processing
				from
					children.start
				until
					children.islast
				loop
					children.item.wel_window.disable_default_processing
					adapt_child_size (children.item, temp_width, height)
					children.item.set_x (mark)
					mark := mark + children.item.width + spacing
					children.item.wel_window.enable_default_processing
					children.forth
				end
				children.item.wel_window.disable_default_processing
				adapt_last_child_size (children.item, temp_width, height, mark)
				children.item.set_x (mark)
				children.item.wel_window.enable_default_processing
			end
			wel_window.resize (temp_width, height) 
			wel_window.enable_default_processing
		end
		

	adapt_child_size (a_child: EV_WIDGET_IMP; a_width, a_height:INTEGER) is
			-- Adapt the attributes of the child according to the options of the box and the child :
			-- homogeneous, expand, fill, spacing.
			-- `a_width', `a_height' are the size of the container.
		local
			temp_width: INTEGER
		do
--			if a_child.is_expand then
--				if is_homogeneous and a_child.is_fill then
					temp_width := (a_width - total_spacing) // children.count
--				elseif is_homogeneous and not a_child.is_fill then
--					temp_width := (minimum_width - total_spacing - total_children_padding)// children.count  -- max of minimum size of children
--				elseif not is_homogeneous and a_child.is_fill then
--					temp_width := a_child.widget.minimum_width + (a_width - minimum_width) // children.count 
--				end
				a_child.parent_ask_resize (temp_width, a_height)
--			end
		end


	adapt_last_child_size (a_child: EV_WIDGET_IMP; a_width, a_height, a_mark:INTEGER) is
			-- Adapt the attributes of the last child according to the options of the box.
		local
			temp_width: INTEGER
		do
--			if a_child.is_expand then
--				if a_child.is_fill then
					temp_width := a_width - a_mark
--				elseif is_homogeneous then
--					temp_width := (minimum_width - total_spacing - total_children_padding)// children.count  -- max of minimum size of children
--				end
				a_child.parent_ask_resize (temp_width, a_height)
--			end
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
					temp_result := temp_result + children.item.minimum_width
					children.forth
				end
			end
			Result := temp_result
		end
		

feature {NONE} -- Implementation

	child_has_resized (child_width, child_height:INTEGER; child: EV_WIDGET_IMP) is
			-- Resize and replace all its children according
			-- to the resize of one of them.
		do
			if shown then
				if child_width >= (minimum_width - total_spacing) // children.count or child_height >= minimum_height then
					parent_ask_resize ((child_width * children.count) + total_spacing, child_height)
					if parent_imp /= Void then
						parent_imp.child_has_resized (width, height, Current)
					end
				else
					child.parent_ask_resize ((minimum_width - total_spacing) // children.count, minimum_height)
				end
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
			if is_homogeneous and child_new_minimum > (minimum_width - total_spacing) // children.count then
				set_minimum_width (child_new_minimum * children.count + total_spacing)
			else
				set_minimum_width (add_children_width + total_spacing)
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
