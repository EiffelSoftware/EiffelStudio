indexing

	description: 
		"EiffelVision scrollable_area, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	
	EV_SCROLLABLE_AREA_IMP
	
inherit
	EV_SCROLLABLE_AREA_I
		
	EV_CONTAINER_IMP
		redefine
			add_child,
			child_added,
			is_child
		end
	
creation
	
	make

feature {NONE} -- Initialization
	
        make is
                        -- Create a scrollable_area widget. 
		do
			widget := gtk_scrolled_window_new ( Default_pointer, 
							    Default_pointer)
			gtk_object_ref (widget)
			gtk_scrolled_window_set_policy (gtk_scrolled_window (widget), 
							gtk_policy_automatic, 
							gtk_policy_automatic)
		end	

feature -- Element change

	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into composite.
			-- We redefine this feature because, there
			-- is 2 ways to add a child in a scrollable
			-- window depending on whether the child is scrollable
			-- or not.
		do
			c_gtk_scrollable_area_add (widget, child_imp.widget)
		end

feature -- Assertion test

	is_child (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Is `a_child' a child of the container?
		do
			Result := c_gtk_scrollable_area_has_child (widget, a_child.widget)
		end

	child_added (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Has `a_child' been added properly?
		do
 			Result := c_gtk_scrollable_area_has_child (widget, a_child.widget)
		end

end -- class EV_SCROLLABLE_AREA_IMP

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
