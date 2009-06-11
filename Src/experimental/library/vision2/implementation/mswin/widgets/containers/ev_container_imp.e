note
	description: "Eiffel Vision container. Mswindow implementation."
	legal: "See notice at end of class."
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
			make,
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

	make
			-- Initialize `Current'. Precusor and create new_item_actions.
		do
			create radio_group.make
			new_item_actions.extend (agent disable_widget_sensitivity)
			new_item_actions.extend (agent add_radio_button)
			create remove_item_actions
			remove_item_actions.extend (agent enable_widget_sensitivity)
			remove_item_actions.extend (agent remove_radio_button)
			Precursor {EV_WIDGET_IMP}
		end

feature -- Access

	client_x: INTEGER
			-- Left of the client area.
			-- `Result' in pixels.
		do
			Result := client_rect.x
		end

	client_y: INTEGER
			-- Top of the client area.
			-- `Result' in pixels.
		do
			Result := client_rect.y
		end

	client_width: INTEGER
			-- Width of the client area of container.
			-- `Result' in pixels.
		do
			if is_show_requested then
				Result := client_rect.width
			else
				Result := child_cell.width
			end
		end

	client_height: INTEGER
			-- Height of the client area of container
			-- `Result' in pixels.
		do
			if is_show_requested then
				Result := client_rect.height
			else
				Result := child_cell.height
			end
		end

	background_pixmap_imp: detachable EV_PIXMAP_IMP
			-- Pixmap used for the background of the widget

	background_pixmap: detachable EV_PIXMAP
			-- `Result' is pixmap used for background.
		do
			if attached background_pixmap_imp as l_background_pixmap_imp then
				create Result
				Result.copy (l_background_pixmap_imp.attached_interface)
			end
		end

feature -- Element change

	set_parent_imp (par_imp: detachable EV_CONTAINER_IMP)
			-- Make `par_imp' the new parent of `Current'.
			-- `par_imp' can be Void then the parent is the screen.
		local
			ww: detachable WEL_WINDOW
		do
			if par_imp /= Void then
				set_top_level_window_imp (par_imp.top_level_window_imp)
				ww ?= par_imp
				check ww /= Void end
				wel_set_parent (ww)
			else
				set_top_level_window_imp (Void)
				if parent_imp /= Void then
					wel_set_parent (default_parent)
				end
			end
		end

	set_background_pixmap (pix: EV_PIXMAP)
			-- Set the background pixmap and redraw the container.
		local
			pixmap: like pix
		do
			if pix /= Void then
				create pixmap
				pixmap.copy (pix)
				background_pixmap_imp ?= pixmap.implementation
			end
			if exists then
				invalidate
			end
		end

	remove_background_pixmap
			-- Remove background pixmap.
		do
			background_pixmap_imp := Void
			if exists then
				invalidate
			end
		end

feature -- Assertion test

	child_added (a_child: EV_WIDGET_IMP): BOOLEAN
			-- Has `a_child' been added properly?
		do
			Result := is_child (a_child)
		end

feature -- Status setting

	destroy
			-- Destroy `Current', but set the parent sensitive
			-- in case it was set insensitive by the child.
		do
			if attached parent_imp as l_parent_imp then
				l_parent_imp.attached_interface.prune (attached_interface)
			end
			if attached_interface.prunable then
				attached_interface.wipe_out
			end
			wel_destroy
			set_is_destroyed (True)
		end

feature {NONE} -- WEL Implementation

	on_menu_char (char_code: CHARACTER; corresponding_menu: WEL_MENU)
			-- The menu char `char_code' has been typed within `corresponding_menu'.
		local
			menu_list: detachable EV_MENU_ITEM_LIST
			menu_list_imp: detachable EV_MENU_ITEM_LIST_IMP
			win_imp: detachable EV_WINDOW_IMP
		do
			win_imp := top_level_window_imp
			if win_imp /= Void then
				menu_list ?= win_imp.menu_bar
				if menu_list /= Void then
					menu_list_imp ?= menu_list.implementation
					if menu_list_imp /= Void then
						win_imp.set_message_return_value (
							menu_list_imp.on_menu_char (char_code, corresponding_menu))
					end
				end
			end
		end

	on_draw_item (control_id: POINTER; draw_item: WEL_DRAW_ITEM_STRUCT)
			-- Handle Wm_drawitem messages.
			-- A owner-draw control identified by `control_id' has
			-- been changed and must be drawn. `draw_item' contains
			-- information about the item to be drawn and the type
			-- of drawing required.
		local
			label_imp: detachable EV_LABEL_IMP
			item_type: INTEGER
			button_imp: detachable EV_BUTTON_IMP
		do
			item_type := draw_item.ctl_type
			if item_type = ({WEL_ODT_CONSTANTS}.Odt_menu) then
				Precursor {EV_MENU_CONTAINER_IMP} (control_id, draw_item)
			elseif item_type = ({WEL_ODT_CONSTANTS}.Odt_static) then
				label_imp ?= draw_item.window_item
				if label_imp /= Void then
					label_imp.on_draw_item (draw_item)
				end
			elseif item_type = ({WEL_ODT_CONSTANTS}.odt_button) then
				button_imp ?= draw_item.window_item
				if button_imp /= Void then
					button_imp.on_draw_item (draw_item)
				end
			end
		end

	on_color_control (control: WEL_COLOR_CONTROL; paint_dc: WEL_PAINT_DC)
			-- Wm_ctlcolorstatic, Wm_ctlcoloredit, Wm_ctlcolorlistbox
			-- and Wm_ctlcolorscrollbar messages.
			-- To change its default colors, the color-control `control'
			-- needs :
			-- 1. a background color and a foreground color to be selected
			--    in the `paint_dc',
			-- 2. a backgound brush to be returned to the system.
		local
			brush: detachable WEL_BRUSH
			w: detachable EV_WIDGET_IMP
			theme_drawer: EV_THEME_DRAWER_IMP
			label: detachable EV_LABEL_IMP
		do
			theme_drawer := application_imp.theme_drawer

			w ?= control
			check
					-- Everything inherits from EV_WIDGET.
				is_a_widget: w /= Void
			end
			label ?= w
			if label /= Void and then application_imp.themes_active then
				disable_default_processing
				brush := background_brush
				check brush /= Void end
				theme_drawer.draw_widget_background (label, paint_dc, create {WEL_RECT}.make (0, 0, w.width, w.height), brush)
					-- Set background of `paint_dc' to transparant so that Windows does not draw
					-- over the background we have just drawn.
				paint_dc.set_background_transparent
				brush.delete
			elseif w.background_color_imp /= Void or
				w.foreground_color_imp /= Void
			then
					-- Not the default color, we need to do something here
					-- to apply `background_color' to `control'.
				paint_dc.set_text_color (control.foreground_color)
				paint_dc.set_background_color (control.background_color)
				brush := allocated_brushes.get (Void, control.background_color)
				debug ("WEL")
					io.put_string ("Warning, there is no `decrement_reference'%Nfor the previous brush%N")
				end
				set_message_return_value (brush.item)
				disable_default_processing
			end
		end

   	background_brush: detachable WEL_BRUSH
   			-- Current window background color used to refresh the window when
   			-- requested by the WM_ERASEBKGND windows message.
   			-- By default there is no background
   		local
   			tmp_bitmap: WEL_BITMAP
		do
 			if exists then
				if attached background_pixmap_imp as l_background_pixmap_imp then
					tmp_bitmap := l_background_pixmap_imp.get_bitmap
					create Result.make_by_pattern (tmp_bitmap)
					tmp_bitmap.decrement_reference
				else
					create Result.make_solid (wel_background_color)
				end
 			end
 		end

	on_wm_vscroll (wparam, lparam: POINTER)
 			-- Wm_vscroll message.
 		local
 			gauge: detachable EV_GAUGE_IMP
 			p: POINTER
 		do
			-- To avoid the commands to be call two times, we check that
			-- it is not a call for a end of scroll
			if cwin_lo_word (wparam) /= {WEL_SB_CONSTANTS}.Sb_endscroll then
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
	 						gauge.change_actions.call
								([gauge.attached_interface.value])
						end
 					end
 				else
 					-- The message comes from a window scroll bar
 					on_vertical_scroll (get_wm_vscroll_code (wparam, lparam),
 						get_wm_vscroll_pos (wparam, lparam))
 				end
			end
 		end

 	on_wm_hscroll (wparam, lparam: POINTER)
 			-- Wm_hscroll message.
 		local
 			gauge: detachable EV_GAUGE_IMP
 			p: POINTER
 		do
			-- To avoid the commands to be call two times, we check that
			-- it is not a call for a end of scroll
			if cwin_lo_word (wparam) /= {WEL_SB_CONSTANTS}.Sb_endscroll then
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
		 					gauge.change_actions.call
								([gauge.attached_interface.value])
						end
	 				end
				else
 					-- The message comes from a window scroll bar
 					on_horizontal_scroll (get_wm_hscroll_code (wparam, lparam),
						get_wm_hscroll_pos (wparam, lparam))
 				end
			end
 		end

	on_destroy
			-- Wm_destroy message.
			-- The window is about to be destroyed.
			--| To be redefined in descendents as required.
		do
		end

	on_notify (a_control_id: INTEGER; info: WEL_NMHDR)
		local
			tooltip_text: WEL_TOOLTIP_TEXT
			tvinfotip: WEL_NM_TREE_VIEW_GETINFOTIP
			temp_node: detachable EV_TREE_NODE_IMP
			tree: detachable EV_TREE_IMP
			tooltip: detachable WEL_TOOLTIP
			rich_text: detachable EV_RICH_TEXT_IMP
			selchange: WEL_RICH_EDIT_SELCHANGE
			list: detachable EV_LIST_IMP
			list_item: detachable EV_LIST_ITEM
			radio_button: detachable EV_RADIO_BUTTON_IMP
			check_button: detachable EV_CHECK_BUTTON_IMP
			button: detachable EV_BUTTON_IMP
			lvninfotip: WEL_NM_LIST_VIEW_GETINFOTIP
			string: WEL_STRING
			multi_column_list: detachable EV_MULTI_COLUMN_LIST_IMP
			multi_column_list_row: detachable EV_MULTI_COLUMN_LIST_ROW
			multi_column_list_row_imp: EV_MULTI_COLUMN_LIST_ROW_I
			l_zero: INTEGER
			checkable_tree: detachable EV_CHECKABLE_TREE_IMP
			custom: WEL_NM_CUSTOM_DRAW
			theme_drawer: EV_THEME_DRAWER_IMP
			bk_brush: WEL_BRUSH
		do
			theme_drawer := application_imp.theme_drawer
			if info.code = ({WEL_TVN_CONSTANTS}.Tvn_getinfotip) then
					-- Create the relevent WEL_TOOLTIP_TEXT.
				create tooltip_text.make_by_nmhdr (info)
					-- Retrieve tree view get info tip structure.
				create tvinfotip.make_by_pointer (info.item)

				tree ?= info.window_from
				check tree /= Void end
				tooltip := tree.get_tooltip
				check tooltip /= Void end
					-- Bring the tooltip to the front.
					-- For some reason without this, it is shown behind
					-- the window.
				tooltip.set_z_order (Hwnd_top)

				tree.all_ev_children.search (tvinfotip.hitem)
				if tree.all_ev_children.found then
					temp_node := tree.all_ev_children.found_item
					check temp_node /= Void end
					if temp_node.tooltip /= Void and
						not temp_node.tooltip.is_empty
					then
							-- Assign tooltip text to `tooltip_text'.
						tooltip_text.set_text (temp_node.tooltip)
					end
				end
			elseif info.code = {WEL_LIST_VIEW_CONSTANTS}.Lvn_getinfotip then
					--| FIXME The way we handle toolips for lists and multi column lists
					--| is somewhat strange. The height of the tooltip returned is too great, and
					--| we are unable to use `tooltip_text' as we do for trees above. This code is
					--| also non unicode compliant. Why can we not implement tooltips for these widgets
					--| as we do for tree items?
				create lvninfotip.make_by_pointer (info.item)
				list ?= info.window_from
				if list = Void then
					multi_column_list ?= info.window_from
					check multi_column_list /= Void end
					tooltip := multi_column_list.get_tooltip
					multi_column_list_row := multi_column_list.i_th (lvninfotip.iitem + 1)
					check multi_column_list_row /= Void end
					multi_column_list_row_imp := multi_column_list_row.implementation
					create string.make (multi_column_list_row_imp.tooltip)
				else
					tooltip := list.get_tooltip
					list_item := list.i_th (lvninfotip.iitem + 1)
					check list_item /= Void end
					create string.make (list_item.implementation.tooltip)
				end
				check tooltip /= Void end
				tooltip.set_z_order (Hwnd_top)

					-- Copy tooltip to allocated memory location.
				lvninfotip.psztext.memory_copy (string.item, string.count.min (lvninfotip.cchtextmax))
				(lvninfotip.psztext + (lvninfotip.cchtextmax - 1)).memory_copy ($l_zero, 1)

			elseif info.code = ({WEL_LIST_VIEW_CONSTANTS}.Lvn_marqueebegin) then
					-- A message has been received from an EV_LIST notifying
					-- us that a bounding box selection is beginning. We
					-- return 1 to override this behaviour.
				set_message_return_value (to_lresult (1))
			elseif info.code = ({WEL_RICH_EDIT_MESSAGE_CONSTANTS}.en_selchange) then
				rich_text ?= info.window_from
				check rich_text /= Void end
				create selchange.make_by_nmhdr (info)
				rich_text.on_en_selchange (selchange.selection_type, selchange.character_range)
			elseif info.code = {WEL_NM_CONSTANTS}.nm_click then
				checkable_tree ?= info.window_from
				if checkable_tree /= Void then
					checkable_tree.on_nm_click
				end
			elseif info.code = {WEL_NM_CONSTANTS}.nm_customdraw then
				radio_button ?= info.window_from
				if radio_button = Void then
					check_button ?= info.window_from
					if check_button /= Void then
						button := check_button
					end
				else
					button := radio_button
				end
					-- Note that this message is only sent on Windows XP if visual styles
					-- are being used. On other versions, this does not matter as the
					-- background is updated here to use the correct visual style.
					-- On older versions, nothing needs to be performed here.
				if button /= Void and application_imp.themes_active then
					create custom.make_by_pointer (info.item)
					if custom.dwdrawstage = {WEL_CDDS_CONSTANTS}.cdds_preerase then
						create bk_brush.make_solid (button.wel_background_color)
						theme_drawer.draw_widget_background (button, custom.hdc, button.client_rect, bk_brush)
						set_message_return_value (to_lresult ({WEL_CDRF_CONSTANTS}.cdrf_dodefault))
						bk_brush.delete
					end
				end
			end
		end

feature {NONE} -- Implementation, focus event

	redraw_current_push_button (focused_button: EV_BUTTON)
			-- Put a bold border on the `focused_button' and
			-- remove any bold border on the other buttons.
			--
			-- Used when `Current' is a child of an EV_DIALOG_IMP.
		local
			l: LINEAR [EV_WIDGET]
			cs: detachable CURSOR_STRUCTURE [EV_WIDGET]
			cur: detachable CURSOR
			widget_imp: detachable EV_WIDGET_IMP
		do
			l := attached_interface.linear_representation
			cs ?= l
			if cs /= Void then
				cur := cs.cursor
			end
			from
				l.start
			until
				l.off
			loop
				widget_imp ?= l.item.implementation
				check
					widget_imp_non_void: widget_imp /= Void
				end
				widget_imp.redraw_current_push_button (focused_button)
				l.forth
			end
			if cs /= Void then
				check cur /= Void end
				cs.go_to (cur)
			end
		end

feature {NONE} -- Implementation : deferred features

	client_rect: WEL_RECT
		deferred
		end

	disable_default_processing
		deferred
		end

	set_message_return_value (v: POINTER)
		deferred
		end

	on_vertical_scroll (scroll_code, position: INTEGER)
		deferred
		end

	on_horizontal_scroll (scroll_code, position: INTEGER)
		deferred
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_CONTAINER note option: stable attribute end

feature {NONE} -- Feature that should be directly implemented by externals

	get_wm_hscroll_code (wparam, lparam: POINTER): INTEGER
			-- Encapsulation of the external cwin_get_wm_hscroll_code.
		deferred
		end

	get_wm_hscroll_hwnd (wparam, lparam: POINTER): POINTER
			-- Encapsulation of the external cwin_get_wm_hscroll_hwnd
		deferred
		end

	get_wm_hscroll_pos (wparam, lparam: POINTER): INTEGER
			-- Encapsulation of the external cwin_get_wm_hscroll_pos
		deferred
		end

	get_wm_vscroll_code (wparam, lparam: POINTER): INTEGER
			-- Encapsulation of the external cwin_get_wm_vscroll_code.
		deferred
		end

	get_wm_vscroll_hwnd (wparam, lparam: POINTER): POINTER
			-- Encapsulation of the external cwin_get_wm_vscroll_hwnd
		deferred
		end

	get_wm_vscroll_pos (wparam, lparam: POINTER): INTEGER
			-- Encapsulation of the external cwin_get_wm_vscroll_pos
		deferred
		end

feature {EV_ANY_I} -- Implementation

	is_child (a_child: EV_WIDGET_IMP): BOOLEAN
			-- Is `a_child' a child of `Current'?
		deferred
		end

	index_of_child (child: EV_WIDGET_IMP): INTEGER
			-- `Result' is 1 based index of `child' within `Current'.
		require
			child_not_void: child /= Void
			child_contained: has (child.attached_interface)
		deferred
		ensure
			valid_result: Result >= 1 and Result <= count
		end

feature {EV_CONTAINER_IMP} -- Implementation

	radio_group: LINKED_LIST [EV_RADIO_BUTTON_IMP]
			-- Radio items in `Current'.
			-- `Current' shares reference with merged containers.

	is_merged (other: EV_CONTAINER): BOOLEAN
			-- Is `Current' merged with `other'?
		require
			other_not_void: other /= Void
		local
			c_imp: detachable EV_CONTAINER_IMP
		do
			c_imp ?= other.implementation
			check c_imp /= Void end
			Result := c_imp.radio_group = radio_group
		end

	reset_radio_group
			-- Reset radio group to be an empty
			-- list.
		do
			create radio_group.make
		ensure
			radio_group_exists: radio_group /= Void
			radio_group_empty: radio_group.is_empty
		end

	set_radio_group (rg: like radio_group)
			-- Set `radio_group' by reference. (Merge)
		do
			radio_group := rg
		ensure
			radio_group_set: radio_group = rg
		end

	add_radio_button (w: EV_WIDGET)
			-- Called every time a widget is added to the container.
			--| If `w' is a radio button then we update associated
			--| radio buttons as necessary.
		require
			w_not_void: w /= Void
		local
			r: detachable EV_RADIO_BUTTON_IMP
		do
			r ?= w.implementation
			if r /= Void then
				if not radio_group.is_empty then
					r.set_unchecked
				end
				r.set_radio_group (radio_group)
			end
		end

	remove_radio_button (w: EV_WIDGET)
			-- Called every time a widget is removed from the container.
			--| If `w' is a radio button then we update  associated
			--| radio buttons as necessary.
		require
			w_not_void: w /= Void
		local
			r: detachable EV_RADIO_BUTTON_IMP
		do
			r ?= w.implementation
			if r /= Void then
				r.remove_from_radio_group
				r.set_checked
			end
		end

	enable_widget_sensitivity (w: EV_WIDGET)
			-- Called every time a widget is removed from `Current'.
			--| If `Current' is disabled and `w' has never been disabled
			--| through the interface then we must enable `w' again.
			--| If a widget is placed in a container that has sensitivity
			--| disabled then we disable the widget also. We must however,
			--| return the widget to it's original state when it is removed.
			--| Hence this function.
		local
			w_imp: detachable EV_WIDGET_IMP
			l_interface: like interface
		do
			w_imp ?= w.implementation
			check
				widget_imp_not_void: w_imp /= Void
			end
			l_interface := interface
			if attached l_interface and then not l_interface.implementation.is_sensitive then
				if not w_imp.internal_non_sensitive then
					w_imp.enable_sensitive
				end
			end
		end

	disable_widget_sensitivity (w: EV_WIDGET)
			-- Called every time a widget is added to `Current'.
			--| If `Current' is disabled then we must disable `w'.
		local
			w_imp: detachable EV_WIDGET_IMP
			l_interface: like interface
		do
			w_imp ?= w.implementation
			check
				widget_imp_not_void: w_imp /= Void
			end
			l_interface := interface
			if attached l_interface and then not l_interface.implementation.is_sensitive then
				w_imp.disable_sensitive
			end
		end

feature -- Status setting

	connect_radio_grouping (a_container: EV_CONTAINER)
			-- Join radio grouping of `a_container' to `Current'.
		local
			l: like radio_group
			peer: detachable EV_CONTAINER_IMP
		do
			peer ?= a_container.implementation
			check peer /= Void end
			l := peer.radio_group
			if l /= radio_group then
				from
					l.start
				until
					l.is_empty
				loop
					add_radio_button (l.item.attached_interface)
				end
				peer.set_radio_group (radio_group)
			end
		end

	unconnect_radio_grouping (a_container: EV_CONTAINER)
			-- Removed radio grouping of `a_container' from `Current'.
		local
			l: detachable like radio_group
			peer: detachable EV_CONTAINER_IMP
			r: detachable EV_RADIO_BUTTON_IMP
			original_selected_button: detachable EV_RADIO_BUTTON_IMP
		do
			peer ?= a_container.implementation
			check peer /= Void end
			l := radio_group
			from
				l.start
			until
				l.off
			loop
				r ?= l.item
				check r /= Void end
				if r.is_selected then
						-- Store originally selected button,
						-- for selection of necessary button at
						-- end of unmerge, as a button has to
						-- be selected in all groups.
					original_selected_button := r
				end
				if r.parent = a_container then
					if peer.radio_group = radio_group then
							-- Reset radio group, back to
							-- empty.
						peer.reset_radio_group
					end
						-- Remove radio button from radio group
						-- of `Current'.
					l.remove
						-- Link radio group of `r' to match that of `a_container'.
					r.internal_set_radio_group (peer.radio_group)
						-- Add `r' to radio group of `container'.
					peer.radio_group.extend (r)
				else
					l.forth
				end
			end

			if not l.is_empty then
				check
					had_original_selection: original_selected_button /= Void
				end
			end
				-- There was not necessarily a selected item, as
				-- the containers may not contain a radio button.
			if original_selected_button /= Void then
					-- We now select a radio button in the new group,
					-- that does not already have one selected.
				if original_selected_button.parent_imp = peer then
					if has_selected_radio_button then
						select_first_radio_button
					end
				elseif peer.has_radio_button then
					peer.select_first_radio_button
				end
			end
		end

feature -- Event handling

	remove_item_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_WIDGET]]
			-- Actions to be performed before an item is removed.

feature {NONE} -- Implementation

	default_process_message (msg: INTEGER; wparam, lparam: POINTER)
			-- Process `msg' which has not been processed by
			-- `process_message'.
		do
			if not process_menu_message (msg, wparam, lparam) then
				Precursor {EV_WIDGET_IMP} (msg, wparam, lparam)
			end
		end

invariant
	new_item_actions_not_void: is_usable implies new_item_actions /= Void
	remove_item_actions_not_void: is_usable implies remove_item_actions /= Void

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_CONTAINER_IMP











