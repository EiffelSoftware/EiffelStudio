indexing

	description: 
		"EiffelVision box, deferred class, parent of vertical and%
		 %horizontal boxes. Mswindows implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	
	EV_BOX_IMP

inherit

	EV_BOX_I

	EV_INVISIBLE_CONTAINER_IMP
		undefine
			add_child
		end


feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
				-- Create the box
		local
			count_imp: EV_CONTAINER_IMP
		do
			count_imp ?= par.implementation
			check
				valid_container: count_imp /= Void
			end
			!! wel_window.make_with_coordinates (count_imp.wel_window, "", 0, 0, 0, 0)
			!! children.make
		end


feature {NONE} -- Implementation

	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into composite at the level position.
		do
			child_imp.set_parent_imp (Current)
			children.extend (child_imp)
		end

	remove_child (child_imp: EV_WIDGET_IMP) is
			-- Remove a given child of the composite
		do
			children.go_i_th (children.index_of (child_imp,1))
			children.remove
--			set_minimum (fonction a rajouter qui recherche le minimum des tailles des enfants)
			parent_ask_resize (minimum_width, minimum_height)
		end


feature {EV_BOX_IMP} -- Access

	children: LINKED_LIST [EV_WIDGET_IMP]
			-- List of the children of the box

end -- class EV_BOX_IMP

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
