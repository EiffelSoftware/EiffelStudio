indexing
	description: "Eiffel Vision scrollable area. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_SCROLLABLE_AREA_IMP
	
inherit
	EV_SCROLLABLE_AREA_I
		undefine
			propagate_foreground_color,
			propagate_background_color
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
			item,
			visual_widget
		end
	
create
	make

feature {NONE} -- Initialization
	
        make (an_interface: like interface) is
                        -- Initialize.
		do
			base_make (an_interface)
			set_c_object (C.gtk_scrolled_window_new (NULL, NULL))

			set_scrolling_policy (C.GTK_POLICY_ALWAYS_ENUM, C.GTK_POLICY_ALWAYS_ENUM)

			set_horizontal_step (10)
			set_vertical_step (10)

			viewport := C.gtk_viewport_new (NULL, NULL)
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
			if p/= NULL then
				p := C.g_list_nth_data (p, 0)
				if p /= NULL then
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

	is_horizontal_scroll_bar_visible: BOOLEAN is
			-- Should horizontal scroll bar be displayed?
		do
			Result := horizontal_policy = C.GTK_POLICY_ALWAYS_ENUM
		end

	is_vertical_scroll_bar_visible: BOOLEAN is
			-- Should vertical scroll bar be displayed?
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

	show_horizontal_scroll_bar is
			-- Display horizontal scroll bar.
		do
			set_scrolling_policy (C.GTK_POLICY_ALWAYS_ENUM, vertical_policy)			
		end

	hide_horizontal_scroll_bar is
			-- Do not display horizontal scroll bar.
		do
			set_scrolling_policy (C.GTK_POLICY_NEVER_ENUM, vertical_policy)
		end

	show_vertical_scroll_bar is
			-- Display vertical scroll bar.
		do
			set_scrolling_policy (horizontal_policy, C.GTK_POLICY_ALWAYS_ENUM)
		end

	hide_vertical_scroll_bar is
			-- Do not display vertical scroll bar.
		do
			set_scrolling_policy (horizontal_policy, C.GTK_POLICY_NEVER_ENUM)
		end

feature {NONE} -- Implementation

	visual_widget: POINTER is
		do
			Result := viewport
		end

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

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--|-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.16  2001/07/14 12:46:23  manus
--| Replace --! by --|
--|
--| Revision 1.15  2001/07/14 12:16:27  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.14  2001/06/07 23:08:06  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.8.4.8  2000/12/15 20:07:22  king
--| Altered step values to meet with invariant
--|
--| Revision 1.8.4.7  2000/10/27 16:54:42  manus
--| Removed undefinition of `set_default_colors' since now the one from EV_COLORIZABLE_IMP is
--| deferred.
--| However, there might be a problem with the definition of `set_default_colors' in the following
--| classes:
--| - EV_TITLED_WINDOW_IMP
--| - EV_WINDOW_IMP
--| - EV_TEXT_COMPONENT_IMP
--| - EV_LIST_ITEM_LIST_IMP
--| - EV_SPIN_BUTTON_IMP
--|
--| Revision 1.8.4.6  2000/09/18 18:06:43  oconnor
--| reimplemented propogate_[fore|back]ground_color for speeeeed
--|
--| Revision 1.8.4.5  2000/08/28 16:35:20  king
--| Removed event_widget
--|
--| Revision 1.8.4.4  2000/08/08 00:03:14  oconnor
--| Redefined set_default_colors to do nothing in EV_COLORIZABLE_IMP.
--|
--| Revision 1.8.4.3  2000/06/29 02:12:04  king
--| Redefined visual widget to viewport
--|
--| Revision 1.8.4.2  2000/06/28 00:35:22  king
--| Removed event_box as c_object
--|
--| Revision 1.8.4.1  2000/05/03 19:08:48  oconnor
--| mergred from HEAD
--|
--| Revision 1.13  2000/05/02 18:55:28  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.12  2000/04/22 00:21:47  brendel
--| scrollbar -> scroll_bar.
--|
--| Revision 1.11  2000/03/21 22:39:43  king
--| Made c_object an event_box
--|
--| Revision 1.10  2000/02/22 18:39:38  oconnor
--| updated copyright date and formatting
--|
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
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
