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


feature {NONE} -- Resizing


	child_has_resized (new_width, new_height: INTEGER; child: EV_WIDGET_IMP) is
			-- Resize and replace all its children according to the resize of one of them.
			-- If the new child has a minimal size which is bigger than the minimum size of
			-- the others
		do
			if new_height > (minimum_height // children.count) or new_width > minimum_width then
				set_size (new_width, new_height)
				set_minimum_width (minimum_width.max(child.minimum_width))
				set_minimum_height (minimum_height.max(child.minimum_height * children.count))
			else
				child.parent_ask_resize (minimum_width, minimum_height // children.count)
			end
		end


	parent_ask_resize (new_width:INTEGER; new_height: INTEGER) is
			-- Resize the box and all the children inside
		local
			mark, temp_width, temp_height: INTEGER
		do
			if new_height > minimum_height or new_width > minimum_width then
				temp_width := minimum_width.max (new_width)
				temp_height := minimum_height.max (new_height)
				if not children.empty then
					from
						children.start
					until
						children.islast
					loop
						children.item.parent_ask_resize (temp_width, temp_height // children.count)
						children.item.set_y (mark) 
						mark := mark + ( temp_height // children.count ) 
						children.forth
					end
					children.item.parent_ask_resize (temp_width, temp_height - mark)
					children.item.set_y (mark) 
				end
				wel_window.resize (temp_width, temp_height)
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
