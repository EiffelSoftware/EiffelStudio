indexing

	description: 
		"EiffelVision split, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	
	EV_SPLIT_AREA_IMP
	
inherit
	
	EV_SPLIT_AREA_I
		redefine
			add_child1,
			add_child2
		end

	EV_CONTAINER_IMP
		undefine
			add_child_ok,
			child_add_successful,
			add_child
		end
		
	
feature {EV_SPLIT_AREA} -- Implementation
	
	add_child1 (child_imp: EV_WIDGET_IMP) is
			-- Add the first child of the split.
		do
			{EV_SPLIT_AREA_I} Precursor (child_imp)
			gtk_paned_add1 (widget, child_imp.widget)
		end
	
	add_child2 (child_imp: EV_WIDGET_IMP) is
			-- Add the second child.
		do
			{EV_SPLIT_AREA_I} Precursor (child_imp)
			gtk_paned_add2 (widget, child_imp.widget)
		end

end -- class EV_SPLIT_AREA_IMP

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
