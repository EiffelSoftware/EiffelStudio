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

	WEL_HWND_CONSTANTS
		export
			{NONE} all
		end

	EV_MENU_CONTAINER_IMP
		export
			{NONE} all
		redefine
			on_draw_item
		end

feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current'. Precusor and create new_item_actions.
		do
			create radio_group.make
			new_item_actions.extend (agent disable_widget_sensitivity)
			new_item_actions.extend (agent add_radio_button)
			new_item_actions.extend (agent update_tab_ordering_for_dialog)
			create remove_item_actions
			remove_item_actions.extend (agent enable_widget_sensitivity)
			remove_item_actions.extend (agent remove_radio_button)
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
			
	background_pixmap: EV_PIXMAP is
			-- `Result' is pixmap used for background.
		do
			if background_pixmap_imp /= Void then
				create Result
				Result.copy(background_pixmap_imp.interface)
			end
		end

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
		
	remove_background_pixmap is
			-- Remove background pixmap.
		do
			background_pixmap_imp := Void
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

	on_menu_char (char_code: CHARACTER; corresponding_menu: WEL_MENU) is
			-- The menu char `char_code' has been typed within `corresponding_menu'.
		local
			menu_list: EV_MENU_ITEM_LIST
			menu_list_imp: EV_MENU_ITEM_LIST_IMP
			win_imp: EV_WINDOW_IMP
			return_value: INTEGER
		do
			win_imp := top_level_window_imp
			if win_imp /= Void then
				menu_list ?= win_imp.menu_bar
				if menu_list /= Void then
					menu_list_imp ?= menu_list.implementation
					if menu_list_imp /= Void then
						return_value := menu_list_imp.on_menu_char (char_code, corresponding_menu)
						win_imp.set_message_return_value (return_value)
					end
				end
			end
		end

	on_draw_item (control_id: INTEGER; draw_item: WEL_DRAW_ITEM_STRUCT) is
			-- Handle Wm_drawitem messages.
			-- A owner-draw control identified by `control_id' has
			-- been changed and must be drawn. `draw_item' contains
			-- information about the item to be drawn and the type
			-- of drawing required.
		local
			label_imp: EV_LABEL_IMP
			item_type: INTEGER
		do
			item_type := draw_item.ctl_type
			if item_type = (feature {WEL_ODT_CONSTANTS}.Odt_menu) then
				Precursor {EV_MENU_CONTAINER_IMP} (control_id, draw_item)
			elseif item_type = (feature {WEL_ODT_CONSTANTS}.Odt_static) then
				label_imp ?= draw_item.window_item
				if label_imp /= Void then
					label_imp.on_draw_item (draw_item)
				end
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
					io.putstring ("Warning, there is no `decrement_reference'%Nfor the previous brush%N")
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
			if info.code = (feature {WEL_TVN_CONSTANTS}.Tvn_getinfotip) then
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
			elseif info.code = (feature {WEL_LIST_VIEW_CONSTANTS}.Lvn_marqueebegin) then
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
		do
			if not process_menu_message(msg, wparam, lparam) then
				Precursor (msg, wparam, lparam)
			end
		end

	wel_sb_constants: WEL_SB_CONSTANTS is
			-- Access to SB_xxx constants.
		once
			create Result
		end

invariant
	new_item_actions_not_void: is_usable implies new_item_actions /= Void
	remove_item_actions_not_void: is_usable implies remove_item_actions /= Void

end -- class EV_CONTAINER_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

