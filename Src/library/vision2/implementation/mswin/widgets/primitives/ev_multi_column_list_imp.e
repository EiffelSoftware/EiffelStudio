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
			pixmaps_size_changed,
			wipe_out
		end

	EV_PRIMITIVE_IMP
		undefine
			on_right_button_down,
			on_left_button_down,
			on_middle_button_down,
			on_left_button_up,
			on_left_button_double_click,
			on_middle_button_double_click,
			on_right_button_double_click,
			pnd_press,
			escape_pnd
		redefine
			on_mouse_move,
			on_key_down,
			interface,
			set_default_minimum_size,
			initialize,
			on_size,
			enable_sensitive, disable_sensitive
		end

	EV_ITEM_LIST_IMP [EV_MULTI_COLUMN_LIST_ROW]
		redefine
			interface,
			initialize,
			wipe_out
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
			set_background_color as wel_set_background_color,
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
			count as wel_count,
			has_capture as wel_has_capture
		undefine
			set_width,
			set_height,
			on_left_button_down,
			on_middle_button_down,
			on_right_button_down,
			on_left_button_up,
			on_middle_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_middle_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_set_focus,
			on_desactivate,
			on_kill_focus,
			on_key_down,
			on_key_up,
			on_char,
			on_set_cursor,
			show,
			hide,
			x_position,
			y_position,
			on_sys_key_down,
			on_sys_key_up,
			default_process_message
		redefine
			on_lvn_columnclick,
			on_lvn_itemchanged,
			on_size,
			on_erase_background,
			default_style,
			process_message,
			on_notify
		end

	EV_MULTI_COLUMN_LIST_ACTION_SEQUENCES_IMP

	WEL_COLOR_CONSTANTS
		export {NONE}
			all
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Make with `an_interface'.
		do
			base_make (an_interface)
			create ev_children.make (0)
			create internal_selected_items.make (2)

				-- Create the WEL LISTVIEW.
			wel_make (default_parent, 0, 0, 0, 0, 0)
			enable_multiple_selection
		end

	initialize is
			-- Initialize `Current'.
		local
			wel_column: WEL_LIST_VIEW_COLUMN
		do
			Precursor {EV_PRIMITIVE_IMP}
			Precursor {EV_MULTI_COLUMN_LIST_I}
			Precursor {EV_ITEM_LIST_IMP}

				-- Create the last column
			create wel_column.make
			wel_column.set_width (Lvscw_autosize_useheader)
			wel_column.set_text ("")
			insert_column (wel_column, 0)

				-- Compute the default height of a row			
			wel_insert_item (create {WEL_LIST_VIEW_ITEM}.make)
			wel_insert_item (create {WEL_LIST_VIEW_ITEM}.make)
			default_row_height := get_item_position (1).y - get_item_position (0).y
			reset_content
			
				-- Set the height of a row to the default height
			row_height := default_row_height
			
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
			-- (For multiple selections see `selected_items').
			--
			-- Void if there is no selection.
		local
			local_selected_index: INTEGER
		do
			local_selected_index := wel_selected_item
			if local_selected_index >= 0 then
				Result := (ev_children @ (local_selected_index + 1)).interface
			end
		end

	selected_items: DYNAMIC_LIST [EV_MULTI_COLUMN_LIST_ROW] is
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

	ensure_item_visible (an_item: EV_MULTI_COLUMN_LIST_ROW) is
			-- Ensure `an_item' is visible in `Current'.
		local
			item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
		do
			item_imp ?= an_item.implementation
			check
				item_imp_not_void: item_imp /= Void
			end
			ensure_visible (internal_get_index (item_imp) - 1)
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
			-- Unselect any selected items. 
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
			if not multiple_selection_enabled then
				if has_headers then
					set_style (default_style - Lvs_singlesel)
				else
					set_style (default_style - Lvs_singlesel +
						Lvs_nocolumnheader)
				end
				multiple_selection_enabled := True
			end
		end

	disable_multiple_selection is
			-- Allow only one item to be selected.
		local
			old_selected_item: EV_MULTI_COLUMN_LIST_ROW
		do
			if multiple_selection_enabled then
					-- Unselect all selected and remember the top
					-- most selected item.
				old_selected_item := selected_item
				clear_selection

					-- Set the new style
				if has_headers then
					set_style (default_style)
				else
					set_style (default_style + Lvs_nocolumnheader)
				end
				multiple_selection_enabled := False

					-- Reselect the top most item
				if old_selected_item /= Void then
					old_selected_item.enable_select
				end
			end
		end

	enable_sensitive is
			-- Make object sensitive to user input.
		do
			Precursor
			invalidate
			update
		end

	disable_sensitive is
			-- Make object desensitive to user input.
		do
			Precursor
			invalidate
			update
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
			invalidate
		end

feature {NONE} -- Implementation

	column_count: INTEGER is
		do	
			Result := wel_column_count
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
			resize_first_column
			from
			until
				wel_column_count = a_columns
			loop
				add_column
			end
		end

	resize_first_column is
			-- Resize first column of `Current'.
			--| As the first column is always inserted, we need to resize
			--| the first column when there is a column in `Current'
			--| at the vision level.
		local
			col_width: INTEGER
		do
			if wel_column_count = 1 then			
				if column_widths.count >= wel_column_count then
					col_width := column_widths @ (wel_column_count)
				else
					col_width := Default_column_width
				end
				wel_set_column_width (col_width, 0)
			end
		end

	add_column is
			-- Append new column to `Current' at end of columns.
		local
			wel_column: WEL_LIST_VIEW_COLUMN
			col_width: INTEGER
			col_text: STRING
			col_index: INTEGER
		do
			if column_widths.count >= wel_column_count + 1 then
				col_width := column_widths @ (wel_column_count + 1)
			else
				col_width := Default_column_width
			end

			if column_titles.count >= wel_column_count + 1 then
				col_text := column_titles @ (wel_column_count + 1)
				if col_text = Void then	
					col_text := "" 
				end
			else
				col_text := ""
			end

			col_index := wel_column_count

			create wel_column.make
			wel_column.set_width (col_width)
			wel_column.set_text (col_text)
			insert_column (wel_column, col_index)
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
			if column_resize_actions_internal /= Void then
				column_resize_actions_internal.call ([a_column])
			end
		end

	resize_column_to_content (a_column: INTEGER) is		
			-- Resize column `a_column' to width of its widest text.
		do
			wel_set_column_width (-1, a_column - 1)
			if column_resize_actions_internal /= Void then
				column_resize_actions_internal.call ([a_column])
			end
		end
		
feature -- Access

	find_item_at_position (x_pos, y_pos: INTEGER):
		EV_MULTI_COLUMN_LIST_ROW_IMP is
			-- Find the item at the given position`x_pos', 1y_pos'
			-- relative to `Current'.
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

	has_headers: BOOLEAN is
			-- True if there is a header line to give titles
			-- to columns.
		do
			Result := not flag_set (style, Lvs_nocolumnheader)
		end

feature -- Element change

	clear_items is
			-- Clear all rows of `Current'.
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
			-- Insert `item_imp' at `an_index' row.
		local
			list: LINKED_LIST [STRING]
			litem: WEL_LIST_VIEW_ITEM
			first_string: STRING
		do
			list := item_imp.interface
		
				-- Add the new columns if some are needed
			if list.count > wel_column_count then
					--| If `item_imp' as more columns than `Current' then we
					--| resize `Current'.
				expand_column_count_to (list.count)
			elseif wel_column_count = 1 then
					--| If we are the first_column then we resize the first column
					--| as there is always a column in `Current'.
				resize_first_column
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
			invalidate
		end

	move_item (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP; an_index: INTEGER) is
			-- Move `item_imp' to position `an_index'.
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
			-- Remove `item_imp' from `Current'.
		local
			an_index: INTEGER
		do
				-- First, we remove the child from the graphical component
			an_index := ev_children.index_of (item_imp, 1) - 1
			delete_item (an_index)
				-- Update the column widths in case this removal caused the
				-- scroll bar to be hidden.
		end

	internal_get_index (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP): INTEGER is
			-- Return the index of `item_imp' in `Current'.
		do
			Result := ev_children.index_of (item_imp, 1)
		end

	internal_is_selected (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP): BOOLEAN is
			-- Is `item_imp' selected in `Current'?
		local
			i: INTEGER
		do
			i := ev_children.index_of (item_imp, 1) - 1
			i := get_item_state (i, Lvis_selected)
			Result := flag_set (i, Lvis_selected)
		end

	internal_select (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP) is
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

	internal_deselect (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP) is
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
				log_font.width.abs * 20 + 7, -- 20 characters wide
				log_font.height.abs	* 5 + 7	 -- 5 characters tall
				)
		end

feature {NONE} -- Implementation, Pixmap handling

	setup_image_list is
			-- Create the image list and associate it
			-- to `Current' if not already associated.
		do
				-- Create image list with all images 16 by 16 pixels
			create image_list.make_with_size (pixmaps_width , pixmaps_height)

				-- Assign `pixmaps_height' to `row height' if necessary.
			if default_row_height < pixmaps_height then
				row_height := pixmaps_height
			end

				-- Associate the image list with the multicolumn list.
			set_small_image_list(image_list)
		ensure
			image_list_not_void: image_list /= Void
		end

	remove_image_list is
			-- Destroy the image list and remove it
			-- from `Current'.
		require
			image_list_not_void: image_list /= Void
		do
				-- Destroy the image list.
			image_list.destroy
			image_list := Void

				-- Remove the image list from the multicolumn list.
			set_small_image_list(Void)
				-- We restore the height of each row to the original setting.
			row_height := default_row_height
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
			image_index		: INTEGER
			wel_row			: WEL_LIST_VIEW_ITEM
		do
				-- Create the imagelist and associate it
				-- to the control if it's not already done.
			if image_list = Void then
				setup_image_list
			end

			image_list.add_pixmap (a_pixmap)
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
			wel_row: WEL_LIST_VIEW_ITEM
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

	wipe_out is
			-- Remove all items.
			-- Redefined for speed optimization.
		local
			child_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
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

feature {NONE} -- Selection implementation

	internal_selected_items_uptodate: BOOLEAN
			-- Is `internal_selected_items' sorted?

	internal_selected_items: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW]
			-- Cached version of all selected items.

	retrieve_selected_items: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW] is
			-- Current selected items (non cached version)
		local
			i: INTEGER
			interf: EV_MULTI_COLUMN_LIST_ROW
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

feature {NONE} -- WEL Implementation

	internal_propagate_pointer_press
		(event_id, x_pos, y_pos, button: INTEGER) is
			-- Propagate `event_id' and `button' to item at position
			-- `x_pos', `y_pos'. Called on pointer press.
		local 
			pre_drop_mcl_row, post_drop_mcl_row: EV_MULTI_COLUMN_LIST_ROW_IMP 
			item_press_actions_called: BOOLEAN
			pt: WEL_POINT
		do
			--| If a pick and drop is being executed, the drop actions
			--| are called before the pointer_button_press_actions are
			--| called on an item. It is possible to remove this item, and
			--| also possible to replace this item, so we must only call these
			--| actions if there is still an item where we clicked, and it is
			--| the same item that was clicked on before we called the drop
			--| actions.
		
				-- Retrieve the item that has been clicked on.
			pre_drop_mcl_row := find_item_at_position (x_pos, y_pos) 
			pt := client_to_screen (x_pos, y_pos)

			if pre_drop_mcl_row /= Void and not is_dnd_in_transport and not
				is_pnd_in_transport and not item_is_in_pnd then
				if pre_drop_mcl_row.pointer_button_press_actions_internal
					/= Void then
					pre_drop_mcl_row.interface.pointer_button_press_actions.call
					([x_pos, y_pos - relative_y (pre_drop_mcl_row), button,
					0.0, 0.0, 0.0, pt.x, pt.y])
				end
					-- We record that the press actions have been called.
				item_press_actions_called := True
			end
				--| The pre_drop_it.parent /= Void is to check that the item that
				--| was originally clicked on, has not been removed during the press actions.
				--| If the parent is now void then it has, and there is no need to continue
				--| with `pnd_press'.
			if pre_drop_mcl_row /= Void and
				pre_drop_mcl_row.is_transport_enabled and not
				parent_is_pnd_source and pre_drop_mcl_row.parent /= Void then
					pre_drop_mcl_row.pnd_press (
						x_pos, y_pos, button, pt.x, pt.y)
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

				-- Retrieve the current item where the button press
				-- was recieved.
			post_drop_mcl_row := find_item_at_position (x_pos, y_pos)	
			
			if not item_press_actions_called then
				-- If there is an item where the button press was recieved,
				-- and it has not changed from the start of this procedure
				-- then call `pointer_button_press_actions'. 
				if post_drop_mcl_row /= Void and
					pre_drop_mcl_row = post_drop_mcl_row and call_press_event then 
					post_drop_mcl_row.interface.pointer_button_press_actions.
						call ([x_pos, y_pos - relative_y (post_drop_mcl_row),
						button, 0.0, 0.0, 0.0, pt.x, pt.y])
				end
			end
				-- Reset `call_press_event'.
			keep_press_event
		end

	internal_propagate_pointer_double_press
		(event_id, x_pos, y_pos, button: INTEGER) is
			-- Propagate `event_id' and `button' to item at position
			-- `x_pos', `y_pos'. Called on pointer press.
		local 
			mcl_row: EV_MULTI_COLUMN_LIST_ROW_IMP
			pt: WEL_POINT
		do
			mcl_row := find_item_at_position (x_pos, y_pos) 
			pt := client_to_screen (x_pos, y_pos)
			if mcl_row /= Void then
				mcl_row.interface.pointer_double_press_actions.call ([x_pos,
					y_pos - relative_y (mcl_row), button, 0.0, 0.0, 0.0,
					pt.x, pt.y])
			end
		end

	relative_y (a_row: EV_MULTI_COLUMN_LIST_ROW_IMP): INTEGER is
			-- `Result' is relative y_position of `a_row' to `Current'.
		local
			point: WEL_POINT
		do
			point := get_item_position (a_row.index - 1)
			Result := point.y
		end

	process_message (hwnd: POINTER; msg, wparam, lparam: INTEGER): INTEGER is
			-- Call the routine `on_*' corresponding to the
			-- message `msg'.
		do
			inspect msg
			when Wm_vscroll then
				on_wm_vscroll
			else
				Result := Precursor (hwnd, msg, wparam, lparam)
			end
		end

	on_notify (a_control_id: INTEGER; info: WEL_NMHDR) is
		local
			header: WEL_NM_HEADER
		do
			Precursor (a_control_id, info)
				-- If a header item has changed then.
			if info.code = Hdn_endtrackw then
					--Retrieve the header that has changed.
				create header.make_by_nmhdr (info)
					--Update the column widths accordingly.
				update_column_width (
					wel_get_column_width (header.iitem),header.iitem + 1)
				if column_resize_actions_internal /= Void then
					column_resize_actions_internal.call ([header.iitem + 1])
				end
			end
		end

	on_wm_vscroll is
		do
			smart_resize := False
		end

	smart_resize: BOOLEAN
		-- Can we re-draw the background ourselves?
		--| If `True' the background is re-drawn manually during
		--| on_erase_background.
		--| If `False' windows re-draws the background for us. 

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Wm_erasebkgnd message.
			--| If `smart_resize' then disable the default windows processing
			--| as this causes flickering when showing `Current' while
			--| re-sizing. We then draw all areas of `Current' that are not
			--| automatically re-drawn, to avoid the flickering.
		local
			counter: INTEGER
			rect1, rect2: WEL_RECT
			brush: WEL_BRUSH
			pixmap_line_length: INTEGER
			bkg_color: WEL_COLOR_REF
		do
			if smart_resize then
				if is_sensitive then
					bkg_color := get_background_color
				else
					create bkg_color.make_system (Color_btnface)
				end
				create brush.make_solid (bkg_color)

					-- Fill in bottom of `paint_dc' if not filled by children.
				if top_index + visible_count + 1 > ev_children.count then
					if ev_children.is_empty then
						create rect2.make (0, 0, client_rect.right,
						client_rect.bottom)
					else
						rect1 := get_item_rect (ev_children.count - 1)	
						create rect2.make (0, rect1.bottom, client_rect.right,
							client_rect.bottom)
					end
					paint_dc.fill_rect (rect2, brush)
				end

					
					-- Fill in left side of `paint_dc'.
				create rect2.make (client_rect.left, client_rect.top,
					client_rect.left + 2, client_rect.bottom)
				paint_dc.fill_rect (rect2, brush)

					-- Fill area of `paint_dc' just above `top_index' item.
				rect1 := get_item_rect (top_index)
				create rect2.make (client_rect.left, rect1.top,
					client_rect.right, rect1.top - 2)	
				paint_dc.fill_rect (rect2, brush)

				create rect2.make (rect1.left, client_rect.top,
					client_rect.right, client_rect.bottom)
				paint_dc.fill_rect (rect2, brush)


					-- Fill in areas of `paint_dc' around images contained.
				if image_list /= Void then
					from
						counter:= top_index
					until
						counter = top_index + visible_count or
						counter > top_index + ev_children.count - 1
					loop
						rect1 := get_item_rect (counter)
						if pixmaps_width < column_width (1) then
							pixmap_line_length := pixmaps_width + 2
						else
							pixmap_line_length := column_width (1)
						end
						create rect2.make (rect1.left, rect1.top +
							pixmaps_height, pixmap_line_length, rect1.bottom)
						paint_dc.fill_rect (rect2, brush)
						counter := counter + 1
					end
				end

					-- Clean GDI objects
				brush.delete

				disable_default_processing
				set_message_return_value (1)
			end
		end
	
	default_style: INTEGER is
			-- Style of `Current'.
		do
			Result := Ws_child + Ws_visible + Ws_group 
				+ Ws_tabstop + Ws_border + Ws_clipchildren
				+ Lvs_report + Lvs_showselalways + Lvs_singlesel
		end

	on_lvn_columnclick (info: WEL_NM_LIST_VIEW) is
			-- A column was tapped.
		do
			interface.column_title_click_actions.call ([info.isubitem + 1])
			disable_default_processing
		end

	on_lvn_itemchanged (info: WEL_NM_LIST_VIEW) is
			-- An item has changed.
			--| For example, one of the items has been selected or deselected.
		local
			item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
		do
			if info.uchanged = Lvif_state and info.isubitem = 0 then
				if flag_set(info.unewstate, Lvis_selected) and
						not flag_set(info.uoldstate, Lvis_selected)
				then
						-- Item is being selected
					internal_selected_items_uptodate := False
					item_imp := ev_children @ (info.iitem + 1)
					item_imp.interface.select_actions.call ([])
					interface.select_actions.call ([item_imp.interface])

				elseif flag_set(info.uoldstate, Lvis_selected) and
					not flag_set(info.unewstate, Lvis_selected)
				then
						-- Item is being deselected
					internal_selected_items_uptodate := False
					item_imp := ev_children @ (info.iitem + 1)
					item_imp.interface.deselect_actions.call ([])
					interface.deselect_actions.call ([item_imp.interface])
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
			-- `Current' is being resized.
		do
			smart_resize:= True
			Precursor {WEL_LIST_VIEW} (size_type, a_width, a_height)
			Precursor {EV_PRIMITIVE_IMP} (size_type, a_width, a_height)
		end

	on_mouse_move (keys, x_pos, y_pos: INTEGER) is
			-- Mouse moved on `Current'.
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
			Precursor {EV_PRIMITIVE_IMP} (keys, x_pos, y_pos)
		end

	default_row_height: INTEGER
			-- Default height of each row
	
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

feature {NONE} -- Interface

	interface: EV_MULTI_COLUMN_LIST

end -- class EV_MULTI_COLUMN_LIST_IMP

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
--| Revision 1.105  2001/07/14 12:46:25  manus
--| Replace --! by --|
--|
--| Revision 1.104  2001/07/14 12:16:30  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.103  2001/06/25 19:05:48  rogers
--| Implemented `ensure_item_visible'.
--|
--| Revision 1.102  2001/06/14 00:09:13  rogers
--| Undefined the version of escape_pnd inherited from EV_PRIMITIVE_IMP.
--|
--| Revision 1.101  2001/06/07 23:08:16  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.31.4.61  2001/05/24 21:07:25  pichery
--| Computed `Default_height_row' instead of using a constant since it depends
--| on the size of fonts.
--|
--| Revision 1.31.4.60  2001/02/15 01:07:50  rogers
--| Fixed bug in internal_propagate_pointer_press. We now check that
--| `pre_drop_mcl_row' is still parented before calling `pnd_press' on
--| `pre_drop_mcl_row'. This is because a button press can cause the item to be
--| removed.
--| ---------------------------------------------
--|
--| Revision 1.31.4.59  2001/02/02 00:51:07  rogers
--| On_key_down now calls process_tab_key before Precursor. This ensures that
--| any tab movement we do in our implementation can be overriden by the user
--| with key_press_actions.
--|
--| Revision 1.31.4.58  2001/01/26 23:22:29  rogers
--| Undefined on_sys_key_down inherited from WEL.
--|
--| Revision 1.31.4.57  2001/01/22 19:07:12  rogers
--| Wipe_out now restores `index' to 0, so `interface.before' returns `True'.
--|
--| Revision 1.31.4.56  2001/01/15 22:35:17  rogers
--| Redefined wipe_out for optimal performance.
--|
--| Revision 1.31.4.55  2001/01/15 18:49:11  rogers
--| Previous bug fix introduced a new bug, so implemented the fix in a
--| different manner.
--|
--| Revision 1.31.4.54  2001/01/11 00:04:54  rogers
--| Fixed bug in add_column. If column_titles contain void references and we
--| are adding a column to `Current', then this previously would crash.
--| i.e. you needed to create `Current' and set it up so that it had one row,
--| and then call set_column_title with a column greater than 2.
--|
--| Revision 1.31.4.53  2001/01/10 20:42:43  rogers
--| Refactored part of expand_column_count_to into resize_first_column. This is
--| now also used by insert_item when inserting the first column into
--| `Current'. These changes fix a bug whereby adding rows with only one column
--| to `Current' when `is_empty' did not cause resizing of the first column.
--|
--| Revision 1.31.4.52  2001/01/09 19:18:11  rogers
--| Redefined default_procesS_message from WEL. Fixed
--| internal_propagate_pointer_press so that it takes into account
--| call_press_event correctly.
--|
--| Revision 1.31.4.51  2000/12/01 19:35:00  rogers
--| Connected column_resize_actions.
--|
--| Revision 1.31.4.49  2000/11/30 18:22:06  manus
--| Removed non-used local variable.
--|
--| Revision 1.31.4.48  2000/11/29 23:13:17  rogers
--| Modified expand_column_count_to so that it resizes the first_column
--| as necessary. Modified on_notify so that update_column_width is only
--| called by the Hdn_endtrackw message. Fixed add_column so the column_widths
--| and titles are assigned correctly.
--|
--| Revision 1.31.4.47  2000/11/29 01:41:15  rogers
--| Redefined on_notify so we can find when a column header has changed and
--| update `column_widths' correctly. Changed empty to is_empty.
--|
--| Revision 1.31.4.46  2000/11/24 22:40:09  rogers
--| Removed all code associated with re-sizing of last column. Fixed
--| column_count so that the value was correct. This means there is no longer
--| the "hidden" extra column.
--|
--| Revision 1.31.4.44  2000/11/22 17:42:00  rogers
--| Removed unreferenced variable from remove_item.
--|
--| Revision 1.31.4.43  2000/11/22 14:38:42  pichery
--| - Handled the `disable_sensitive'. It now sets the background
--|   to gray.
--|
--| Revision 1.31.4.42  2000/11/20 20:29:43  rogers
--| Removing the last row no longer removes the columns.
--|
--| Revision 1.31.4.41  2000/11/14 18:31:24  rogers
--| Renamed has_capture inherited from WEL as wel_has_capture.
--|
--| Revision 1.31.4.40  2000/11/08 17:48:09  rogers
--| Formatting.
--|
--| Revision 1.31.4.39  2000/11/06 17:57:47  rogers
--| Undefined on_sys_key_down from wel. Version from EV_WIDGET_IMP is now used.
--|
--| Revision 1.31.4.38  2000/11/02 20:29:37  rogers
--| Column_alignment_changed now calls invalidate so the changes to the
--| alignment are made visible.
--|
--| Revision 1.31.4.37  2000/10/28 01:08:50  manus
--| Removed creation of local variable `gui_font' since it was not used.
--|
--| Revision 1.31.4.36  2000/10/25 23:37:05  rogers
--| Modified internal_propagate_pointer_press so that the button press events
--| are recieved in the correct order in conjunction with the pick/drag and
--| drop. Correct order is before when starting a pick and after when ending
--| a pick.
--|
--| Revision 1.31.4.35  2000/10/24 18:53:42  rogers
--| Fixed bug in internal_propagate_pointer_press if you were in PND and had
--| dropped on an item and removed that item from `Current' in the drop
--| actions.
--|
--| Revision 1.31.4.34  2000/10/23 18:34:36  rogers
--| Further correction to remove_item.
--|
--| Revision 1.31.4.33  2000/10/16 22:20:48  rogers
--| Corrected remove_item. If removing the last item, the index used to delete
--| the columns, was incorrect.
--|
--| Revision 1.31.4.32  2000/10/16 14:43:16  pichery
--| replaced `dispose' with `delete'.
--|
--| Revision 1.31.4.31  2000/10/12 15:50:27  pichery
--| Added reference tracking for GDI objects to decrease
--| the number of GDI objects alive.
--|
--| Revision 1.31.4.30  2000/10/11 00:00:28  raphaels
--| Added `on_desactivate' to list of undefined features from WEL_WINDOW.
--|
--| Revision 1.31.4.29  2000/10/02 19:26:52  rogers
--| Fixed bug where removing items that caused the vertical scroll bar to be
--| hidden would cause a gap to appear between the first item and the
--| title_row. Fixed another bug with the removal of the last item. The
--| column_count is now reset back to one, and the title row is updated
--| to display correctly.
--|
--| Revision 1.31.4.28  2000/09/15 19:30:56  rogers
--| Fixed internal_propagate_pointer_double_press. Pointer_button_press_actions
--| was being called instead of pointer_double_press_actions.
--|
--| Revision 1.31.4.27  2000/09/13 22:09:21  rogers
--| Changed the style of Precursor.
--|
--| Revision 1.31.4.26  2000/09/08 21:59:47  rogers
--| Removed work arounds for compiler bugs.
--|
--| Revision 1.31.4.25  2000/08/29 17:53:00  rogers
--| Implemented row_height.
--|
--| Revision 1.31.4.24  2000/08/11 18:48:17  rogers
--| Fixed copyright clauses. Now use ! instead of |. Formatting.
--|
--| Revision 1.31.4.23  2000/08/08 02:39:59  manus
--| Updated inheritance with new WEL messages handling
--| New resizing policy by calling `ev_' instead of `internal_', see
--|   `vision2/implementation/mswin/doc/sizing_how_to.txt'.
--| Better `on_erase_background' that deletes useless GDI objects instead of
--| waiting for the GC to do it.
--|
--| Revision 1.31.4.22  2000/08/02 21:06:16  rogers
--| GDI objects in on_erase_background are only destroyed if they have been
--| created.
--|
--| Revision 1.31.4.21  2000/08/02 16:53:22  rogers
--| Set_default_minimum_size and on_erase_background now delete the temporary
--| GDI objects created.
--|
--| Revision 1.31.4.20  2000/07/24 23:47:56  rogers
--| Now inherits EV_MULTI_COLUMN_LIST_ACTION_SEQUENCES_IMP.
--|
--| Revision 1.31.4.19  2000/07/12 16:10:20  rogers
--| Undefined x_position and y_position inherited from WEL, as they are now
--| inherited from EV_WIDGET_IMP.
--|
--| Revision 1.31.4.18  2000/07/07 18:32:51  rogers
--| Fixed bug in on_erase_background which would cause crash when no children
--| were contained.
--|
--| Revision 1.31.4.17  2000/06/21 23:18:05  rogers
--| Now pass corect column index to column_title_click_actions.
--|
--| Revision 1.31.4.16  2000/06/21 22:50:24  rogers
--| Changed on_lvm_column_click to reflect the change of the action
--| sequence in the interface.
--|
--| Revision 1.31.4.15  2000/06/13 18:36:31  rogers
--| Removed undefintion of remove_command.
--|
--| Revision 1.31.4.14  2000/06/09 20:22:57  rogers
--| Added internal_propagate_pointer_double_press. Comments, formatting.
--|
--| Revision 1.31.4.13  2000/05/27 01:55:52  pichery
--| Cosmetics
--|
--| Revision 1.31.4.12  2000/05/17 18:49:43  rogers
--| Added column_widths_fill_client_area, used in on_erase_background to
--| allow the control to automatically re-draw itself before the columns
--| fill the width of the control.
--|
--| Revision 1.31.4.11  2000/05/16 22:25:05  rogers
--| On_erase_background now fills the background with the correct brush color,
--| instead of always white.
--|
--| Revision 1.31.4.10  2000/05/14 07:43:12  pichery
--| Added 2 compiler bug workarounds (to be removed
--| when the compiler has been fixed)
--|
--| Revision 1.31.4.9  2000/05/09 17:29:12  rogers
--| Removed magic number from propagate_pointer_press, comments and formatting.
--|
--| Revision 1.31.4.7  2000/05/09 00:43:21  rogers
--| Redefined on_erase_background so we now draw the background ourselves to
--| avoid flickering when the window re-sizes. Added smart_resize and redefined
--| on_wm_vscroll.
--|
--| Revision 1.31.4.4  2000/05/03 22:35:04  brendel
--| Fixed resize_actions.
--|
--| Revision 1.31.4.3  2000/05/03 22:17:18  pichery
--| - Cosmetics / Optimization with local variables
--| - Replaced calls to `width' to calls to `wel_width'
--|   and same for `height'.
--|
--| Revision 1.31.4.2  2000/05/03 19:09:50  oconnor
--| mergred from HEAD
--|
--| Revision 1.98  2000/05/03 00:07:07  brendel
--| Added call to invalidate.
--|
--| Revision 1.97  2000/04/27 23:23:10  rogers
--| Undefined on_left_button_up from EV_PRIMITIVE_IMP.
--|
--| Revision 1.96  2000/04/27 23:03:44  pichery
--| Added set_default_minimum_size
--|
--| Revision 1.95  2000/04/27 17:50:19  pichery
--| - changed the type of `selected_items' from
--|   LINKED_LIST to ARRAYED_LIST.
--| - Cached the `selected_items'
--| - Fix bug with multiple_selection (it was not
--| possible to disable the multiple selection if
--| the mclist was not in a container).
--|
--| Revision 1.94  2000/04/26 22:14:29  rogers
--| Removed redundent local.
--|
--| Revision 1.93  2000/04/26 04:06:20  pichery
--| EV_IMAGE_LIST_IMP.add_pixmap now
--| takes an EV_PIXMAP as parameter.
--| -->Adapting
--|
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
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
