indexing
	description: 
		"EiffelVision box. GTK+ implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_BOX_IMP
	
inherit
	EV_BOX_I
		redefine
			interface
		end

	EV_WIDGET_LIST_IMP
		redefine
			interface
		end
		
feature -- Access

	is_homogeneous: BOOLEAN is
			-- Are all children restriced to be the same size.
		do
			Result := C.c_gtk_box_homogeneous (c_object) /= 0
		end

	border_width: INTEGER is
			-- Width of border around container in pixels.
		do
			Result := C.c_gtk_container_border_width (c_object)
		end

	padding: INTEGER is
			-- Space between children in pixels.		
		do
			Result := C.c_gtk_box_spacing (c_object)
		end
	
feature -- Status report

	is_child_expanded (child: EV_WIDGET): BOOLEAN is
			-- Is `child' expanded to occupy avalible spare space.
		local
			fill: BOOLEAN
			expand, pad, pack_type: INTEGER
			wid_imp: EV_WIDGET_IMP
		do
			wid_imp ?= child.implementation
			C.gtk_box_query_child_packing (
				c_object,
				wid_imp.c_object,
				$expand,
				$fill,
				$pad,
				$pack_type
			)
			Result := expand.to_boolean
		end
	
feature -- Status settings
	
	set_homogeneous (flag: BOOLEAN) is
			-- Set whether every child is the same size.
		do
			C.gtk_box_set_homogeneous (c_object, flag)
		end

	set_border_width (value: INTEGER) is
			 -- Assign `value' to `border_width'.
		do
			C.gtk_container_set_border_width (c_object, value)
		end	
	
	set_padding (value: INTEGER) is
			-- Assign `value' to `padding'.
		do
			C.gtk_box_set_spacing (c_object, value)
		end	

	set_child_expandable (child: EV_WIDGET; flag: BOOLEAN) is
			-- Set whether `child' expands to fill available spare space.
		local
			old_expand, fill, pad, pack_type: INTEGER
			wid_imp: EV_WIDGET_IMP
		do
			wid_imp ?= child.implementation
			C.gtk_box_query_child_packing (
				c_object,
				wid_imp.c_object,
				$old_expand,
				$fill,
				$pad,
				$pack_type
			)
			C.gtk_box_set_child_packing (
				c_object,
				wid_imp.c_object,
				flag,
				fill.to_boolean,
				pad,
				pack_type
			)
		end

feature {EV_CONTAINER_IMP, EV_WIDGET_IMP} -- Implementation

-- FIXME probably obsolete (Sam 19991215)
	child_packing_changed (the_child: EV_WIDGET_IMP) is
			-- changed the settings of his child `the_child'.
			-- Redefined because there is an `is_child_expandable' option.
		local
			child_interface: EV_WIDGET
		do
			child_interface ?= the_child.interface
	--		inspect
	--			the_child.resize_type
	--		when 0 then
				-- 0 : no horizontal nor vertical resizing, the widget moves
--				c_gtk_box_set_child_options (the_child.vbox_widget, the_child.hbox_widget, is_child_expandable(child_interface), False)
--					-- To forbid vertical resizing
--				c_gtk_box_set_child_options (the_child.hbox_widget, the_child.widget, True, False)
--					-- To forbid horizontal resizing
	--		when 1 then
--				-- 1 : only the width changes
--				c_gtk_box_set_child_options (the_child.vbox_widget, the_child.hbox_widget, is_child_expandable(child_interface), False)
--					-- To forbid vertical resizing
--				c_gtk_box_set_child_options (the_child.hbox_widget, the_child.widget, True, True)
--					-- To allow horizontal resizing
	--		when 2 then
--				-- 2 : only the height changes
--				c_gtk_box_set_child_options (the_child.vbox_widget, the_child.hbox_widget, is_child_expandable(child_interface), True)
--					-- To allow vertical resizing
--				c_gtk_box_set_child_options (the_child.hbox_widget, the_child.widget, True, False)
--					-- To forbid horizontal resizing
	--		when 3 then
--				-- 3 : both width and height change
--				c_gtk_box_set_child_options (the_child.vbox_widget, the_child.hbox_widget, is_child_expandable(child_interface), True)
--					-- To allow vertical resizing
--				c_gtk_box_set_child_options (the_child.hbox_widget, the_child.widget, True, True)
--					-- To allow horizontal resizing
	--		end
		end
		
feature {EV_ANY_I} -- Implementation

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
		do
			C.gtk_box_reorder_child (a_container, a_child, a_position)
		end

	interface: EV_BOX
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

end -- class EV_BOX_IMP

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
--| Revision 1.22  2000/02/14 11:40:31  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.21.6.12  2000/02/04 21:24:03  king
--| Corrected spelling in comment
--|
--| Revision 1.21.6.11  2000/02/04 04:25:37  oconnor
--| released
--|
--| Revision 1.21.6.10  2000/01/27 19:29:42  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.21.6.9  2000/01/19 18:09:46  oconnor
--| commentd out obsolete code
--|
--| Revision 1.21.6.8  2000/01/18 17:53:36  oconnor
--| Added EV_WIDGET_LIST.gtk_reorder_child deferred.
--| Defined in ev_notebook_imp.e and ev_box_imp.e.
--| GTK is missing a GtkMultiContainer class so there is no way
--| to polymorphicaly call gtk_box_reorder_child and gtk_notebook_reorder_child.
--|
--| Revision 1.21.6.7  1999/12/17 23:19:00  oconnor
--| use INTEGER not BOOLEAN when passing to C
--|
--| Revision 1.21.6.6  1999/12/16 02:38:09  oconnor
--| added comments
--|
--| Revision 1.21.6.5  1999/12/15 23:50:49  oconnor
--| moved expandable implementation to BOX_IMP, redid comments
--|
--| Revision 1.21.6.4  1999/12/15 20:17:28  oconnor
--| reworking box formatting, contracts and names
--|
--| Revision 1.21.6.3  1999/12/04 18:59:18  oconnor
--| moved externals into EV_C_EXTERNALS, accessed through EV_ANY_IMP.C
--|
--| Revision 1.21.6.2  1999/11/30 23:15:47  oconnor
--| redefine interface to be of more refined type
--|
--| Revision 1.21.6.1  1999/11/24 17:29:53  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.21.2.3  1999/11/17 01:53:03  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.21.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
