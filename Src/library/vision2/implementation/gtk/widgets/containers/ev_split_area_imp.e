--| FIXME NOT_REVIEWED this file has not been reviewed
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

feature -- Status report

	position: INTEGER is
			-- The position of the split in pixels.
		do
			Result := c_gtk_paned_child1_size (widget)
		end

	minimum_position: INTEGER is
			-- Minimum position the splitter can have.
		do
			check
				To_Be_implemented: False
			end
		end

	maximum_position: INTEGER is
			-- Maximum position the splitter can have.
		do
			check
				To_Be_implemented: False
			end
		end

	is_first_area_shrinkable: BOOLEAN is
			-- Can the first area be shrunk to a size smaller than the
			-- child it contains? True if it does not contain any child.
		do
			check
				To_Be_implemented: False
			end
		end

	is_second_area_shrinkable: BOOLEAN is
			-- Can the second area be shrunk to a size smaller than the
			-- child it contains? True if it does not contain any child.
		do
			check
				To_Be_implemented: False
			end
		end

feature -- Status setting

	set_position (value: INTEGER) is
			-- Make `value' the new position of the splitter.
			-- `value' is given in pixel.
		do
			gtk_paned_set_position (widget, value)
		end

	set_first_area_shrinkable (flag: BOOLEAN) is
			-- Allow the split area to shrink the first area if `flag', forbid
			-- it otherwise.
		do
			check
				To_Be_implemented: False
			end
		end

	set_second_area_shrinkable (flag: BOOLEAN) is
			-- Allow the split area to shrink the second area if `flag', forbid
			-- it otherwise.
		do
			check
				To_Be_implemented: False
			end
		end

feature -- Element change

	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add the first child of the split.
		do
			-- Create `vbox_widget' and `hbox_widget'.
			add_child_packing (child_imp)

			if c_gtk_paned_child1 (widget) = default_pointer then
				gtk_paned_add1 (widget, child_imp.vbox_widget)
			elseif c_gtk_paned_child2 (widget) = default_pointer then
				gtk_paned_add2 (widget, child_imp.vbox_widget)
			end

			-- Sets the resizing options.
			child_packing_changed (child_imp) 
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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.9  2000/02/14 11:40:31  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.8.6.3  2000/02/04 04:25:38  oconnor
--| released
--|
--| Revision 1.8.6.2  2000/01/27 19:29:43  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.8.6.1  1999/11/24 17:29:54  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.8.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
