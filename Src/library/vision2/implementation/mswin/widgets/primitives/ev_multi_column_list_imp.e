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
			initialize
		end

	EV_PRIMITIVE_IMP
		undefine
			pnd_press
		redefine
			on_left_button_down,
			on_middle_button_down,
			on_right_button_down,
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

	EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP
		redefine
			interface
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
			get_item as wel_get_item,
			insert_item as wel_insert_item,
			set_column_width as wel_set_column_width,
			get_column_width as wel_get_column_width,
			set_column_title as wel_set_column_title,
			item as wel_item,
			move as wel_move,
			enabled as is_sensitive, 
			width as wel_width,
			height as wel_height,
			x as x_position,
			y as y_position,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize
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
			default_style,
			process_message
		end

	WEL_LVHT_CONSTANTS
		export
			{NONE} all
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
			--| FIXME
			row_height := 16
		end

	initialize is
			-- Initialize with precursors.
		do
			{EV_PRIMITIVE_IMP} Precursor
			{EV_MULTI_COLUMN_LIST_I} Precursor
			{EV_ITEM_LIST_IMP} Precursor
			add_column
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
			interf: EV_MULTI_COLUMN_LIST_ROW
			c: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW_IMP]
		do
			from
				c := ev_children
				!! Result.make
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
			c: LINKED_LIST [EV_MULTI_COLUMN_LIST_ROW]
		do
			from
				c := selected_items
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

	align_text_left (a_column: INTEGER) is
			-- Display text of `a_column' left aligned.
			-- First column is always left aligned.
		do
			set_column_format (a_column - 1, Lvcfmt_left)
		end

	align_text_center (a_column: INTEGER) is
			-- Display text of `a_column' centered.
			-- First column is always left aligned.
		do
			set_column_format (a_column - 1, Lvcfmt_center)
		end
	
	align_text_right (a_column: INTEGER) is
			-- Display text of `a_column' right aligned.
			-- First column is always left aligned.
		do
			set_column_format (a_column - 1, Lvcfmt_right)
		end

feature -- Element change

	set_row_height (a_height: INTEGER) is
			-- Assign `a_height' to ??.
		do
			row_height := a_height
			--| FIXME TBI
		end

feature {NONE} -- Implementation

	set_row_pixmap (a_row: INTEGER; a_pixmap: EV_PIXMAP) is
			-- Set row `a_row' pixmap to `a_pixmap'.
		do
			check
				to_be_implemented: False
			end
		end

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
				column_count > a_columns
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

			create wel_column.make
			wel_column.set_cx (col_width)
			wel_column.set_text (col_text)
			append_column (wel_column)
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

	last_column_width_setting: INTEGER
		-- The width that the last column was set to by the user.
		--| Used by compute_column_widths somehow.

	find_item_at_position (x_pos, y_pos: INTEGER): EV_MULTI_COLUMN_LIST_ROW_IMP is
			-- Find the item at the given position.
			-- Position is relative to the toolbar.
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

feature -- Status report

	selected: BOOLEAN is
			-- Is at least one item selected ?
		do
			Result := selected_count >= 1
		end

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
			c: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW_IMP]
		do
			from
				c := ev_children
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

	compute_column_widths is
			-- Re-compute column widths to fill parent.
		local
			current_width: INTEGER
				-- Width of multi column list.
			counter: INTEGER
		do
			current_width := width
				-- assign `width' to `current_width'
			from
				counter := 1
			until
				counter = column_count + 1
			loop
				-- For every column in the mc list.
				if counter = column_count then
					if current_width > last_column_width_setting then
						wel_set_column_width 
							(current_width, counter - 1)
					elseif current_width < column_width (counter)
						then 
						wel_set_column_width
							(last_column_width_setting, counter - 1)
					end
				end
				current_width := current_width - 
					column_width (counter)
				counter := counter + 1
			end
		end

feature {EV_MULTI_COLUMN_LIST_ROW_I} -- Implementation

	insert_item (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP; an_index: INTEGER) is
			-- Insert `item_imp' at `index'.
		local
			list: LINKED_LIST [STRING]
			litem: WEL_LIST_VIEW_ITEM
			rw: INTEGER
			first_string: STRING
		do
			list := item_imp.interface
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
			ev_children.go_i_th (an_index - 1)
			ev_children.put_right (item_imp)
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

			-- Then, we update the children
			ev_children.go_i_th (an_index + 1)
			ev_children.remove
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
			--| FIXME We need nice values.
			internal_set_minimum_size (1, 2 * row_height)
		end

feature {NONE} -- WEL Implementation

	internal_propagate_pointer_press (event_id, x_pos, y_pos, button: INTEGER) is
			-- Propagate `event_id' to the good item. 
		local 
			mcl_row: EV_MULTI_COLUMN_LIST_ROW_IMP
			pt: WEL_POINT
			offsets: TUPLE [INTEGER, INTEGER]
		do
			mcl_row := find_item_at_position (x_pos, y_pos) 
			pt := client_to_screen (x_pos, y_pos)
			if mcl_row /= Void and mcl_row.is_transport_enabled and not parent_is_pnd_source then
					mcl_row.pnd_press (x_pos, y_pos, 3, pt.x, pt.y)
				elseif pnd_item_source /= Void then 
					pnd_item_source.pnd_press (x_pos, y_pos, 3, pt.x, pt.y)
				end
			if mcl_row /= Void then 
				offsets := mcl_row.relative_position
				mcl_row.interface.pointer_button_press_actions.call ([x_pos - offsets.integer_arrayed @ 1 + 1,
				y_pos - offsets.integer_arrayed @ 2, button, 0.0, 0.0, 0.0, pt.x, pt.y])
			end 
		end 

	process_message (hwnd: POINTER; msg,
			wparam, lparam: INTEGER): INTEGER is
			-- Call the routine `on_*' corresponding to the
			-- message `msg'.
		do
			if msg = Wm_paint then
				compute_column_widths
			else
				Result := {WEL_LIST_VIEW} Precursor (hwnd, msg,
					wparam, lparam)
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

	on_left_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Wm_lbuttondown message
		do
			internal_propagate_pointer_press (keys, x_pos, y_pos, 1)
			{EV_PRIMITIVE_IMP} Precursor (keys, x_pos, y_pos)
		end

	on_middle_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Wm_mbuttondown message
			-- See class WEL_MK_CONSTANTS for `keys' value
		do
			internal_propagate_pointer_press (keys, x_pos, y_pos, 2)
			{EV_PRIMITIVE_IMP} Precursor (keys, x_pos, y_pos)
		end

	on_right_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Wm_rbuttondown message
			-- See class WEL_MK_CONSTANTS for `keys' value
		local
			pt: WEL_POINT
			it: EV_MULTI_COLUMN_LIST_ROW_IMP
			a: BOOLEAN
		do
			a:= item_is_pnd_source
			create pt.make (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			internal_propagate_pointer_press (keys, x_pos, y_pos, 3)
			it := find_item_at_position (x_pos, y_pos)

			if item_is_pnd_source = a then
				pnd_press (x_pos, y_pos, 3, pt.x, pt.y)
			end
			interface.pointer_button_press_actions.call ([x_pos, y_pos, 3, 0.0, 0.0, 0.0, pt.x, pt.y])
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- A key has been pressed
		do
			{EV_PRIMITIVE_IMP} Precursor (virtual_key, key_data)
			process_tab_key (virtual_key)
		end

	on_size (size_type, a_height, a_width: INTEGER) is
			-- List resized.
		do
			Precursor (size_type, a_height, a_width)
			interface.resize_actions.call ([screen_x, screen_y, a_width, a_height])
		end

	on_mouse_move (keys, x_pos, y_pos: INTEGER) is
			-- Mouse moved on list.
		local
			mcl_row: EV_MULTI_COLUMN_LIST_ROW_IMP
			pt: WEL_POINT
			offsets: TUPLE [INTEGER, INTEGER]
		do
			mcl_row := find_item_at_position (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			if mcl_row /= Void then
				offsets := mcl_row.relative_position
				mcl_row.interface.pointer_motion_actions.call ([x_pos - offsets.integer_arrayed @ 1 + 1,
				y_pos - offsets.integer_arrayed @ 2, 0.0, 0.0, 0.0, pt.x, pt.y])
			end
			if pnd_item_source /= Void then
				pnd_item_source.pnd_motion (x_pos, y_pos, pt.x, pt.y)
			end
			{EV_PRIMITIVE_IMP} Precursor (keys, x_pos, y_pos)
		end

feature {EV_MULTI_COLUMN_LIST_ROW_IMP}

	child_y (child: EV_MULTI_COLUMN_LIST_ROW_IMP): INTEGER is
			-- `Result' is relative ycoor of row to `parent_imp'
		local
			a, b: INTEGER
		do
			a := top_index
			b := internal_get_index (child)
			if not title_shown then
				Result := (internal_get_index (child) - top_index - 1) * 14
			else
				Result := (internal_get_index (child) - top_index) * 14 + window_frame_height - 1
			end
			a := window_frame_height
		end

	child_x: INTEGER is
			-- `Result' is relative xcoor of row to `parent_imp'
		do
			Result := window_frame_width - 1
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
--| Revision 1.75  2000/03/30 23:39:36  rogers
--| The number of columns is now set to one by default.
--|
--| Revision 1.74  2000/03/30 19:56:24  rogers
--| Now inherits from EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP.
--| Removed features and attributes associated with source of PND as
--| these are now inherited, and fixed references to these.
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
--| On_right_button_down no longer calls the precursor, but calls the pointer_button_press_actions directly.
--|
--| Revision 1.55  2000/03/21 23:10:03  rogers
--| Added features for chechking PND status with relation, and modified features to support this. Fixed column_title with a tmeporary implementation.
--|
--| Revision 1.54  2000/03/14 23:51:15  rogers
--| Removed unused local.
--|
--| Revision 1.53  2000/03/14 19:02:00  rogers
--| Removed all commented code from on_****_button_down, and implemented correctly. Removed all on_****_button_up.
--|
--| Revision 1.52  2000/03/14 18:41:05  rogers
--| Changed internal_propagate_event to internal_propagate_pointer_press and implemented this feature. Re-implemented child_y.
--|
--| Revision 1.49  2000/03/13 23:15:21  rogers
--| Added internal_propagate_event, not yet implemented. Redfined on_mouse_move from ev_primitive and call the pointer_motion_actions on an item if required. Changed the export status of implementation feature to {EV_MULTI_COLUMN_LIST_ROW_IMP}.
--|
--| Revision 1.48  2000/03/13 22:22:13  rogers
--| Fixed set_columns so if the list does not have a parent and items are added, the default_parent will be used.
--|
--| Revision 1.47  2000/03/07 18:31:37  rogers
--| Redefined on_size from WEL_LIST_VIEW, so the resize_actions can be called.
--|
--| Revision 1.46  2000/03/06 23:29:30  rogers
--| Corrected formatting in set_columns, interface.select_actions and interface.deselect_Actions have been connected. Removed commented out make which is redundent.
--|
--| Revision 1.43  2000/03/06 17:13:33  rogers
--| Added calls to row select and deselect actions. Added call to column_click_actions.
--|
--| Revision 1.42  2000/03/04 00:09:35  rogers
--| Removed commented item, implemented seemingly correct code for column_title which currently does not work. Appears to be a WEL bug.
--|
--| Revision 1.41  2000/03/03 19:33:19  rogers
--| renamed get_column_width -> column_width and changed all internal calls accordingly, added column_title which is still to be implemented.
--|
--| Revision 1.40  2000/03/03 19:10:02  rogers
--| Redefined extend from EV_ITEM_LIST_IMP, added a boolean, first_addition which holds whether the addition is the first addition after creation. Implemented set_columns.
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
