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

	child_has_resized (new_width, new_height:INTEGER; child: EV_WIDGET_IMP) is
			-- Resize and replace all its children according
			-- to the resize of one of them.
		do
			if new_width > (minimum_width // children.count) or new_height > (minimum_height) then
				set_size (new_width, new_height)
				set_minimum_height (minimum_height.max(child.minimum_height))
				set_minimum_width (minimum_width.max(child.minimum_width * children.count))
			else
				child.parent_ask_resize (minimum_width // children.count, minimum_height)
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
						children.item.parent_ask_resize (temp_width // children.count, temp_height)
						children.item.set_x (mark)
						mark := mark + (temp_width // children.count)
						children.forth
					end
					children.item.parent_ask_resize (temp_width - mark, temp_height)
					children.item.set_x (mark)
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
