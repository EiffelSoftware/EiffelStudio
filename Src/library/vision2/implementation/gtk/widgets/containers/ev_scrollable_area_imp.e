indexing
	description: "Eiffel Vision scrollable area. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_SCROLLABLE_AREA_IMP
	
inherit
	EV_SCROLLABLE_AREA_I
		redefine
			interface
		end
		
	EV_VIEWPORT_IMP
		redefine
			horizontal_adjustment,
			vertical_adjustment,
			interface,
			make,
			replace,
			item
		end
	
create
	make

feature {NONE} -- Initialization
	
        make (an_interface: like interface) is
                        -- Initialize. 
		do
			base_make (an_interface)
			set_c_object (
				C.gtk_scrolled_window_new (Default_pointer, Default_pointer)
			)

			set_scrolling_policy (C.GTK_POLICY_ALWAYS_ENUM, C.GTK_POLICY_ALWAYS_ENUM)

			set_horizontal_step (1)
			set_vertical_step (1)

			viewport := C.gtk_viewport_new (Default_pointer, Default_pointer)
			C.gtk_widget_show (viewport)
			C.gtk_container_add (c_object, viewport)
		end

feature -- Access

	item: EV_WIDGET is
			-- Current item
		local
			p: POINTER
			o: EV_ANY_IMP
		do
			p := C.gtk_container_children (viewport)
			if p/= Default_pointer then
				p := C.g_list_nth_data (p, 0)
				if p /= Default_pointer then
					o := eif_object_from_c (p)
					Result ?= o.interface
				end
			end
		end

	horizontal_step: INTEGER is
			-- Number of pixels scrolled up or down when user clicks
			-- an arrow on the horizontal scrollbar.
		do
			Result := C.gtk_adjustment_struct_step_increment (horizontal_adjustment).rounded
		end

	vertical_step: INTEGER is
			-- Number of pixels scrolled left or right when user clicks
			-- an arrow on the vertical scrollbar.
		do
			Result := C.gtk_adjustment_struct_step_increment (vertical_adjustment).rounded
		end

	is_horizontal_scrollbar_visible: BOOLEAN is
			-- Should horizontal scrollbar be displayed?
		do
			Result := horizontal_policy = C.GTK_POLICY_ALWAYS_ENUM
		end

	is_vertical_scrollbar_visible: BOOLEAN is
			-- Should vertical scrollbar be displayed?
		do
			Result := vertical_policy = C.GTK_POLICY_ALWAYS_ENUM
		end

feature -- Element change

	replace (v: like item) is
			-- Replace `item' with `v'.
		local
			i: EV_WIDGET
			imp: EV_WIDGET_IMP
		do
			i := item
			if i /= Void then
				imp ?= i.implementation
				C.gtk_container_remove (viewport, imp.c_object)
			end
			if v /= Void then
				imp ?= v.implementation
				C.gtk_container_add (viewport, imp.c_object)
			end
		end

	set_horizontal_step (a_step: INTEGER) is
			-- Set `horizontal_step' to `a_step'.
		do
			if horizontal_step /= a_step then
				C.set_gtk_adjustment_struct_step_increment (horizontal_adjustment, a_step)
				C.gtk_adjustment_changed (horizontal_adjustment)
			end
		end

	set_vertical_step (a_step: INTEGER) is
			-- Set `vertical_step' to `a_step'.
		do
			if vertical_step /= a_step then
				C.set_gtk_adjustment_struct_step_increment (vertical_adjustment, a_step)
				C.gtk_adjustment_changed (vertical_adjustment)
			end
		end

	show_horizontal_scrollbar is
			-- Display horizontal scrollbar.
		do
			set_scrolling_policy (C.GTK_POLICY_ALWAYS_ENUM, vertical_policy)			
		end

	hide_horizontal_scrollbar is
			-- Do not display horizontal scrollbar.
		do
			set_scrolling_policy (C.GTK_POLICY_NEVER_ENUM, vertical_policy)
		end

	show_vertical_scrollbar is
			-- Display vertical scrollbar.
		do
			set_scrolling_policy (horizontal_policy, C.GTK_POLICY_ALWAYS_ENUM)
		end

	hide_vertical_scrollbar is
			-- Do not display vertical scrollbar.
		do
			set_scrolling_policy (horizontal_policy, C.GTK_POLICY_NEVER_ENUM)
		end

feature {NONE} -- Implementation

	horizontal_adjustment: POINTER is
			-- Pointer to the adjustment struct of the hscrollbar
		do
			Result := C.gtk_scrolled_window_get_hadjustment (c_object)
		end

	vertical_adjustment: POINTER is
			-- Pointer to the adjustment struct of the vscrollbar
		do
			Result := C.gtk_scrolled_window_get_vadjustment (c_object)
		end

	horizontal_policy: INTEGER
		-- Policy type used for the horizontal scrollbar (ALWAYS, AUTOMATIC or NEVER)

	vertical_policy: INTEGER
		-- Policy type used for the vertical scrollbar (ALWAYS, AUTOMATIC or NEVER)

	set_scrolling_policy (hscrollpol, vscrollpol: INTEGER) is
			-- Set the policy for both scrollbars.
		do
			C.gtk_scrolled_window_set_policy (
				c_object,
				hscrollpol,
				vscrollpol
			)
			horizontal_policy := hscrollpol
			vertical_policy := vscrollpol
		end

feature {EV_ANY_I} -- Implementation		

	interface: EV_SCROLLABLE_AREA
			-- Provides a common user interface to platform dependent 
			-- functionality implemented by `Current'

end -- class EV_SCROLLABLE_AREA_IMP

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
--| Revision 1.9  2000/02/14 11:40:31  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.8.6.8  2000/02/12 00:33:52  king
--| Set hor/ver step to 1
--|
--| Revision 1.8.6.7  2000/02/12 00:24:46  king
--| Implemented scrollable area to new structure
--|
--| Revision 1.8.6.6  2000/02/11 19:00:16  oconnor
--| formatting
--|
--| Revision 1.8.6.5  2000/02/10 21:53:17  oconnor
--| started implementation
--|
--| Revision 1.8.6.4  2000/02/04 04:25:38  oconnor
--| released
--|
--| Revision 1.8.6.3  2000/01/28 19:30:14  brendel
--| Revision.
--| Now inherits from EV_VIEWPORT and adds the scrollbars to the viewable area.
--|
--| Revision 1.8.6.2  2000/01/27 19:29:43  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.8.6.1  1999/11/24 17:29:54  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.8.2.3  1999/11/17 01:53:03  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.8.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
