--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		" EiffelVision container. Allows only one children.%
		% Deferred class, parent of all the containers.%
		% Mswindows implementation."
	note: " This class would be the equivalent of a wel_composite_window%
		% in the wel hierarchy."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_CONTAINER_IMP

inherit
	EV_CONTAINER_I
		redefine
			interface
		end

	EV_SIZEABLE_CONTAINER_IMP
		undefine
			initialize
		redefine
			interface
		end

	EV_MENU_ITEM_HANDLER_IMP

	EV_WIDGET_IMP
		redefine
			interface,
			initialize
		end

	WEL_SB_CONSTANTS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	initialize is
			-- Precusor and create new_item_actions.
		do
			create radio_group.make
			create new_item_actions.make ("new_item", <<"widget">>)
			new_item_actions.extend (~add_radio_button)
			create remove_item_actions.make ("remove_item", <<"widget">>)
			remove_item_actions.extend (~remove_radio_button)
			{EV_WIDGET_IMP} Precursor
		end

feature -- Access

	client_x: INTEGER is
			-- Left of the client area.
		do
			Result := client_rect.x
		end

	client_y: INTEGER is
			-- Top of the client area.
		do
			Result := client_rect.y
		end

	client_width: INTEGER is
			-- Width of the client area of container
		do
			Result := client_rect.width
		end

	client_height: INTEGER is
			-- Height of the client area of container
		do
			Result := client_rect.height
		end

	background_pixmap_imp: EV_PIXMAP_IMP
			-- Pixmap used for the background of the widget

feature -- Element change

	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		local
			par_imp: EV_CONTAINER_IMP
			ww: WEL_WINDOW
		do
			if par /= Void then
				--if parent_imp /= Void then
				--	parent_imp.remove_child (Current)
				--end
				par_imp ?= par.implementation
				check
					valid_cast: par_imp /= Void
				end
				set_top_level_window_imp (par_imp.top_level_window_imp)

				--| FIXME , The child should have already been added.
				--| par_imp.interface.extend (Current.interface)
				par_imp.add_child (Current)
				ww ?= par.implementation
				wel_set_parent (ww)
			elseif parent_imp /= Void then
				wel_set_parent (default_parent)
			end
		end

	set_background_pixmap (pix: EV_PIXMAP) is
			-- Set the background pixmap and redraw the container.
		do
			if pix /= Void then
				background_pixmap_imp ?= pix.implementation
	--			background_pixmap_imp.reference
			end
			if exists then
				invalidate
			end
		end

feature -- Assertion test

	child_added (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Has `a_child' been added properly?
		do
			Result := is_child (a_child)
		end

feature {NONE} -- WEL Implementation

	on_draw_item (control_id: INTEGER; draw_item: WEL_DRAW_ITEM_STRUCT) is
			-- Wm_drawitem message.
			-- A owner-draw control identified by `control_id' has
			-- been changed and must be drawn. `draw_item' contains
			-- information about the item to be drawn and the type
			-- of drawing required.
		local
			pixcon: EV_OPTION_BUTTON_IMP
		do
			pixcon ?= draw_item.window_item
			if pixcon /= Void then
				pixcon.on_draw (draw_item)
			end
		end

	on_color_control (control: WEL_COLOR_CONTROL; paint_dc: WEL_PAINT_DC) is
			-- Wm_ctlcolorstatic, Wm_ctlcoloredit, Wm_ctlcolorlistbox 
			-- and Wm_ctlcolorscrollbar messages.
			-- To change its default colors, the color-control `control'
			-- needs :
			-- 1. a background color and a foreground color to be selected
			--    in the `paint_dc',
			-- 2. a backgound brush to be returned to the system.
		local
			brush: WEL_BRUSH
		do
			paint_dc.set_text_color (control.foreground_color)
			paint_dc.set_background_color (control.background_color)
			!! brush.make_solid (control.background_color)
			set_message_return_value (brush.to_integer)
			disable_default_processing
		end

   	background_brush: WEL_BRUSH is
   			-- Current window background color used to refresh the window when
   			-- requested by the WM_ERASEBKGND windows message.
   			-- By default there is no background  
		do
 			if exists then
				if background_pixmap_imp /= Void then
					create Result.make_by_pattern (background_pixmap_imp.bitmap)
				elseif background_color_imp /= Void then
					create Result.make_solid (background_color_imp)
				end
 			end
 		end

	on_wm_vscroll (wparam, lparam: INTEGER) is
 			-- Wm_vscroll message.
 			-- Should be implementated in EV_CONTAINER_IMP,
			-- But as we can't implement a deferred feature
 			-- with an external, it is not possible.
 		local
 			gauge: EV_GAUGE_IMP
 			p: POINTER
 		do
			-- To avoid the commands to be call two times, we check that
			-- it is not a call for a end of scroll
			if cwin_lo_word (wparam) /= Sb_endscroll then
	 			p := get_wm_vscroll_hwnd (wparam, lparam)
	 			if p /= default_pointer then
	 				-- The message comes from a gauge,
 					gauge ?= windows.item (p)
						if gauge /= Void then
	 						check
 							gauge_exists: gauge.exists
 						end
						gauge.on_scroll (get_wm_vscroll_code (wparam, lparam), get_wm_vscroll_pos (wparam, lparam))
 						gauge.interface.change_actions.call ([])
 					end
 				else
 					-- The message comes from a window scroll bar
 					on_vertical_scroll (get_wm_vscroll_code (wparam, lparam),
 						get_wm_vscroll_pos (wparam, lparam))
 				end
			end
 		end
 
 	on_wm_hscroll (wparam, lparam: INTEGER) is
 			-- Wm_hscroll message.
 		local
 			gauge: EV_GAUGE_IMP
 			p: POINTER
 		do
			-- To avoid the commands to be call two times, we check that
			-- it is not a call for a end of scroll
			if cwin_lo_word (wparam) /= Sb_endscroll then
	 			p := get_wm_hscroll_hwnd (wparam, lparam)
	 			if p /= default_pointer then
	 				-- The message comes from a gauge
	 				gauge ?= windows.item (p)
	 				if gauge /= Void then
	 					check
	 						gauge_exists: gauge.exists
	 					end
						gauge.on_scroll (get_wm_vscroll_code (wparam, lparam), get_wm_vscroll_pos (wparam, lparam))
	 					gauge.interface.change_actions.call ([])
	 				end
				else
 					-- The message comes from a window scroll bar
 					on_horizontal_scroll (get_wm_hscroll_code (wparam, lparam),
						get_wm_hscroll_pos (wparam, lparam))
 				end
			end
 		end

	on_destroy is
			-- Wm_destroy message.
			-- The window is about to be destroyed.
		do
			if background_pixmap_imp /= Void then
	--			background_pixmap_imp.unreference
			end
		end

feature {NONE} -- Implementation : deferred features

	client_rect: WEL_RECT is
		deferred
		end

	disable_default_processing is
		deferred
		end

	set_message_return_value (v: INTEGER) is
		deferred
		end

	windows: HASH_TABLE [WEL_WINDOW, POINTER] is
		deferred
		end

	on_vertical_scroll (scroll_code, position: INTEGER) is
		deferred
		end

	on_horizontal_scroll (scroll_code, position: INTEGER) is
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_CONTAINER

feature {NONE} -- Feature that should be directly implemented by externals

	get_wm_hscroll_code (wparam, lparam: INTEGER): INTEGER is
			-- Encapsulation of the external cwin_get_wm_hscroll_code.
		deferred
		end

	get_wm_hscroll_hwnd (wparam, lparam: INTEGER): POINTER is
			-- Encapsulation of the external cwin_get_wm_hscroll_hwnd
		deferred
		end

	get_wm_hscroll_pos (wparam, lparam: INTEGER): INTEGER is
			-- Encapsulation of the external cwin_get_wm_hscroll_pos
		deferred
		end

	get_wm_vscroll_code (wparam, lparam: INTEGER): INTEGER is
			-- Encapsulation of the external cwin_get_wm_vscroll_code.
		deferred
		end

	get_wm_vscroll_hwnd (wparam, lparam: INTEGER): POINTER is
			-- Encapsulation of the external cwin_get_wm_vscroll_hwnd
		deferred
		end

	get_wm_vscroll_pos (wparam, lparam: INTEGER): INTEGER is
			-- Encapsulation of the external cwin_get_wm_vscroll_pos
		deferred
		end

feature {EV_ANY_I} -- Implementation

	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into composite
		require
			valid_child: child_imp /= Void
			not_already_child: not is_child (child_imp)
			add_child_ok: add_child_ok
		deferred
		ensure
			child_added: child_added (child_imp)
		end

	remove_child (child_imp: EV_WIDGET_IMP) is
			-- Remove the given child from the children of
			-- the container.
		deferred
		ensure
			child_removed: not is_child (child_imp)
		end

	add_child_ok: BOOLEAN is
			-- Used in the precondition of
			-- 'add_child'. True, if it is ok to add a
			-- child to container.
		deferred
		end

	is_child (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Is `a_child' a child of the container?
		deferred
		end

feature {EV_CONTAINER_IMP} -- Implementation

	radio_group: LINKED_LIST [EV_RADIO_BUTTON_IMP]
			-- Radio items in this container.
			-- `Current' shares reference with merged containers.

	is_merged (other: EV_CONTAINER): BOOLEAN is
			-- Is `Current' merged with `other'?
		require
			other_not_void: other /= Void
		local
			c_imp: EV_CONTAINER_IMP
		do
			c_imp ?= other.implementation
			Result := c_imp.radio_group = radio_group
		end

	set_radio_group (rg: like radio_group) is
			-- Set `radio_group' by reference. (Merge)
		do
			radio_group := rg
		end

	add_radio_button (w: EV_WIDGET) is
			-- Called every time a widget is added to the container.
		require
			w_not_void: w /= Void
		local
			r: EV_RADIO_BUTTON_IMP
		do
			r ?= w.implementation
			if r /= Void then
				if not radio_group.empty then
					r.set_unchecked
				end
				r.set_radio_group (radio_group)
			end
		end

	remove_radio_button (w: EV_WIDGET) is
			-- Called every time a widget is removed from the container.
		require
			w_not_void: w /= Void
		local
			r: EV_RADIO_BUTTON_IMP
		do
			r ?= w.implementation
			if r /= Void then
				r.remove_from_radio_group
				r.set_checked
			end
		end

feature -- Status setting

	connect_radio_grouping (a_container: EV_CONTAINER) is
			-- Join radio grouping of `a_container' to Current.
		local
			l: like radio_group
			peer: EV_CONTAINER_IMP
		do
			peer ?= a_container.implementation
			if peer = Void then
				-- It's a widget that inherits from EV_CONTAINER,
				-- but has implementation renamed.
				-- If this is the case, on `a_container' this feature
				-- had to be redefined.
				a_container.merge_radio_button_groups (interface)
			else
				l := peer.radio_group
				if l /= radio_group then
					from
						l.start
					until
						l.empty
					loop
						add_radio_button (l.item.interface)
					end
					peer.set_radio_group (radio_group)
				end
			end
		end

feature -- Event handling

	new_item_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET]]
			-- Actions to be performed after an item is added.

	remove_item_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET]]
			-- Actions to be performed before an item is removed.

invariant
	new_item_actions_not_void: is_useable implies new_item_actions /= Void
	remove_item_actions_not_void: is_useable implies remove_item_actions /= Void

end -- class EV_CONTAINER_IMP

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.42  2000/03/14 03:02:55  brendel
--| Merged changed from WINDOWS_RESIZING_BRANCH.
--|
--| Revision 1.41.2.1  2000/03/09 21:39:47  brendel
--| Replaced x with x_position and y with y_position.
--| Before, both were available.
--|
--| Revision 1.41  2000/03/06 21:21:53  brendel
--| Added functionality to connect_radio_grouping that reverses the target
--| and argument of the call when implementation of argument is Void.
--|
--| Revision 1.40  2000/02/29 20:02:45  brendel
--| Improved implementation of radio group merging.
--|
--| Revision 1.39  2000/02/29 00:42:21  brendel
--| Finished first implementation of container radio group merging.
--|
--| Revision 1.38  2000/02/28 16:29:17  brendel
--| Added functionality that groups radio buttons.
--|
--| Revision 1.37  2000/02/19 05:45:00  oconnor
--| released
--|
--| Revision 1.36  2000/02/15 03:17:27  brendel
--| Implemented call to action sequence of gauges.
--|
--| Revision 1.35  2000/02/14 11:40:42  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.34.10.10  2000/02/03 17:01:23  rogers
--|  Removed code in set_parent that was no longer necessary.
--|
--| Revision 1.34.10.9  2000/01/31 23:00:21  rogers
--| Removed set_text_for_item, implemented set_item_text, and re-implemented child_added.
--|
--| Revision 1.34.10.8  2000/01/31 19:30:45  brendel
--| Added previously deleted features from EV_CONTAINER_I as a temporary measure.
--|
--| Revision 1.34.10.7  2000/01/31 17:03:51  brendel
--| Corrected error in set_parent.
--|
--| Revision 1.34.10.6  2000/01/29 01:05:02  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.34.10.5  2000/01/27 19:30:20  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.34.10.4  2000/01/25 17:37:52  brendel
--| Removed code associated with old events.
--| Implementation and more removal is needed.
--|
--| Revision 1.34.10.3  2000/01/20 17:51:12  king
--| Commented out *reference of pixmap.
--|
--| Revision 1.34.10.2  1999/12/17 00:54:02  rogers
--| Altered to fit in with the review branch. Redefinitions required.
--|
--| Revision 1.34.10.1  1999/11/24 17:30:26  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.34.6.3  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
