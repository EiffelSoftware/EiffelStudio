indexing
	description: "EiffelVision toolbar, mswindows implementation."
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
 			minimum_width, minimum_height, pnd_press, escape_pnd
		redefine
			parent_imp, wel_move_and_resize, on_mouse_move, on_key_down,
			destroy, interface, initialize, on_left_button_double_click,
			x_position, y_position, disable_sensitive, enable_sensitive,
			update_for_pick_and_drop
		end

	EV_SIZEABLE_CONTAINER_IMP
		undefine
			ev_set_minimum_width, ev_set_minimum_height, ev_set_minimum_size,
			initialize_sizeable 
		redefine
			compute_minimum_width, compute_minimum_height, 
			compute_minimum_size, interface
		end

	EV_ITEM_LIST_IMP [EV_TOOL_BAR_ITEM]
		redefine
			interface, initialize, on_left_button_double_click
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
			on_sys_key_down, default_process_message, on_sys_key_up
		redefine
			wel_set_parent, wel_resize, wel_move, wel_move_and_resize,
 			on_left_button_double_click, default_style
		end

	WEL_COLOR_CONSTANTS
		export
			{NONE} all
		end

	EV_SHARED_IMAGE_LIST_IMP
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

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
		do
			create ctrl.make_with_toolbar (default_parent, Current)
			wel_make (ctrl, 0)	
			Precursor {EV_PRIMITIVE_IMP}
			Precursor {EV_ITEM_LIST_IMP}
			create radio_group.make
			new_item_actions.extend (~add_button)
			new_item_actions.extend (~add_radio_button)
			new_item_actions.extend (~add_toggle_button)
			remove_item_actions.extend (~remove_radio_button)
		end

feature -- Access
	
	bar: EV_INTERNAL_TOOL_BAR_IMP is
			-- WEL container of `Current'
		do
			Result ?= wel_parent
		end

	ev_children: ARRAYED_LIST [EV_TOOL_BAR_BUTTON_IMP]
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

feature -- Status setting

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
			list: ARRAYED_LIST [EV_TOOL_BAR_BUTTON_IMP]
			widget_imp: EV_TOOL_BAR_BUTTON_IMP
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
					widget_imp := list.item
					if flag then
						widget_imp.disable_sensitive 
					else
						if not widget_imp.internal_non_sensitive then
							widget_imp.enable_sensitive
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

	insert_item (button: EV_TOOL_BAR_BUTTON_IMP; an_index: INTEGER) is
			-- Insert `button' at the `an_index' position in `Current'.
		local
			but: WEL_TOOL_BAR_BUTTON
			button_text: STRING
			radio_button: EV_TOOL_BAR_RADIO_BUTTON_IMP
			separator_button: EV_TOOL_BAR_SEPARATOR_IMP
			toggle_button: EV_TOOL_BAR_TOGGLE_BUTTON_IMP
		do
			-- We need to check the type of tool bar button.
			-- Depending on the type, `but' is created differently.
			radio_button ?= button
			toggle_button ?= button
			if radio_button /= Void or toggle_button /= Void then
				create but.make_check (-1, button.id)
			end
			separator_button ?= button
			if separator_button /= Void then
				create but.make_separator
				but.set_command_id (button.id)
			end
			if radio_button = Void and toggle_button =Void and
				separator_button = Void then
				create but.make_button (-1, button.id)
			end

				-- First, we take care of the pixmap,
			if button.has_pixmap then
				button.set_pixmap_in_parent
				but.set_bitmap_index (button.image_index)
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
						add_strings (<<" ">>)
						but.set_string_index (last_string_index)	
					end
				end
			end

				-- Finally, we insert the button
			wel_insert_button (an_index - 1, but)
			auto_size

			if not is_sensitive then
				disable_button (button.id)
			end

				-- We notify the change to integrate them if necessary
			notify_change (2 + 1, Current)
		end
		
	remove_item (button: EV_TOOL_BAR_BUTTON_IMP) is
			-- Remove `button' from `current'.
		local
			id1: INTEGER
		do
			id1 := ev_children.index_of (button, 1)
			delete_button (internal_get_index (button))
			notify_change (2 + 1, Current)
		end

feature -- Basic operation

	internal_get_index (button: EV_TOOL_BAR_BUTTON_IMP): INTEGER is
			-- Retrieve the current index of `button'.
		do
			Result := cwin_send_message_result (
				wel_item, Tb_commandtoindex, button.id, 0)
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

	internal_reset_button (but: EV_TOOL_BAR_BUTTON_IMP) is
			-- XX To update XX
			-- This function is used each time we change an attribute of a 
			-- button as the text or the pixmap. Yet, it should only be a 
			-- Temporary implementation. For now, no message is available to 
			-- change the text of a button. But this implementation should
			-- be changed as soon as windows allow a more direct way to 
			-- change an attribute.
		local
			an_index: INTEGER
		do
			an_index := internal_get_index (but) + 1
			remove_item (but)
			insert_item (but, an_index)
		end

	find_item_at_position (x_pos, y_pos: INTEGER): EV_TOOL_BAR_BUTTON_IMP is
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
			pre_drop_it := find_item_at_position (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)

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

			if not press_actions_called then
				interface.pointer_button_press_actions.call
					([x_pos, y_pos, button, 0.0, 0.0, 0.0, pt.x, pt.y])
			end
					
			post_drop_it := find_item_at_position (x_pos, y_pos)

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
			it := find_item_at_position (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			if it /= Void then
				it.interface.pointer_double_press_actions.call
				([x_pos - child_x (it.interface), y_pos, button, 0.0, 0.0, 0.0,
				pt.x, pt.y])
			end
		end
		
feature {EV_ANY_I}

	update_for_pick_and_drop (starting: BOOLEAN) is
			-- Pick and drop status has changed so update appearence of
			-- all children.
		do
			from
				ev_children.start
			until
				ev_children.off
			loop
				ev_children.item.update_for_pick_and_drop (starting)
				ev_children.forth
			end
		end
		
	
feature {EV_INTERNAL_TOOL_BAR_IMP} -- Click action event

	button_associated_with_id (command_id: INTEGER): EV_TOOL_BAR_BUTTON_IMP is
			-- `Result' is button associated with `command_id'.
		local
			found: BOOLEAN
			local_children: ARRAYED_LIST [EV_TOOL_BAR_BUTTON_IMP]
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
			but.interface.select_actions.call ([])
		end

	button_tooltip_text (command_id: INTEGER): STRING is
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

	remove_image_list is
			-- Destroy the image list and remove it
			-- from `Current'.
		require
			imagelists_not_void: default_imagelist /= Void and hot_imagelist /= Void
		do
				-- Destroy the image list.
			destroy_imagelist (default_imagelist)
			destroy_imagelist (hot_imagelist)
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
			-- Update display of all buttons with text = Void.
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
			-- Does a child of `Current' have a text set?
		local
			a_cursor: CURSOR
		do
			a_cursor := ev_children.cursor
			from
				ev_children.start
			until
				ev_children.off or Result = True
			loop
				if not ev_children.item.text.is_empty then
					Result := True
				end
				ev_children.forth
			end
			ev_children.go_to (a_cursor)
		end
	
	children_with_text: INTEGER is
			-- Does a child of `Current' have a text set?
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
			list: ARRAYED_LIST [EV_TOOL_BAR_BUTTON_IMP]
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
			bar.move_and_resize (a_x, a_y, a_width, height - 4, repaint)
			reposition
		end

	wel_resize (a_width, a_height: INTEGER) is
			-- Move and resize `Current'.
			-- We must not resize the height of the tool-bar.
		do
			bar.resize (a_width, height - 4)
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
			it := find_item_at_position (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			if it /= Void then
				it.interface.pointer_motion_actions.call
				([x_pos - child_x (it.interface),
				y_pos, 0.0, 0.0, 0.0,
				pt.x, pt.y])
			end
			if pnd_item_source /= Void then
				pnd_item_source.pnd_motion (x_pos, y_pos, pt.x, pt.y)
			end
			Precursor {EV_PRIMITIVE_IMP} (keys, x_pos, y_pos)
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- A key has been pressed
		do
			process_tab_key (virtual_key)
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
			Precursor {EV_ITEM_LIST_IMP} (keys, x_pos, y_pos)
		end

	default_style: INTEGER is
			-- Default style used to create the control
		local
			Ccs_constants: WEL_CCS_CONSTANTS
		once
			create Ccs_constants

			Result := 
				Ws_visible + 
				Ws_child + 
				Ws_clipchildren +
				Ws_clipsiblings +
				Tbstyle_tooltips + 
				Ccs_constants.Ccs_nodivider

				-- Add the flat style if available.
			if comctl32_version >= version_470 then
				Result := Result + Tbstyle_flat
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
			button_imp: EV_TOOL_BAR_BUTTON_IMP
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

feature {EV_PND_TRANSPORTER_IMP}

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

	child_y_absolute (button: EV_TOOL_BAR_BUTTON): INTEGER is
			-- `Result' is absolute ycoor of `button'.	
		local
			button_rectangle: WEL_RECT
			window_rectangle: WEL_RECT
			but: EV_TOOL_BAR_BUTTON_IMP
			b: EV_INTERNAL_TOOL_BAR_IMP
		do
			but ?= button.implementation
			button_rectangle := button_rect (internal_get_index (but))
			window_rectangle := window_rect
			b := bar
			Result := b.window_rect.top + 
			((b.window_rect.height - button_rectangle.height)//2) - 1
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
			cwin_show_window (bar.item, cmd_show)
		end

feature {EV_ANY_I}

	interface: EV_TOOL_BAR

end -- class EV_TOOL_BAR_IMP

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

