indexing
	description: "EiffelVision Combo-box. Implementation interface"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_COMBO_BOX_IMP

inherit
	EV_COMBO_BOX_I
		redefine
			interface,
			initialize
		end

	EV_LIST_ITEM_LIST_IMP
		redefine
			interface,
			initialize
		end

	EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP
		redefine
			interface
		end

	EV_FONTABLE_IMP
		redefine
			interface,
			set_font
		end

	EV_TEXT_COMPONENT_IMP
		export {EV_INTERNAL_COMBO_FIELD_IMP, EV_INTERNAL_COMBO_BOX_IMP}
			on_left_button_up,
			on_middle_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_middle_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_key_down,
			on_key_up,
			on_set_focus,
			on_desactivate,
			on_kill_focus,
			on_set_cursor
		undefine
			height,
			on_right_button_down,
			on_middle_button_down,
			on_left_button_down,
			on_left_button_up,
			on_left_button_double_click,
			on_middle_button_double_click,
			on_right_button_double_click,
			pnd_press,
			escape_pnd
		redefine
			set_editable,
			on_key_down,
			interface,
			initialize,
			on_set_focus,
			on_kill_focus,
			set_foreground_color,
			set_background_color,
			tooltip_window,
			destroy,
			propagate_key_to_dialog
		end

	WEL_DROP_DOWN_COMBO_BOX_EX
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			font as wel_font,
			set_font as wel_set_font,
			destroy as wel_destroy,
			shown as is_displayed,
			select_item as wel_select_item,
			selected_item as wel_selected_item,
			height as wel_height,
			width as wel_width,
			insert_item as wel_insert_item,
			set_limit_text as set_text_limit,
			move as wel_move,
			x as x_position,
			y as y_position,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize,
			item as wel_item,
			enabled as is_sensitive,
			count as wel_count,
			text as wel_text,
			has_capture as wel_has_capture,
			text_length as wel_text_length,
			list_shown as is_list_shown
		export
			{EV_INTERNAL_COMBO_FIELD_IMP} edit_item
			{EV_INTERNAL_COMBO_BOX_IMP} combo_item
			{EV_LIST_ITEM_IMP} wel_insert_item
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
			on_mouse_wheel,
			on_desactivate,
			on_key_down,
			on_key_up,
			on_char,
			on_set_cursor,
			show,
			hide,
			on_size,
			x_position,
			y_position,
			on_sys_key_down,
			on_sys_key_up,
			default_process_message,
			on_getdlgcode
		redefine
			on_cbn_editchange,
			on_cbn_selchange,
			on_cbn_dropdown,
			on_cbn_closeup,
			on_cben_insert_item,
			on_erase_background,
			default_style,
			has_focus,
			on_set_focus,
			on_kill_focus,
			set_focus
		end

	WEL_EM_CONSTANTS
		export
			{NONE} all
		end

	EV_TEXT_FIELD_ACTION_SEQUENCES_IMP
		export
			{NONE} all
		end

	EV_COMBO_BOX_ACTION_SEQUENCES_IMP
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			internal_window_make (default_parent, Void, default_style +
				Cbs_dropdown, 0, 0, 0, 50, -1, default_pointer)
			create ev_children.make (2)
 			id := 0
		end

	initialize is
			-- Initialize `Current'.
		do
			set_default_font
			create text_field.make_with_combo (Current)
			create combo.make_with_combo (Current)
			Precursor {EV_TEXT_COMPONENT_IMP}
			Precursor {EV_LIST_ITEM_LIST_IMP}
			initialize_pixmaps
		end

feature -- Access

	text_field: EV_INTERNAL_COMBO_FIELD_IMP
			-- An internal text field that forwards the events to `Current'.

	combo: EV_INTERNAL_COMBO_BOX_IMP
			-- The combo_box inside the combo-box-ex. It forwards the
			-- events.
			--| Windows sends messages to combo box's parent.
			--| Therefore we use EV_INTERNAL_COMBO_BOX_IMP to propagate these
			--| messages correctly.

feature -- Measurement

	height: INTEGER is
			-- height of `Current' when the list is hidden.
		do
			Result := window_rect.height
		end

feature -- Status report

	text: STRING_32 is
			-- `Result' is text of `Current'. Void if none.
		local
			loc_selected_item: like selected_item
		do
			if not is_editable then
					-- In this case, Windows does not return a text because
					-- text is associated with the item, therefore we take
					-- text from currently selected item if any.
				loc_selected_item := selected_item
				if loc_selected_item /= Void then
					Result := loc_selected_item.text
				else
					Result := ""
				end
			else
				Result := wel_text
			end
		end

	item_height: INTEGER is
			-- height required by an item.
		do
			if private_font /= Void then
				Result := private_font.implementation.height
			else
				Result := private_wel_font.height
			end
		end

	is_selected (an_id: INTEGER): BOOLEAN is
			-- Is item addressed by the one-based index `an_id' selected?
		do
			if selected then
				Result := ( (an_id - 1) = wel_selected_item )
			end
		end

	selected_item: EV_LIST_ITEM is
			-- Currently selected item.
		local
			new_selected_item: EV_LIST_ITEM_IMP
		do
			if selected then
				new_selected_item := ev_children @ (wel_selected_item + 1)
					--| Arrays are zero-based in WEL and one-based in Vision2.
				Result := new_selected_item.interface
			end
		end

	has_selection: BOOLEAN is
			-- Is there a current text selection?
		local
			wel_sel: POINTER
			start_pos, end_pos: INTEGER
				-- starting and ending character positions of the
				-- current selection in the edit control
		do
			wel_sel := cwin_send_message_result (edit_item, Em_getsel, to_wparam (0), to_lparam (0))
			start_pos := cwin_hi_word (wel_sel)
			end_pos := cwin_lo_word (wel_sel)

				-- There is a current selection if the positions
				-- are different.
			Result :=  start_pos /= end_pos
		end

	internal_caret_position: INTEGER is
			-- Caret position.
		local
			sel_end: INTEGER
		do
			--Result := cwin_hi_word (cwin_send_message_result (edit_item, Em_getsel, to_wparam (0), to_lparam (0)))
			fixme (once "[
				Replace sel_end's type by INTEGER_32, as $sel_end has to be a pointer to a DWORD.
			]")
			cwin_send_message (edit_item, Em_getsel, to_wparam (0), $sel_end)
			Result := sel_end
		end

	has_focus: BOOLEAN is
			-- Does `Current' have focus?
		do
			Result := combo.has_focus
			if not Result and then is_editable then
				Result := text_field.has_focus
			end
		end

feature -- Status setting

	set_focus is
			-- Set the focus to `Current'
		do
			if not has_focus then
				if is_editable then
					Precursor {WEL_DROP_DOWN_COMBO_BOX_EX}
				else
					combo.set_focus
				end
			end
		end

	select_item (an_index: INTEGER) is
			-- Select the item at the one-based index `an_index'.
			--|--------------------------------------------------
			--| We cannot redefine this feature because then a
			--| postcondition is violated because of the change
			--| of index.
			--|--------------------------------------------------
		do
				-- Select the item in the combo box
			wel_select_item (an_index - 1)

				-- Deal with the selection change.
			on_cbn_selchange
		end

	deselect_item (an_index: INTEGER) is
			-- Unselect the item at the one-based index `an_index'.
		do
			clear_selection
		end

	clear_selection is
			-- Clear selection of `Current'.
		do
				-- Unselect the item in the combo box
			unselect

				-- Deal with the selection change.
			on_cbn_selchange
		end

	set_editable (flag: BOOLEAN) is
			-- If `flag' then make `Current' read-write.
			-- If not `flag' then make `Current' read only.
		do
			if flag then
				set_read_write
			else
				set_read_only
			end
		end

	internal_set_caret_position (pos: INTEGER) is
			-- Set the caret position to `pos'.
		do
			cwin_send_message (edit_item, Em_setsel, to_wparam (pos), to_lparam (pos))
		end

feature -- Basic operation

	deselect_all is
			-- Unselect the currently selected text.
		do
			cwin_send_message (edit_item, Em_setsel, to_wparam (-1), to_lparam (0))
		end

	delete_selection is
			-- Delete the current selection.
		do
			cwin_send_message (edit_item, Wm_clear, to_wparam (0), to_lparam (0))
		end

	cut_selection is
			-- Cut the current selection to the clipboard.
		do
			cwin_send_message (edit_item, Wm_cut, to_wparam (0), to_lparam (0))
		end

	copy_selection is
			-- Copy the current selection to the clipboard.
		do
			cwin_send_message (edit_item, Wm_copy, to_wparam (0), to_lparam (0))
		end

	clip_paste is
			-- Paste the contents of the clipboard to the current
			-- caret position.
		do
			cwin_send_message (edit_item, Wm_paste, to_wparam (0), to_lparam (0))
		end

	replace_selection (txt: STRING_GENERAL) is
			-- Replace the current selection with `txt'.
			-- If there is no selection, `txt' is inserted
			-- at the current `caret_position'.
		require
			exists: exists
			text_not_void: txt /= Void
		local
			wel_str: WEL_STRING
		do
			create wel_str.make (txt)
			cwin_send_message (edit_item, Em_replacesel, to_wparam (0), wel_str.item)
		end

feature {EV_LIST_ITEM_IMP} -- Pixmap handling

	setup_image_list is
			-- Create the image list and associate it
			-- to `Current' if not already associated.
		do
				-- Create image list with all images `pixmaps_width' by
				-- `pixmaps_height'.
				--| Default values of pixmaps_width and pixmaps_height are
				--| 16 and 16.
			create image_list.make_with_size (pixmaps_width, pixmaps_height)

				-- Associate the image list with the multicolumn list.
			set_image_list(image_list)
		end

	remove_image_list is
			-- Destroy the image list and remove it
			-- from `Current'.
		do
			check
				image_list_not_void: image_list /= Void
			end
				-- Destroy the image list.
			image_list.destroy
			image_list := Void
				-- Remove the image_list_from `Current'
			set_image_list (Void)
		ensure then
			image_list_is_void: image_list = Void
		end

feature {EV_LIST_ITEM_IMP} -- Implementation

	set_pixmap_of_child (an_item: EV_LIST_ITEM_IMP; position, image_index: INTEGER) is
			-- Set pixmap of `an_item' at position `position' in `Current'
			-- to the `image_index'th image in `image_list'.
		local
			cb_item: WEL_COMBO_BOX_EX_ITEM
		do
			cb_item := an_item.cb_item
			cb_item.set_image (image_index)
			cb_item.set_selected_image (image_index)
			cb_item.set_index (position - 1)
			delete_item (position - 1)
			wel_insert_item (cb_item)
		end

	remove_pixmap_of_child (an_item: EV_LIST_ITEM_IMP; position: INTEGER) is
			-- Remove pixmap of `an_item' located at position `position' in
			-- `Current'.
		local
			cb_item: WEL_COMBO_BOX_EX_ITEM
		do
			cb_item := an_item.cb_item
			cb_item.set_image (0)
			cb_item.set_selected_image (0)
			delete_item (position - 1)
			wel_insert_item (cb_item)
		end

	internal_select_item (item_imp: EV_LIST_ITEM_IMP) is
			-- Select `item_imp'.
		do
			select_item (internal_get_index (item_imp))
		end

	internal_is_selected (item_imp: EV_LIST_ITEM_IMP): BOOLEAN is
			-- Is `item_imp' selected?
		do
			Result := is_selected (internal_get_index (item_imp))
		end

	internal_deselect_item (item_imp: EV_LIST_ITEM_IMP) is
			-- Deselect `item_imp'.
		do
			deselect_item (internal_get_index (item_imp))
		end

	internal_get_index (item_imp: EV_LIST_ITEM_IMP): INTEGER is
			-- `Result' is index of `item_imp'.
		do
			Result := ev_children.index_of (item_imp, 1)
		end

   	get_item_position (an_index: INTEGER): WEL_POINT is
   			-- Retrieves the position of the zero-based `index'-th item.
   			-- in the drop-down list.
   		local
   			item_imp: EV_LIST_ITEM_IMP
   		do
   			create Result.make (0, 0)
   			item_imp := ev_children @ (an_index + 1)

   			if item_imp.is_displayed then
   				Result.set_y ((an_index - top_index) * item_height)
   			end
   		end

	visible_count: INTEGER is
   			-- Number of items that can be displayed in the list.
   		local
   			wel_rect: WEL_RECT
   			list_height: INTEGER
   		do
   			wel_rect := dropped_rect
   			list_height := wel_rect.bottom - wel_rect.top
   			Result := list_height // list_item_height
		end

feature {EV_INTERNAL_COMBO_FIELD_IMP, EV_INTERNAL_COMBO_BOX_IMP}

	on_set_focus is
			-- Called when a `Wm_setfocus' message is recieved.
		local
			top_level_titled_window: EV_TITLED_WINDOW
		do
				-- We now store `Current' in `top_level_window_imp' so
				-- we can restore the focus to it when required.
				--| See window_process_message in EV_WINDOW_IMP.
			if top_level_window_imp /= Void then
				if is_editable then
					top_level_window_imp.set_last_focused_widget (text_field.item)
				else
					top_level_window_imp.set_last_focused_widget (combo.item)
				end
				top_level_titled_window ?= top_level_window_imp.interface
				application_imp.set_window_with_focus (top_level_titled_window)
			end
				--| `Current' is made up of
				--| multiple widgets which propagate events accordingly.
				--| We need to check that we do not call the `focus_in_actions'
				--| multiple times due to this propagation.
			if focus_on_widget.item /= Current then
				if focus_in_actions_internal /= Void then
					focus_in_actions_internal.call (Void)
				end
			end
			focus_on_widget.put (Current)
		end

	on_kill_focus is
			-- Called when a `Wm_killfocus' message is received.
		do
			if not has_focus then
				Precursor {EV_TEXT_COMPONENT_IMP}
			end
		end

feature {NONE} -- Implementation

	propagate_key_to_dialog (is_pressed: BOOLEAN): BOOLEAN is
			-- Should we propagate a key event if `Current' is parented in a dialog?
			-- If `is_pressed', then it is a key_press event, otherwise a key_release event.
		do
			Result := not is_list_shown
		end

	internal_propagate_pointer_press (keys, x_pos, y_pos, button: INTEGER) is
			-- Propagate `keys', `x_pos' and `y_pos' to the appropriate
			-- item event. Called on a pointer button press.
		local
			pt: WEL_POINT
		do
			--|FIXME Implement
			--| Event propagation to children is not completed.
			pt := client_to_screen (x_pos, y_pos)
			pnd_press (x_pos, y_pos, button, pt.x, pt.y)
			if button /= 3 then
				-- If left button pressed the bring `Current'
				-- to foreground.
				top_level_window_imp.move_to_foreground
			end
		end

	internal_propagate_pointer_double_press
		(keys, x_pos, y_pos, button: INTEGER) is
			-- Propagate `keys', `x_pos' and `y_pos' to the appropriate
			-- item event. Called on a pointer double press.
		do
			--| Currently not implemented. This means that any items in the
			--| combo box will not recieve double click events.
		end

	find_item_at_position (x_pos, y_pos: INTEGER): EV_LIST_ITEM_IMP is
			-- `Result' is item at pixel position `x_pos', `y_pos'.
		do
			--| FIXME to be implemented for pick-and-dropable.	
		end

	recreate_combo_box (creation_flag: INTEGER) is
			-- Destroy the existing combo box and recreate
			-- a new one with `creation_flag' in the style
		local
			par_imp		: WEL_WINDOW
			cur_x		: INTEGER
			cur_y		: INTEGER
			cur_width	: INTEGER
			cur_height	: INTEGER
		do
				-- We keep some useful informations that will be
				-- destroyed when calling `wel_destroy'
			par_imp ?= parent_imp
				-- `Current' may not have been actually phsically parented
				-- within windows yet.
			if par_imp = Void then
				par_imp ?= default_parent
			end
			cur_x := x_position
			cur_y := y_position
			cur_width := ev_width
			cur_height := ev_height

					-- We destroy the old combo
			wel_destroy

				-- We create the new combo.
			internal_window_make (
				par_imp,
				Void,
				default_style | creation_flag,
				cur_x,
				cur_y,
				cur_width,
				cur_height,
				0,
				default_pointer
				)
 			id := 0
			internal_copy_list
		end

	set_read_only is
			-- Make `Current' read only.
		local
			sensitive: BOOLEAN
			s_item: EV_LIST_ITEM
		do
			if is_editable then
				sensitive := is_sensitive
				s_item := selected_item
				recreate_combo_box (Cbs_dropdownlist)

					-- Remove the text field and create a combo.
				text_field := Void
				create combo.make_with_combo (Current)
				if not sensitive then
					disable_sensitive
				end
				if s_item /= Void then
					s_item.enable_select
				end
				if foreground_color_imp /= Void then
					set_foreground_color (foreground_color)
				end
			end
		end

	set_read_write is
			-- Make `Current' read-writeable.
		local
			sensitive: BOOLEAN
			s_item: EV_LIST_ITEM
		do
			if not is_editable then
				sensitive := is_sensitive
				s_item := selected_item
				recreate_combo_box (Cbs_dropdown)

					-- Remove the combo and create a text field.
				create combo.make_with_combo (Current)
 	 			create text_field.make_with_combo (Current)
				if not sensitive then
					disable_sensitive
				end
				if s_item /= Void then
					s_item.enable_select
				end
				if foreground_color_imp /= Void then
					set_foreground_color (foreground_color)
				end
			end
		end

	read_only: BOOLEAN is
			-- Is `Current' read-only?
		do
			Result := flag_set (style, Cbs_dropdownlist)
		end

	internal_copy_list is
			-- Take an empty list and initialize all the children with
			-- the contents of `ev_children'.
		local
			original_index: INTEGER
			current_item: EV_LIST_ITEM_IMP
			image_list_set: BOOLEAN
		do
			original_index := ev_children.index
			from
				ev_children.start
			until
				ev_children.after
			loop
				add_string (ev_children.item.wel_text)
				current_item := ev_children.item
				if current_item.has_pixmap then
					if not image_list_set then
						set_image_list (image_list)
						image_list_set := True
					end
					set_pixmap_of_child (current_item, current_item.index, current_item.image_index)
				end
				ev_children.forth
			end
			ev_children.go_i_th (original_index)
		ensure
			index_not_changed: index = old index
		end

	insert_item (item_imp: EV_LIST_ITEM_IMP; an_index: INTEGER) is
			-- Insert `item_imp' at the one-based index `an_index'.
		do
			--FIXME must set the index as in LIST.
			insert_string_at (item_imp.wel_text, an_index - 1)
		end

	on_cben_insert_item (an_item: WEL_COMBO_BOX_EX_ITEM) is
 			-- An item has been inserted in the control.
		do
				-- If this is the first item inserted in `Current' then
				-- we select it.
			if an_item.index = 0 and count = 1 then
				select_item (1)
			end
 		end

	refresh_item (item_imp: EV_LIST_ITEM_IMP) is
			-- Refresh current so that it take into account
			-- changes made in `item_imp'
		do
			set_item_info (item_imp.index - 1, item_imp.cb_item)
		end

	remove_item (item_imp: EV_LIST_ITEM_IMP) is
			-- Remove `item_imp' from `Current'.
		local
			an_index: INTEGER
		do
			an_index := internal_get_index (item_imp)
			delete_string (an_index - 1)
		end

	set_foreground_color (color: EV_COLOR) is
			-- Make `color' the new `foreground_color'
		do
			Precursor {EV_TEXT_COMPONENT_IMP} (color)
			if is_displayed then
				if is_editable then
					text_field.invalidate
				end
				combo.invalidate
			end
		end

	set_background_color (color: EV_COLOR) is
			-- Make `color' the new `background_color'.
		do
			precursor {EV_TEXT_COMPONENT_IMP} (color)
			if is_displayed then
				if is_editable then
					text_field.invalidate
				end
				combo.invalidate
			end
		end

	set_font (ft: EV_FONT) is
			-- Make `ft' new font of `Current'.
		do
			Precursor {EV_FONTABLE_IMP} (ft)
			set_default_minimum_size
		end

	tooltip_window: WEL_WINDOW is
			-- `Result' is WEL_WINDOW of `Current' used
			-- to trigger tooltip events.
		do
			Result := window_of_item (text_field.item)
		end

feature {EV_INTERNAL_COMBO_FIELD_IMP, EV_INTERNAL_COMBO_BOX_IMP}
	-- WEL Implementation

	on_key_down (virtual_key, key_data: INTEGER) is
			-- We check if the enter key is pressed.
			--| 13 is the number of the return key.
		local
			list: like ev_children
			counter: INTEGER
			found: BOOLEAN
			s1, s2: STRING_32
		do
			process_tab_key (virtual_key)
			Precursor {EV_TEXT_COMPONENT_IMP} (virtual_key, key_data)
			if virtual_key = Vk_return then
				-- If return pressed, select item with matching text.
				list := ev_children
				from
					list.start
					counter := 1
				until
					counter = list.count + 1 or found
				loop
					s1 := list.item.text
					s2 := text
					s1.to_upper
					s2.to_upper
					if equal (s1, s2) then
						if not is_selected (counter) then
							select_item (counter)
						end
						found := True
					end
					if not list.off then
						list.forth
					end
					counter := counter + 1
				end

					-- Call the return actions
				if return_actions_internal /= Void then
					return_actions_internal.call (Void)
				end
			end
		end

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Wm_erasebkgnd message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
		do
			disable_default_processing
			set_message_return_value (to_lresult (1))
		end

feature {NONE} -- WEL Implementation

	default_style: INTEGER is
			-- Default windows style used to create `Current'.
		do
			Result := Ws_child | Ws_visible | Ws_group
						| Ws_tabstop | Ws_vscroll
						| Cbs_autohscroll | Ws_clipchildren
						| Ws_clipsiblings
		end

	old_selected_item: EV_LIST_ITEM_IMP
			-- The previously selected item.

	last_edit_change: STRING_32
			-- The string resulting from the last edit change.

	on_cbn_selchange is
			-- The selection is about to change.
		local
			new_selected_item: EV_LIST_ITEM_IMP
		do
					-- Retrieve the new selected item.
			if selected then
				new_selected_item := ev_children.i_th (wel_selected_item + 1)
			else
				new_selected_item := Void
			end

			if not equal (old_selected_item, new_selected_item) then
					-- Send a "Deselect Action" to the old item, and
					-- to the combo box.
				if old_selected_item /= Void then
					if old_selected_item.deselect_actions_internal /= Void then
						old_selected_item.deselect_actions_internal.call (Void)
					end
					if deselect_actions_internal /= Void then
						deselect_actions_internal.call
							([old_selected_item.interface])
					end
				end

					-- Remember the current selected item.
				old_selected_item := new_selected_item

					-- Send a "Select Action" to the new item, and
					-- to the combo box.
				if new_selected_item /= Void then
					if new_selected_item.select_actions_internal /= Void then
						new_selected_item.select_actions_internal.call (Void)
					end
					if select_actions_internal /= Void then
						select_actions_internal.call
							([new_selected_item.interface])
					end
				end
			end
		end

	on_cbn_editchange is
			-- The edit control portion is about to
			-- display altered text.
		do
			if not equal (text, last_edit_change) then
				if change_actions_internal /= Void then
					change_actions_internal.call (Void)
				end
			end
			last_edit_change := text
		end

	on_cbn_dropdown is
			-- List box is about to be made visible.
		local
			pt: WEL_POINT
		do
			if drop_down_actions_internal /= Void then
				drop_down_actions_internal.call (Void)
			end
			if not ev_children.is_empty then
				pt := client_to_screen (0,0)
				combo.resize (combo.width, screen_height - pt.y)
			else
				combo.resize (combo.width, 50)
			end
		end

	on_cbn_closeup is
			-- The combo box has been closed.
		do
			if list_hidden_actions_internal /= Void then
				list_hidden_actions_internal.call (Void)
			end
		end

	set_selection (start_pos, end_pos: INTEGER) is
			-- Hilight the text between `start_pos' and `end_pos'.
			-- Both `start_pos' and `end_pos' are selected.
		do
			text_field.set_selection (start_pos, end_pos)
		end

	wel_selection_start: INTEGER is
			-- Zero based index of the first character selected.
		do
			Result := cwin_lo_word (cwin_send_message_result (edit_item,
				Em_getsel, to_wparam (0), to_lparam (0)))
		end

	wel_selection_end: INTEGER is
			-- Zero based index of the last character selected.
		do
			Result := cwin_hi_word (cwin_send_message_result (edit_item,
				Em_getsel, to_wparam (0), to_lparam (0)))
		end

	destroy is
			-- Destroy `Current'.
		do
			wipe_out
			Precursor {EV_TEXT_COMPONENT_IMP}
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_COMBO_BOX

invariant
	combo_not_void: is_initialized implies combo /= Void
	text_field_not_void: (is_initialized and then is_editable) implies text_field /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_COMBO_BOX_IMP

