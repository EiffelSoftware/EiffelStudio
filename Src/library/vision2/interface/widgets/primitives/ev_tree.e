indexing
	description: 
		"EiffelVision tree. A tree show a hierarchy with%
		% several levels of items."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TREE

inherit
	EV_PRIMITIVE
		redefine
			implementation
		end

	EV_TREE_ITEM_CONTAINER
		redefine
			implementation
		end

creation
	make

feature {NONE} -- Initialization
	
	make (par: EV_CONTAINER) is         
			-- Create a tree widget with `par' as
			-- parent.
		do
			!EV_TREE_IMP!implementation.make (par)
			widget_make (par)
		end

feature {EV_TREE_ITEM} -- Implementation
	
	implementation: EV_TREE_I	

end -- class EV_TREE

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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
--|---------------------------------------------------------------
