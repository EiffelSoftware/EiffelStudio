indexing
	description: 
		"A common class for the container with only%
		% one child."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SINGLE_CHILD_CONTAINER_IMP

inherit
	EV_CONTAINER_IMP
		redefine
			set_insensitive
		end

feature -- Access

	child: EV_WIDGET_IMP
			-- The child of the container.

feature -- Status report

	set_insensitive (flag: BOOLEAN) is
			-- Set current widget in insensitive mode if
   			-- `flag'.
		do
			if child /= Void then
				child.set_insensitive (flag)
			end
			{EV_CONTAINER_IMP} Precursor (flag)
		end

feature -- Element change

	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into composite
		do
			child := child_imp
			notify_change (2 + 1)
		end

	remove_child (child_imp: EV_WIDGET_IMP) is
			-- Remove the given child from the children of
			-- the container.
		do
			child := Void
			notify_change (2 + 1)
		end

feature -- Basic operations

	propagate_background_color is
			-- Propagate the current background color of the container
			-- to the children.
		do
			if child /= Void then
				child.set_background_color (background_color)
			end
		end

	propagate_foreground_color is
			-- Propagate the current foreground color of the container
			-- to the children.
		do
			if child /= Void then
				child.set_foreground_color (foreground_color)
			end
		end

feature -- Assertion

	add_child_ok: BOOLEAN is
			-- Used in the precondition of
			-- 'add_child'. True, if it is ok to add a
			-- child to container.
		do
			Result := child = Void
		end

	is_child (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Is `a_child' a child of the container?
		do
			Result := a_child = child
		end

end -- class EV_SINGLE_CHILD_CONTAINER_IMP

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
