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
			child_packing_changed
--			remove_child,
--			child_added,
--			is_child			
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

	spacing: INTEGER is
			-- Spacing between the objects in the box
		do
			Result := c_gtk_box_spacing (widget)
		end
	
feature -- Status report

	is_child_expandable (child: EV_WIDGET): BOOLEAN is
			-- Is the child corresponding to `index' expandable. ie: does it
			-- accept the parent to resize or move it.
		deferred
		end
	
feature -- Status settings

	set_child_expandable (child: EV_WIDGET; flag: BOOLEAN) is
			-- Make the child corresponding to `index' expandable if `flag',
			-- not expandable otherwise.
		deferred
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

feature {EV_CONTAINER_IMP, EV_WIDGET_IMP} -- Implementation

	child_packing_changed (the_child: EV_WIDGET_IMP) is
			-- changed the settings of his child `the_child'.
			-- Redefined because there is an `is_child_expandable' option.
		local
			child_interface: EV_WIDGET
		do
			child_interface ?= the_child.interface
			inspect
				the_child.resize_type
			when 0 then
				-- 0 : no horizontal nor vertical resizing, the widget moves
				c_gtk_box_set_child_options (the_child.vbox_widget, the_child.hbox_widget, is_child_expandable(child_interface), False)
					-- To forbid vertical resizing
				c_gtk_box_set_child_options (the_child.hbox_widget, the_child.widget, True, False)
					-- To forbid horizontal resizing
			when 1 then
				-- 1 : only the width changes
				c_gtk_box_set_child_options (the_child.vbox_widget, the_child.hbox_widget, is_child_expandable(child_interface), False)
					-- To forbid vertical resizing
				c_gtk_box_set_child_options (the_child.hbox_widget, the_child.widget, True, True)
					-- To allow horizontal resizing
			when 2 then
				-- 2 : only the height changes
				c_gtk_box_set_child_options (the_child.vbox_widget, the_child.hbox_widget, is_child_expandable(child_interface), True)
					-- To allow vertical resizing
				c_gtk_box_set_child_options (the_child.hbox_widget, the_child.widget, True, False)
					-- To forbid horizontal resizing
			when 3 then
				-- 3 : both width and height change
				c_gtk_box_set_child_options (the_child.vbox_widget, the_child.hbox_widget, is_child_expandable(child_interface), True)
					-- To allow vertical resizing
				c_gtk_box_set_child_options (the_child.hbox_widget, the_child.widget, True, True)
					-- To allow horizontal resizing
			end
		end

end -- class EV_BOX_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------
