indexing

	description: 
		"EiffelVision box, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	
	EV_BOX_IMP
	
inherit
	EV_BOX_I
		
	EV_INVISIBLE_CONTAINER_IMP
		redefine
			remove_child,
			child_added,
			is_child			
		end

feature -- Access

	is_homogeneous: BOOLEAN is
			-- Is the current box homogeneous
		do
			Result := c_gtk_box_homogeneous (widget) /= 0
		end

	border_width: INTEGER is
			-- Border width around container
		do
			Result := c_gtk_container_border_width (widget)
		end

feature -- Element change (box specific)
	
	set_homogeneous (flag: BOOLEAN) is
			-- Homogenous controls whether each object in
			-- the box has the same size.
		do
			gtk_box_set_homogeneous (widget, flag)
		end

	set_border_width (value: INTEGER) is
			-- Border width around container
		do
			gtk_container_set_border_width (widget, value)
		end	
	
	set_spacing (value: INTEGER) is
			-- Spacing between the objects in the box
		do
			gtk_box_set_spacing (widget, value)
		end	

feature -- Assertion test

	is_child (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Is `a_child' a child of the container?
		do
			Result := c_gtk_container_has_child (widget, a_child.box_widget)
		end

	child_added (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Has `a_child' been added properly?
		do
			Result := c_gtk_container_has_child (widget, a_child.box_widget)
		end

feature {EV_BOX} -- Implementation

	remove_child (child_imp: EV_WIDGET_IMP) is	
			-- Remove the given child.
			-- Function redefined because the widget is in a box. 
		do
			gtk_container_remove (GTK_CONTAINER (child_imp.box_widget), child_imp.widget)
			gtk_container_remove (GTK_CONTAINER (widget), child_imp.box_widget)
			
		end

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
