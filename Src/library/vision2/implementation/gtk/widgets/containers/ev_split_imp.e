indexing

	description: 
		"EiffelVision split, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	
	EV_SPLIT_IMP
	
inherit
	
	EV_SPLIT_I

	EV_CONTAINER_IMP
		
	
feature {EV_SPLIT} -- Implementation
	
	add_child1 (child_imp: EV_WIDGET_IMP) is
			-- Add the first child of the split.
		do
			gtk_paned_add1 (widget, child_imp.widget)
		end
	
	add_child2 (child_imp: EV_WIDGET_IMP) is
			-- Add the second child.
		do
			gtk_paned_add2 (widget, child_imp.widget)
		end

end

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
