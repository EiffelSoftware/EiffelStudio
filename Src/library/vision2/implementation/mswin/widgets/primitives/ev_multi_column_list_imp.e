indexing
	description: 
		"Eiffel Vision multi column list. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MULTI_COLUMN_LIST_IMP 

inherit
	EV_MULTI_COLUMN_LIST_I
		redefine
			interface,
			initialize,
			remove_row_pixmap,
			pixmaps_size_changed
		end

	EV_PRIMITIVE_IMP
		undefine
			on_right_button_down,
			on_left_button_down,
			on_middle_button_down,
			pnd_press
		redefine
			on_mouse_move,
			on_key_down,
			interface,
			set_default_minimum_size,
			initialize
		end

	EV_ITEM_LIST_IMP [EV_MULTI_COLUMN_LIST_ROW]
		redefine
			interface,
			initialize
		end

	WEL_LIST_VIEW
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			destroy as wel_destroy,
			shown as is_displayed,
			font as wel_font,
			set_font as wel_set_font,
			selected_items as wel_selected_items,
			selected_item as wel_selected_item,
			get_item as wel_get_item,
			insert_item as wel_insert_item,
			set_column_width as wel_set_column_width,
			get_column_width as wel_get_column_width,
			set_column_title as wel_set_column_title,
			column_count as wel_column_count,
			item as wel_item,
			move as wel_move,
			enabled as is_sensitive, 
			width as wel_width,
			height as wel_height,
			x as x_position,
			y as y_position,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize,
			count as wel_count
		undefine
			remove_command,
			set_width,
			set_height,
			window_process_message,
			on_left_button_down,
			on_right_button_down,
			on_left_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_set_focus,
			on_kill_focus,
			on_key_down,
			on_key_up,
			on_set_cursor,
			show,
			hide
		redefine
			on_lvn_columnclick,
			on_lvn_itemchanged,
			on_size,
			on_notify,
			default_style,
			process_message
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Make with `an_interface'.
		do
			base_make (an_interface)
			create ev_children.make (0)
			wel_make (default_parent, 0, 0, 0, 0, 0)
		end

	initialize is
			-- Initialize with precursors.
		local
			wel_column: WEL_LIST_VIEW_COLUMN
		do
			{EV_PRIMITIVE_IMP} Precursor
			{EV_MULTI_COLUMN_LIST_I} Precursor
			{EV_ITEM_LIST_IMP} Precursor

				-- Create the last column
			create wel_column.make
			wel_column.set_width (Lvscw_autosize_useheader)
			wel_column.set_text ("")
			insert_column (wel_column, 0)

				-- Set the WEL extended view style
			if comctl32_version >= version_470 then
				set_extended_view_style (get_extended_view_style + 
					Lvs_ex_fullrowselect)
			end
		end

feature -- Access

	selected_item: EV_MULTI_COLUMN_LIST_ROW is
			-- Currently selected item.
			-- Topmost selected item if multiple items are selected.
			-- (For multiple selections see `selected_items')
		do
			Result ?= selected_items.last
		end

	selected_items: LINKED_LIST [EV_MULTI_COLUMN_LIST_ROW] is
			-- Currently selected items.
		local
			i: INTEGER
			interf: like selected_item
			c: like ev_children
		do
			from
				c := ev_children
				create Result.make
				i := 0
			until
				i = selected_count
			loop
				interf ?= (c @ (wel_selected_items @ i + 1)).interface
				Result.extend (interf)
				i := i + 1
			end			
		end

	row_height: INTEGER
			-- Height in pixels of each row.

	column_count: INTEGER is
			-- Number of columns filled by the user
			--
			-- The WEL implementation has one more column
			-- at the end of all columns.
		do
			Result := (wel_column_count - 1).max(0)
		end

feature -- Status report

	multiple_selection_enabled: BOOLEAN
			-- Can more that one item be selected?
	
	title_shown: BOOLEAN is
			-- Is a row displaying column titles shown?
		do
			Result := not flag_set (style, Lvs_nocolumnheader)
		end

feature -- Status setting

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
			c: like selected_items
		do
			c := selected_items
			from
				c.start
			until
				c.after
			loop
				c.item.disable_select
				c.forth
			end
		end

	enable_multiple_selection is
			-- Allow more than one item to be selected.
		do
			if not multiple_selection_enabled and parent_imp /= Void then
				if has_headers then
					set_style (default_style)
				else
					set_style (default_style + Lvs_nocolumnheader)
				end
			end
			multiple_selection_enabled := True
		end

	disable_multiple_selection is
			-- Allow only one item to be selected.
		do
			if multiple_selection_enabled and parent_imp /= Void then
				if has_headers then
					set_style (default_style + Lvs_singlesel)
				else
					set_style (default_style + Lvs_singlesel + 
						Lvs_nocolumnheader)
				end
			end
			multiple_selection_enabled := False
		end

	show_title_row is
			-- Show row displaying column titles.
		do
			if not has_headers then
				if multiple_selection_enabled then
					set_style (default_style)
				else
					set_style (default_style + Lvs_singlesel)
				end
			end
		end

	hide_title_row is
			-- Hide row displaying column titles.
		do
			if has_headers then
				if multiple_selection_enabled then
					set_style (default_style + Lvs_nocolumnheader)
				else
					set_style (default_style + Lvs_singlesel + 
						Lvs_nocolumnheader)
				end
			end
		end

	column_alignment_changed (an_alignment: EV_TEXT_ALIGNMENT;
		a_column: INTEGER) is
			-- Set alignment of `a_column' to corresponding `alignment_code'.
		do
			if an_alignment.is_left_aligned then
				set_column_format (a_column - 1, Lvcfmt_left)
			elseif an_alignment.is_center_aligned then
				set_column_format (a_column - 1, Lvcfmt_center)
			else
				set_column_format (a_column - 1, Lvcfmt_right)
			end
		end

feature {NONE} -- Implementation

	set_text_on_position (a_x, a_y: INTEGER; a_text: STRING) is
			-- Set the label of the cell with coordinates `a_x', `a_y'
			-- with `txt'.
		do
			set_cell_text (a_x - 1, a_y - 1, a_text)
		end

	expand_column_count_to (a_columns: INTEGER) is
			-- Set `columns' to `a_columns'.
		do
			from
			until
				column_count >= a_columns
			loop
				add_column
			end
		end

	add_column is
			-- Append new column at end.
		local
			wel_column: WEL_LIST_VIEW_COLUMN
			col_width: INTEGER
			col_text: STRING
			col_index: INTEGER
		do
			if column_widths.count > column_count then
				col_width := column_widths @ (column_count + 1)
			else
				col_width := Default_column_width
			end

			if column_titles.count > column_count then
				col_text := column_titles @ (column_count + 1)
			else
				col_text := ""
			end

			col_index := column_count.max(0)

			create wel_column.make
			wel_column.set_width (col_width)
			wel_column.set_text (col_text)

			insert_column (wel_column, col_index)
			wel_set_column_width (col_width, col_index)
			wel_set_column_width (Lvscw_autosize_useheader, col_index + 1)
		end

	column_title_changed (a_title: STRING; a_column: INTEGER) is
			-- Replace title of `a_column' with `a_title' if column present.
			-- If `a_title' is Void, remove it.
		local
			txt: STRING
		do
			if a_column <= column_count then
				txt := a_title
				if txt = Void then
					txt := ""
				end
				wel_set_column_title (txt, a_column - 1)
			end
		end

	column_width_changed (a_width, a_column: INTEGER) is
			-- Replace width of `a_column' with `a_width' if column present.
		do
			if a_column <= column_count then
				wel_set_column_width (a_width, a_column - 1)
			end
		end

feature -- Access

	find_item_at_position (x_pos, y_pos: INTEGER):
		EV_MULTI_COLUMN_LIST_ROW_IMP is
			-- Find the item at the given position.
			-- Position is relative to the multi-column list.
		local
			pt: WEL_POINT
			info: WEL_LV_HITTESTINFO
		do
			create pt.make (16, y_pos)
				-- 16 is used as it will always be within the selected part
				-- of the row.
			create info.make_with_point (pt)
			cwin_send_message (wel_item, Lvm_hittest, 0, info.to_integer)
			if flag_set (info.flags, Lvht_onitemlabel)
			or flag_set (info.flags, Lvht_onitemicon)
			then
				Result := ev_children @ (info.iitem + 1)
			end
		end

feature -- Status report

	has_headers: BOOLEAN is
			-- True if there is a header line to give titles
			-- to columns
		do
			Result := not flag_set (style, Lvs_nocolumnheader)
		end

feature -- Element change

	clear_items is
			-- Clear all the items of the list.
		local
			c: like ev_children
		do
			c := ev_children
			from
				c.start
			until
				c.after
			loop
				c.item.interface.destroy
				c.forth
			end
			reset_content
			c.wipe_out
		end

feature {EV_MULTI_COLUMN_LIST_ROW_I} -- Implementation

	insert_item (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP; an_index: INTEGER) is
			-- Insert `item_imp' at `index'.
		local
			list: LINKED_LIST [STRING]
			litem: WEL_LIST_VIEW_ITEM
			counter: INTEGER
			first_string: STRING
			columns_to_add: INTEGER
		do
			list := item_imp.interface

				-- Add the new columns if some are needed
			if list.count > column_count then
				expand_column_count_to (list.count)	
			end

				-- Put the items in the listview.
			from
				list.start
				if list.after then
					first_string := ""
				else
					first_string := list.item
					list.forth
				end
				create litem.make_with_attributes (
					Lvif_text, an_index - 1, 0, 0, first_string)
				wel_insert_item (litem)
			until
				list.after
			loop
				create litem.make_with_attributes (
					Lvif_text, an_index - 1, list.index - 1, 0, list.item)
				cwin_send_message (wel_item, Lvm_setitem, 0,
					litem.to_integer)
				list.forth
			end
		end

	move_item (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP; an_index: INTEGER) is
			-- Move the given item to the given position.
		local
			bool: BOOLEAN
		do
			bool := item_imp.is_selected
			remove_item (item_imp)
			insert_item (item_imp, an_index)
			if bool then
				item_imp.enable_select
			end
		end

	remove_item (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP) is
			-- Remove `item' from the list
		local
			an_index: INTEGER
		do
				-- First, we remove the child from the graphical component
			an_index := ev_children.index_of (item_imp, 1) - 1
			delete_item (an_index)
		end

	internal_get_index (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP): INTEGER is
			-- Return the index of `item' in the list.
		do
			Result := ev_children.index_of (item_imp, 1)
		end

	internal_is_selected (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP): BOOLEAN is
			-- Is `item_imp' selected in the list?
		local
			i: INTEGER
		do
			i := ev_children.index_of (item_imp, 1) - 1
			i := get_item_state (i, Lvis_selected)
			Result := flag_set (i, Lvis_selected)
		end

	internal_select (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP) is
			-- Select `item_imp' in the list.
		local
			i, flags: INTEGER
			litem: WEL_LIST_VIEW_ITEM
		do
			i := ev_children.index_of (item_imp, 1) - 1
			create litem.make_with_attributes (Lvif_state, i, 0, 0, "")
			litem.set_state (Lvis_selected)
			litem.set_statemask (Lvis_selected)	
			cwin_send_message (wel_item, Lvm_setitemstate, i,
				litem.to_integer)
		end

	internal_deselect (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP) is
			-- Deselect `item_imp' in the list.
		local
			i, flags: INTEGER
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
			-- Initialize the size of the widget.
		do
			--|FIXME Is there better values we could use?
			internal_set_minimum_size (32, 32)
		end

feature {NONE} -- Implementation, Pixmap handling

	setup_image_list is
			-- Create the image list and associate it
			-- to the control if it's not already done.
		do
				-- Create image list with all images 16 by 16 pixels
			create image_list.make_with_size (pixmaps_width, pixmaps_height)

				-- Associate the image list with the multicolumn list.
			set_small_image_list(image_list)
		ensure
			image_list_not_void: image_list /= Void
		end

	remove_image_list is
			-- Destroy the image list and remove it
			-- from the control if it's not already done.
		require
			image_list_not_void: image_list /= Void
		do
				-- Destroy the image list.
			image_list.destroy
			image_list := Void

				-- Remove the image list from the multicolumn list.
			set_small_image_list(Void)
		ensure
			image_list_is_void: image_list = Void
		end

	pixmaps_size_changed is
			-- The size of the displayed pixmaps has just
			-- changed.
		local
			pixmap: EV_PIXMAP
			cur: CURSOR
		do
				-- We only do the job if there are some images.
			if image_list /= Void then

					-- Rebuild the image list.
				remove_image_list
				setup_image_list

					-- Save cursor position
				cur := ev_children.cursor

					-- ReInsert the image of each
					-- row in the image list.
				from
					ev_children.start
				until
					ev_children.after
				loop
					pixmap := ev_children.item.pixmap
					if pixmap /= Void then
						set_row_pixmap (
							ev_children.index,
							pixmap
							)
					end		
					ev_children.forth
				end
					-- Restore saved position
				ev_children.go_to (cur)
			end
		end

	set_row_pixmap (a_row: INTEGER; a_pixmap: EV_PIXMAP) is
			-- Set row `a_row' pixmap to `a_pixmap'.
		local
			pixmap_imp		: EV_PIXMAP_IMP_STATE
			image_index		: INTEGER
			wel_row			: WEL_LIST_VIEW_ITEM
		do
			pixmap_imp ?= a_pixmap.implementation

				-- Create the imagelist and associate it
				-- to the control if it's not already done.
			if image_list = Void then
				setup_image_list
			end

			image_list.add_pixmap (pixmap_imp)
			image_index := image_list.last_position

				-- Retrieve the first item of the row
			wel_row := wel_get_item (a_row - 1, 0)

				-- Add image to the item
			wel_row.set_image (image_index)

				-- Reflect the change in Windows.
			replace_item (wel_row)

				-- Update the display
			invalidate
		end

	remove_row_pixmap (a_row: INTEGER) is
			-- Remove any associated pixmap with row `a_row'.
		local
			image_index		: INTEGER
			wel_row			: WEL_LIST_VIEW_ITEM
		do
				-- Create the imagelist and associate it
				-- to the control if it's not already done.
			if image_list /= Void then
					-- Retrieve the first item of the row
				wel_row := wel_get_item (a_row - 1, 0)
	
					-- Remove image from the cell
				wel_row.set_image (0)

					-- Reflect the change in Windows.
				replace_item (wel_row)

					-- Update the display
				invalidate
			end
		end

feature {NONE} -- WEL Implementation

	updating_column_width: BOOLEAN
			-- Are we in the function `update_column_width'?
			--
			-- This flag is used to avoid reentrance in the function 
			-- `update_column_width'. 

	internal_propagate_pointer_press
		(event_id, x_pos, y_pos, button: INTEGER) is
			-- Propagate `event_id' to the good item. 
		local 
			mcl_row: EV_MULTI_COLUMN_LIST_ROW_IMP
			pt: WEL_POINT
		do
			mcl_row := find_item_at_position (x_pos, y_pos) 
			pt := client_to_screen (x_pos, y_pos)
			if mcl_row /= Void and mcl_row.is_transport_enabled and not
				parent_is_pnd_source then
					mcl_row.pnd_press (x_pos, y_pos, 3, pt.x, pt.y)
				elseif pnd_item_source /= Void then 
					pnd_item_source.pnd_press (x_pos, y_pos, 3, pt.x, pt.y)
				end
			if mcl_row /= Void then 
				mcl_row.interface.pointer_button_press_actions.call ([x_pos,
					y_pos - relative_y (mcl_row), button, 0.0, 0.0, 0.0,
					pt.x, pt.y])
			end 
		end

	relative_y (a_row: EV_MULTI_COLUMN_LIST_ROW_IMP): INTEGER is
			-- `Result' is relative y_position of `a_row' to `Current'
		local
			point: WEL_POINT
		do
			point := get_item_position (a_row.index - 1)
			Result := point.y
		end

	process_message (hwnd: POINTER; msg,
			wparam, lparam: INTEGER): INTEGER is
			-- Call the routine `on_*' corresponding to the
			-- message `msg'.
		local
			wel_window_pos: WEL_WINDOW_POS
		do
			inspect msg
			when Wm_windowposchanging then
				create wel_window_pos.make_by_pointer (
					cwel_integer_to_pointer(lparam)
					)
				on_wm_windowposchanging (wel_window_pos)
			when Wm_windowposchanged then
				create wel_window_pos.make_by_pointer (
					cwel_integer_to_pointer(lparam)
					)
				on_wm_windowposchanged (wel_window_pos)
--|--------------------------------------------------------
--| FIXME ARNAUD: Handle This message to avoid flickering
--| while resizing.
--|--------------------------------------------------------
--			when Wm_erasebkgnd then
--				disable_default_processing
--				set_message_return_value (1)
			else
				Result := Precursor (hwnd, msg, wparam, lparam)
			end
		end

	update_last_column_width is
		do
			updating_column_width := True -- Set reentrance flag.

			wel_set_column_width (Lvscw_autosize_useheader, wel_column_count - 1)

			updating_column_width := False -- remove reentrance flag.
		end

	on_wm_windowposchanging (window_pos: WEL_WINDOW_POS) is
			-- The WM_WINDOWPOSCHANGING message is sent to a 
			-- window whose size, position, or place in the 
			-- Z order is about to change as a result of a 
			-- call to the SetWindowPos function or another 
			-- window-management function.
			--
			-- Arnaud: We handle here the resize event before
			-- it actually occurs. We only recompute the
			-- column widths if the size is decreasing. If the
			-- size is increasing, recomputing the last column
			-- width with the future size would cause the 
			-- appearance of an horizontal scrollbar because
			-- the window has not yet its future size.
			-- Increasing size width is handled in 
			-- `on_wm_windowposchanged'.
		do
			if (not updating_column_width) and is_displayed then
					-- window_pos.width holds the future
					-- width of the window.
				if window_pos.width - width < 0 then
					update_last_column_width
				end
			end
		end

	on_wm_windowposchanged (window_pos: WEL_WINDOW_POS) is
			-- The WM_WINDOWPOSCHANGED message is sent to 
			-- a window whose size, position, or place in 
			-- the Z order has changed as a result of a call 
			-- to the SetWindowPos function or another 
			-- window-management function.
			--
			-- Called to avoid the appearance of an horizontal
			-- scrollbar. See `on_wm_windowposchanging' for more
			-- details.
		do
			if (not updating_column_width) and is_displayed then
					-- window_pos.width holds the future
					-- width of the window.
				update_last_column_width
			end
		end

	on_notify (control_id: INTEGER; info: WEL_NMHDR) is
			-- The WM_NOTIFY message is sent by a common control 
			-- to its parent window when an event has occurred 
			-- or the control requires some information. 
		local
			code: INTEGER
		do
			code := info.code
			if (code = Hdn_itemchangeda) or (code = Hdn_itemchangedw)
			   and (not updating_column_width)
			then
					-- A column header has changed. Its size may 
					-- being changed. So we recompute the width 
					-- of the last column.
				update_last_column_width
			end
		end
	
	default_style: INTEGER is
			-- Style of the current window.
		do
			Result := Ws_child + Ws_visible + Ws_group 
				+ Ws_tabstop + Ws_border + Ws_clipchildren
				+ Lvs_report + Lvs_showselalways
		end

	on_lvn_columnclick (info: WEL_NM_LIST_VIEW) is
			-- A column was tapped.
		do
			interface.column_click_actions.call ([])
			disable_default_processing
		end

	on_lvn_itemchanged (info: WEL_NM_LIST_VIEW) is
			-- An item has changed
		local
			item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
		do
			if info.uchanged = Lvif_state and info.isubitem = 0 then
				if flag_set(info.unewstate, Lvis_selected) and
						not flag_set(info.uoldstate, Lvis_selected) then
					item_imp := ev_children @ (info.iitem + 1)
					item_imp.interface.select_actions.call ([])
					interface.select_actions.call ([item_imp.interface])
				elseif flag_set(info.uoldstate, Lvis_selected) and
					not flag_set(info.unewstate, Lvis_selected) then
					item_imp := ev_children @ (info.iitem + 1)
					item_imp.interface.deselect_actions.call ([])
					interface.deselect_actions.call ([item_imp.interface])
				end
			end
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- A key has been pressed
		do
			{EV_PRIMITIVE_IMP} Precursor (virtual_key, key_data)
			process_tab_key (virtual_key)
		end

	on_size (size_type, a_width, a_height: INTEGER) is
			-- List resized.
		do
			Precursor (size_type, a_width, a_height)
			interface.resize_actions.call ([screen_x, screen_y, a_width,
				a_height])
		end

	on_mouse_move (keys, x_pos, y_pos: INTEGER) is
			-- Mouse moved on list.
		local
			mcl_row: EV_MULTI_COLUMN_LIST_ROW_IMP
			pt: WEL_POINT
		do
			mcl_row := find_item_at_position (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			if mcl_row /= Void then
				mcl_row.interface.pointer_motion_actions.call ([x_pos,
					y_pos - relative_y (mcl_row), 0.0, 0.0, 0.0, pt.x, pt.y])
			end
			if pnd_item_source /= Void then
				pnd_item_source.pnd_motion (x_pos, y_pos, pt.x, pt.y)
			end
			{EV_PRIMITIVE_IMP} Precursor (keys, x_pos, y_pos)
		end

feature {EV_MULTI_COLUMN_LIST_ROW_IMP}

	image_list: EV_IMAGE_LIST_IMP
			-- Image list to store all images required by items.

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
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_x (lparam)
		end

	mouse_message_y (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_y (lparam)
		end

	show_window (hwnd: POINTER; cmd_show: INTEGER) is
			-- Encapsulation of the cwin_show_window function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			cwin_show_window (hwnd, cmd_show)
		end

feature {NONE}

	interface: EV_MULTI_COLUMN_LIST

end -- class EV_MULTI_COLUMN_LIST_IMP

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
--|---------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.92  2000/04/26 00:03:12  pichery
--| Slight redesign of the pixmap handling in
--| trees and multi-column lists.
--|
--| Added `set_pixmaps_size', `pixmaps_width'
--| and `pixmaps_height' in the interfaces and
--| in the implementations.
--|
--| Fixed bugs in multi-column lists and trees.
--|
--| Revision 1.91  2000/04/25 01:22:46  pichery
--| Entire refactoring - Improvement.
--|
--| Revision 1.90  2000/04/21 19:37:23  rogers
--| Useful comments on compute_column_widths and last_column
--| width_setting. Formatted all long lines.
--|
--| Revision 1.87  2000/04/21 16:58:01  rogers
--| Removed child_x and wel_window_parent fix.
--|
--| Revision 1.85  2000/04/20 22:23:35  king
--| Implemented column_alignment_changed, removed other alignement features.
--|
--| Revision 1.84  2000/04/20 21:57:53  king
--| Made compilable with new alignment features
--|
--| Revision 1.83  2000/04/20 18:51:19  rogers
--| Removed redundent ev_children update's from insert_item
--| and remove_item.
--|
--| Revision 1.82  2000/04/20 01:21:39  pichery
--| Fixed call to an obsolete feature
--|
--| Revision 1.81  2000/04/19 01:31:02  pichery
--| Added redefine clause
--|
--| Revision 1.80  2000/04/18 21:25:39  pichery
--| - Fixed bug in `on_size' (swap of parameters)
--| - Cosmetics
--|
--| Revision 1.79  2000/04/17 23:30:35  rogers
--| Added wel_window_parent fix.
--|
--| Revision 1.78  2000/04/11 16:58:55  rogers
--| Removed direct inheritance from EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP.
--|
--| Revision 1.77  2000/04/05 21:16:12  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.76  2000/03/31 00:25:25  rogers
--| Removed on_left_button_down, on_middle_button_down and
--| on_right_button_down as they are now inherited from
--| EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP
--|
--| Revision 1.75  2000/03/30 23:39:36  rogers
--| The number of columns is now set to one by default.
--|
--| Revision 1.74  2000/03/30 19:56:24  rogers
--| Now inherits from EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP.
--| Removed features and attributes associated with source of PND as
--| these are now inherited, and fixed references to these.
--|
--| Revision 1.73.2.2  2000/04/05 19:59:32  brendel
--| Removed calls to ev_children by graphical insert/remove features.
--|
--| Revision 1.73.2.1  2000/04/03 18:25:35  brendel
--| Count is now implemented in EV_DYNAMIC_LIST_IMP.
--|
--| Revision 1.73  2000/03/30 16:29:32  rogers
--| Multiple selection no longer requires pre-parenting.
--|
--| Revision 1.72  2000/03/29 02:19:00  brendel
--| Removed silly column_count.
--| Added set_row_pixmap from _I.
--|
--| Revision 1.71  2000/03/29 01:17:39  brendel
--| Fixed bug in column_(width|title)_changed. Redefined column count
--| for no apparent reason.
--|
--| Revision 1.70  2000/03/27 20:43:49  brendel
--| Removed obsolete `item_type'.
--|
--| Revision 1.69  2000/03/27 18:09:50  brendel
--| Improved implementation of `add_column'.
--| Clean-up.
--|
--| Revision 1.68  2000/03/27 17:20:38  brendel
--| columns -> column_count
--|
--| Revision 1.67  2000/03/27 16:16:09  brendel
--| Added expand_columns_to. To be implemented.
--|
--| Revision 1.66  2000/03/25 01:45:57  brendel
--| Cleanup.
--|
--| Revision 1.65  2000/03/25 01:14:56  brendel
--| Implemented according to new _I.
--|
--| Revision 1.64  2000/03/24 19:43:07  brendel
--| Cleanup. More will be necessary.
--|
--| Revision 1.62  2000/03/24 18:15:45  brendel
--| Now adds columns if necessary. Seems to work.
--|
--| Revision 1.61  2000/03/24 18:00:42  brendel
--| Move update_child back.
--|
--| Revision 1.60  2000/03/24 17:32:35  brendel
--| Moved update code into _I.
--|
--| Revision 1.59  2000/03/24 01:38:01  brendel
--| Added set_default_minimum_size to some value other than zero. Needs fixing.
--| Added `row_height'.
--| Added `update_children' called on idle when one ore more children need
--| to be updated.
--|
--| Revision 1.58  2000/03/23 23:26:23  brendel
--| Replaced obsolete call.
--|
--| Revision 1.57  2000/03/23 18:19:37  brendel
--| Commented out line that uses internal_text. get back to this.
--|
--| Revision 1.56  2000/03/22 20:21:27  rogers
--| On_right_button_down no longer calls the precursor, but calls the
--| pointer_button_press_actions directly.
--|
--| Revision 1.55  2000/03/21 23:10:03  rogers
--| Added features for chechking PND status with relation, and modified
--| features to support this. Fixed column_title with a temporary
--| implementation.
--|
--| Revision 1.54  2000/03/14 23:51:15  rogers
--| Removed unused local.
--|
--| Revision 1.53  2000/03/14 19:02:00  rogers
--| Removed all commented code from on_****_button_down, and implemented
--| correctly. Removed all on_****_button_up.
--|
--| Revision 1.52  2000/03/14 18:41:05  rogers
--| Changed internal_propagate_event to internal_propagate_pointer_press and
--| implemented this feature. Re-implemented child_y.
--|
--| Revision 1.49  2000/03/13 23:15:21  rogers
--| Added internal_propagate_event, not yet implemented. Redfined
--| on_mouse_move from ev_primitive and call the pointer_motion_actions on an
--| item if required. Changed the export status of implementation feature to
--| {EV_MULTI_COLUMN_LIST_ROW_IMP}.
--|
--| Revision 1.48  2000/03/13 22:22:13  rogers
--| Fixed set_columns so if the list does not have a parent and items are added,
--| the default_parent will be used.
--|
--| Revision 1.47  2000/03/07 18:31:37  rogers
--| Redefined on_size from WEL_LIST_VIEW, so the resize_actions can be called.
--|
--| Revision 1.46  2000/03/06 23:29:30  rogers
--| Corrected formatting in set_columns, interface.select_actions and interface.
--| deselect_Actions have been connected. Removed commented out make which is
--| redundent.
--|
--| Revision 1.43  2000/03/06 17:13:33  rogers
--| Added calls to row select and deselect actions. Added call to
--| column_click_actions.
--|
--| Revision 1.42  2000/03/04 00:09:35  rogers
--| Removed commented item, implemented seemingly correct code for column_title
--| which currently does not work. Appears to be a WEL bug.
--|
--| Revision 1.41  2000/03/03 19:33:19  rogers
--| renamed get_column_width -> column_width and changed all internal calls
--| accordingly, added column_title which is still to be implemented.
--|
--| Revision 1.40  2000/03/03 19:10:02  rogers
--| Redefined extend from EV_ITEM_LIST_IMP, added a boolean, first_addition
--| which holds whether the addition is the first addition after creation.
--| Implemented set_columns.
--|
--| Revision 1.38  2000/03/03 00:54:20  brendel
--| set_selected -> en/dis-able_select.
--|
--| Revision 1.37  2000/03/02 22:19:40  brendel
--| is_multiple_selection -> multiple_selection_enabled.
--| Formatted to 80 columns.
--|
--| Revision 1.36  2000/03/02 19:58:16  rogers
--| Renamed set_multiple_selection -> enable_multiple_selection and
--| set_eingle_selection -> disable_multiple_selection.
--|
--| Revision 1.35  2000/02/19 06:34:13  oconnor
--| removed old command stuff
--|
--| Revision 1.34  2000/02/19 05:45:01  oconnor
--| released
--|
--| Revision 1.33  2000/02/14 11:40:44  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.31.4.1.2.8  2000/02/04 19:07:33  rogers
--| Removed a redundent EV_ROUTINE_COMMAND defenition.
--|
--| Revision 1.31.4.1.2.7  2000/02/03 17:20:46  brendel
--| Changed `make_with_size' to `make' in creation clause.
--|
--| Revision 1.31.4.1.2.6  2000/01/29 01:05:03  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.31.4.1.2.5  2000/01/27 19:30:28  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.31.4.1.2.4  2000/01/25 17:37:53  brendel
--| Removed code associated with old events.
--| Implementation and more removal is needed.
--|
--| Revision 1.31.4.1.2.3  2000/01/19 22:35:45  rogers
--| Removed item as it is now inherited from EV_ITEM_LIST_IMP.
--|
--| Revision 1.31.4.1.2.2  1999/12/17 00:37:46  rogers
--| Altered to fit in with the review branch. Basic alterations, 
--| redefinitaions of name clashes etc. Make now takes an interface
--| Now inherits from EV_ITEM_LIST_IMP.
--|
--| Revision 1.31.4.1.2.1  1999/11/24 17:30:32  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.31.2.2  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
