indexing
	description: 
		"Eiffel Vision box.%N%
		%Invisible container with unlimited number of children."
	status: "See notice at end of class"
	keywords: "box, container, child"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_BOX

inherit
	EV_WIDGET_LIST
		redefine
			implementation,
			is_in_default_state
		end

feature -- Status report

	is_homogeneous: BOOLEAN is
			-- Are all children restriced to be the same size.
		do
			Result := implementation.is_homogeneous
		ensure
			bridge_ok: Result = implementation.is_homogeneous
		end

	border_width: INTEGER is
			-- Width of border around container in pixels.
		do
			Result := implementation.border_width
		ensure
			bridge_ok: Result = implementation.border_width
			positive: Result >= 0
		end

	padding: INTEGER is
			-- Space between children in pixels.
		do
			Result := implementation.padding
		ensure
			bridge_ok: Result = implementation.padding
			positive: Result >= 0
		end 

feature -- Status report

	is_child_expanded (child: EV_WIDGET): BOOLEAN is
			-- Is `child' expanded to occupy avalible spare space.
		require
			has_child: has (child)
		do
			Result := implementation.is_child_expanded (child)
		ensure
			bridge_ok: Result = implementation.is_child_expanded (child)
		end

feature -- Status setting
	
	enable_homogeneous is
			-- Make every child the same size.
		do
			implementation.set_homogeneous (True)
		ensure
			is_homogeneous: is_homogeneous
		end

	disable_homogeneous is
			-- Remove restriction that every child is the same size.
		do
			implementation.set_homogeneous (False)
		ensure
			not_is_homogeneous: not is_homogeneous
		end

	set_border_width (value: INTEGER) is
			-- Assign `value' to `border_width'.
		require
			positive_value: value >= 0
		do
			implementation.set_border_width (value)
		ensure
			border_width_assigned: border_width = value
		end

	set_padding (value: INTEGER) is
			-- Assign `value' to `padding'.
		require
			positive_value: value >= 0
		do
			implementation.set_padding (value)
		ensure
			padding_assigned: padding = value
		end

	enable_child_expand (child: EV_WIDGET) is
			-- Expand `child' to occupy avalible spare space.
		require
			has_child: has (child)
		do
			implementation.set_child_expandable (child, True)
		ensure
			child_expanded: is_child_expanded (child)
		end

	disable_child_expand (child: EV_WIDGET) is
			-- Do not expand `child' to occupy avalible spare space.
		require
			has_child: has (child)
		do
			implementation.set_child_expandable (child, False)
		ensure
			not_child_expanded: not is_child_expanded (child)
		end

feature -- Implementation
	
	implementation: EV_BOX_I
			-- Platform dependent access.

feature {EV_ANY} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state.
		do
			Result := {EV_WIDGET_LIST} Precursor and (
				not is_homogeneous and
				border_width = 0 and
				padding = 0			
			)
		end
			
end -- class EV_BOX

--!-----------------------------------------------------------------------------
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.17  2000/02/14 11:40:51  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.16.6.7  2000/01/28 20:00:12  oconnor
--| released
--|
--| Revision 1.16.6.6  2000/01/27 19:30:50  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.16.6.5  1999/12/16 02:26:18  oconnor
--| added initial state check
--|
--| Revision 1.16.6.4  1999/12/15 20:17:29  oconnor
--| reworking box formatting, contracts and names
--|
--| Revision 1.16.6.3  1999/12/15 18:33:05  oconnor
--| formatting
--|
--| Revision 1.16.6.2  1999/11/24 22:40:58  oconnor
--| added review notes
--|
--| Revision 1.16.6.1  1999/11/24 17:30:51  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.16.2.5  1999/11/09 16:53:16  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.16.2.4  1999/11/04 23:10:54  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.16.2.3  1999/11/02 17:20:12  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
