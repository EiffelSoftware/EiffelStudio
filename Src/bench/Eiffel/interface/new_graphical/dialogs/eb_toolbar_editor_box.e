indexing
	description	: "A dialog box that allows the user to customize a toolbar%
				  %Call `customize' each time a toolbar must be edited"
	author		: "Xavier Rousselot"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_TOOLBAR_EDITOR_BOX

inherit
	EV_DIALOG

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	make

feature -- Initialization

	make is
		do
			make_with_title (Interface_names.t_Customize_toolbar_text)
			w_width := Layout_constants.dialog_unit_to_pixels(560)
			w_height := Layout_constants.dialog_unit_to_pixels(360)
			close_request_actions.wipe_out
			close_request_actions.extend (~exit)
			prepare
			create final_toolbar.make (20)
		end

	prepare is
			-- Initialize world.
		local
			list_container1: EV_VERTICAL_BOX
			list_container2: EV_VERTICAL_BOX
			central_button_container: EV_VERTICAL_BOX
			right_button_container: EV_VERTICAL_BOX
			main_container: EV_VERTICAL_BOX
			square_container: EV_HORIZONTAL_BOX
			pool_label: EV_LABEL
			current_label: EV_LABEL
			combo_strings: ARRAY [STRING]
			text_combo_box: EV_HORIZONTAL_BOX
			color_combo_box: EV_HORIZONTAL_BOX
			text_combo_label: EV_LABEL
			color_combo_label: EV_LABEL
			widget_minimum_width: INTEGER
		do
				-- Create the containers
			create list_container1
			create list_container2
			create central_button_container
			create right_button_container
			create square_container
			create main_container

			create pool_list.make (True)
			pool_list.drop_actions.extend (~move_to_pool_list)
			pool_list.disable_multiple_selection
			pool_list.select_actions.extend (~on_pool_select)
			pool_list.deselect_actions.extend (~on_pool_deselect)
			create current_list.make (False)
			current_list.drop_actions.extend (~move_to_current_list)
			current_list.disable_multiple_selection
			current_list.select_actions.extend (~on_current_select)
			current_list.deselect_actions.extend (~on_current_deselect)

			create combo_strings.make (1,2)
			combo_strings.put (Interface_names.l_Put_text_right_text, 1)
			combo_strings.put (Interface_names.l_No_text_text, 2)
			create text_combo.make_with_strings (combo_strings)
			create text_combo_label.make_with_text (Interface_names.l_Toolbar_select_text_position)
			create text_combo_box
			text_combo_box.set_padding (Layout_constants.Small_padding_size)
			text_combo_box.extend (text_combo_label)
			text_combo_box.disable_item_expand (text_combo_label)
			text_combo_box.extend (text_combo)
			text_combo.disable_edit

			create combo_strings.make (1,2)
			combo_strings.put (Interface_names.l_Toolbar_with_gray_icons, 1)
			combo_strings.put (Interface_names.l_Toolbar_without_gray_icons, 2)
			create color_combo.make_with_strings (combo_strings)
			create color_combo_label.make_with_text (Interface_names.l_Toolbar_select_has_gray_icons)
			create color_combo_box
			color_combo_box.set_padding (Layout_constants.Small_padding_size)
				--| FIXME XR: When someone wants flashing icons , uncomment these lines.
--			color_combo_box.extend (color_combo_label)
--			color_combo_box.disable_item_expand (color_combo_label)
--			color_combo_box.extend (color_combo)
--			color_combo.disable_edit

			widget_minimum_width := text_combo_label.minimum_width.max (color_combo_label.minimum_width)
			color_combo_label.set_minimum_width (widget_minimum_width)
			text_combo_label.set_minimum_width (widget_minimum_width)

			create pool_label.make_with_text (Interface_names.l_Available_buttons_text)
			pool_label.align_text_left
			create current_label.make_with_text (Interface_names.l_Displayed_buttons_text)
			current_label.align_text_left

			create add_button.make_with_text (Interface_names.b_Add_text)
			add_button.select_actions.extend (~add_to_displayed)
			Layout_constants.set_default_size_for_button (add_button)
			add_button.disable_sensitive
			create remove_button.make_with_text (Interface_names.b_Remove_text)
			Layout_constants.set_default_size_for_button (remove_button)
			remove_button.select_actions.extend (~remove_from_displayed)
			remove_button.disable_sensitive
			create up_button.make_with_text (Interface_names.b_Up_text)
			Layout_constants.set_default_size_for_button (up_button)
			up_button.select_actions.extend (~move_up)
			up_button.disable_sensitive
			create down_button.make_with_text (Interface_names.b_Down_text)
			Layout_constants.set_default_size_for_button (down_button)
			down_button.select_actions.extend (~move_down)
			down_button.disable_sensitive
			create ok_button.make_with_text (Interface_names.b_Ok_text)
			Layout_constants.set_default_size_for_button (ok_button)
			ok_button.select_actions.extend (~generate_toolbar)
			ok_button.select_actions.extend (~exit)
			create cancel_button.make_with_text (Interface_names.b_Cancel_text)
			cancel_button.select_actions.extend (~exit)
			Layout_constants.set_default_size_for_button (cancel_button)

			list_container1.set_padding (Layout_constants.Small_border_size)
			list_container1.extend (pool_label)
			list_container1.disable_item_expand (pool_label)
			list_container1.extend (pool_list)

			list_container2.set_padding (Layout_constants.Small_border_size)
			list_container2.extend (current_label)
			list_container2.disable_item_expand (current_label)
			list_container2.extend (current_list)

			central_button_container.set_padding (Layout_constants.Small_padding_size)
			central_button_container.set_border_width (Layout_constants.Default_border_size)
			central_button_container.extend (create {EV_CELL})
			central_button_container.extend (add_button)
			central_button_container.disable_item_expand (add_button)
			central_button_container.extend (remove_button)
			central_button_container.disable_item_expand (remove_button)
			central_button_container.extend (create {EV_CELL})

			right_button_container.set_padding (Layout_constants.Small_padding_size)
			right_button_container.set_border_width (Layout_constants.Default_border_size)
			right_button_container.extend (ok_button)
			right_button_container.disable_item_expand (ok_button)
			right_button_container.extend (cancel_button)
			right_button_container.disable_item_expand (cancel_button)
			right_button_container.extend (create {EV_CELL})
			right_button_container.extend (up_button)
			right_button_container.disable_item_expand (up_button)
			right_button_container.extend (down_button)
			right_button_container.disable_item_expand (down_button)

			square_container.extend (list_container1)
			square_container.extend (central_button_container)
			square_container.disable_item_expand (central_button_container)
			square_container.extend (list_container2)
			square_container.extend (right_button_container)
			square_container.disable_item_expand (right_button_container)

			main_container.set_padding (Layout_constants.Default_padding_size)
			main_container.set_border_width (Layout_constants.Default_border_size) 
			main_container.extend (square_container)
			main_container.extend (text_combo_box)
			main_container.disable_item_expand (text_combo_box)
			main_container.extend (color_combo_box)
			main_container.disable_item_expand (color_combo_box)

				-- Add widgets to our window
			extend (main_container)

			set_default_cancel_button (cancel_button)
			set_default_push_button (ok_button)
		end

	customize_toolbar (a_parent: EV_WINDOW; gray_icons: BOOLEAN; text_displayed: BOOLEAN; toolbar: ARRAYED_LIST [EB_TOOLBARABLE]) is
			-- Reload the dialog box with available buttons found in `toolbar'
			-- and set `is_text_displayed' to `text_displayed'.
			-- `toolbar' is a list of separators and commands that represents both
			--  * the current aspect of the toolbar
			-- 	* the pool of controls available
		do
			is_text_displayed := text_displayed
			has_gray_icons := gray_icons
			fill_lists (toolbar)
			if text_displayed then
				text_combo.first.enable_select
			else
				text_combo.start
				text_combo.forth
				text_combo.item.enable_select
			end -- if
			if has_gray_icons then
				color_combo.set_text (Interface_names.l_Toolbar_with_gray_icons)
			else
				color_combo.set_text (Interface_names.l_Toolbar_without_gray_icons)
			end
			valid_data := False
			set_width (w_width)
			set_height (w_height)
			show_modal_to_window (a_parent)
		end

feature -- Result

	valid_data: BOOLEAN
			-- Is the content of `is_text_displayed' and `final_toolbar' up-to-date?
			-- (which might not be the case if the user clicked Cancel)

	is_text_displayed: BOOLEAN
			-- Should text be printed next to toolbar buttons?

	has_gray_icons: BOOLEAN
			-- Should gray icons be displayed?

	final_toolbar: ARRAYED_LIST [EB_TOOLBARABLE]
			-- list containing the buttons to be displayed and then the ones in the pool

feature {NONE} -- Graphical interface
	
	pool_list: EB_CUSTOM_TOOLBAR_LIST -- EV_LIST
			-- list containing the whole pool of buttons (+ a separator at the beginning)

	current_list: EB_CUSTOM_TOOLBAR_LIST -- EV_LIST
			-- list containing the buttons and the separators to be displayed

	add_button: EV_BUTTON
			-- button labeled "Add"

	remove_button: EV_BUTTON
			-- button labeled "Remove"

	up_button: EV_BUTTON
			-- button labeled "Up"

	down_button: EV_BUTTON
			-- button labeled "Down"

	ok_button: EV_BUTTON
			-- button labeled "Ok"

	cancel_button: EV_BUTTON
			-- button labeled "Cancel"

	text_combo: EV_COMBO_BOX
			-- box to select whether text is displayed on the right of buttons
			-- or not.

	color_combo: EV_COMBO_BOX
			-- box to select whether icons are displayed in gray or not.

	w_height: INTEGER
			-- current height of the window. 
			--
			-- Useful only because Vision2 currently does not remember the size
			-- of the window after a hide/show.

	w_width: INTEGER
			-- current width of the window. 
			--
			-- Useful only because Vision2 currently does not remember the size
			-- of the window after a hide/show.

feature {NONE} -- Button actions

	generate_toolbar is
			-- Generate a "toolbar" in `final_toolbar' from the user input
			-- and set `is_text_displayed'
		local
			cur: EB_CUSTOMIZABLE_LIST_ITEM
			cmd: EB_TOOLBARABLE_COMMAND
		do
			is_text_displayed := text_combo.text.is_equal (Interface_names.l_Put_text_right_text)
			has_gray_icons := color_combo.text.is_equal (Interface_names.l_Toolbar_with_gray_icons)

			final_toolbar.wipe_out
			from
				current_list.start
			until
				current_list.after
			loop
					-- Copy the content of current_list to final_toolbar
				cur := current_list.customizable_item
				cmd ?= cur.data
				if cmd /= Void then
					cmd.enable_displayed
					final_toolbar.extend (cmd)
				else
					final_toolbar.extend (cur.data)
				end
				current_list.forth
			end -- loop

			from
				pool_list.start
				pool_list.forth -- To avoid copying the initial Separator
			until
				pool_list.after
			loop
					-- Copy the content of pool_list to final_toolbar
				cur := pool_list.customizable_item
				cmd ?= cur.data
				if cmd /= Void then
					cmd.disable_displayed
					final_toolbar.extend (cmd)
				else
					final_toolbar.extend (cur.data)
				end
				pool_list.forth
			end -- loop
			valid_data := True
		end

	exit is
			-- Hide the current window
		do
			w_width := width
			w_height := height
			destroy
		end

	add_to_displayed is
			-- Move the currently selected button from the pool to the displayed buttons
		local
			sel: EB_CUSTOMIZABLE_LIST_ITEM
			sel2: EB_CUSTOMIZABLE_LIST_ITEM
		do
			sel := pool_list.customizable_selected_item
			if sel /= Void then
				if not sel.is_separator then
					pool_list.start
					pool_list.prune (sel)
				else
					create sel.make (create {EB_TOOLBARABLE_SEPARATOR})
					set_up_events (sel)
				end -- if
				sel2 := current_list.customizable_selected_item
				if  sel2 /= Void then
					current_list.start
					current_list.search (sel2)
					current_list.put_right (sel)
				else
					current_list.put_front (sel)
				end -- if
				sel.enable_select
			end -- if
		end

	remove_from_displayed is
			-- Move the currently selected button from the pool to the displayed buttons
		local
			sel: EB_CUSTOMIZABLE_LIST_ITEM
			sel2: EB_CUSTOMIZABLE_LIST_ITEM
		do
			sel := current_list.customizable_selected_item
			if sel /= Void then
				current_list.start
				current_list.prune (sel)
				if (not sel.is_separator) then
					sel2 := pool_list.customizable_selected_item
					if  sel2 /= Void then
						pool_list.start
						pool_list.search (sel2)
						pool_list.put_right (sel)
					else
						pool_list.extend (sel)
					end -- if
					sel.enable_select
				end -- if
			end -- if
		end

	move_up is
			-- Move the currently selected button one position up in `current_list'
		local
			sel: EB_CUSTOMIZABLE_LIST_ITEM
		do
			moving := True
			sel := current_list.customizable_selected_item
			if sel /= Void then
				current_list.start
				current_list.search (sel)
				if not current_list.isfirst then
					current_list.remove
					current_list.back
					current_list.put_left (sel)
					sel.enable_select
				end
			end
			moving := False
		end

	move_down is
			-- Move the currently selected button one position down in `current_list'
		local
			sel: EB_CUSTOMIZABLE_LIST_ITEM
		do
			moving := True
			sel := current_list.customizable_selected_item
			if sel /= Void then
				current_list.start
				current_list.search (sel)
				if not current_list.islast then
					current_list.remove
					current_list.put_right (sel)
					sel.enable_select
				end
			end
			moving := False
		end

feature {NONE} -- Actions performed by agents like graying buttons

	moving: BOOLEAN
			-- flag set when moving an item up or down to avoid graying buttons unnecessarily

	on_pool_select (an_item: EB_CUSTOMIZABLE_LIST_ITEM) is
			-- Called when the user clicks the pool list
		do
			if (not add_button.is_sensitive) then
				add_button.enable_sensitive
			end -- if
		end

	on_pool_deselect (an_item: EB_CUSTOMIZABLE_LIST_ITEM) is
			-- Called when the user deselects an item of the pool list
		do
			if add_button.is_sensitive then
				add_button.disable_sensitive
			end -- if
		end

	on_current_select (an_item: EB_CUSTOMIZABLE_LIST_ITEM) is
			-- Called when the user clicks the current list
		do
			if (not remove_button.is_sensitive) then
				remove_button.enable_sensitive
				up_button.enable_sensitive
				down_button.enable_sensitive
			end -- if
		end

	on_current_deselect (an_item: EB_CUSTOMIZABLE_LIST_ITEM) is
			-- Called when the user deselects an item of the current list
		do
			if (not moving) 
				and then remove_button.is_sensitive
			then
				remove_button.disable_sensitive
				up_button.disable_sensitive
				down_button.disable_sensitive
			end -- if
		end

	move_to_pool_list (an_item: EB_CUSTOMIZABLE_LIST_ITEM) is
		do
			if an_item.parent /= Void then
				if not an_item.is_separator then
					an_item.parent.start
					an_item.parent.prune (an_item)
					pool_list.extend (an_item)
				elseif (not an_item.custom_parent.is_a_pool_list) then
					an_item.parent.start
					an_item.parent.prune (an_item)
				end
			end
		end

	move_to_current_list (an_item: EB_CUSTOMIZABLE_LIST_ITEM) is
		do
			if an_item.parent /= Void then
				if (not an_item.is_separator) or else (not an_item.custom_parent.is_a_pool_list) then
					an_item.parent.start
					an_item.parent.prune (an_item)
					current_list.extend (an_item)
				else
					current_list.extend (create {EB_CUSTOMIZABLE_LIST_ITEM}.make (create {EB_TOOLBARABLE_SEPARATOR}))
					set_up_events (an_item)
				end
			end
		end

	mouse_move (li: EB_CUSTOMIZABLE_LIST_ITEM; xi, yi, b: INTEGER; xf, yf, p: DOUBLE; ax, ay: INTEGER) is
			-- Move `li' to the other list.
			--| Assumption: `li' is selected.
		do
			if li.custom_parent = current_list then
				remove_from_displayed
			else
				add_to_displayed
			end
		end

feature {NONE} -- Internal data

	set_up_events (it: EB_CUSTOMIZABLE_LIST_ITEM) is
			-- Set up the double_click actions and the drop actions of `it'.
		require
			valid_it: it /= Void
		do
			it.pointer_double_press_actions.extend (~mouse_move (it, ?, ?, ?, ?, ?, ?, ?, ?))
			it.drop_actions.extend (~drop2 (?, it))
		end

	drop2 (src, dst: EB_CUSTOMIZABLE_LIST_ITEM) is
			-- `src' was dropped onto `dst'.
			-- Set up events for `src' if it is a newly created separator. (Eww how ugly...)
		local
			conv_cust: EB_CUSTOMIZABLE_LIST_ITEM
		do
			if
				src.is_separator and then
				src.custom_parent.is_a_pool_list and then
				not dst.custom_parent.is_a_pool_list
			then
					-- `dst' must have added a new separator after itself.
				dst.parent.start
				dst.parent.search (dst)
				dst.parent.forth
				conv_cust ?= dst.parent.item
				if conv_cust /= Void then
					set_up_events (conv_cust)
				end
			end
		end

	fill_lists (toolbar: ARRAYED_LIST[EB_TOOLBARABLE]) is
			-- Fill in `pool_list' and `current_list' with the pool and the toolbar
		require
			toolbar_non_void: toolbar /= Void
		local
			n: EB_CUSTOMIZABLE_LIST_ITEM
			nc: EB_TOOLBARABLE_COMMAND
		do
			pool_list.wipe_out
			current_list.wipe_out
			create n.make (create {EB_TOOLBARABLE_SEPARATOR})
			n.pointer_double_press_actions.extend (~mouse_move (n, ?, ?, ?, ?, ?, ?, ?, ?))
			pool_list.extend (n)
			from
				toolbar.start
			until
				toolbar.after
			loop
				create n.make (toolbar.item)
				set_up_events (n)
				if n.is_separator then
					current_list.extend (n)
				else
					nc ?= toolbar.item
					if nc /= Void then
						if nc.is_displayed then
							current_list.extend (n)
						else
							pool_list.extend (n)
						end -- if
					end -- if
				end -- if
				toolbar.forth
			end -- loop
		end

end -- class TOOLBAR_EDITOR_BOX
