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
			remove_child,
			child_added,
			is_child
		end
	
create
	
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

feature -- Access

	horizontal_step: INTEGER is
			-- Step of the horizontal scrolling
			-- ie : the user clicks on a horizontal arrow
		do
		end

	horizontal_leap: INTEGER is
			-- Leap of the horizontal scrolling
			-- ie : the user clicks on the horizontal scroll bar
		do
		end

	vertical_step: INTEGER is
			-- Step of the vertical scrolling
			-- ie : the user clicks on a vertical arrow
		do
		end

	vertical_leap: INTEGER is
			-- Leap of the vertical scrolling
			-- ie : the user clicks on the vertical scroll bar
		do
		end

	horizontal_value: INTEGER is
			-- Current position of the horizontal scroll bar
		do
		end

	vertical_value: INTEGER is
			-- Current position of the vertical scroll bar
		do
		end

	horizontal_minimum: INTEGER is
			-- Minimal position on the horizontal scroll bar
		do
		end

	vertical_minimum: INTEGER is
			-- Maximal position on the vertical scroll bar
		do
		end

	horizontal_maximum: INTEGER is
			-- Maximal position on the horizontal scroll bar
		do
		end

	vertical_maximum: INTEGER is
			-- Maximal position on the vertical scroll bar
		do
		end

feature -- Element change

	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into composite.
			-- We redefine this feature because, there
			-- is 2 ways to add a child in a scrollable
			-- window depending on whether the child is scrollable
			-- or not so we can not use directly `gtk_container_add'.
		do
			c_gtk_scrollable_area_add (widget, child_imp.widget)
		end

	remove_child (child_imp: EV_WIDGET_IMP) is	
			-- Remove the given child from the children of
			-- the container.
			-- Redefined because we do not have any
			-- resizing options in an EV_SCROLLABLE_AREA.
		do
			-- Remove the child from the current container. 			
			gtk_container_remove (GTK_CONTAINER (widget), child_imp.widget)
		end

	set_horizontal_step (value: INTEGER) is
			-- Make `value' the new horizontal step.
		do
		end

	set_vertical_step (value: INTEGER) is
			-- Make `value' the new vertical step.
		do
		end

	set_horizontal_leap (value: INTEGER) is
			-- Make `value' the new horizontal leap.
		do
		end

	set_vertical_leap (value: INTEGER) is
			-- Make `value' the new vertical leap.
		do
		end

	set_horizontal_value (value: INTEGER) is
			-- Make `value' the new horizontal value where `value' is given in percentage.
			-- As this feature use and integer approximation, the post-condition is not
			-- always verified.
		do
		end

	set_vertical_value (value: INTEGER) is
			-- Make `value' the new vertical value where `value' is given in percentage.
			-- As this feature use and integer approximation, the post-condition is not
			-- always verified.
		do
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
