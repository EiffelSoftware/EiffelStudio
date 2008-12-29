note
	description: "Eiffel Vision list. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_LIST_IMP

inherit
	EV_LIST_I
		redefine
			interface, initialize, selected_item, selected_items, wipe_out
		end

	EV_LIST_ITEM_LIST_IMP
		redefine
			initialize, interface, wipe_out
		end

	EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		undefine
			on_right_button_down, on_left_button_down,
			on_middle_button_down, on_left_button_up,
			on_left_button_double_click, on_middle_button_double_click,
			on_right_button_double_click, pnd_press, escape_pnd, set_background_color,
			set_foreground_color
		redefine
			make, on_key_down, on_mouse_move, set_default_minimum_size,
			initialize, interface, on_size, enable_sensitive, disable_sensitive, background_color,
			destroy
		end

 	WEL_LIST_VIEW
		rename
			make as wel_make, parent as wel_parent, destroy as wel_destroy,
			shown as is_displayed, set_parent as wel_set_parent,
			set_background_color as wel_set_background_color,
			font as wel_font, set_font as wel_set_font, move as wel_move,
			item as wel_item, enabled as is_sensitive, width as wel_width,
			height as wel_height, x as x_position, y as y_position,
			resize as wel_resize, move_and_resize as wel_move_and_resize,
			count as wel_count, selected_items as wel_selected_items,
			selected_item as wel_selected_item, insert_item as wel_insert_item,
			replace_item as wel_replace_item,
			has_capture as wel_has_capture
		undefine
			set_width, set_height, on_left_button_down, on_middle_button_down,
			on_right_button_down, on_left_button_up, on_middle_button_up,
			on_right_button_up, on_left_button_double_click,
			on_middle_button_double_click, on_right_button_double_click,
			on_mouse_move, on_key_down, on_key_up, on_char, on_set_focus,
			on_desactivate, on_kill_focus, on_set_cursor, show, hide,
			x_position, y_position, on_sys_key_down, on_sys_key_up,
			default_process_message, on_mouse_wheel, on_getdlgcode,
			on_wm_dropfiles
		redefine
			on_lvn_itemchanged, on_size, on_erase_background, default_style,
			default_ex_style
		end

	WEL_RGN_CONSTANTS
		export {NONE}
			all
		end

	WEL_COLOR_CONSTANTS
		export {NONE}
			all
		end

	EV_SHARED_IMAGE_LIST_IMP
		export {NONE}
			all
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create `Current' with interface `an_interface'.
			-- `Current' will be in single selection mode.
		local
			wel_lv_column: WEL_LIST_VIEW_COLUMN
		do
			base_make (an_interface)
			create ev_children.make (2)
			create internal_selected_items.make (2)

				-- Create the WEL LISTVIEW.
			wel_make (Default_parent, 0, 0, 0, 0, 0)
			create wel_lv_column.make
			append_column (wel_lv_column)
			set_extended_view_style (default_ex_style)
		end

	initialize
			-- Initialize `Current'.
		do
			Precursor {EV_PRIMITIVE_IMP}
			Precursor {EV_LIST_ITEM_LIST_IMP}
			initialize_pixmaps

				-- Set the WEL extended view style
			if comctl32_version >= version_470 then
				set_extended_view_style (get_extended_view_style +
					Lvs_ex_fullrowselect)
			end
		end

feature -- Access

	multiple_selection_enabled: BOOLEAN
			-- Can more than one item be selected?

	selected_item: EV_LIST_ITEM
			-- Currently selected item.
			-- Topmost selected item if multiple items are selected.
			-- (For multiple selections see `selected_items')
			--
			-- Void if there is no selection
		local
			local_selected_index: INTEGER
		do
			local_selected_index := wel_selected_item
			if local_selected_index >= 0 then
				Result := (ev_children @ (local_selected_index + 1)).interface
			end
		end

	selected_items: ARRAYED_LIST [EV_LIST_ITEM]
			-- Currently selected items.
		do
			if not internal_selected_items_uptodate then
				internal_selected_items := retrieve_selected_items
				internal_selected_items_uptodate := True
			end
			Result := internal_selected_items.twin
		ensure then
			valid_result: Result.is_equal(retrieve_selected_items)
		end

feature -- Status setting

	ensure_item_visible (an_item: EV_LIST_ITEM)
			-- Ensure `an_item' is visible in `Current'.
		local
			item_imp: EV_LIST_ITEM_IMP
		do
			item_imp ?= an_item.implementation
			check
				item_imp_not_void: item_imp /= Void
			end
			ensure_visible (internal_get_index (item_imp) - 1)
		end

	select_item (an_index: INTEGER)
			-- Select item at `an_index'.
		do
			(ev_children @ an_index).enable_select
		end

	deselect_item (an_index: INTEGER)
			-- Deselect item at `an_index'.
		do
			(ev_children @ an_index).disable_select
		end

	clear_selection
			-- Make `selected_items' empty.
		local
			local_selected_items: like selected_items
			list_item_imp: EV_LIST_ITEM_IMP
		do
			if not internal_selected_items_uptodate then
				internal_selected_items := retrieve_selected_items
				internal_selected_items_uptodate := True
			end
			local_selected_items := internal_selected_items
			from
				local_selected_items.start
			until
				local_selected_items.after
			loop
				list_item_imp ?= local_selected_items.item.implementation
					-- We now directly deselect the item through the implementation
					-- rather than calling the interface.
				internal_deselect_item (list_item_imp)
				local_selected_items.forth
			end

			internal_selected_items.wipe_out
		end

	enable_multiple_selection
			-- Allow more than one item to be selected.
		do
			if not multiple_selection_enabled then
				set_style (default_style - Lvs_singlesel)
				multiple_selection_enabled := True

					-- The scroll bars become hidden, but by calling `update_item'
					-- it forces `Current' to redisplay them if necessary.
				if count > 0 then
					update_item (count - 1)
				end
			end
		end

	disable_multiple_selection
			-- Allow only one item to be selected.
		local
			old_selected_item: EV_LIST_ITEM
		do
			if multiple_selection_enabled then
					-- Unselect all selected and remember the top
					-- most selected item.
				old_selected_item := selected_item
				clear_selection

					-- Set the new style
				set_style (default_style)
				multiple_selection_enabled := False

					-- Reselect the top most item
				if old_selected_item /= Void then
					old_selected_item.enable_select
				end
					-- The scroll bars become hidden, but by calling `update_item'
					-- it forces `Current' to redisplay them if necessary.
				if count > 0 then
					update_item (count - 1)
				end
			end
		end

	selected_items_at_disable_sensitive: ARRAYED_LIST [EV_LIST_ITEM]
		-- All the selected items at the point `disable_sensitive'
		-- was called. When we call `disable_sensitive' on a list, we
		-- do not want the selected items to be highlighted any longer.
		-- In order to do this, we need to internally deselect any selected items
		-- during `disable_select' and then enable all these items again
		-- during `enable_select'.

	enable_sensitive
			-- Make object sensitive to user input.
		local
			item_imp: EV_LIST_ITEM_IMP
		do
				-- Do nothing if we are already sensitive.
			if not is_sensitive then
				-- If we had any selected items when calling `disable_sensitive' then
				-- restore these to be selected again.
				if selected_items_at_disable_sensitive /= Void then
					from
						selected_items_at_disable_sensitive.start
					until
						selected_items_at_disable_sensitive.off
					loop
						item_imp ?= selected_items_at_disable_sensitive.item.implementation
						if has (item_imp.interface) then
							internal_select_item (item_imp)
						end
						selected_items_at_disable_sensitive.forth
					end
					internal_selected_items_uptodate := False
				end
				Precursor
				invalidate
				update
			end
		end

	disable_sensitive
			-- Make object desensitive to user input.
		do
				-- Do nothing if we are already not sensitive.
			if is_sensitive then
					-- Copy `selected_items' into `selected_items_at_disable_sensitive'
				if selected_items /= Void then
					selected_items_at_disable_sensitive := selected_items.twin
				end
				Precursor
					-- We now remove the selection on all selected items.
				clear_selection
				invalidate
				update
			end
		end

	set_background_color (color: EV_COLOR)
			-- Make `color' the new `background_color'
		do
			background_color_imp ?= color.implementation
			set_text_background_color (background_color_imp)
			if is_displayed then
				-- If the widget is not hidden then invalidate.
				invalidate
			end
		end

	set_foreground_color (color: EV_COLOR)
			-- Make `color' the new `foreground_color'
		do
			foreground_color_imp ?= color.implementation
			set_text_foreground_color (foreground_color_imp)
			if is_displayed then
				-- If the widget is not hidden then invalidate.
				invalidate
			end
		end

feature {EV_LIST_ITEM_IMP} -- Implementation

	internal_propagate_pointer_press (keys, x_pos, y_pos, button: INTEGER)
			-- Propagate `keys', `x_pos' and `y_pos' to the appropriate
			-- item event. Called on a pointer button press.
		local
			pre_drop_it, post_drop_it: EV_LIST_ITEM_IMP
			item_press_actions_called: BOOLEAN
			pt: WEL_POINT
		do
			pre_drop_it := find_item_at_position (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			if pre_drop_it /= Void and not transport_executing
				and not item_is_in_pnd then
				if pre_drop_it.pointer_button_press_actions_internal
					/= Void then
					pre_drop_it.pointer_button_press_actions_internal.call(
						[x_pos,y_pos - pre_drop_it.relative_y, button, 0.0,
						0.0, 0.0, pt.x, pt.y])
				end
					-- We record that the press actions have been called.
				item_press_actions_called := True
			end
				--| The pre_drop_it.parent /= Void is to check that the item that
				--| was originally clicked on, has not been removed during the press actions.
				--| If the parent is now void then it has, and there is no need to continue
				--| with `pnd_press'.
			if pre_drop_it /= Void and pre_drop_it.is_transport_enabled and
				not parent_is_pnd_source and pre_drop_it.parent /= Void then
				pre_drop_it.pnd_press (x_pos, y_pos, button, pt.x, pt.y)
			elseif pnd_item_source /= Void then
				pnd_item_source.pnd_press (x_pos, y_pos, button, pt.x, pt.y)
			end

			if item_is_pnd_source_at_entry = item_is_pnd_source then
				pnd_press (x_pos, y_pos, button, pt.x, pt.y)
			end

			if not press_actions_called and call_press_event then
				interface.pointer_button_press_actions.call
					([x_pos, y_pos, button, 0.0, 0.0, 0.0, pt.x, pt.y])
			end

			post_drop_it := find_item_at_position (x_pos, y_pos)

				-- If the press actions have not already been called then
				-- call them. If `press_actions_called' = False then it means
				-- we were in a pick and drop when entering this procedure, so
				-- we now call them after the PND has completed.
			if not item_press_actions_called then

					-- If there is an item where the button press was recieved,
					-- and it has not changed from the start of this procedure
					-- then call `pointer_button_press_actions'.
					--| Internal_propagate_pointer_press in
					--| EV_MULTI_COLUMN_LIST_IMP has a complete explanation.
				if post_drop_it /= Void and pre_drop_it = post_drop_it and call_press_event then
					if post_drop_it.pointer_button_press_actions_internal
						/= Void then
						post_drop_it.pointer_button_press_actions_internal.call(
							[x_pos,y_pos - post_drop_it.relative_y, button, 0.0,
							0.0, 0.0, pt.x, pt.y])
					end
				end
			end
				-- Reset `call_press_event'.
			keep_press_event
		end

	internal_propagate_pointer_double_press
		(keys, x_pos, y_pos, button: INTEGER)
			-- Propagate `keys', `x_pos' and `y_pos' to the appropriate
			-- item event. Called on a pointer button double press.
		local
			it: EV_LIST_ITEM_IMP
			pt: WEL_POINT
		do
			it := find_item_at_position (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			if it /= Void then
				if it.pointer_double_press_actions_internal /= Void then
					it.pointer_double_press_actions_internal.call
						([x_pos, y_pos, button, 0.0, 0.0, 0.0, pt.x, pt.y])
					end
			end
		end

feature {EV_LIST_ITEM_I} -- Implementation

	set_pixmap_of_child (an_item: EV_LIST_ITEM_IMP; position,
		image_index: INTEGER)
			-- Set pixmap of `an_item' at position `position' in `Current'
			-- to the `image_index'th image in `image_list'.
		local
			lv_item: WEL_LIST_VIEW_ITEM
		do
			lv_item := an_item.lv_item
			lv_item.set_image (image_index)
			lv_item.set_iitem (position - 1)
			wel_replace_item (lv_item)
			set_column_width (lvscw_autosize, 0)
		end

	remove_pixmap_of_child (an_item: EV_LIST_ITEM_IMP; position: INTEGER)
			-- Remove pixmap of `an_item' located at position `position' in
			-- `Current'.
		local
			lv_item: WEL_LIST_VIEW_ITEM
		do
			lv_item := an_item.lv_item
			lv_item.set_image (0)
			lv_item.set_iitem (position - 1)
			wel_replace_item (lv_item)
			set_column_width (lvscw_autosize, 0)
		end

	insert_item (item_imp: EV_LIST_ITEM_IMP; an_index: INTEGER)
			-- Insert `item_imp' at `an_index'.
		local
			litem: WEL_LIST_VIEW_ITEM
		do
			create litem.make
			litem.set_text (item_imp.text)
			litem.set_iitem (an_index - 1)
			litem.set_image (0)

				-- We set the index within the list item
			item_imp.lv_item.set_iitem (an_index - 1)
			wel_insert_item (litem)
			set_column_width (lvscw_autosize, 0) -- Autosize
		end

	refresh_item (item_imp: EV_LIST_ITEM_IMP)
			-- Refresh current so that it take into account
			-- changes made in `item_imp'
		do
			wel_replace_item (item_imp.lv_item)
				--| Setting a text of an item causes this feature to be called.
				--| We must autosize the column width in case the text is wider
				--| than the text of any items already contained in `Current'.
			set_column_width (lvscw_autosize, 0)
		end

	remove_item (item_imp: EV_LIST_ITEM_IMP)
			-- Remove `item' from the list
		local
			an_index: INTEGER
		do
			an_index := ev_children.index_of (item_imp, 1) - 1
			delete_item (an_index)
			set_column_width (lvscw_autosize, 0) -- Autosize
		end

	internal_get_index (item_imp: EV_LIST_ITEM_IMP): INTEGER
			-- Return the index of `item_imp' in the list.
		do
			Result := ev_children.index_of (item_imp, 1)
		end

	internal_is_selected (item_imp: EV_LIST_ITEM_IMP): BOOLEAN
			-- Is `item_imp' selected in `Current'?
		local
			i: INTEGER
		do
			i := ev_children.index_of (item_imp, 1) - 1
			i := get_item_state (i, Lvis_selected)
			Result := flag_set (i, Lvis_selected)
		end

	internal_select_item (item_imp: EV_LIST_ITEM_IMP)
			-- Select `item_imp' in `Current'.
		local
			i: INTEGER
			litem: WEL_LIST_VIEW_ITEM
		do
			i := ev_children.index_of (item_imp, 1) - 1
			create litem.make_with_attributes (Lvif_state, i, 0, 0, "")
			litem.set_state (Lvis_selected + Lvis_focused)
			litem.set_statemask (Lvis_selected + Lvis_focused)
			{WEL_API}.send_message (wel_item, Lvm_setitemstate, to_wparam (i), litem.item)
		end

	internal_deselect_item (item_imp: EV_LIST_ITEM_IMP)
			-- Deselect `item_imp' in `Current'.
		local
			i: INTEGER
			litem: WEL_LIST_VIEW_ITEM
		do
			i := ev_children.index_of (item_imp, 1) - 1
			create litem.make_with_attributes (Lvif_state, i, 0, 0, "")
			litem.set_state (0)
			litem.set_statemask (Lvis_selected + Lvis_focused)
			{WEL_API}.send_message (wel_item, Lvm_setitemstate, to_wparam (i), litem.item)
		end

	set_default_minimum_size
			-- Called after creation. Set the current size and
			-- notify the parent.
		local
			log_font: WEL_LOG_FONT
		do
			log_font := wel_font.log_font
			ev_set_minimum_size (
				log_font.width.abs * 15 + 7, -- 15 characters wide
				log_font.height.abs	* 3 + 7	 -- 3 characters tall
				)
				-- Now dispose of `log_font' as it is no longer required.
			log_font.dispose
		end

	wipe_out
			-- Remove all items.
			-- Redefined for speed optimization.
		local
			child_imp: EV_LIST_ITEM_IMP
		do
			from
				ev_children.start
			until
				ev_children.is_empty
			loop
				child_imp := ev_children.item
				child_imp.on_orphaned
				remove_item_actions.call ([child_imp.interface])
				child_imp.set_parent_imp (Void)
				if internal_selected_items.has (child_imp.interface) then
					if child_imp.deselect_actions_internal /= Void then
						child_imp.deselect_actions_internal.call (Void)
					end
					if deselect_actions_internal /= Void then
						deselect_actions_internal.call (Void)
					end
					internal_selected_items.prune (child_imp.interface)
				end
				ev_children.remove
			end
			reset_content
			index := 0

				-- We must now force the list to recompute the need
				-- for a horizontal scroll bar.
			set_column_width (lvscw_autosize, 0)
		end

feature {EV_LIST_ITEM_IMP} -- Pixmap handling

	setup_image_list
			-- Create the image list and associate it
			-- to `Current' if not already associated.
		do
				-- Create image list with all images 16 by 16 pixels
			image_list := get_imagelist_with_size (
				pixmaps_width , pixmaps_height)

				-- Associate the image list with the multicolumn list.
			set_small_image_list(image_list)
		ensure then
			image_list_not_void: image_list /= Void
		end

	remove_image_list
			-- Destroy the image list and remove it
			-- from `Current'.
		do
				-- Destroy the image list.
			destroy_imagelist (image_list)
			image_list := Void

				-- Remove the image list from the list.
			set_small_image_list(Void)
		ensure then
			image_list_is_void: image_list = Void
 		end

feature {EV_ANY_I} -- Implementation

	find_item_at_position (x_pos, y_pos: INTEGER): EV_LIST_ITEM_IMP
			-- `Result' is list item at pixel position `x_pos', `y_pos'.
		local
			pt: WEL_POINT
			info: WEL_LV_HITTESTINFO
		do
			create pt.make (x_pos, y_pos)
			create info.make_with_point (pt)
			{WEL_API}.send_message (wel_item, Lvm_hittest, to_wparam (0), info.item)
			if flag_set (info.flags, Lvht_onitemlabel)
			or flag_set (info.flags, Lvht_onitemicon)
			then
				Result := ev_children @ (info.iitem + 1)
			end
		end

	default_style: INTEGER
			-- Default style of `Current'.
		once
			Result := Ws_visible + Ws_child + Ws_group + Ws_tabstop
				+ Ws_border + Ws_clipchildren + Lvs_showselalways
				+ Lvs_nocolumnheader
				+ Lvs_report
				+ Lvs_singlesel
				+ Lvs_shareimagelists
				+ Ws_clipchildren
		end

	default_ex_style: INTEGER
		once
			Result := Lvs_ex_infotip
		end

	on_lvn_itemchanged (info: WEL_NM_LIST_VIEW)
			-- An item has changed.
		local
			item_imp: EV_LIST_ITEM_IMP
			item_interface: EV_LIST_ITEM
		do
				-- Selections can only occur when `Current' is sensitive.
				-- We must actually check this, as when disabling/enabling current,
				-- we must internally select/deselect items, and we wish to discard
				-- these messages so that they are not reflected in `interface'.
			if is_sensitive then
				if info.uchanged = Lvif_state and info.isubitem = 0 then
					if flag_set(info.unewstate, Lvis_selected) and
							not flag_set(info.uoldstate, Lvis_selected)
					then
							-- Item is being selected
						internal_selected_items_uptodate := False
						item_imp := ev_children @ (info.iitem + 1)
						item_interface := item_imp.interface
						if item_imp.select_actions_internal /= Void then
							item_imp.select_actions_internal.call (Void)
						end
						if select_actions_internal /= Void then
							select_actions_internal.call (Void)
						end

					elseif flag_set(info.uoldstate, Lvis_selected) and
						not flag_set(info.unewstate, Lvis_selected)
					then
							-- Item is being unselected
						internal_selected_items_uptodate := False
						item_imp := ev_children @ (info.iitem + 1)
						item_interface := item_imp.interface
						if item_imp.deselect_actions_internal /= Void then
							item_imp.deselect_actions_internal.call (Void)
						end
						if deselect_actions_internal /= Void then
							deselect_actions_internal.call (Void)
						end
					end
				end
			end
		end

	on_key_down (virtual_key, key_data: INTEGER)
			-- A key has been pressed.
		do
			process_navigation_key (virtual_key)
			Precursor {EV_PRIMITIVE_IMP} (virtual_key, key_data)
		end

	on_size (size_type, a_width, a_height: INTEGER)
			-- `Current' resized.
		do
			Precursor {WEL_LIST_VIEW} (size_type, a_width, a_height)
			Precursor {EV_PRIMITIVE_IMP} (size_type, a_width, a_height)
		end

	on_mouse_move (keys, x_pos, y_pos: INTEGER)
			-- Executed when the mouse move.
		local
			it: EV_LIST_ITEM_IMP
			pt: WEL_POINT
		do
			it := find_item_at_position (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			if it /= Void then
				if it.pointer_motion_actions_internal /= Void then
					it.pointer_motion_actions_internal.call ([x_pos, y_pos -
						it.relative_y, 0.0, 0.0, 0.0, pt.x, pt.y])
				end
			end
			if pnd_item_source /= Void then
				pnd_item_source.pnd_motion (x_pos, y_pos, pt.x, pt.y)
			end
			Precursor {EV_PRIMITIVE_IMP} (keys, x_pos, y_pos)
		end

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT)
			-- Wm_erasebkgnd message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
			--| `Current' no longer re-draws the background and draws the
			--| items on top. We must now calculate the area which will not be
			--|re-drawn by the items and now draw that ourseleves first.
		local
			bkg_color: WEL_COLOR_REF
			brush: WEL_BRUSH
			rect1, rect2: WEL_RECT
			reg, temp_reg, new_reg: WEL_REGION
			counter: INTEGER
			pixmap_line_length: INTEGER
		do
			disable_default_processing
			set_message_return_value (to_lresult (1))
				-- Create a brush corresponding to the background color.
			if is_sensitive then
				if background_color_imp = Void then
					bkg_color := get_background_color
				else
					bkg_color := background_color_imp
				end
			else
				create bkg_color.make_system (Color_btnface)
			end
			create brush.make_solid (bkg_color)
				-- Create a region coresponding to `invalid_rect'.
			create reg.make_rect_indirect (invalid_rect)
				-- If `Current' is not empty then.
				-- We check to see if there are children, as if `Current' is
				-- empty, we simply fill the whole of `reg'
			if ev_children.count /= 0 then
					-- If the visible children do not reach to the bottom
					-- of `Current'.
				if top_index + visible_count + 1 > ev_children.count then
					rect1 := get_item_rect (ev_children.count - 1)
					create temp_reg.make_rect (rect1.left, 0, rect1.right,
						rect1.bottom)
				else
					rect1 := get_item_rect (top_index)
					create temp_reg.make_rect (rect1.left, 0, rect1.right,
						wel_height)
				end
				new_reg := reg.combine (temp_reg, Rgn_diff)
				temp_reg.delete
						-- Erase the background in `new_reg'.
				paint_dc.fill_region (new_reg, brush)
				new_reg.delete
					-- Fill in left side of `paint_dc'.
				create rect2.make (client_rect.left, client_rect.top,
					client_rect.left + 2, client_rect.bottom)
				paint_dc.fill_rect (rect2, brush)
					-- Fill in top of `paint_dc'
				create rect2.make (client_rect.left, client_rect.top,
					client_rect.right, client_rect.top + 2)
				paint_dc.fill_rect (rect2, brush)
					-- Fill in areas of `paint_dc' around images contained.
				from
					counter:= top_index
				until
					counter = top_index + visible_count or
					counter > ev_children.count - 1
				loop
					rect1 := get_item_rect (counter)
					pixmap_line_length := pixmaps_width + 2
					create rect2.make (rect1.left, rect1.top +
						pixmaps_height, pixmap_line_length, rect1.bottom)
					paint_dc.fill_rect (rect2, brush)
					counter := counter + 1
				end
					-- Delete windows GDI objects.
				brush.delete
			else
					-- There are no children , so erase all of `reg'.
				paint_dc.fill_region (reg, brush)
			end
			reg.delete
			brush.delete
		end

	background_color: EV_COLOR
			-- Color used for the background of `Current'.
			-- This has been redefined as the background color of
			-- text components is white, or `Color_read_write' by default.
		do
			if background_color_imp /= Void then
				Result ?= background_color_imp.interface
			else
				Result := (create {EV_STOCK_COLORS}).Color_read_write
			end
		end

feature {NONE} -- Implementation

	internal_selected_items_uptodate: BOOLEAN
			-- Is `internal_selected_items' sorted?

	internal_selected_items: like selected_items
			-- Cached version of all selected items.

	retrieve_selected_items: like selected_items
			-- Current selected items (non cached version)
		local
			i: INTEGER
			interf: EV_LIST_ITEM
			c: like ev_children
			wel_sel_items: like wel_selected_items
		do
			create Result.make (selected_count)
			c := ev_children
			wel_sel_items := wel_selected_items
			from
				i := 0
			until
				i = selected_count
			loop
				interf ?= (c @ (wel_sel_items @ i + 1)).interface
				Result.extend (interf)
				i := i + 1
			end
		end

	valid_selected_items (a_selected_items: like selected_items): BOOLEAN
			-- Validate `a_selected_items' as selected items list.
		local
			good_selected_items: like selected_items
		do
			Result := True
			good_selected_items := retrieve_selected_items

				-- Test if `a_selected_items' is included into
				-- `good_selected_items'
			from
				a_selected_items.start
			until
				(a_selected_items.after) or (Result = False)
			loop
				Result := good_selected_items.has(a_selected_items.item)
				a_selected_items.forth
			end

				-- Test if `good_selected_items' is included into
				-- `a_selected_items'
			from
				good_selected_items.start
			until
				(good_selected_items.after) or (Result = False)
			loop
				Result := a_selected_items.has(good_selected_items.item)
				good_selected_items.forth
			end
		end

	destroy
			-- Destroy `Current'.
		do
			wipe_out
			Precursor {EV_PRIMITIVE_IMP}
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_LIST;

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




end -- class EV_LIST_IMP

