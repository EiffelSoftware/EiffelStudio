indexing

	description: 
		"EiffelVision composite, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_CONTAINER_I
	
inherit
	EV_WIDGET_I

feature -- Access

	client_width: INTEGER is
			-- Width of the client area of container
		require
			exists: not destroyed
		deferred
		ensure
			positive_result: Result >= 0
		end
	
	client_height: INTEGER is
			-- Height of the client area of container
		require
			exists: not destroyed
		deferred
		ensure
			positive_result: Result >= 0
		end

	child: EV_WIDGET_IMP
			-- The child of the current container

feature -- Element change

	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into composite
		require
			exists: not destroyed
			valid_child: child_imp /= Void
			add_child_ok: add_child_ok
		deferred
		ensure
			child_add_successful: child_add_successful (child_imp)
		end

feature -- Assertion test

	add_child_ok: BOOLEAN is
			-- Used in the precondition of
			-- 'add_child'. True, if it is ok to add a
			-- child to container. Normal container have
			-- only one child, but this feature can be
			-- redefined in decendants.
		do
			Result := child = Void
		end

	child_add_successful (new_child: EV_WIDGET_I): BOOLEAN is
			-- Used in the postcondition of 'add_child'
		local
			child_imp: EV_WIDGET_IMP
		do
			child_imp ?= new_child
			Result := child = child_imp
		end
	
end -- class EV_CONTAINER_I

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
