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

	EV_CONTAINER_IMP
		redefine
			add_child,
			add_child_ok
		end

feature -- Status setting

	set_position (value: INTEGER) is
			-- Make `value' the new position of the splitter.
			-- `value' is given in percentage.
		do
			check
				not_yet_implemented: False
			end
		end

feature -- Element change

	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add the first child of the split.
		do
			if c_gtk_paned_child1 (widget) = default_pointer then
				gtk_paned_add1 (widget, child_imp.widget)
			elseif c_gtk_paned_child2 (widget) = default_pointer then
				gtk_paned_add2 (widget, child_imp.widget)
			end
		end

feature -- Assertion test

	add_child_ok: BOOLEAN is
			-- Used in the precondition of
			-- 'add_child'. True, if it is ok to add a
			-- child to container.
		do
			Result := c_gtk_container_nb_children (widget) < 2
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
