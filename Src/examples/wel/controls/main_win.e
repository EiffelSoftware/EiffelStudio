class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			on_menu_command,
			on_accelerator_command,
			on_vertical_scroll_control,
			on_horizontal_scroll_control,
			closeable,
			class_icon
		end

	WEL_SB_CONSTANTS
		export
			{NONE} all
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Make the main window
		do
			make_top (Title)
			resize (590, 360)
			set_menu (main_menu)
		end

feature -- Access
	
	list_box: WEL_SINGLE_SELECTION_LIST_BOX

	list_box_mul: WEL_MULTIPLE_SELECTION_LIST_BOX

	combo_box: WEL_DROP_DOWN_LIST_COMBO_BOX

	edit: WEL_SINGLE_LINE_EDIT

	multi_edit: WEL_MULTIPLE_LINE_EDIT

	static: WEL_STATIC

	button: WEL_PUSH_BUTTON

	scroll_bar: WEL_SCROLL_BAR

	radio1, radio2: WEL_RADIO_BUTTON

	bcheck1, bcheck2: WEL_CHECK_BOX

	group1, group2: WEL_GROUP_BOX

	list_box_item_num: INTEGER

	list_box_mul_item_num: INTEGER

	combo_box_item_num: INTEGER

	vertical_scroll_bar: BOOLEAN

feature {NONE} -- Implementation

	on_vertical_scroll_control (scroll_code, position: INTEGER;
			bar: WEL_SCROLL_BAR) is
		do
			bar.on_scroll (scroll_code, position)
			static.set_text (bar.position.out)
		end

	on_horizontal_scroll_control (scroll_code, position: INTEGER;
			bar: WEL_SCROLL_BAR) is
		do
			bar.on_scroll (scroll_code, position)
			static.set_text (bar.position.out)
		end

	on_menu_command (menu_id: INTEGER) is
		do
			inspect
				menu_id
			when Cmd_exit then
				if closeable then
					destroy
				end
			when Cmd_list_box_create then
				menu_list_box_create
			when Cmd_list_box_delete then
				menu_list_box_delete
			when Cmd_list_box_add_item then
				menu_list_box_add_item
			when Cmd_list_box_count_item then
				menu_list_box_count_item
			when Cmd_list_box_current_item then
				menu_list_box_current_item
			when Cmd_mul_create then
				menu_mul_create
			when Cmd_mul_delete then
				menu_mul_delete
			when Cmd_mul_add_item then
				menu_mul_add_item
			when Cmd_mul_count_item then
				menu_mul_count_item
			when Cmd_mul_current_item then
				menu_mul_current_item
			when Cmd_combo_box_create then
				menu_combo_box_create
			when Cmd_combo_box_delete then
				menu_combo_box_delete
			when Cmd_combo_box_add_item then
				menu_combo_box_add_item
			when Cmd_combo_box_count_item then
				menu_combo_box_count_item
			when Cmd_combo_box_current_item then
				menu_combo_box_current_item
			when Cmd_combo_box_show_list then
				menu_combo_show_list
			when Cmd_combo_box_hide_list then
				menu_combo_hide_list
			when Cmd_edit_create then
				menu_edit_create
			when Cmd_edit_delete then
				menu_edit_delete
			when Cmd_edit_set_text then
				menu_edit_set_text
			when Cmd_edit_clear_text then
				menu_edit_clear_text
			when Cmd_edit_text_length then
				menu_edit_text_length
			when Cmd_edit_current_text then
				menu_edit_current_text
			when Cmd_multi_edit_create then
				menu_multi_edit_create
			when Cmd_multi_edit_delete then
				menu_multi_edit_delete
			when Cmd_multi_edit_set_text then
				menu_multi_edit_set_text
			when Cmd_multi_edit_clear_text then
				menu_multi_edit_clear_text
			when Cmd_multi_edit_text_length then
				menu_multi_edit_text_length
			when Cmd_multi_edit_current_text then
				menu_multi_edit_current_text
			when Cmd_button_create then
				menu_button_create
			when Cmd_button_delete then
				menu_button_delete
			when Cmd_button_enable then
				menu_button_enable
			when Cmd_button_disable then
				menu_button_disable
			when Cmd_scroll_bar_delete then
				menu_scroll_bar_delete
			when Cmd_scroll_bar_set_vertical then
				menu_scroll_bar_set_vertical
			when Cmd_scroll_bar_set_horizontal then
				menu_scroll_bar_set_horizontal
			when Cmd_radio_create then
				menu_radio_create
			when Cmd_radio_delete then
				menu_radio_delete
			when Cmd_radio_state then
				menu_radio_state
			when Cmd_check_create then
				menu_check_create
			when Cmd_check_delete then
				menu_check_delete
			when Cmd_check_state then
				menu_check_state
			else
			end
		end

	on_accelerator_command (accelerator_id: INTEGER) is
		do
			on_menu_command (accelerator_id)
		end

	closeable: BOOLEAN is
		do
			Result := message_box ("Do you want to exit?", "Exit",
				Mb_yesno + Mb_iconquestion) = Idyes
		end

	text_info: STRING is
		once
			!! Result.make (20)
		ensure
			result_not_void: Result /= Void
		end

	main_menu: WEL_MENU is
		once
			!! Result.make_by_id (Id_menu_application)
			menu_start
		end

	list_box_menu: WEL_MENU is
		once
			Result := main_menu.popup_menu (0)
		end

	list_box_mul_menu: WEL_MENU is
		once
			Result := main_menu.popup_menu (1)
		end

	combo_box_menu: WEL_MENU is
		once
			Result := main_menu.popup_menu (2)
		end

	edit_menu: WEL_MENU is
		once
			Result := main_menu.popup_menu (3)
		end

	multi_edit_menu: WEL_MENU is
		once
			Result := main_menu.popup_menu (4)
		end

	button_menu: WEL_MENU is
		once
			Result := main_menu.popup_menu (5)
		end

	scroll_bar_menu: WEL_MENU is
		once
			Result := main_menu.popup_menu (6)
		end

	radio_menu: WEL_MENU is
		once
			Result := main_menu.popup_menu (7)
		end

	check_menu: WEL_MENU is
		once
			Result := main_menu.popup_menu (8)
		end

	scroll_bar_sub_menu: WEL_MENU is
		once
			Result := scroll_bar_menu.popup_menu (0)
		end

	class_icon: WEL_ICON is
		once
			!! Result.make_by_id (Id_ico_application)
		end

	menu_start is
		do
			list_box_menu.disable_item (Cmd_list_box_delete)
			list_box_menu.disable_item (Cmd_list_box_add_item)
			list_box_menu.disable_item (Cmd_list_box_count_item)
			list_box_menu.disable_item (Cmd_list_box_current_item)
			list_box_mul_menu.disable_item (Cmd_mul_delete)
			list_box_mul_menu.disable_item (Cmd_mul_add_item)
			list_box_mul_menu.disable_item (Cmd_mul_count_item)
			list_box_mul_menu.disable_item (Cmd_mul_current_item)
			combo_box_menu.disable_item (Cmd_combo_box_delete)
			combo_box_menu.disable_item (Cmd_combo_box_add_item)
			combo_box_menu.disable_item (Cmd_combo_box_count_item)
			combo_box_menu.disable_item (Cmd_combo_box_current_item)
			combo_box_menu.disable_item (Cmd_combo_box_show_list)
			combo_box_menu.disable_item (Cmd_combo_box_hide_list)
			button_menu.disable_item (Cmd_button_delete)
			button_menu.disable_item (Cmd_button_enable)
			button_menu.disable_item (Cmd_button_disable)
			edit_menu.disable_item (Cmd_edit_delete)
			edit_menu.disable_item (Cmd_edit_set_text)
			edit_menu.disable_item (Cmd_edit_clear_text)
			edit_menu.disable_item (Cmd_edit_text_length)
			edit_menu.disable_item (Cmd_edit_current_text)
			multi_edit_menu.disable_item (Cmd_multi_edit_delete)
			multi_edit_menu.disable_item (Cmd_multi_edit_set_text)
			multi_edit_menu.disable_item (Cmd_multi_edit_clear_text)
			multi_edit_menu.disable_item (Cmd_multi_edit_text_length)
			multi_edit_menu.disable_item (Cmd_multi_edit_current_text)
			scroll_bar_menu.disable_item (Cmd_scroll_bar_delete)
			radio_menu.disable_item (Cmd_radio_delete)
			radio_menu.disable_item (Cmd_radio_state)
			check_menu.disable_item (Cmd_check_delete)
			check_menu.disable_item (Cmd_check_state)
		end

	menu_list_box_create is
		do
			list_box_item_num := 0
			!! list_box.make (Current, 10, 100, 100, 200, -1)
			list_box_menu.disable_item (Cmd_list_box_create)
			list_box_menu.disable_item (Cmd_list_box_current_item)
			list_box_menu.enable_item (Cmd_list_box_add_item)
			list_box_menu.enable_item (Cmd_list_box_delete)
			list_box_menu.enable_item (Cmd_list_box_count_item)
		end

	menu_list_box_delete is
		do
			list_box.destroy
			list_box_menu.enable_item (Cmd_list_box_create)
			list_box_menu.disable_item (Cmd_list_box_delete)
			list_box_menu.disable_item (Cmd_list_box_add_item)
			list_box_menu.disable_item (Cmd_list_box_count_item)
			list_box_menu.disable_item (Cmd_list_box_current_item)
		end

	menu_list_box_add_item is
		do
			list_box_menu.enable_item (Cmd_list_box_current_item)
			text_info.wipe_out
			text_info.append ("Item ")
			text_info.append_integer (list_box_item_num)
			list_box.add_string (text_info)
			list_box_item_num := list_box_item_num + 1
		end

	menu_list_box_count_item is
		do
			text_info.wipe_out
			text_info.append_integer (list_box.count)
			if list_box.count > 1 then
				text_info.append (" items are present.")
			else
				text_info.append (" item is present.")
			end
			information_message_box (text_info, "Count item")
		end

	menu_list_box_current_item is
		do
			if list_box.selected then
				text_info.wipe_out
				text_info.append (list_box.selected_string)
				text_info.append (" is selected.")
				information_message_box (text_info, "Current item")
			else
				error_message_box ("No item selected.")
			end
		end

	menu_mul_create is
		do
			list_box_mul_item_num := 0
			!! list_box_mul.make (Current, 116, 100, 100, 200, -1)
			list_box_mul_menu.disable_item (Cmd_mul_create)
			list_box_mul_menu.disable_item (Cmd_mul_current_item)
			list_box_mul_menu.enable_item (Cmd_mul_add_item)
			list_box_mul_menu.enable_item (Cmd_mul_delete)
			list_box_mul_menu.enable_item (Cmd_mul_count_item)
		end

	menu_mul_delete is
		do
			list_box_mul.destroy
			list_box_mul_menu.enable_item (Cmd_mul_create)
			list_box_mul_menu.disable_item (Cmd_mul_delete)
			list_box_mul_menu.disable_item (Cmd_mul_add_item)
			list_box_mul_menu.disable_item (Cmd_mul_count_item)
			list_box_mul_menu.disable_item (Cmd_mul_current_item)
		end

	menu_mul_add_item is
		do
			list_box_mul_menu.enable_item (Cmd_mul_current_item)
			text_info.wipe_out
			text_info.append ("Item ")
			text_info.append_integer (list_box_mul_item_num)
			list_box_mul.add_string (text_info)
			list_box_mul_item_num := list_box_mul_item_num + 1
		end

	menu_mul_count_item is
		do
			text_info.wipe_out
			text_info.append_integer (list_box_mul.count)
			if list_box_mul.count > 1 then
				text_info.append (" items are present.")
			else
				text_info.append (" item is present.")
			end
			information_message_box (text_info, "Count item")
		end

	menu_mul_current_item is
		local
			i: INTEGER
			array_items: ARRAY [STRING]
		do
			if list_box_mul.count_selected_items > 0 then
				text_info.wipe_out
				array_items := list_box_mul.selected_strings
				from
					i := array_items.lower
				until
					i = array_items.count
				loop
					text_info.append (array_items.item (i))
					i := i + 1
					if i /= array_items.count then
						text_info.append (", ")
					end
				end
				if list_box_mul.count_selected_items > 1 then
					text_info.append (" are selected.")
				else
					text_info.append (" is selected.")
				end
				information_message_box (text_info, "Current item")
			else
				error_message_box ("No item selected.")
			end
		end

	menu_combo_box_create is
		do
			combo_box_item_num := 0
			!! combo_box.make (Current, 115, 20, 102, 90, -1)
			combo_box_menu.disable_item (Cmd_combo_box_create)
			combo_box_menu.disable_item (Cmd_combo_box_current_item)
			combo_box_menu.enable_item (Cmd_combo_box_add_item)
			combo_box_menu.enable_item (Cmd_combo_box_delete)
			combo_box_menu.enable_item (Cmd_combo_box_count_item)
			combo_box_menu.enable_item (Cmd_combo_box_show_list)
			combo_box_menu.enable_item (Cmd_combo_box_hide_list)
		end

	menu_combo_box_delete is
		do
			combo_box.hide_list
			combo_box.destroy
			combo_box_menu.enable_item (Cmd_combo_box_create)
			combo_box_menu.disable_item (Cmd_combo_box_delete)
			combo_box_menu.disable_item (Cmd_combo_box_add_item)
			combo_box_menu.disable_item (Cmd_combo_box_count_item)
			combo_box_menu.disable_item (Cmd_combo_box_current_item)
			combo_box_menu.disable_item (Cmd_combo_box_show_list)
			combo_box_menu.disable_item (Cmd_combo_box_hide_list)
		end

	menu_combo_box_add_item is
		do
			combo_box_menu.enable_item (Cmd_combo_box_current_item)
			text_info.wipe_out
			text_info.append ("Item ")
			text_info.append_integer (combo_box_item_num)
			combo_box.add_string (text_info)
			combo_box_item_num := combo_box_item_num + 1
		end

	menu_combo_box_count_item is
		do
			text_info.wipe_out
			text_info.append_integer (combo_box.count)
			if combo_box.count > 1 then
				text_info.append (" items are present.")
			else
				text_info.append (" item is present.")
			end
			information_message_box (text_info, "Count item")
		end

	menu_combo_box_current_item is
		do
			if combo_box.selected then
				text_info.wipe_out
				text_info.append (combo_box.selected_string)
				text_info.append (" is selected.")
				information_message_box (text_info, "Current item")
			else
				error_message_box ("No item selected.")
			end
		end

	menu_combo_show_list is
		do
			combo_box.show_list
		end

	menu_combo_hide_list is
		do
			combo_box.hide_list
		end

	menu_button_create is
		do
			!! button.make (Current, "Button", 10, 20, 100, 50, -1)
			button_menu.disable_item (Cmd_button_create)
			button_menu.enable_item (Cmd_button_delete)
			button_menu.uncheck_item (Cmd_button_enable)
			button_menu.uncheck_item (Cmd_button_disable)
			button_menu.enable_item (Cmd_button_enable)
			button_menu.enable_item (Cmd_button_disable)
			button_menu.check_item (Cmd_button_enable)
		end

	menu_button_delete is
		do
			button.destroy
			button_menu.disable_item (Cmd_button_delete)
			button_menu.disable_item (Cmd_button_enable)
			button_menu.disable_item (Cmd_button_disable)
			button_menu.enable_item (Cmd_button_create)
			button_menu.uncheck_item (Cmd_button_enable)
			button_menu.uncheck_item (Cmd_button_disable)
		end

	menu_button_enable is
		do
			button.enable
			button_menu.check_item (Cmd_button_enable)
			button_menu.uncheck_item (Cmd_button_disable)
		end

	menu_button_disable is
		do
			button.disable
			button_menu.uncheck_item (Cmd_button_enable)
			button_menu.check_item (Cmd_button_disable)
		end

	menu_edit_create is
		do
			!! edit.make (Current, "Edit", 250,
				100, 100, 22, -1)
			edit_menu.disable_item (Cmd_edit_create)
			edit_menu.enable_item (Cmd_edit_delete)
			edit_menu.enable_item (Cmd_edit_set_text)
			edit_menu.enable_item (Cmd_edit_clear_text)
			edit_menu.enable_item (Cmd_edit_text_length)
			edit_menu.enable_item (Cmd_edit_current_text)
		end

	menu_edit_delete is
		do
			edit.destroy
			edit_menu.enable_item (Cmd_edit_create)
			edit_menu.disable_item (Cmd_edit_delete)
			edit_menu.disable_item (Cmd_edit_set_text)
			edit_menu.disable_item (Cmd_edit_clear_text)
			edit_menu.disable_item (Cmd_edit_text_length)
			edit_menu.disable_item (Cmd_edit_current_text)
		end

	menu_edit_set_text is
		do
			edit.set_text ("New text")
		end

	menu_edit_clear_text is
		do
			edit.clear
		end

	menu_edit_text_length is
		do
			text_info.wipe_out
			text_info.append ("The length is ")
			text_info.append_integer (edit.text_length)
			information_message_box (text_info, "Text length")
		end

	menu_edit_current_text is
		do
			information_message_box (edit.text, "Current text")
		end

	menu_multi_edit_create is
		do
			!! multi_edit.make (Current, "Multiple line edit", 250,
				20, 300, 70, -1)
			multi_edit_menu.disable_item (Cmd_multi_edit_create)
			multi_edit_menu.enable_item (Cmd_multi_edit_delete)
			multi_edit_menu.enable_item (Cmd_multi_edit_set_text)
			multi_edit_menu.enable_item (Cmd_multi_edit_clear_text)
			multi_edit_menu.enable_item (Cmd_multi_edit_text_length)
			multi_edit_menu.enable_item (Cmd_multi_edit_current_text)
		end

	menu_multi_edit_delete is
		do
			multi_edit.destroy
			multi_edit_menu.enable_item (Cmd_multi_edit_create)
			multi_edit_menu.disable_item (Cmd_multi_edit_delete)
			multi_edit_menu.disable_item (Cmd_multi_edit_set_text)
			multi_edit_menu.disable_item (Cmd_multi_edit_clear_text)
			multi_edit_menu.disable_item (Cmd_multi_edit_text_length)
			multi_edit_menu.disable_item (Cmd_multi_edit_current_text)
		end

	menu_multi_edit_set_text is
		do
			multi_edit.set_text ("New text")
		end

	menu_multi_edit_clear_text is
		do
			multi_edit.clear
		end

	menu_multi_edit_text_length is
		do
			text_info.wipe_out
			text_info.append ("The length is ")
			text_info.append_integer (multi_edit.text_length)
			information_message_box (text_info, "Text length")
		end

	menu_multi_edit_current_text is
		do
			information_message_box (multi_edit.text, "Current text")
		end

	menu_scroll_bar_create is
		do
			!! static.make (Current, "static", 250, 270,
				30, 20, -1)
			if vertical_scroll_bar then
				!! scroll_bar.make_vertical (Current, 250, 170,
					20, 100, -1)
			else
				!! scroll_bar.make_horizontal (Current, 250,
					250, 100, 20, -1)
			end
			scroll_bar_menu.enable_item (Cmd_scroll_bar_delete)
			scroll_bar_sub_menu.disable_item (Cmd_scroll_bar_set_vertical)
			scroll_bar_sub_menu.disable_item (Cmd_scroll_bar_set_horizontal)
			scroll_bar.set_range (0, 100)
			scroll_bar.set_position (50)
			text_info.wipe_out
			text_info.append_integer (scroll_bar.position)
			static.set_text (text_info)
		end

	menu_scroll_bar_delete is
		do
			static.destroy
			scroll_bar.destroy
			scroll_bar_menu.disable_item (Cmd_scroll_bar_delete)
			scroll_bar_sub_menu.enable_item (Cmd_scroll_bar_set_vertical)
			scroll_bar_sub_menu.enable_item (Cmd_scroll_bar_set_horizontal)
		end

	menu_scroll_bar_set_vertical is
		do
			vertical_scroll_bar := True
			menu_scroll_bar_create
		end

	menu_scroll_bar_set_horizontal is
		do
			vertical_scroll_bar := False
			menu_scroll_bar_create
		end

	menu_radio_create is
		do
			!! group1.make (Current, "Group box", 380, 90, 85, 70, -1)
			!! radio1.make (Current, "Radio1", 390, 110, 65, 20, -1)
			!! radio2.make (Current, "Radio2", 390, 130, 65, 20, -1)
			radio_menu.enable_item (Cmd_radio_delete)
			radio_menu.enable_item (Cmd_radio_state)
			radio_menu.disable_item (Cmd_radio_create)
		end

	menu_radio_delete is
		do
			radio1.destroy
			radio2.destroy
			group1.destroy
			radio_menu.disable_item (Cmd_radio_delete)
			radio_menu.disable_item (Cmd_radio_state)
			radio_menu.enable_item (Cmd_radio_create)
		end

	menu_radio_state is
		do
			text_info.wipe_out
			text_info.append (radio1.text)
			text_info.append (" is ")
			if radio1.checked then
				text_info.append ("checked.%N")
			else
				text_info.append ("unchecked.%N")
			end
			text_info.append (radio2.text)
			text_info.append (" is ")
			if radio2.checked then
				text_info.append ("checked.")
			else
				text_info.append ("unchecked.")
			end
			information_message_box (text_info, "State")
		end

	menu_check_create is
		do
			!! group2.make (Current, "Group box", 380, 180, 85, 70, -1)
			!! bcheck1.make (Current, "Check1", 390, 200, 65, 20, -1)
			!! bcheck2.make (Current, "Check2", 390, 220, 65, 20, -1)
			check_menu.enable_item (Cmd_check_delete)
			check_menu.enable_item (Cmd_check_state)
			check_menu.disable_item (Cmd_check_create)
		end

	menu_check_delete is
		do
			bcheck1.destroy
			bcheck2.destroy
			group2.destroy
			check_menu.disable_item (Cmd_check_delete)
			check_menu.disable_item (Cmd_check_state)
			check_menu.enable_item (Cmd_check_create)
		end

	menu_check_state is
		do
			text_info.wipe_out
			text_info.append (bcheck1.text)
			text_info.append (" is ")
			if bcheck1.checked then
				text_info.append ("checked.%N")
			else
				text_info.append ("unchecked.%N")
			end
			text_info.append (bcheck2.text)
			text_info.append (" is ")
			if bcheck2.checked then
				text_info.append ("checked.")
			else
				text_info.append ("unchecked.")
			end
			information_message_box (text_info, "State")
		end

	Title: STRING is "WEL Controls"
			-- Window's title

end -- class MAIN_WINDOW

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
