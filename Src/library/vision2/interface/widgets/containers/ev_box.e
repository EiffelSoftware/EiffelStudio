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
			is_in_default_state,
			make_for_test
		end

feature -- Initialization

	make_for_test is
		local
			timer: EV_TIMEOUT
		do
			{EV_WIDGET_LIST} Precursor
			create timer.make_with_interval (1000)
			timer.actions.extend (~do_test)
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

	is_item_expanded (an_item: EV_WIDGET): BOOLEAN is
			-- Is `an_item' expanded to occupy avalible spare space.
			--| FIXME rename implmenetation.is_child_expanded to
			--| implmenetation.is_item_expanded
		require
			has_an_item: has (an_item)
		do
			Result := implementation.is_child_expanded (an_item)
		ensure
			bridge_ok: Result = implementation.is_child_expanded (an_item)
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

	enable_item_expand (an_item: EV_WIDGET) is
			-- Expand `an_item' to occupy avalible spare space.
			--| FIXME reimplement _I to use this interface not
			--| set_child_expandable
		require
			has_an_item: has (an_item)
		do
			implementation.set_child_expandable (an_item, True)
		ensure
			an_item_expanded: is_item_expanded (an_item)
		end

	disable_item_expand (an_item: EV_WIDGET) is
			-- Do not expand `an_item' to occupy avalible spare space.
			--| FIXME reimplement _I to use this interface not
			--| set_child_expandable
		require
			has_an_item: has (an_item)
		do
			implementation.set_child_expandable (an_item, False)
		ensure
			not_an_item_expanded: not is_item_expanded (an_item)
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

	do_test is
			-- Cycle the first widget into the last position.
		local
			w: EV_WIDGET
		do
			w := first
			if w /= Void then
				prune_all (w)
				extend (w)
			end
		end

feature -- Obsolete

	is_child_expanded (child: EV_WIDGET): BOOLEAN is
		obsolete
			"use is_item_expanded"
		do
			Result := is_item_expanded (child)
		end

	enable_child_expand (child: EV_WIDGET) is
		obsolete
			"use enable_item_expand"
		do
			enable_item_expand (child)
		end

	disable_child_expand (child: EV_WIDGET) is
		obsolete
			"use disable_item_expand"
		do
			disable_item_expand (child)
		end
			
end -- class EV_BOX

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--| Revision 1.22  2000/03/09 01:28:31  oconnor
--| Renamed *_child_expand* to *_item_expand*
--|
--| Revision 1.21  2000/03/01 03:25:32  oconnor
--| added make_for_test
--|
--| Revision 1.20  2000/03/01 03:24:19  oconnor
--| reverted last commit which was in error
--|
--| Revision 1.19  2000/03/01 03:12:30  oconnor
--| added create make_for_testnterface/widgets/primitives/ev_vertical_separator.e
--|
--| Revision 1.18  2000/02/22 18:39:50  oconnor
--| updated copyright date and formatting
--|
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
