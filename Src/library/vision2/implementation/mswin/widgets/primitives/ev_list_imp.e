indexing
	description: "Eiffel Vision list. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_LIST_IMP

inherit
	EV_LIST_I
		undefine
			pixmaps_size_changed
		redefine	
			interface, initialize, selected_item, selected_items, wipe_out
		end
		
	EV_LIST_ITEM_LIST_IMP
		redefine
			initialize, interface, wipe_out
		end
	
	EV_PRIMITIVE_IMP
		undefine
			on_right_button_down, on_left_button_down,
			on_middle_button_down, on_left_button_up,
			on_left_button_double_click, on_middle_button_double_click,
			on_right_button_double_click, pnd_press, escape_pnd
		redefine
			make, on_key_down, on_mouse_move, set_default_minimum_size,
			initialize, interface, on_size, enable_sensitive, disable_sensitive
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
			default_process_message
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

creation
	make
	
feature {NONE} -- Initialization
	
	make (an_interface: like interface) is         
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

	initialize is
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

	selected_item: EV_LIST_ITEM is
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

	selected_items: ARRAYED_LIST [EV_LIST_ITEM] is
			-- Currently selected items.
		do
			if not internal_selected_items_uptodate then
				internal_selected_items := retrieve_selected_items
				internal_selected_items_uptodate := True
			end
			Result := clone (internal_selected_items)
		ensure then
			valid_result: Result.is_equal(retrieve_selected_items)
		end

feature -- Status setting

	ensure_i_th_visible (an_index: INTEGER) is
			-- Ensure item `an_index' is visible in `Current'.
		do
			ensure_visible (an_index - 1)
		end

	select_item (an_index: INTEGER) is
			-- Select item at `an_index'.
		do
			(ev_children @ an_index).enable_select
		end

	deselect_item (an_index: INTEGER) is
			-- Deselect item at `an_index'.
		do
			(ev_children @ an_index).disable_select
		end

	clear_selection is
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

	enable_multiple_selection is
			-- Allow more than one item to be selected.
		do
			if not multiple_selection_enabled then
				set_style (default_style - Lvs_singlesel)
				multiple_selection_enabled := True
			end
		end

	disable_multiple_selection is
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
			end
		end
	
	selected_items_at_disable_sensitive: ARRAYED_LIST [EV_LIST_ITEM]
		-- All the selected items at the point `disable_sensitive'
		-- was called. When we call `disable_sensitive' on a list, we
		-- do not want the selected items to be highlighted any longer.
		-- In order to do this, we need to internally deselect any selected items
		-- during `disable_select' and then enable all these items again
		-- during `enable_select'.

	enable_sensitive is
			-- Make object sensitive to user input.
		local
			item_imp: EV_LIST_ITEM_IMP
		do
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

	disable_sensitive is
			-- Make object desensitive to user input.
		do
				-- Copy `selected_items' into `selected_items_at_disable_sensitive'
			if selected_items /= Void then
				selected_items_at_disable_sensitive := clone (selected_items)
			end
			Precursor
				-- We now remove the selection on all selected items.
			clear_selection
			invalidate
			update
		end

feature {EV_LIST_ITEM_IMP} -- Implementation

	internal_propagate_pointer_press (keys, x_pos, y_pos, button: INTEGER) is
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
		(keys, x_pos, y_pos, button: INTEGER) is
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
		image_index: INTEGER) is
			-- Set pixmap of `an_item' at position `position' in `Current'
			-- to the `image_index'th image in `image_list'.
		local
			lv_item: WEL_LIST_VIEW_ITEM
		do
			lv_item := an_item.lv_item
			lv_item.set_image (image_index)
			lv_item.set_iitem (position - 1)
			wel_replace_item (lv_item)
		end

	remove_pixmap_of_child (an_item: EV_LIST_ITEM_IMP; position: INTEGER) is
			-- Remove pixmap of `an_item' located at position `position' in
			-- `Current'.
		local
			lv_item: WEL_LIST_VIEW_ITEM
		do
			lv_item := an_item.lv_item
			lv_item.set_image (0)
			lv_item.set_iitem (position - 1)
			wel_replace_item (lv_item)
		end

	insert_item (item_imp: EV_LIST_ITEM_IMP; an_index: INTEGER) is
			-- Insert `item_imp' at `an_index'.
		local
			litem: WEL_LIST_VIEW_ITEM
		do
			create litem.make
			if item_imp.text /= Void then
				litem.set_text (item_imp.text)
			end
			litem.set_iitem (an_index - 1)
			litem.set_image (0)

				-- We set the index within the list item
			item_imp.lv_item.set_iitem (an_index - 1)
			wel_insert_item (litem)
			set_column_width (-1, 0) -- Autosize
		end

	refresh_item (item_imp: EV_LIST_ITEM_IMP) is
			-- Refresh current so that it take into account 
			-- changes made in `item_imp'
		do
			wel_replace_item (item_imp.lv_item)
				--| Setting a text of an item causes this feature to be called.
				--| We must autosize the column width in case the text is wider
				--| than the text of any items already contained in `Current'.
			set_column_width (-1, 0)
		end

	remove_item (item_imp: EV_LIST_ITEM_IMP) is
			-- Remove `item' from the list
		local
			an_index: INTEGER
		do
			an_index := ev_children.index_of (item_imp, 1) - 1
			delete_item (an_index)
			set_column_width (-1, 0) -- Autosize
		end

	internal_get_index (item_imp: EV_LIST_ITEM_IMP): INTEGER is
			-- Return the index of `item_imp' in the list.
		do
			Result := ev_children.index_of (item_imp, 1)
		end

	internal_is_selected (item_imp: EV_LIST_ITEM_IMP): BOOLEAN is
			-- Is `item_imp' selected in `Current'?
		local
			i: INTEGER
		do
			i := ev_children.index_of (item_imp, 1) - 1
			i := get_item_state (i, Lvis_selected)
			Result := flag_set (i, Lvis_selected)
		end

	internal_select_item (item_imp: EV_LIST_ITEM_IMP) is
			-- Select `item_imp' in `Current'.
		local
			i: INTEGER
			litem: WEL_LIST_VIEW_ITEM
		do
			i := ev_children.index_of (item_imp, 1) - 1
			create litem.make_with_attributes (Lvif_state, i, 0, 0, "")
			litem.set_state (Lvis_selected)
			litem.set_statemask (Lvis_selected)	
			cwin_send_message (wel_item, Lvm_setitemstate, i,
				litem.to_integer)
		end

	internal_deselect_item (item_imp: EV_LIST_ITEM_IMP) is
			-- Deselect `item_imp' in `Current'.
		local
			i: INTEGER
			litem: WEL_LIST_VIEW_ITEM
		do
			i := ev_children.index_of (item_imp, 1) - 1
			create litem.make_with_attributes (Lvif_state, i, 0, 0, "")
			litem.set_state (0)
			litem.set_statemask (Lvis_selected)	
			cwin_send_message (wel_item, Lvm_setitemstate, i,
				litem.to_integer)
		end

	set_default_minimum_size is
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
		end

	wipe_out is
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
						child_imp.deselect_actions_internal.call ([])
					end
					if deselect_actions_internal /= Void then
						deselect_actions_internal.call ([child_imp.interface])
					end
					internal_selected_items.prune (child_imp.interface)
				end
				ev_children.remove
			end
			reset_content
			index := 0
		end

feature {EV_LIST_ITEM_IMP} -- Pixmap handling

	setup_image_list is
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

	remove_image_list is
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

	find_item_at_position (x_pos, y_pos: INTEGER): EV_LIST_ITEM_IMP is
			-- `Result' is list item at pixel position `x_pos', `y_pos'.
		local
			pt: WEL_POINT
			info: WEL_LV_HITTESTINFO
		do
			create pt.make (x_pos, y_pos)
			create info.make_with_point (pt)
			cwin_send_message (wel_item, Lvm_hittest, 0, info.to_integer)
			if flag_set (info.flags, Lvht_onitemlabel)
			or flag_set (info.flags, Lvht_onitemicon)
			then
				Result := ev_children @ (info.iitem + 1)
			end
		end

	default_style: INTEGER is
			-- Default style of `Current'.
		once
			Result := Ws_visible + Ws_child + Ws_group + Ws_tabstop
				+ Ws_border + Ws_clipchildren + Lvs_showselalways
				+ Lvs_nocolumnheader
				+ Lvs_report
				+ Lvs_singlesel
				+ Lvs_shareimagelists
		end

	default_ex_style: INTEGER is
		once
			Result := Lvs_ex_infotip
		end

	on_lvn_itemchanged (info: WEL_NM_LIST_VIEW) is
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
							item_imp.select_actions_internal.call ([])
						end
						if select_actions_internal /= Void then
							select_actions_internal.call ([item_interface])
						end
	
					elseif flag_set(info.uoldstate, Lvis_selected) and
						not flag_set(info.unewstate, Lvis_selected)
					then
							-- Item is being unselected
						internal_selected_items_uptodate := False
						item_imp := ev_children @ (info.iitem + 1)
						item_interface := item_imp.interface
						if item_imp.deselect_actions_internal /= Void then
							item_imp.deselect_actions_internal.call ([])
						end
						if deselect_actions_internal /= Void then
							deselect_actions_internal.call ([item_interface])
						end
					end
				end
			end
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- A key has been pressed.
		do
			process_tab_key (virtual_key)
			Precursor {EV_PRIMITIVE_IMP} (virtual_key, key_data)
		end

	on_size (size_type, a_width, a_height: INTEGER) is
			-- `Current' resized.
		do
			Precursor {WEL_LIST_VIEW} (size_type, a_width, a_height)
			Precursor {EV_PRIMITIVE_IMP} (size_type, a_width, a_height)
		end

	on_mouse_move (keys, x_pos, y_pos: INTEGER) is
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

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
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
			set_message_return_value (1)
				-- Create a brush corresponding to the background color.
			if is_sensitive then
				bkg_color := get_background_color
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
				reg.delete
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
		end

feature {NONE} -- Implementation

	internal_selected_items_uptodate: BOOLEAN
			-- Is `internal_selected_items' sorted?

	internal_selected_items: like selected_items
			-- Cached version of all selected items.

	retrieve_selected_items: like selected_items is
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

	valid_selected_items (a_selected_items: like selected_items): BOOLEAN is
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

feature {NONE} -- Feature that should be directly implemented by externals

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgTabItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			Result := cwin_get_next_dlgtabitem (hdlg, hctl, previous)
		end

	next_dlggroupitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgGroupItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			check
				Never_called: False
			end
		end

	mouse_message_x (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not work because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_x (lparam)
		end

	mouse_message_y (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not work because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_y (lparam)
		end

	show_window (hwnd: POINTER; cmd_show: INTEGER) is
			-- Encapsulation of the cwin_show_window function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not work because
			-- it would be implemented by an external.
		do
			cwin_show_window (hwnd, cmd_show)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_LIST

end -- class EV_LIST_IMP

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
--| Revision 1.83  2001/06/14 00:09:12  rogers
--| Undefined the version of escape_pnd inherited from EV_PRIMITIVE_IMP.
--|
--| Revision 1.82  2001/06/07 23:08:16  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.35.4.60  2001/06/04 21:40:27  rogers
--| Moved redundent require else from `remove_image_list'.
--|
--| Revision 1.35.4.59  2001/05/25 23:12:53  rogers
--| Added selected_items_at_disable_sensitive. When a list is made non
--| sensitive, we now internally deselect the items so the selection is no
--| longer visible.
--|
--| Revision 1.35.4.58  2001/02/15 00:56:06  rogers
--| Fixed bug in internal_propagate_pointer_press. We now check that
--| `pre_drop_it' is still parented before calling `pnd_press' on
--| `pre_drop_it'. This is because a button press can cause the item to be
--| removed.
--|
--| Revision 1.35.4.57  2001/02/02 00:51:33  rogers
--| On_key_down now calls process_tab_key before Precursor. This ensures that
--| any tab movement we do in our implementation can be overriden by the user
--| with key_press_actions.
--|
--| Revision 1.35.4.56  2001/01/26 23:22:51  rogers
--| Undefined on_sys_key_down inherited from WEL.
--|
--| Revision 1.35.4.55  2001/01/22 19:09:45  rogers
--| Redefined `default_ex_style'. This allows us to give a style to `Current'
--| required for infotip notification. Wipe_out now resets `index' to 0, so
--| before is correct after a wipe_out.
--|
--| Revision 1.35.4.52  2000/12/29 00:38:29  rogers
--| Internal_propagate_pointer_press now only calls the
--| pointer_button_press_actions if a pnd is running if `call_press_events'.
--|
--| Revision 1.35.4.51  2000/12/27 00:42:23  rogers
--| Implemented ensure_i_th_visible.
--|
--| Revision 1.35.4.50  2000/12/01 00:07:56  rogers
--| Fixed refresh item so that the column is re-sized automatically.
--|
--| Revision 1.35.4.49  2000/11/22 20:09:31  rogers
--| Fixed bug in erase_background where the background at the top of the list
--| was not being re-drawn.
--|
--| Revision 1.35.4.48  2000/11/22 14:36:39  pichery
--| - Handled the `disable_sensitive'. It now sets the background
--|   to gray.
--| - Added "full row select" flag.
--|
--| Revision 1.35.4.47  2000/11/21 23:55:24  rogers
--| Fixed bug with child indexes within on_erase_background.
--|
--| Revision 1.35.4.46  2000/11/21 18:45:23  rogers
--| Removed process_message, column_widths_fill_client_area,
--| on_wm_window_pos_changing, on_wm_window_pos_changed. Re-implemented
--| on_erase_background. The horizontal scroll bar is now displayed as
--| required, and `Current' does not flicker when re-sizing with the show
--| window contents while dragging option enabled.
--|
--| Revision 1.35.4.44  2000/11/09 16:44:35  pichery
--| - Added shared imagelist.
--| - Removed the default border around the list (lists now has
--|   the same border than trees).
--| - Cosmetics
--|
--| Revision 1.35.4.43  2000/11/06 17:58:06  rogers
--| Undefined on_sys_key_down from wel. Version from EV_WIDGET_IMP is now used.
--|
--| Revision 1.35.4.42  2000/10/28 01:08:24  manus
--| Removed creation of `gui_font' local variable that was not needed.
--|
--| Revision 1.35.4.41  2000/10/27 02:35:54  manus
--| Removed the undefinition of `set_default_colors' since the inherited one does what we want.
--|
--| Revision 1.35.4.40  2000/10/25 23:25:26  rogers
--| Modified internal_propagate_pointer_press so that the button press
--| events are recieved in the correct order in conjunction with the
--| pick/drag and drop. Correct order is before when starting a pick and after
--| when ending a pick.
--|
--| Revision 1.35.4.39  2000/10/24 19:46:16  rogers
--| Fixed bug in internal_propagate_pointer_press if you were in PND and
--| had dropped on an item and removed that item from `Current' in the drop
--| actions.
--|
--| Revision 1.35.4.38  2000/10/11 00:00:28  raphaels
--| Added `on_desactivate' to list of undefined features from WEL_WINDOW.
--|
--| Revision 1.35.4.37  2000/09/26 18:42:31  rogers
--| Clear selection was not working correctly without assertions on as the
--| internal_selected_items were not being updated. With assertions on,
--| selected_items would be called, which would then update the
--| internal_selected_items. Now  clear_selection updates the
--| internal_selected_items if necessary.
--|
--| Revision 1.35.4.36  2000/09/23 22:52:22  rogers
--| Insert item now sets the iitem attribute of lv_item from item_imp.
--| This attribute holds the position of an item in it's parent. For example,
--| when set_text was called previously on an item, the index retrieved from
--| lv_item was always returned as 0, so the first child of the parent was
--| always updated, not the actual item.
--|
--| Revision 1.35.4.35  2000/09/23 22:00:51  rogers
--| Last commit should have read: Fixed bug in insert_item so it no longer
--| crashes when text of implementation is Void.
--|
--| Revision 1.35.4.33  2000/09/13 22:10:54  rogers
--| Changed the style of Precursor.
--|
--| Revision 1.35.4.32  2000/08/21 20:28:35  rogers
--| Added remove_pixmap_of_child.
--|
--| Revision 1.35.4.30  2000/08/08 02:38:51  manus
--| Updated inheritance with new WEL messages handling
--| New resizing policy by calling `ev_' instead of `internal_', see
--|   `vision2/implementation/mswin/doc/sizing_how_to.txt'.
--| Better implementation of `on_erase_background' which delete GDI objects.
--|
--| Revision 1.35.4.29  2000/08/04 20:39:35  rogers
--| All action sequence calls through the interface have been replaced with
--| calls to the internal action sequences.
--|
--| Revision 1.35.4.28  2000/08/02 21:06:38  rogers
--| GDI objects in on_erase_background are only destroyed if they have been
--| created.
--|
--| Revision 1.35.4.27  2000/08/02 16:44:09  rogers
--| We now delete the GDI objects that we create duing on_erase_background.
--|
--| Revision 1.35.4.26  2000/07/28 02:42:07  pichery
--| Fixed bug in `set_text' of EV_LIST_ITEM_IMP (changes
--| were not reflected in the parent if the item was already in a
--| list).
--|
--| Revision 1.35.4.25  2000/07/21 20:02:29  rogers
--| Removed unwanted changes. PLease ignore last commit message.
--|
--| Revision 1.35.4.23  2000/07/18 22:36:03  rogers
--| Initialize now calls initialize_pixmaps instead of {EV_LIST_I} Precursor.
--|
--| Revision 1.35.4.21  2000/07/18 20:38:52  rogers
--| Removed pixmaps_size_changed as it is now inherited from
--| EV_LIST_ITEM_LIST_IMP. Altered on_erase_background, but alteration
--| not complete.
--|
--| Revision 1.35.4.20  2000/07/17 19:34:20  rogers
--| Implemented pixmaps_size_changed.
--|
--| Revision 1.35.4.19  2000/07/17 17:57:20  rogers
--| Pre and post conditions changed for remove_image_list.
--|
--| Revision 1.35.4.18  2000/07/14 18:00:52  rogers
--| Initialize now calls {EV_LIST_I} Precursor after other precursor calls.
--|
--| Revision 1.35.4.17  2000/07/14 17:48:55  rogers
--| Removed image_list as it is now inherited from EV_LIST_ITEM_LIST_IMP.
--|
--| Revision 1.35.4.16  2000/07/14 17:23:06  rogers
--| Chnaged export of pixmap features to EV_LIST_ITEM_IMP.
--|
--| Revision 1.35.4.15  2000/07/13 23:50:55  rogers
--| Initialize now calls precursor.
--|
--| Revision 1.35.4.14  2000/07/13 23:43:25  rogers
--| Added image list, set_up_image_list and remove_image_list which will
--| associate `image_list' with `Current'.
--|
--| Revision 1.35.4.13  2000/07/12 16:10:33  rogers
--| Undefined x_position and y_position inherited from WEL, as they are now
--| inherited from EV_WIDGET_IMP.
--|
--| Revision 1.35.4.12  2000/07/10 17:55:55  rogers
--| Now inherits WEL_REGION_CONSTANTS. Reimplemented on_erase_background to use
--| WEL_REGION. This fixes graphical bugs involving display of items removed
--| and automatic hiding of scroll bars.
--|
--| Revision 1.35.4.11  2000/06/19 19:02:13  rogers
--| Removed FIXME NOT_REVIEWED. Comments, formatting.
--|
--| Revision 1.35.4.10  2000/06/13 18:36:43  rogers
--| Removed undefintion of remove_command.
--|
--| Revision 1.35.4.9  2000/06/09 20:26:06  rogers
--| Added internal_propagate_pointer_double_press. Comments. Formatting.
--|
--| Revision 1.35.4.8  2000/05/30 15:59:50  rogers
--| Removed unreferenced variables.
--|
--| Revision 1.35.4.7  2000/05/22 16:42:24  rogers
--| Fixed on_erase_background as it would crash when attempting to re-draw
--| the background around the children, when there were no children.
--|
--| Revision 1.35.4.6  2000/05/17 18:53:05  rogers
--| Added column_widths_fill_client_area to fix bug in on_erase_background
--| which would not re-draw the control properly before the column widths had
--| been computed to fill the client rectangle.
--|
--| Revision 1.35.4.5  2000/05/16 23:42:07  rogers
--| Added on_erase_background, on_wm_window_pos_changing and
--| on_wm_window_pos_changed. Flickering on resize has been drastically
--| reduced by never clearing the background, but filling in the space
--| surrounding the items during on_erase_background.
--| ---------------------------------------------------------------------------
--|
--| Revision 1.35.4.3  2000/05/09 17:28:09  rogers
--| ev_multi_column_list_imp.e
--|
--| Revision 1.35.4.2  2000/05/03 22:35:04  brendel
--| Fixed resize_actions.
--|
--| Revision 1.35.4.1  2000/05/03 19:09:50  oconnor
--| mergred from HEAD
--|
--| Revision 1.79  2000/04/27 23:22:49  rogers
--| Undefined on_left_button_up from EV_PRIMITIVE_IMP.
--|
--| Revision 1.78  2000/04/27 23:03:28  pichery
--| Added set_default_minimum_size
--|
--| Revision 1.77  2000/04/27 17:51:18  pichery
--| Cosmetics
--|
--| Revision 1.76  2000/04/25 01:20:36  pichery
--| Changed the inheritance for constants,
--| Removed `wel_parent' hack.
--|
--| Revision 1.75  2000/04/21 01:22:16  pichery
--| Added flag to EV_LIST_IMP in order
--| to select the full row.
--|
--| Revision 1.74  2000/04/20 01:24:53  pichery
--| Changed the inheritance to take into
--| account EV_COMBO_BOX_IMP.
--|
--| Revision 1.73  2000/04/19 03:12:29  pichery
--| Fixed bugs
--|
--| Revision 1.72  2000/04/19 02:23:25  pichery
--| Changed postcondition in `selected_items'.
--|
--| Revision 1.69  2000/04/18 21:22:45  pichery
--| MAJOR CHANGE:
--| - Changed the implementation of EV_LIST_IMP. It now
--| inherit from WEL_LIST_VIEW instead of WEL_LIST_BOX.
--|
--| - fixed all waiting problems.
--|
--| --> Ready for review
--|
--| Revision 1.66  2000/04/17 23:32:02  rogers
--| Fixed bug in find_item_at_position.
--|
--| Revision 1.65  2000/04/11 23:56:03  brendel
--| Fixed cut/paste error.
--|
--| Revision 1.64  2000/04/11 19:01:25  brendel
--| Removed resolved FIXME's.
--| Formatted for 80 columns.
--|
--| Revision 1.63  2000/04/11 16:59:51  rogers
--| Removed direct inheritance from EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP.
--|
--| Revision 1.62  2000/04/05 21:16:12  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.61  2000/04/05 20:06:57  rogers
--| Added temporary compiler bug fix.
--|
--| Revision 1.60  2000/04/05 18:35:07  rogers
--| Recreate_list now correctly stores the existing attributes
--| of the windows object before destroying it, and then creating
--| a new object with these attributes.
--|
--| Revision 1.59  2000/03/31 19:07:44  rogers
--| Remove FIXME as it has been fixed.
--| Internal_propagate_pointer_press now propagates correct button.
--|
--| Revision 1.58  2000/03/31 00:26:11  rogers
--| Removed on_left_button_down, on_middle_button_down and
--| on_right_button_down as they are now inherited from
--| EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP
--|
--| Revision 1.57  2000/03/30 19:58:02  rogers
--| Now inherits from EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP.
--| Removed features and attributes associated with source of PND as
--| these are now inherited, and fixed references to these.
--|
--| Revision 1.56.2.2  2000/04/05 19:57:16  brendel
--| Added compiler hack. See code.
--|
--| Revision 1.56.2.1  2000/04/03 18:24:40  brendel
--| Renamed count as wel_count.
--|
--| Revision 1.56  2000/03/30 17:43:56  brendel
--| Moved common features with EV_COMBO_BOX up to EV_LIST_ITEM_LIST_IMP.
--|
--| Revision 1.55  2000/03/29 22:12:11  brendel
--| Added `set_item_imp_text'.
--| Improved contracts.
--|
--| Revision 1.54  2000/03/29 20:31:03  brendel
--| Added is_item_imp_selected, select_item_imp and deselect_item_imp.
--|
--| Revision 1.53  2000/03/29 02:20:47  brendel
--| Revised. Cleaned up.
--| Now inherits from WEL_SINGLE_SELECTION_LIST_BOX and
--| WEL_MULTIPLE_SELECTION_LIST_BOX. Features applying to multiple selection
--| start with ms_* and single sel. with ss_*.
--|
--| Revision 1.52  2000/03/24 19:14:52  rogers
--| Redefined initialize from EV_LIST_ITEM_HOLDER_IMP.
--|
--| Revision 1.51  2000/03/21 01:25:54  rogers
--| Renamed child_source -> pnd_child_source, set_child_source ->
--| set_pnd_child_source. Added pnd_press.
--|
--| Revision 1.50  2000/03/17 23:40:34  rogers
--| Added the following features: list_is_pnd_source, child_source,
--| set_child_Source, set_source_true, set_source_false. These fatures are
--| now being reviewed and will be modified further. Implemented on_mouse_move
--| and pnd_press.
--|
--| Revision 1.49  2000/03/15 17:06:36  rogers
--| Removed commented code. Added internal_propagate_pointer_press,
--| on_left_button_down, on_middle_button_down, on_right_button_down.
--| Removed on_lbn_dblclick.
--|
--| Revision 1.47  2000/03/14 23:53:09  rogers
--| Redefined on_mouse_move from EV_PRIMITIVE_IMP so items events can be
--| called. Added find_item_at_position.
--|
--| Revision 1.46  2000/03/14 19:24:14  rogers
--| renamed
--| 	move -> wel_move
--| 	height -> wel_height
--| 	x -> x_position
--| 	y -> y_position
--| 	resize -> wel_resize
--| 	move_and_resize -> wel_move_and_resize
--|
--| Revision 1.45  2000/03/07 17:53:53  rogers
--| Redefined on_size from WEL_LIST_BOX, so the resize_actions can be called.
--|
--| Revision 1.44  2000/03/07 00:11:56  rogers
--| The select actions are now always called on the child first before the
--| list
--|
--| Revision 1.43  2000/03/06 20:47:36  rogers
--| The list select and deselect action sequences now only return the selected
--| item, so any calls to these action sequences have been modified.
--|
--| Revision 1.42  2000/02/29 23:13:24  rogers
--| Removed selected_item as it is no longer platform dependent, it now comes
--| from EV_LIST_I.
--|
--| Revision 1.41  2000/02/29 19:35:21  rogers
--| Selected item now returns the first item that is selected in the list when
--| multiple selection is enabled.
--|
--| Revision 1.40  2000/02/25 21:41:12  rogers
--| In on_lbn_selchange, added code to handle the possibility of an item
--| being destroyed within an action sequence.
--|
--| Revision 1.39  2000/02/25 00:34:41  rogers
--| Clear selection, will only now call on_lbn_selchange when not in
--| multiple_selection mode when there was an item selected. Fixes bug where
--| an attempt to call the events on last_selected_item when it is Void
--| last.interface.deselect_actions.call ([])
--|
--| Revision 1.38  2000/02/24 21:18:58  rogers
--| Connected the select and de-select events to the list when in single
--| selection mode. Multiple selection mode still needs connecting.
--|
--| Revision 1.37  2000/02/19 05:45:01  oconnor
--| released
--|
--| Revision 1.36  2000/02/14 11:40:44  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.35.6.9  2000/02/10 18:01:12  rogers
--| Removed the old command association. Implemented part of the new event
--| system calls.
--|
--| Revision 1.35.6.8  2000/02/09 17:36:49  rogers
--| Altered inheritence of interface. Now redefined and selected from
--| EV_LIST_I, redefined from EV_LIST_ITEM_HOLDER_IMP, and renamed to
--| ev_primitive_imp_interface from EV_PRIMITIVE_IMP.
--|
--| Revision 1.35.6.7  2000/02/02 20:49:50  rogers
--| Altered the inheritcance of interfaces slightly. See diff.
--|
--| Revision 1.35.6.6  2000/01/27 19:30:27  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.35.6.5  2000/01/25 17:37:52  brendel
--| Removed code associated with old events.
--| Implementation and more removal is needed.
--|
--| Revision 1.35.6.4  2000/01/18 23:32:45  rogers
--| Renamed
--| 	set_single_selection -> disable_multiple_selection
--| 	set_multiple_selection -> enable_multiple_selection
--| 	is_multiple_selection -> multiple_selection_enabled
--|
--| Revision 1.35.6.3  2000/01/15 01:47:40  rogers
--| Modified to comply with the major vision2 changes. For redefinitions, see
--| diff. Implemanted interface.
--|
--| Revision 1.35.6.2  1999/12/17 00:38:43  rogers
--| Altered to fit in with the review branch. Basic alterations, redefinitaions
--| of name clashes etc. Make now takes an interface.
--|
--| Revision 1.35.6.1  1999/11/24 17:30:32  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.35.2.2  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
