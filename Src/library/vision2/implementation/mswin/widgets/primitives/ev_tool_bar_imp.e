indexing
	description: "EiffelVision toolbar, mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_IMP

inherit
	EV_TOOL_BAR_I
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		undefine
			on_right_button_down, on_left_button_down, on_middle_button_down,
 			on_left_button_up, on_left_button_double_click,
 			on_middle_button_double_click, on_right_button_double_click,
 			minimum_width, minimum_height, pnd_press, escape_pnd, update_for_pick_and_drop
		redefine
			parent_imp, wel_move_and_resize, on_mouse_move, on_key_down,
			destroy, interface, initialize, on_left_button_double_click,
			x_position, y_position, disable_sensitive, enable_sensitive,
			update_for_pick_and_drop, is_dockable_source, show, hide, is_show_requested
		end

	EV_SIZEABLE_CONTAINER_IMP
		undefine
			ev_set_minimum_width, ev_set_minimum_height, ev_set_minimum_size,
			initialize_sizeable
		redefine
			compute_minimum_width, compute_minimum_height,
			compute_minimum_size, interface
		end

	EV_DOCKABLE_TARGET_IMP
		redefine
			interface
		end

	EV_ITEM_LIST_IMP [EV_TOOL_BAR_ITEM, EV_TOOL_BAR_ITEM_IMP]
		redefine
			interface, initialize
		end

	EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP
		redefine
			interface,
			on_left_button_double_click
		end

	WEL_IMAGELIST_TOOL_BAR
		rename
			make as wel_make, insert_button as wel_insert_button,
			parent as wel_parent, set_parent as wel_set_parent,
			shown as is_displayed, destroy as wel_destroy,
			destroy_item as wel_destroy_item, item as wel_item,
			enabled as is_sensitive,  width as wel_width,
			height as wel_height, tooltip as wel_tooltip,
			set_tooltip as wel_set_tooltip, x as x_position,
			y as y_position, move as wel_move, resize as wel_resize,
			move_and_resize as wel_move_and_resize,
			has_capture as wel_has_capture
		undefine
			set_width, set_height, on_mouse_move, on_left_button_down,
			on_middle_button_down, on_right_button_down, on_left_button_up,
			on_middle_button_up, on_right_button_up,
			on_left_button_double_click, on_middle_button_double_click,
			on_right_button_double_click, on_key_up, on_key_down,
			on_kill_focus, on_desactivate, on_set_focus, on_set_cursor,
			on_char, show, hide, on_size, x_position, y_position,
			on_sys_key_down, default_process_message, on_sys_key_up,
			on_mouse_wheel, on_getdlgcode, on_erase_background,
			on_wm_dropfiles
		redefine
			wel_set_parent, wel_resize, wel_move, wel_move_and_resize,
 			on_left_button_double_click, default_style, background_brush,
 			on_tbn_dropdown
		end

	WEL_COLOR_CONSTANTS
		export
			{NONE} all
		end

	EV_SHARED_IMAGE_LIST_IMP
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Wm_erasebkgnd message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
			-- (from WEL_WINDOW)
			-- (export status {NONE})
		local
			bk_brush: WEL_BRUSH
			theme_drawer: EV_THEME_DRAWER_IMP
		do
			bk_brush := background_brush
			theme_drawer := application_imp.theme_drawer
			theme_drawer.draw_widget_background (Current, paint_dc, invalid_rect, bk_brush)
			bk_brush.delete
			disable_default_processing
			set_message_return_value (to_lresult (1))
		end

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			create ev_children.make (2)
		end

	initialize is
			-- Initialize `Current'.
		local
			ctrl: EV_INTERNAL_TOOL_BAR_IMP
			l_prev_ex_style: INTEGER
		do
			create ctrl.make_with_toolbar (default_parent, Current)
			wel_make (ctrl, 0)
				-- For some reasons most of the time on Windows XP with a manifest file
				-- Windows set the transparent flag, and since we don't want it, we need
				-- to unset it.
			set_style (style & tbstyle_transparent.bit_not)

			Precursor {EV_PRIMITIVE_IMP}
			Precursor {EV_ITEM_LIST_IMP}
			create radio_group.make
			new_item_actions.extend (agent add_button)
			new_item_actions.extend (agent add_radio_button)
			new_item_actions.extend (agent add_toggle_button)
			remove_item_actions.extend (agent remove_radio_button)

			-- On Windows, we only can set ex style of toolbar this way.
			l_prev_ex_style := {WEL_API}.send_message_result_integer (wel_item, tb_setextendedstyle, to_wparam (0), to_lparam (tbstyle_ex_mixedbuttons | tbstyle_ex_drawddarrows ))

		end

feature -- Access

	bar: EV_INTERNAL_TOOL_BAR_IMP is
			-- WEL container of `Current'
		do
			Result ?= wel_parent
		end

	ev_children: ARRAYED_LIST [EV_TOOL_BAR_ITEM_IMP]
			-- List of the direct children of `Current'.

	parent_imp: EV_CONTAINER_IMP is
			-- Parent container of `Current'.
		do
			if bar.parent = default_parent then
				Result := Void
			else
				Result ?= bar.parent
			end
		end

	x_position: INTEGER is
			-- `Result' is x_position of `Current' in pixels.
			-- If `wel_parent' not Void then `Result' is relative to
			-- `wel_parent' else `Result' is relative to screen.
			--| We redefine this as the parent of `Current' is always `bar'
			--| which has the same coordinates, we need to perform our
			--| calculations against the parent of `bar'.
		local
			rect: WEL_RECT
			point: WEL_POINT
		do
			if is_show_requested then
				if wel_parent /= Void then
					rect := bar.window_rect
					create point.make (rect.x, rect.y)
					point.screen_to_client (bar.parent)
					Result := point.x
				else
					Result := absolute_x
				end
			else
				Result := child_cell.x
			end
		end

	y_position: INTEGER is
			-- `Result' is y_position of `Current' in pixels.
			-- If `wel_parent' not Void then `Result' is relative to
			-- `wel_parent' else `Result' is relative to screen.
			--| We redefine this as the parent of `Current' is always `bar'
			--| which has the same coordinates, we need to perform our
			--| calculations against the parent of `bar'.
		local
			rect: WEL_RECT
			point: WEL_POINT
		do
			if is_show_requested then
				if wel_parent /= Void then
					rect := bar.window_rect
					create point.make (rect.x, rect.y)
					point.screen_to_client (bar.parent)
					Result := point.y
				else
					Result := absolute_y
				end
			else
				Result := child_cell.x
			end
		end

	is_show_requested: BOOLEAN is
			-- Is `Current' displayed in its parent?
		do
			Result := flag_set (bar.style, {WEL_WINDOW_CONSTANTS}.Ws_visible)
		end

	is_vertical: BOOLEAN
			-- Is vertical items layout?

feature -- Status report

	separator_width: INTEGER is
			-- Current separator width.
		do
			Result := 8
		end

	shown: BOOLEAN is
			-- Is the window shown?
		do
			Result := flag_set (bar.style, Ws_visible)
		end

	has_vertical_button_style: BOOLEAN is
			-- Is the `pixmap' displayed vertically above `text' for
			-- all buttons contained in `Current'? If `False', then
			-- the `pixmap' is displayed to left of `text'.
		do
			Result := not flag_set (style, Tbstyle_list)
		end

feature -- Status setting

	show is
			-- Show `Current'.
			-- Need to notify the parent.
		local
			p_imp: like parent_imp
		do
			show_window (bar.item, {WEL_WINDOW_CONSTANTS}.Sw_show)
			p_imp := parent_imp
			if p_imp /= Void then
				p_imp.notify_change (Nc_minsize, Current)
			end
		end

	hide is
			-- Hide `Current'.
		local
			p_imp: like parent_imp
		do
			show_window (bar.item, {WEL_WINDOW_CONSTANTS}.Sw_hide)
			p_imp := parent_imp
			if p_imp /= Void then
				p_imp.notify_change (Nc_minsize, Current)
			end
		end

	disable_vertical_button_style is
			-- Ensure `has_vertical_button_style' is `False'.
		do
			if has_vertical_button_style then
				set_style (default_style | Tbstyle_list)
				update_buttons (interface, 1, count)
			end
		end

	enable_vertical_button_style is
			-- Ensure `has_vertical_button_style' is `True'.
		do
			if not has_vertical_button_style then
				set_style (default_style)
				update_buttons (interface, 1, count)
			end
		end

	destroy is
			-- Destroy the widget, but set the parent sensitive
			-- in case it was set insensitive by the child.
		do
			if parent_imp /= Void then
				parent_imp.interface.prune (Current.interface)
			end
			bar.destroy
			if default_imagelist /= Void then
				destroy_toolbar_default_imagelist (default_imagelist)
			end
			if hot_imagelist /= Void then
				destroy_toolbar_hot_imagelist (hot_imagelist)
			end
			set_is_destroyed (True)
		end

	enable_sensitive is
			-- Make object sensitive to user input.
		do
			set_insensitive (False)
			Precursor
		end

	disable_sensitive is
			-- Make object non-sensitive to user input.
		do
			set_insensitive (True)
			Precursor
		end

	set_insensitive (flag: BOOLEAN) is
			-- If `flag' then make `Current' insensitive. Else
			-- make `Current' sensitive.
		local
			list: ARRAYED_LIST [EV_TOOL_BAR_ITEM_IMP]
			item_imp: EV_TOOL_BAR_ITEM_IMP
			cur: CURSOR
		do
			if not ev_children.is_empty then
				list := ev_children
				from
					cur := list.cursor
					list.start
				until
					list.after
				loop
					item_imp := list.item
					if flag then
						item_imp.disable_sensitive
					else
						if not item_imp.internal_non_sensitive then
							item_imp.enable_sensitive
						end
					end
					list.forth
				end
				list.go_to (cur)
			end
		ensure
			cursor_not_moved: old ev_children.index = ev_children.index
		end

feature -- Element change

	insert_item (button: EV_TOOL_BAR_ITEM_IMP; an_index: INTEGER) is
			-- Insert `button' at the `an_index' position in `Current'.
		local
			but: WEL_TOOL_BAR_BUTTON
			button_text: STRING_32
			radio_button: EV_TOOL_BAR_RADIO_BUTTON_IMP
			separator_button: EV_TOOL_BAR_SEPARATOR_IMP
			toggle_button: EV_TOOL_BAR_TOGGLE_BUTTON_IMP
			dropdown_button: EV_TOOL_BAR_DROP_DOWN_BUTTON_IMP
		do
			-- We need to check the type of tool bar button.
			-- Depending on the type, `but' is created differently.
			radio_button ?= button
			toggle_button ?= button
			dropdown_button ?= button
			if radio_button /= Void or toggle_button /= Void then
				create but.make_check (-1, button.id)
			end
			if dropdown_button /= Void then
				create but.make_drop_down_button (-1, button.id)
			end
			separator_button ?= button
			if separator_button /= Void then
				create but.make_separator
				but.set_command_id (button.id)
			end
			if radio_button = Void and toggle_button = Void and dropdown_button = Void and
				separator_button = Void then
				create but.make_button (-1, button.id)
			end

				-- First, we take care of the pixmap,
			if button.has_pixmap then
				button.set_pixmap_in_parent
				but.set_bitmap_index (button.image_index)
			elseif separator_button = Void then
					-- Now special handling to ensure that the toolbar buttons are displayed
					-- at the minimum size of their `text' by addition of an image list with
					-- small pixmaps.
				button.set_pixmap_in_parent
				but.set_bitmap_index (-1)
			end

				-- Also take care of toggled state if a toggle button.
			if toggle_button /= Void and then toggle_button.is_selected then
				but.set_state  ({WEL_TB_STATE_CONSTANTS}.Tbstate_checked | {WEL_TB_STATE_CONSTANTS}.Tbstate_enabled)
			end

				-- If we are a separator then there is no need to handle the text.
			if separator_button = Void then
					-- Then, the text of the button.
				button_text := button.text -- Speed optimization
				if not button_text.is_empty then
						--| We now add an empty text to all children without
						--| text, so that they do not share text with other buttons.
						--| Only performed when a text is added to the first child.
					if children_with_text = 1 then
						update_buttons_with_no_text
					end
					add_strings (<<button_text>>)
					but.set_string_index (last_string_index)
				else
						--| If we do not have a text, then we need to add an empty text in
						--| order to stop the text from another button being used.
						--| Adding the empty text causes the toolbar to re-size, so
						--| we only add the empty text when there are children already with text.
					if a_child_has_text then
						add_strings (<<"">>)
						but.set_string_index (last_string_index)
					end
					--| If there is no text, we should set button style not to show text.
					--| Otherwise there is gap after icons if no texts setted.
					but.set_style (but.style & {WEL_TB_STYLE_CONSTANTS}.btns_showtext.bit_not)
				end
			end

				-- Finally, we insert the button
			wel_insert_button (an_index - 1, but)
			auto_size

				-- Disable the button if it should not be sensitive.
			if not is_sensitive or not button.is_sensitive then
				disable_button (button.id)
			end

				-- Only perform resizing if we are not currently within
				-- execution of `reset_button'.
			if not is_in_reset_button then
					-- We notify the change to integrate them if necessary
				notify_change (nc_minsize, Current)
			end
		end

	remove_item (button: EV_TOOL_BAR_ITEM_IMP) is
			-- Remove `button' from `current'.
		local
			id1: INTEGER
		do
			id1 := ev_children.index_of (button, 1)
			delete_button (internal_get_index (button))
				-- Only perform resizing if we are not currently within
				-- execution of `reset_button'.
			if not is_in_reset_button then
				notify_change (nc_minsize, Current)
			end
				-- Now restore `private_pixmap' and
				-- `private_grey_pixmap' if necessary.
			button.restore_private_pixmaps
		end

feature -- Basic operation

	enable_vertical is
			-- Enable vertical items layout.
		local
			l_wel_button: WEL_TOOL_BAR_BUTTON
			l_count: INTEGER
			l_behind_is_separator: BOOLEAN
		do
			if not is_vertical then
				from
					l_count := button_count - 1
					-- For the last button, we do not need to set tbstate_wrap
					l_behind_is_separator := True
				until
					l_count < 0
				loop
					l_wel_button := i_th_button (l_count)
					-- We set button tbstate_wrap ourself instead of using SetRows(), is because
					-- SetRows can't always show one line vertical toolbar when Windows Xp common control is used.

					-- WEL_TOOL_BAR_BUTTON with tbstyle_sep maybe a custom control (such as a combo box...),
					-- but currently in Vision2 Windows implmentation it must be a separator.
					if not l_behind_is_separator then
						l_wel_button.set_state (l_wel_button.state | {WEL_TB_STATE_CONSTANTS}.tbstate_wrap)
						l_wel_button.set_style (l_wel_button.style & {WEL_TB_STYLE_CONSTANTS}.btns_showtext.bit_not)
						-- Because after set_state of a button is not work immediately,
						-- So we first delete it, then insert it.
						delete_button (l_count)
						wel_insert_button (l_count, l_wel_button)
					end

					l_behind_is_separator := (l_wel_button.style & {WEL_TB_STYLE_CONSTANTS}.tbstyle_sep) /= 0

					l_count := l_count - 1
				end

				set_minimum_width (get_max_width)
				set_minimum_height (get_max_height)
				is_vertical := True
			end

		end

	disable_vertical is
			-- Disable vertical items layout. Then items will be horizontal layout.
		local
			l_wel_button: WEL_TOOL_BAR_BUTTON
			l_count: INTEGER
		do
			if is_vertical then
				from
					l_count := button_count - 1
				until
					l_count < 0
				loop
					l_wel_button := i_th_button (l_count)

					l_wel_button.set_state (l_wel_button.state & {WEL_TB_STATE_CONSTANTS}.tbstate_wrap.bit_not)
					l_wel_button.set_style (l_wel_button.style | {WEL_TB_STYLE_CONSTANTS}.btns_showtext)
					-- Because after set_state of a button is not work immediately,
					-- So we first delete it, then insert it.
					delete_button (l_count)
					wel_insert_button (l_count, l_wel_button)

					l_count := l_count - 1
				end

				set_minimum_width (get_max_width)
				set_minimum_height (get_max_height)
				is_vertical := False
			end

		end

	internal_get_index (button: EV_TOOL_BAR_ITEM_IMP): INTEGER is
			-- Retrieve the current index of `button'.
		do
			Result := {WEL_API}.send_message_result_integer (
				wel_item, Tb_commandtoindex, to_wparam (button.id), to_lparam (0))
		end

	compute_minimum_width is
			-- Update the minimum-size of `Current'.
		local
			num: INTEGER
		do
			if comctl32_version >= version_471 then
					-- New version using API available starting with IE4.
				ev_set_minimum_width (get_max_width)
			else
					-- No API available, we can only guess the right value...
				num := separator_count
				num := (count - num) * buttons_width + num * separator_width
				ev_set_minimum_width (num)
			end
		end

	compute_minimum_height is
			-- Update the minimum-size of `Current'.
		do
			if comctl32_version >= version_471 then
					-- New version using API available starting with IE4.
				ev_set_minimum_height (get_max_height)
			else
					-- No API available, we can only guess the right value...
				ev_set_minimum_height (buttons_height + 4)
			end

		end

	compute_minimum_size is
			-- Recompute both the minimum_width and then
			-- minimum_height of `Current'.
		do
			compute_minimum_height
			compute_minimum_width
		end

	internal_reset_button (but: EV_TOOL_BAR_ITEM_IMP) is
			-- XX To update XX
			-- This function is used each time we change an attribute of a
			-- button as the text or the pixmap. Yet, it should only be a
			-- Temporary implementation. For now, no message is available to
			-- change the text of a button. But this implementation should
			-- be changed as soon as windows allow a more direct way to
			-- change an attribute.
		local
			an_index: INTEGER
			locked_in_here: BOOLEAN
		do
				-- Flag `is_in_reset_button' to `True', preventing resizing occurring.
			is_in_reset_button := True

			if is_displayed and then application_imp.locked_window = Void then
				locked_in_here := True
				lock_window_update
			end
			an_index := internal_get_index (but) + 1
			remove_item (but)
			insert_item (but, an_index)
			if locked_in_here then
				unlock_window_update
			end
			is_in_reset_button := False
			notify_change (nc_minsize, Current)
		end

	is_in_reset_button: BOOLEAN
		-- Is `internal_reset_button' currently executing?
		-- Used to prevent sizing notifications from occurring during `internal_reset_button' which
		-- calls `remove_item' followed by `insert_item'.

	is_dockable_source (x_pos, y_pos: INTEGER): BOOLEAN is
			-- Is `Current' at position `x_pos', `y_pos' a dockable source?
		local
			tool_bar_button: EV_TOOL_BAR_BUTTON_IMP
		do
			Result := is_dockable
			tool_bar_button ?= find_item_at_position (x_pos, y_pos)
			if tool_bar_button /= Void and then tool_bar_button.is_dockable then
				Result := True
			end
		end

	find_item_at_position (x_pos, y_pos: INTEGER): EV_TOOL_BAR_ITEM_IMP is
			-- Find the item at `x_pos', `y_pos'.
			-- Position is relative to `Current'.
			-- If there is no button at (`x_pos',`y_pos'), the result is Void.
		local
			item_index: INTEGER
		do
			item_index := find_button(x_pos, y_pos)
			if item_index >= 0 and item_index < ev_children.count then
				 Result := ev_children.i_th (item_index + 1)
			end
		end

	internal_propagate_pointer_press (keys, x_pos, y_pos, button: INTEGER) is
			-- Propagate `keys', `x_pos', `y_pos' and `button' to the
			-- appropriate event item. Called on a pointer button press.
		local
			pre_drop_it, post_drop_it: EV_TOOL_BAR_BUTTON_IMP
			item_press_actions_called: BOOLEAN
			pt: WEL_POINT
		do
			pre_drop_it ?= find_item_at_position (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)

			if pre_drop_it /= Void and then pre_drop_it.is_dockable and button = 1 and not is_dock_executing then
				item_is_dockable_source := True
				start_docking (x_pos, y_pos, 1, 0, 0, 0, pt.x, pt.y, pre_drop_it.interface)
			end

			if pre_drop_it /= Void and not transport_executing
				and not item_is_in_pnd then
				if pre_drop_it.pointer_button_press_actions_internal
					/= Void then
					pre_drop_it.interface.pointer_button_press_actions.call
						([x_pos - child_x (pre_drop_it.interface), y_pos,
						button, 0.0, 0.0, 0.0, pt.x, pt.y])
				end
					-- We record that the press actions have been called.
				item_press_actions_called := True
			end
				--| The pre_drop_it.parent /= Void is to check that the item that
				--| was originally clicked on, has not been removed during the press actions.
				--| If the parent is now void then it has, and there is no need to continue
				--| with `pnd_press'.
			if not item_is_dockable_source then
				if pre_drop_it /= Void and pre_drop_it.is_transport_enabled and
					not parent_is_pnd_source and pre_drop_it.parent /= Void then
					pre_drop_it.pnd_press (x_pos, y_pos, button, pt.x, pt.y)
				elseif pnd_item_source /= Void then
					pnd_item_source.pnd_press (
						x_pos, y_pos, button, pt.x, pt.y)
				end

				if item_is_pnd_source_at_entry = item_is_pnd_source then
					pnd_press (x_pos, y_pos, button, pt.x, pt.y)
				end
			end
			if not press_actions_called then
				interface.pointer_button_press_actions.call
					([x_pos, y_pos, button, 0.0, 0.0, 0.0, pt.x, pt.y])
			end

			post_drop_it ?= find_item_at_position (x_pos, y_pos)

				-- If there is an item where the button press was recieved,
				-- and it has not changed from the start of this procedure
				-- then call `pointer_button_press_actions'.
				--| Internal_propagate_pointer_press in
				--| EV_MULTI_COLUMN_LIST_IMP has a fuller explanation.
			if not item_press_actions_called then
				if post_drop_it /= Void and pre_drop_it = post_drop_it then
					post_drop_it.interface.pointer_button_press_actions.call
							([x_pos - child_x (post_drop_it.interface), y_pos,
							button, 0.0, 0.0, 0.0, pt.x, pt.y])
				end
			end
		end

	internal_propagate_pointer_double_press
		(keys, x_pos, y_pos, button: INTEGER) is
			-- Propagate `keys', `x_pos', `y_pos' and `button' to the
			-- appropriate event item. Called on a pointer button double click.
		local
			it: EV_TOOL_BAR_BUTTON_IMP
			pt: WEL_POINT
		do
			it ?= find_item_at_position (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			if it /= Void then
				it.interface.pointer_double_press_actions.call
				([x_pos - child_x (it.interface), y_pos, button, 0.0, 0.0, 0.0,
				pt.x, pt.y])
			end
		end

feature {EV_INTERNAL_TOOL_BAR_IMP} -- Click action event

	button_associated_with_id (command_id: INTEGER): EV_TOOL_BAR_BUTTON_IMP is
			-- `Result' is button associated with `command_id'.
		local
			found: BOOLEAN
			local_children: ARRAYED_LIST [EV_TOOL_BAR_ITEM_IMP]
		do
			local_children := ev_children
			from
				local_children.start
			until
				found or else local_children.after
			loop
				Result ?= local_children.item
				found := Result /= Void and then Result.id = command_id
				local_children.forth
			end
			check
				button_with_command_id_exists: Result /= Void
			end
		end

	on_button_clicked (command_id: INTEGER) is
			-- Execute `select_actions' of EV_TOOL_BAR_BUTTON_IMP associated
			-- with `command_id'.
		require
			valid_command_id: command_id > 0
		local
			but: EV_TOOL_BAR_BUTTON_IMP
			toggle_but: EV_TOOL_BAR_TOGGLE_BUTTON_IMP
			radio_button: EV_TOOL_BAR_RADIO_BUTTON_IMP
		do
				-- Assign button associated with `command_id' to but.
			but := button_associated_with_id (command_id)

				-- Update the state of the toggle button
				-- (if it's a toggle button)
			toggle_but ?= but
			if toggle_but /= Void then
				toggle_but.update_selected (button_checked  (command_id))
			end

			radio_button ?= but

			if radio_button /= Void and radio_button.is_sensitive then
				radio_button.update_radio_states
				if radio_button.selected_peer = radio_button.interface then
					radio_button.enable_select
				end
			end

				-- Call the actions.
			but.interface.select_actions.call (Void)
		end

	button_tooltip_text (command_id: INTEGER): STRING_32 is
			--	`Result' is tooltip text for button with `command_id'.
		local
			but: EV_TOOL_BAR_BUTTON_IMP
		do
			but := button_associated_with_id (command_id)
			Result := but.tooltip
		end

feature {EV_TOOL_BAR_BUTTON_IMP} -- Pixmap handling

	default_imagelist: EV_IMAGE_LIST_IMP
			-- "Default" image list associated with this toolbar.

	hot_imagelist: EV_IMAGE_LIST_IMP
			-- "Hot" image list associated with this toolbar.

	setup_image_list (pixmap_width :INTEGER; pixmap_height :INTEGER) is
			-- Create the image list and associate it
			-- to `Current' if not already associated.
		require
			imageslists_are_void: default_imagelist = Void and hot_imagelist = Void
		do
			default_imagelist := get_toolbar_default_imagelist_with_size (pixmap_width, pixmap_height)
			hot_imagelist := get_toolbar_hot_imagelist_with_size (pixmap_width, pixmap_height)
			set_image_list (default_imagelist)
			set_hot_image_list (hot_imagelist)
		ensure
			imagelists_not_void: default_imagelist /= Void and hot_imagelist /= Void
		end

	has_false_image_list: BOOLEAN
		-- Is an image list associated with `Current' due to an item with a pixmap?

	enable_false_image_list is
			-- Ensure `has_false_image_list' is `True'.
		do
			has_false_image_list := True
		ensure
			enabled: has_false_image_list = True
		end

	disable_false_image_list is
			-- Ensure `has_false_image_list' is `False'.
		do
			has_false_image_list := False
		ensure
			disabled: has_false_image_list = False
		end

	remove_image_list is
			-- Destroy the image list and remove it
			-- from `Current'.
		require
			imagelists_not_void: default_imagelist /= Void and hot_imagelist /= Void
		do
			default_imagelist := Void
			hot_imagelist := Void

				-- Remove the image list from the list.
			set_image_list (Void)
			set_hot_image_list (Void)
		ensure
			imageslists_are_void: default_imagelist = Void and hot_imagelist = Void
 		end

feature {NONE} -- Implementation

	update_buttons_with_no_text is
			-- Update display of all buttons with empty `text'.
		local
			a_cursor: CURSOR
			but: EV_TOOL_BAR_SEPARATOR_IMP
		do
			a_cursor := ev_children.cursor
			from
				ev_children.start
			until
				ev_children.off
			loop
				if ev_children.item.text.is_empty then
					but ?= ev_children.item
					if but = Void then
						internal_reset_button (ev_children.item)
					end
				end
				ev_children.forth
			end
			ev_children.go_to (a_cursor)
		end

	a_child_has_text: BOOLEAN is
			-- Does a child of `Current' have text set?
		local
			a_cursor: CURSOR
		do
			a_cursor := ev_children.cursor
			from
				ev_children.start
			until
				ev_children.off or else Result
			loop
				Result := not ev_children.item.text.is_empty
				ev_children.forth
			end
			ev_children.go_to (a_cursor)
		end

	children_with_text: INTEGER is
			-- How many children of `Current' have text set?
		local
			a_cursor: CURSOR
		do
			a_cursor := ev_children.cursor
			from
				ev_children.start
			until
				ev_children.off
			loop
				if not ev_children.item.text.is_empty then
					Result := Result + 1
				end
				ev_children.forth
			end
			ev_children.go_to (a_cursor)
		end

	separator_count: INTEGER is
			-- Number of separators in `Current'.
			-- Necessary for the implementation of the minimum_width
			-- of the toolbar. As soon as the message Tb_getmaxsize
			-- is available, this feature should not be so usefull.
		local
			list: ARRAYED_LIST [EV_TOOL_BAR_ITEM_IMP]
			original_index: INTEGER
			separator: EV_TOOL_BAR_SEPARATOR_IMP
		do
			from
				original_index := index
				list := ev_children
				list.start
			until
				list.after
			loop
				separator ?= list.item
				if separator /= Void then
					Result := Result + 1
				end
				list.forth
			end
			ev_children.go_i_th (original_index)
		end

feature {NONE} -- WEL Implementation

	wel_move_and_resize (a_x, a_y, a_width, a_height: INTEGER;
			repaint: BOOLEAN) is
			-- Move and resize `Current'.
			-- We must not resize the height of the tool-bar.
		do
			bar.move_and_resize (a_x, a_y, a_width, height, repaint)
			reposition
		end

	wel_resize (a_width, a_height: INTEGER) is
			-- Move and resize `Current'.
			-- We must not resize the height of the tool-bar.
		do
			bar.resize (a_width, height)
			reposition
		end

	wel_move (a_x, a_y: INTEGER) is
			-- Move `Current'.
		do
			bar.move (a_x, a_y)
		end

	wel_set_parent (a_parent: WEL_WINDOW) is
			-- Assign `a_parent' as the parent of `Current'.
		do
			bar.set_parent (a_parent)
		end

	on_mouse_move (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the mouse move.
		local
			it: EV_TOOL_BAR_BUTTON_IMP
			pt: WEL_POINT
		do
			it ?= find_item_at_position (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			if it /= Void and then it.pointer_motion_actions_internal /= Void then
				it.pointer_motion_actions_internal.call
				([x_pos - child_x (it.interface),
				y_pos, 0.0, 0.0, 0.0,
				pt.x, pt.y])
			end
			if pnd_item_source /= Void and application_imp.dockable_source = Void then
				pnd_item_source.pnd_motion (x_pos, y_pos, pt.x, pt.y)
			end
			Precursor {EV_PRIMITIVE_IMP} (keys, x_pos, y_pos)
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- A key has been pressed
		do
			process_navigation_key (virtual_key)
			Precursor {EV_PRIMITIVE_IMP} (virtual_key, key_data)
		end

	on_left_button_double_click (keys, x_pos, y_pos: INTEGER) is
			-- Left mouse button has been double clicked.
			--| This has been redefined so that if you double click
			--| on a radio button, we can stop Windows altering the
			--| buttons state.
		local
			it: EV_TOOL_BAR_RADIO_BUTTON_IMP
		do
			it ?= find_item_at_position (x_pos, y_pos)
			if it /= Void then
				disable_default_processing
			end
			Precursor {EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP} (keys, x_pos, y_pos)
		end

	on_tbn_dropdown (info: WEL_NM_TOOL_BAR) is
			-- Drop down button drop down arrow clicked.
		local
			l_button: EV_TOOL_BAR_DROP_DOWN_BUTTON_IMP
		do
			l_button ?= button_associated_with_id (info.button_id)
			check dropdown_notify_only_happen_on_dropdown_button: l_button /= Void end
			l_button.interface.drop_down_actions.call ([])
		end

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible | Ws_child | Ws_clipchildren | Ws_clipsiblings |
				Tbstyle_tooltips | {WEL_CCS_CONSTANTS}.Ccs_nodivider

				-- Add the flat style if available.
			if comctl32_version >= version_470 then
				if not application_imp.themes_active then
						-- Setting this style with themes enabled overdraws
						-- any custom background color
					Result := Result | Tbstyle_flat
				end
			end
		end

feature {EV_INTERNAL_TOOL_BAR_IMP} -- Implementation

	background_brush: WEL_BRUSH is
   			-- Current window background color used to refresh the window when
   			-- requested by the WM_ERASEBKGND windows message.
   			-- By default there is no background
		do
 			if exists then
 				create Result.make_solid (wel_background_color)
			end
 		end

feature {EV_TOOL_BAR_IMP} -- Implementation

	radio_group: LINKED_LIST [EV_TOOL_BAR_RADIO_BUTTON_IMP]
			-- Radio items in `Current'.
			-- `Current' shares reference with merged containers.

	is_merged (other: EV_TOOL_BAR): BOOLEAN is
			-- Is `Current' merged with `other'?
		require
			other_not_void: other /= Void
		local
			t_imp: EV_TOOL_BAR_IMP
		do
			t_imp ?= other.implementation
			Result := t_imp.radio_group = radio_group
		end

	set_radio_group (rg: like radio_group) is
			-- Set `radio_group' by reference. (Merge)
		do
			radio_group := rg
		end

	add_radio_button (w: EV_TOOL_BAR_ITEM) is
			-- Called when `w' has been added to `Current'.
		require
			w_not_void: w /= Void
		local
			r: EV_TOOL_BAR_RADIO_BUTTON_IMP
		do
			r ?= w.implementation
			if r /= Void then
				if not radio_group.is_empty then
					r.disable_select
				end
				r.set_radio_group (radio_group)
			end
		end

	add_button (w: EV_TOOL_BAR_ITEM) is
			-- Called when `w' has been added to `Current'.
		require
			w_not_void: w /= Void
		local
			button_imp: EV_TOOL_BAR_ITEM_IMP
		do
			button_imp ?= w.implementation
			check
				implementation_not_void: button_imp /= Void
			end
			if not button_imp.is_sensitive then
				disable_button (button_imp.id)
			end
		end

	remove_radio_button (w: EV_TOOL_BAR_ITEM) is
			-- Called when `w' has been removed from `Current'.
		require
			w_not_void: w /= Void
		local
			r: EV_TOOL_BAR_RADIO_BUTTON_IMP
		do
			r ?= w.implementation
			if r /= Void then
				r.remove_from_radio_group
				r.enable_select
			end
		end

	add_toggle_button (w: EV_TOOL_BAR_ITEM) is
			-- Called when `w' has been added to `Current'.
		require
			item_not_void: w /= Void
		local
			t: EV_TOOL_BAR_TOGGLE_BUTTON_IMP
		do
			t ?= w.implementation
			if t /= Void then
				if t.is_selected then
					check_button (t.id)
				end
			end
		end

feature {EV_DOCKABLE_SOURCE_I} -- Implementation

	insertion_position: INTEGER is
			-- `Result' is index to left of item beneath the
			-- current mouse pointer or count + 1 if over the toolbar
			-- and not over a button. i.e if over button 1, `Result' is 0.
		local
			offset: INTEGER
			item_index: INTEGER
		do
			Result := -1
			offset := internal_screen.pointer_position.x - screen_x
			item_index := find_button(offset, height // 2)
			if item_index >= 0 and item_index < ev_children.count then
				Result := item_index
			elseif item_index <= - 1 and item_index >= - count then
				Result := item_index.abs
			elseif (item_index = -count - 1) then
				Result := count + 1
			end
		end

	block_selection_for_docking is
			-- Ensure that a tool bar button is not selected as a
			-- result of the transport ending.
		do
			disable_default_processing
		end

feature {EV_TOOL_BAR_ITEM_IMP} -- Implementation

	child_x (button: EV_TOOL_BAR_BUTTON): INTEGER is
			-- `Result' is relative xcoor of `button' to `parent_imp'.
		local
			button_rectangle: WEL_RECT
			but: EV_TOOL_BAR_BUTTON_IMP
		do
			but ?= button.implementation
			button_rectangle := button_rect (internal_get_index (but))
			Result := button_rectangle.left
		end

	child_y (button: EV_TOOL_BAR_BUTTON): INTEGER is
			-- `Result' is relative ycoor of `button' to `parent_imp'.
		local
			button_rectangle: WEL_RECT
			but: EV_TOOL_BAR_BUTTON_IMP
		do
			but ?= button.implementation
			button_rectangle := button_rect (internal_get_index (but))
			Result := button_rectangle.top
		end

	child_x_absolute (button: EV_TOOL_BAR_BUTTON): INTEGER is
			-- `Result' is absolute xcoor of `button'.	
		local
			button_rectangle: WEL_RECT
			but: EV_TOOL_BAR_BUTTON_IMP
		do
			but ?= button.implementation
			button_rectangle := button_rect (internal_get_index (but))
			Result := screen_x + button_rectangle.left
		end

	child_y_absolute (button: EV_TOOL_BAR_BUTTON): INTEGER is
			-- `Result' is absolute ycoor of `button'.	
		local
			button_rectangle: WEL_RECT
			but: EV_TOOL_BAR_BUTTON_IMP
		do
			but ?= button.implementation
			button_rectangle := button_rect (internal_get_index (but))
			Result := screen_y + button_rectangle.top
		end

	child_width (button: EV_TOOL_BAR_BUTTON): INTEGER is
			-- `Result' is width of `button'.
		local
			button_rectangle: WEL_RECT
			but: EV_TOOL_BAR_BUTTON_IMP
		do
			but ?= button.implementation
			button_rectangle := button_rect (internal_get_index (but))
			Result := button_rectangle.width
		end

	child_height (button: EV_TOOL_BAR_BUTTON): INTEGER is
			-- `Result' is height of `button'.
		local
			button_rectangle: WEL_RECT
			but: EV_TOOL_BAR_BUTTON_IMP
		do
			but ?= button.implementation
			button_rectangle := button_rect (internal_get_index (but))
			Result := button_rectangle.height
		end

feature {EV_ANY_I}

	interface: EV_TOOL_BAR;

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




end -- class EV_TOOL_BAR_IMP

