indexing
	description: "Eiffel Vision container. Mswindow implementation."
	status: "See notice at end of class."
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
		redefine
			interface
		end

	EV_WIDGET_IMP
		undefine
			minimum_width,
			minimum_height,
			initialize_sizeable,
			ev_apply_new_size,
			redraw_current_push_button
		redefine
			interface,
			initialize,
			destroy,
			default_process_message
		end

	EV_CONTAINER_ACTION_SEQUENCES_IMP

	EV_SHARED_GDI_OBJECTS

	WEL_TVN_CONSTANTS
		export
			{NONE} all
		end

	WEL_HWND_CONSTANTS
		export
			{NONE} all
		end

	WEL_LIST_VIEW_CONSTANTS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current'. Precusor and create new_item_actions.
		do
			create radio_group.make
			new_item_actions.extend (~disable_widget_sensitivity)
			new_item_actions.extend (~add_radio_button)
			new_item_actions.extend (~update_tab_ordering_for_dialog)
			create remove_item_actions
			remove_item_actions.extend (~enable_widget_sensitivity)
			remove_item_actions.extend (~remove_radio_button)
			Precursor {EV_WIDGET_IMP}
		end

feature -- Access

	client_x: INTEGER is
			-- Left of the client area.
			-- `Result' in pixels.
		do
			Result := client_rect.x
		end

	client_y: INTEGER is
			-- Top of the client area.
			-- `Result' in pixels.
		do
			Result := client_rect.y
		end

	client_width: INTEGER is
			-- Width of the client area of container.
			-- `Result' in pixels.
		do
			if is_show_requested then
				Result := client_rect.width
			else
				Result := child_cell.width
			end
		end

	client_height: INTEGER is
			-- Height of the client area of container
			-- `Result' in pixels.
		do
			if is_show_requested then
				Result := client_rect.height
			else
				Result := child_cell.height
			end
		end

	background_pixmap_imp: EV_PIXMAP_IMP
			-- Pixmap used for the background of the widget

feature -- Element change

	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of `Current'.
			-- `par' can be Void then the parent is the screen.
		local
			par_imp: EV_CONTAINER_IMP
			ww: WEL_WINDOW
		do
			if par /= Void then
				par_imp ?= par.implementation
				check
					valid_cast: par_imp /= Void
				end
				set_top_level_window_imp (par_imp.top_level_window_imp)
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

feature -- Status setting

	destroy is
			-- Destroy `Current', but set the parent sensitive
			-- in case it was set insensitive by the child.
		do
			if parent_imp /= Void then
				parent_imp.interface.prune (Current.interface)
			end
			interface.wipe_out
			wel_destroy
			is_destroyed := True
		end

feature {NONE} -- WEL Implementation

	on_draw_item (control_id: INTEGER; draw_item: WEL_DRAW_ITEM_STRUCT) is
			-- Wm_drawitem message.
			-- A owner-draw control identified by `control_id' has
			-- been changed and must be drawn. `draw_item' contains
			-- information about the item to be drawn and the type
			-- of drawing required.
			--| This is empty as there are currently no controls that
			--| are owner drawn. If some are added then code to handle
			--| their re-drawing should be called from here.
		require
			draw_item_valid: draw_item /= Void
		local
			label_imp: EV_LABEL_IMP
		do
			label_imp ?= draw_item.window_item
			if label_imp /= Void then
				label_imp.on_draw_item (draw_item)
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
			w: EV_WIDGET_IMP
		do
			w ?= control
			check
					-- Everything inherits from EV_WIDGET.
				is_a_widget: w /= Void
			end
			if w.background_color_imp /= Void or 
				w.foreground_color_imp /= Void
			then
					-- Not the default color, we need to do something here
					-- to apply `background_color' to `control'.
				paint_dc.set_text_color (control.foreground_color)
				paint_dc.set_background_color (control.background_color)
				brush := allocated_brushes.get (Void, control.background_color)
				debug ("WEL")
					io.putstring (
						"Warning, there is no `decrement_reference'%Nfor the %
						%previous brush%N")
				end
				set_message_return_value (brush.to_integer)
				disable_default_processing
			end
		end

   	background_brush: WEL_BRUSH is
   			-- Current window background color used to refresh the window when
   			-- requested by the WM_ERASEBKGND windows message.
   			-- By default there is no background  
   		local
   			tmp_bitmap: WEL_BITMAP
		do
 			if exists then
				if background_pixmap_imp /= Void then
					tmp_bitmap := background_pixmap_imp.get_bitmap
					create Result.make_by_pattern (tmp_bitmap)
					tmp_bitmap.decrement_reference
				else
					create Result.make_solid (wel_background_color)
				end
 			end
 		end

	on_wm_vscroll (wparam, lparam: INTEGER) is
 			-- Wm_vscroll message.
 		local
 			gauge: EV_GAUGE_IMP
 			p: POINTER
 		do
			-- To avoid the commands to be call two times, we check that
			-- it is not a call for a end of scroll
			if cwin_lo_word (wparam) /= Wel_sb_constants.Sb_endscroll then
	 			p := get_wm_vscroll_hwnd (wparam, lparam)
	 			if p /= default_pointer then
	 				-- The message comes from a gauge,
 					gauge ?= window_of_item (p)
					if gauge /= Void then
	 					check
 							gauge_exists: gauge.exists
 						end
						gauge.on_scroll (get_wm_vscroll_code (wparam, lparam),
							get_wm_vscroll_pos (wparam, lparam))
						if gauge.change_actions_internal /= Void then
	 						gauge.change_actions_internal.call
								([gauge.interface.value])
						end
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
			if cwin_lo_word (wparam) /= Wel_sb_constants.Sb_endscroll then
	 			p := get_wm_hscroll_hwnd (wparam, lparam)
	 			if p /= default_pointer then
	 				-- The message comes from a gauge
	 				gauge ?= window_of_item (p)
	 				if gauge /= Void then
	 					check
	 						gauge_exists: gauge.exists
	 					end
						gauge.on_scroll (get_wm_vscroll_code (wparam, lparam),
							get_wm_vscroll_pos (wparam, lparam))
						if gauge.change_actions_internal /= Void then
		 					gauge.change_actions_internal.call
								([gauge.interface.value])
						end
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
			--| To be redefined in descendents as required.
		do
		end

	on_notify (a_control_id: INTEGER; info: WEL_NMHDR) is
		local
			tooltip_text: WEL_TOOLTIP_TEXT
			tvinfotip: WEL_NM_TREE_VIEW_GETINFOTIP
			temp_node: EV_TREE_NODE_IMP
			tree: EV_TREE_IMP
			tooltip: WEL_TOOLTIP
		do
			if info.code = Tvn_getinfotip then
					-- Create the relevent WEL_TOOLTIP_TEXT.
				create tooltip_text.make_by_nmhdr (info)
					-- Retrieve tree view get info tip structure.
				create tvinfotip.make_by_pointer (tooltip_text.item)

				tree ?= info.window_from
				tooltip ?= tree.get_tooltip
					-- Bring the tooltip to the front.
					-- For some reason without this, it is shown behind 
					-- the window.
				tooltip.set_z_order (Hwnd_top)

				tree.all_ev_children.search (tvinfotip.hitem)
				if tree.all_ev_children.found then
					temp_node := tree.all_ev_children.found_item
					if temp_node.tooltip /= Void and 
						not temp_node.tooltip.is_empty
					then
							-- Assign tooltip text to `tooltip_text'.
						tooltip_text.set_text (temp_node.tooltip)
					end
				end
			elseif info.code = Lvn_marqueebegin then
					-- A message has been received from an EV_LIST notifying
					-- us that a bounding box selection is beginning. We
					-- return 1 to override this behaviour.
				set_message_return_value (1)
			end
		end
		
	update_tab_ordering_for_dialog (w: EV_WIDGET) is
			-- If `Current' is an EV_DIALOG_IMP_MODAL or an 
			-- EV_DIALOG_IMP_MODELESS
			-- Then we must recursively reverse the tab order of the children.
		local
			common: EV_DIALOG_IMP_COMMON
			widget_imp: EV_WIDGET_IMP
		do
			common ?= top_level_window_imp
			widget_imp ?= w.implementation
			check
				widget_imp_not_void: widget_imp /= Void
			end
				--| This should only be called after `widget_imp' has been parented
				--| So `Parent_imp' should never ben Void.
			check
				parent_not_void: widget_imp.parent_imp /= Void
			end
			if common /= Void then
				common.modify_tab_order (widget_imp.parent_imp)
			end
		end

feature {EV_CONTAINER_IMP} -- Implementation

	adjust_tab_ordering (ordered_widgets: ARRAYED_LIST [WEL_WINDOW]; 
				widget_depths: ARRAYED_LIST [INTEGER]; depth: INTEGER) is
			-- Adjust tab ordering of children in `Current'.
			-- Used when `Current' is a child of an EV_DIALOG_IMP_MODAL
			-- or an EV_DIALOG_IMP_MODELESS.
		deferred
		end

feature {NONE} -- Implementation, focus event

	redraw_current_push_button (focused_button: EV_BUTTON) is
			-- Put a bold border on the `focused_button' and
			-- remove any bold border on the other buttons.
			--
			-- Used when `Current' is a child of an EV_DIALOG_IMP.
		local
			l: LINEAR [EV_WIDGET]
			cs: CURSOR_STRUCTURE [EV_WIDGET]
			cur: CURSOR
			widget_imp: EV_WIDGET_IMP
		do
			l := interface.linear_representation
			cs ?= l
			if cs /= Void then
				cur := cs.cursor
			end
			from
				l.start
			until
				l.after
			loop
				widget_imp ?= l.item.implementation
				check 
					widget_imp_non_void: widget_imp /= Void
				end
				widget_imp.redraw_current_push_button (focused_button)
				l.forth
			end
			if cs /= Void then
				cs.go_to (cur)
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

	is_child (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Is `a_child' a child of `Current'?
		deferred
		end

feature {EV_CONTAINER_IMP} -- Implementation

	radio_group: LINKED_LIST [EV_RADIO_BUTTON_IMP]
			-- Radio items in `Current'.
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
			--| If `w' is a radio button then we update associated
			--| radio buttons as necessary.
		require
			w_not_void: w /= Void
		local
			r: EV_RADIO_BUTTON_IMP
		do
			r ?= w.implementation
			if r /= Void then
				if not radio_group.is_empty then
					r.set_unchecked
				end
				r.set_radio_group (radio_group)
			end
		end

	remove_radio_button (w: EV_WIDGET) is
			-- Called every time a widget is removed from the container.
			--| If `w' is a radio button then we update  associated
			--| radio buttons as necessary.
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

	enable_widget_sensitivity (w: EV_WIDGET) is
			-- Called every time a widget is removed from `Current'.
			--| If `Current' is disabled and `w' has never been disabled
			--| through the interface then we must enable `w' again.
			--| If a widget is placed in a container that has sensitivity
			--| disabled then we disable the widget also. We must however,
			--| return the widget to it's original state when it is removed.
			--| Hence this function.
		local
			w_imp: EV_WIDGET_IMP
		do
			w_imp ?= w.implementation
			check
				widget_imp_not_void: w_imp /= Void
			end
			if not interface.implementation.is_sensitive then
				if not w_imp.internal_non_sensitive then
					w_imp.enable_sensitive
				end
			end
		end

	disable_widget_sensitivity (w: EV_WIDGET) is
			-- Called every time a widget is added to `Current'.
			--| If `Current' is disabled then we must disable `w'.
		local
			w_imp: EV_WIDGET_IMP
		do
			w_imp ?= w.implementation
			check
				widget_imp_not_void: w_imp /= Void
			end
			if not interface.implementation.is_sensitive then
				w_imp.disable_sensitive
			end
		end
		
feature -- Status setting

	connect_radio_grouping (a_container: EV_CONTAINER) is
			-- Join radio grouping of `a_container' to `Current'.
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
						l.is_empty
					loop
						add_radio_button (l.item.interface)
					end
					peer.set_radio_group (radio_group)
				end
			end
		end

feature -- Event handling

	remove_item_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET]]
			-- Actions to be performed before an item is removed.

feature {NONE} -- Implementation

	default_process_message (msg, wparam, lparam: INTEGER) is
			-- Process `msg' which has not been processed by
			-- `process_message'.
		local
			draw_item_struct: WEL_DRAW_ITEM_STRUCT
		do
			if msg = Wm_drawitem then
				create draw_item_struct.make_by_pointer (
					integer_to_pointer (lparam))
				on_draw_item (wparam, draw_item_struct)
			else
				Precursor (msg, wparam, lparam)
			end
		end

	wel_sb_constants: WEL_SB_CONSTANTS is
			-- Access to SB_xxx constants.
		once
			create Result
		end

feature {NONE} -- Externals

	integer_to_pointer (i: INTEGER): POINTER is
			-- Converts an integer `i' to a pointer
		external
			"C [macro <wel.h>] (EIF_INTEGER): EIF_POINTER"
		alias
			"cwel_integer_to_pointer"
		end

invariant
	new_item_actions_not_void: is_usable implies new_item_actions /= Void
	remove_item_actions_not_void: is_usable implies remove_item_actions /= Void

end -- class EV_CONTAINER_IMP

--|-----------------------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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
--| Revision 1.58  2001/07/14 12:46:25  manus
--| Replace --! by --|
--|
--| Revision 1.57  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.56  2001/06/29 21:54:41  pichery
--| - Changed the behavior of the `default_push_button', we now use
--|   `current_push_button': the currently focused push button.
--| - The redrawing of the button with bold border is now done in vision2
--|   rather than by Windows itself.
--|
--| Revision 1.55  2001/06/07 23:08:14  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.34.8.36  2001/05/27 20:36:27  pichery
--| - Redefined `default_process_message' so that it calls `on_draw_item'
--|   which was already defined but not referenced anywhere.
--| - Implemented `on_draw_item' so that it calls EV_LABEL_IMP.on_draw_item.
--| - Cosmetics
--| - Formatting to 80 characters
--|
--| Revision 1.34.8.35  2001/05/18 16:26:38  rogers
--| Removed destroy_just_called.
--|
--| Revision 1.34.8.34  2001/03/29 18:38:10  rogers
--| Exported adjust_tab_ordering to {EV_CONTAINER_IMP}.
--|
--| Revision 1.34.8.33  2001/03/29 18:25:09  rogers
--| Renamed update_tab_for_dialog to update_tab_ordering_for_dialog.
--| Renamed reverse_tab_order to adjust_tab_ordering.
--|
--| Revision 1.34.8.32  2001/03/29 01:12:55  rogers
--| Added update_tab_for_dialog which is added to `new_item_actions'.
--|
--| Revision 1.34.8.31  2001/03/28 21:45:15  rogers
--| Changed signature of reverse_tab_order.
--|
--| Revision 1.34.8.30  2001/03/28 19:22:08  rogers
--| Added reverse_tab_order as deferred.
--|
--| Revision 1.34.8.29  2001/03/04 22:25:50  pichery
--| - renammed `bitmap' into `get_bitmap'
--|
--| Revision 1.34.8.28  2001/02/23 23:42:41  pichery
--| Added tight reference tracking for wel_bitmaps.
--|
--| Revision 1.34.8.27  2001/02/16 01:18:50  andrew
--| Changed spelling of is_useable in invariant to is_usable
--|
--| Revision 1.34.8.26  2001/02/03 21:22:02  pichery
--| Fixed bug with new dialog implementation based on the state pattern.
--|
--| Revision 1.34.8.25  2000/12/18 23:59:27  rogers
--| On_notify now handles tooltip notifications from tree items. Now inherits
--| WEL_TVN_CONSTANTS, WEL_HWND_CONSTANTS and WEL_SWP_CONSTANTS.
--|
--| Revision 1.34.8.21  2000/11/09 23:39:44  manus
--| Redefined `destroy' so that we `wipe_out' current container of all its
--| children if any before destroying the C objects. This solves a bug where
--| you want to reuse some widgets which belonged to `Current'.
--|
--| Revision 1.34.8.20  2000/11/07 23:02:27  rogers
--| Added update_tooltip which updates the tooltip information for a widget
--| after it has been added to `Current'. Update_tooltip has been added to
--| `new_item_actions'. Comments, formatting.
--|
--| Revision 1.34.8.19  2000/11/01 01:57:38  manus
--| `client_width' and `client_height' always go through `client_rect'. It
--| solves some problems with first resizing done by Windows when showing a
--| window.
--|
--| Revision 1.34.8.18  2000/10/27 02:14:25  manus
--| Removed inheritance from WEL_SB_constants, since there is now a once for
--| accessing the constants. Redefined `background_brush' to make sure it takes
--| the background color from the new defined `wel_background_color' which is
--| always the color set by Windows, unless set by user. Modified
--| `on_color_control' so that it checks if `background_color_imp' is Void or
--| not. If it is Void, nothing has to be done, Windows will give the correct
--| color, if not Void, we give Windows our color.
--|
--| Revision 1.34.8.17  2000/10/16 14:32:09  pichery
--| Added comments to signal a possible bug.
--|
--| Revision 1.34.8.16  2000/10/10 23:58:25  raphaels
--| `window_of_item' is now inherited from WEL_WINDOWS_ROUTINES
--|
--| Revision 1.34.8.15  2000/10/06 00:03:16  king
--| Resolved obsolete AS call
--|
--| Revision 1.34.8.14  2000/09/13 18:24:02  manus
--| Added EV_SHARED_GDI_OBJECTS that keeps track of most of brushes and pens
--| allocated in Vision2. Now EV_SHARED_GDI_OJECTS is a heir to EV_DRAWABLE_IMP
--| and EV_CONTAINER_IMP. The first, we just move the onces to the heir, for the
--| second we use them in `on_color_control' in order to reuse brushes
--| that are created since we cannot delete them right after their use.
--|
--| Revision 1.34.8.13  2000/09/07 02:37:07  manus
--| Updated `new_item_actions' creation and declaration with the new event class
--| EV_CONTAINER_ACTION_SEQUENCES_I.
--|
--| Revision 1.34.8.12  2000/09/06 23:42:20  oconnor
--| added new_item_actions to ev_container
--|
--| Revision 1.34.8.11  2000/08/16 22:39:37  rogers
--| Added disable_widget_sensitivity and added it to the new_item_actions.
--|
--| Revision 1.34.8.10  2000/08/15 23:31:31  rogers
--| Added enable_widget_sensitivity and placed this in the remove_item_actions.
--| Now when a widget is removed from `Current', it will be made sensitive
--| if it was made non sensitive as an effect from `Current' being non
--| sensitive.
--|
--| Revision 1.34.8.9  2000/08/11 18:57:20  rogers
--| Fixed copyright clauses. Now use ! instead of |. Formatting.
--|
--| Revision 1.34.8.8  2000/08/08 03:13:35  manus
--| New resizing policy by calling `ev_' instead of `internal_', see
--|   `vision2/implementation/mswin/doc/sizing_how_to.txt'.
--| `client_width' and `client_height' have been redefined to match new sizing
--|implementation. Cosmetics
--|
--| Revision 1.34.8.7  2000/08/04 16:51:46  rogers
--| All calls to action sequences made through a widgets interface are now
--| made directly on the internal actions of that widget.
--|
--| Revision 1.34.8.6  2000/07/25 00:52:25  rogers
--| Removed arguments to make procedure of action_sequences.
--|
--| Revision 1.34.8.5  2000/07/21 23:04:19  rogers
--| Removed add_child and add_child_ok as no longer used in Vision2.
--|
--| Revision 1.34.8.4  2000/07/21 18:45:08  rogers
--| Removed remove_child as it is now redundent in Vision2.
--|
--| Revision 1.34.8.3  2000/06/22 19:08:58  rogers
--| Change actions from EV_GAUGE now return the integer value of the gauge.
--| On_wm_hscroll and On_wm_vscroll now pass the current value of the gauge
--| to the gauges change_actions.
--|
--| Revision 1.34.8.2  2000/05/09 00:57:04  manus
--| Update WEL recent changes:
--| - rename `windows.item (p)' by `window_of_item (p)'.
--| - Add new deferred routine `window_of_item' which replaces `windows'
--| previously defined.
--|
--| Revision 1.34.8.1  2000/05/03 19:09:26  oconnor
--| mergred from HEAD
--|
--| Revision 1.53  2000/05/01 21:54:32  rogers
--| Comments, formatting. Removed FIXME NOT_REVIEWED.
--|
--| Revision 1.52  2000/04/29 03:22:39  pichery
--| Cosmetics
--|
--| Revision 1.51  2000/04/26 22:18:10  rogers
--| Set parent no longer calls par_imp.add_child as the child is already added.
--|
--| Revision 1.50  2000/04/26 18:35:55  brendel
--| Indexing clause.
--|
--| Revision 1.49  2000/04/14 23:34:19  rogers
--| Removed widget_parent and widget_orphaned as on_parented is no
--| longer needed in new_item_actions and on_orphaned is no longer
--| needed in remove_item_actions.
--|
--| Revision 1.48  2000/04/05 21:16:12  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.47.2.1  2000/04/05 19:56:14  brendel
--| Renoved obsolete postcondition.
--|
--| Revision 1.47  2000/03/23 23:22:52  brendel
--| Renamed widget_contained to widget_parented.
--| Added widget_orphaned.
--|
--| Revision 1.46  2000/03/21 20:13:21  brendel
--| Removed inheritance of obsolete class EV_MENU_ITEM_HANDLER.
--|
--| Revision 1.45  2000/03/21 17:36:12  oconnor
--| commented out option button _IMP reference
--|
--| Revision 1.44  2000/03/20 23:24:46  pichery
--| - Added `on_contained' notion. A container now notify its widget when it
--|   put them into itself (usefull for pixmap)
--|
--| Revision 1.43  2000/03/14 20:09:08  brendel
--| Rearranged initialization
--|
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
--| Removed set_text_for_item, implemented set_item_text, and re-implemented
--| child_added.
--|
--| Revision 1.34.10.8  2000/01/31 19:30:45  brendel
--| Added previously deleted features from EV_CONTAINER_I as a temporary
--| measure.
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
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
