note
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			background_brush
		end

	WEL_SB_CONSTANTS
		export
			{NONE} all
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Make the main window
		do
			make_top (Title)
			resize (590, 360)
			set_menu (main_menu)
		end

feature -- Access

	list_box: ?WEL_SINGLE_SELECTION_LIST_BOX

	list_box_mul: ?WEL_MULTIPLE_SELECTION_LIST_BOX

	combo_box: ?WEL_DROP_DOWN_LIST_COMBO_BOX

	edit: ?WEL_SINGLE_LINE_EDIT

	multi_edit: ?WEL_MULTIPLE_LINE_EDIT

	static: ?WEL_STATIC

	button: ?WEL_PUSH_BUTTON

	scroll_bar: ?WEL_SCROLL_BAR

	radio1, radio2: ?WEL_RADIO_BUTTON

	bcheck1, bcheck2: ?WEL_CHECK_BOX

	group1, group2: ?WEL_GROUP_BOX

	list_box_item_num: INTEGER

	list_box_mul_item_num: INTEGER

	combo_box_item_num: INTEGER

	vertical_scroll_bar: BOOLEAN

	background_brush: WEL_BRUSH
			-- Dialog boxes background color is the same than
			-- button color.
		do
			create Result.make_by_sys_color (Color_btnface + 1)
		end

feature {NONE} -- Implementation

	on_vertical_scroll_control (scroll_code, position: INTEGER; bar: WEL_BAR)
		do
			if {l_scroll_bar: like scroll_bar} bar and then {l_static: like static} static then
				l_scroll_bar.on_scroll (scroll_code, position)
				l_static.set_text (l_scroll_bar.position.out)
			end
		end

	on_horizontal_scroll_control (scroll_code, position: INTEGER; bar: WEL_BAR)
		do
			if {l_scroll_bar: like scroll_bar} bar and then {l_static: like static} static then
				l_scroll_bar.on_scroll (scroll_code, position)
				l_static.set_text (l_scroll_bar.position.out)
			end
		end

	on_menu_command (menu_id: INTEGER)
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
			when Cmd_mul_count_selected_item then
				menu_mul_count_selected_item
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

	on_accelerator_command (accelerator_id: INTEGER)
		do
			on_menu_command (accelerator_id)
		end

	closeable: BOOLEAN
		local
			msg_box: WEL_MSG_BOX
		do
			create msg_box.make
			msg_box.question_message_box (Current, "Do you want to exit?", "Exit")
			Result := msg_box.message_box_result = Idyes
		end

	text_info: STRING
		once
			create Result.make (20)
		ensure
			result_not_void: Result /= Void
		end

	main_menu: WEL_MENU
		once
			create Result.make_by_id (Id_menu_application)
			menu_start
		end

	list_box_menu: WEL_MENU
		once
			Result := main_menu.popup_menu (0)
		end

	list_box_mul_menu: WEL_MENU
		once
			Result := main_menu.popup_menu (1)
		end

	combo_box_menu: WEL_MENU
		once
			Result := main_menu.popup_menu (2)
		end

	edit_menu: WEL_MENU
		once
			Result := main_menu.popup_menu (3)
		end

	multi_edit_menu: WEL_MENU
		once
			Result := main_menu.popup_menu (4)
		end

	button_menu: WEL_MENU
		once
			Result := main_menu.popup_menu (5)
		end

	scroll_bar_menu: WEL_MENU
		once
			Result := main_menu.popup_menu (6)
		end

	radio_menu: WEL_MENU
		once
			Result := main_menu.popup_menu (7)
		end

	check_menu: WEL_MENU
		once
			Result := main_menu.popup_menu (8)
		end

	scroll_bar_sub_menu: WEL_MENU
		once
			Result := scroll_bar_menu.popup_menu (0)
		end

	menu_start
		do
			list_box_menu.disable_item (Cmd_list_box_delete)
			list_box_menu.disable_item (Cmd_list_box_add_item)
			list_box_menu.disable_item (Cmd_list_box_count_item)
			list_box_menu.disable_item (Cmd_list_box_current_item)
			list_box_mul_menu.disable_item (Cmd_mul_delete)
			list_box_mul_menu.disable_item (Cmd_mul_add_item)
			list_box_mul_menu.disable_item (Cmd_mul_count_item)
			list_box_mul_menu.disable_item (Cmd_mul_count_selected_item)
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

	menu_list_box_create
		local
			l_list_box: like list_box
		do
			list_box_item_num := 0
			create l_list_box.make (Current, 10, 100, 100, 200, -1)
			list_box := l_list_box
			l_list_box.set_font (gui_font)
			list_box_menu.disable_item (Cmd_list_box_create)
			list_box_menu.disable_item (Cmd_list_box_current_item)
			list_box_menu.enable_item (Cmd_list_box_add_item)
			list_box_menu.enable_item (Cmd_list_box_delete)
			list_box_menu.enable_item (Cmd_list_box_count_item)
		end

	menu_list_box_delete
		do
			if {l_list_box: like list_box} list_box then
				l_list_box.destroy
			end
			list_box_menu.enable_item (Cmd_list_box_create)
			list_box_menu.disable_item (Cmd_list_box_delete)
			list_box_menu.disable_item (Cmd_list_box_add_item)
			list_box_menu.disable_item (Cmd_list_box_count_item)
			list_box_menu.disable_item (Cmd_list_box_current_item)
		end

	menu_list_box_add_item
		do
			list_box_menu.enable_item (Cmd_list_box_current_item)
			text_info.wipe_out
			if {l_list_box: like list_box} list_box then
				text_info.append ("Item ")
				text_info.append_integer (list_box_item_num)
				l_list_box.add_string (text_info)
				list_box_item_num := list_box_item_num + 1
			end
		end

	menu_list_box_count_item
		local
			msg_box: WEL_MSG_BOX
		do
			text_info.wipe_out
			if {l_list_box: like list_box} list_box then
				text_info.append_integer (l_list_box.count)
				if l_list_box.count /= 1 then
					text_info.append (" items are present.")
				else
					text_info.append (" item is present.")
				end
			end
			create msg_box.make
			msg_box.information_message_box (Current, text_info, "Count item")
		end

	menu_list_box_current_item
		local
			msg_box: WEL_MSG_BOX
		do
			if {l_list_box: like list_box} list_box and then l_list_box.selected then
				text_info.wipe_out
				text_info.append (l_list_box.selected_string)
				text_info.append (" is selected.")
			else
				text_info.wipe_out
				text_info.append ("No item selected.")
			end
			create msg_box.make
			msg_box.information_message_box (Current, text_info, "Current item")
		end

	menu_mul_create
		local
			l_list_box_mul: like list_box_mul
		do
			list_box_mul_item_num := 0
			create l_list_box_mul.make (Current, 116, 100, 100, 200, -1)
			list_box_mul := l_list_box_mul
			l_list_box_mul.set_font (gui_font)
			list_box_mul_menu.disable_item (Cmd_mul_create)
			list_box_mul_menu.disable_item (Cmd_mul_current_item)
			list_box_mul_menu.enable_item (Cmd_mul_add_item)
			list_box_mul_menu.enable_item (Cmd_mul_delete)
			list_box_mul_menu.enable_item (Cmd_mul_count_item)
			list_box_mul_menu.enable_item (Cmd_mul_count_selected_item)
		end

	menu_mul_delete
		do
			if {l_list_box_mul: like list_box_mul} list_box_mul then
				l_list_box_mul.destroy
			end
			list_box_mul_menu.enable_item (Cmd_mul_create)
			list_box_mul_menu.disable_item (Cmd_mul_delete)
			list_box_mul_menu.disable_item (Cmd_mul_add_item)
			list_box_mul_menu.disable_item (Cmd_mul_count_item)
			list_box_mul_menu.disable_item (Cmd_mul_count_selected_item)
			list_box_mul_menu.disable_item (Cmd_mul_current_item)
		end

	menu_mul_add_item
		do
			list_box_mul_menu.enable_item (Cmd_mul_current_item)
			text_info.wipe_out
			if {l_list_box_mul: like list_box_mul} list_box_mul then
				text_info.append ("Item ")
				text_info.append_integer (list_box_mul_item_num)
				l_list_box_mul.add_string (text_info)
				list_box_mul_item_num := list_box_mul_item_num + 1
			end
		end

	menu_mul_count_item
		local
			msg_box: WEL_MSG_BOX
		do
			text_info.wipe_out
			if {l_list_box_mul: like list_box_mul} list_box_mul then
				text_info.append_integer (l_list_box_mul.count)
				if l_list_box_mul.count > 1 then
					text_info.append (" items are present.")
				else
					text_info.append (" item is present.")
				end
			end
			create msg_box.make
			msg_box.information_message_box (Current, text_info, "Count item")
		end

	menu_mul_count_selected_item
		local
			msg_box: WEL_MSG_BOX
			selected_items: ARRAY [INTEGER]
			i: INTEGER
		do
			text_info.wipe_out
			if {l_list_box_mul: like list_box_mul} list_box_mul then
				text_info.append_integer (l_list_box_mul.count_selected_items)
				text_info.append (" items are selected.%N%N")
				text_info.append ("Selected items: ")

				selected_items := l_list_box_mul.selected_items
				from
					i := selected_items.lower
				until
					i > selected_items.upper
				loop
					text_info.append ((selected_items @ i).out)
					if i /= selected_items.upper then
						text_info.append (", ")
					end
						-- Goto line if
					if (i \\ 15) = 14 then
						text_info.append ("%N")
					end
					i := i + 1
				end
			end
			create msg_box.make
			msg_box.information_message_box (Current, text_info, "Count item")
		end

	menu_mul_current_item
		local
			i: INTEGER
			array_items: ARRAY [STRING_32]
			msg_box: WEL_MSG_BOX
		do
			if
				{l_list_box_mul: like list_box_mul} list_box_mul and then
				l_list_box_mul.count_selected_items > 0
			then
				text_info.wipe_out
				array_items := l_list_box_mul.selected_strings
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
				if l_list_box_mul.count_selected_items > 1 then
					text_info.append (" are selected.")
				else
					text_info.append (" is selected.")
				end
				create msg_box.make
				msg_box.information_message_box (Current, text_info, "Current item")
			else
				create msg_box.make
				msg_box.error_message_box (Current, "No item selected.", "Error")
			end
		end

	menu_combo_box_create
		local
			l_combo_box: like combo_box
		do
			combo_box_item_num := 0
			create l_combo_box.make (Current, 115, 20, 102, 90, -1)
			combo_box := l_combo_box
			l_combo_box.set_font (gui_font)
			combo_box_menu.disable_item (Cmd_combo_box_create)
			combo_box_menu.disable_item (Cmd_combo_box_current_item)
			combo_box_menu.enable_item (Cmd_combo_box_add_item)
			combo_box_menu.enable_item (Cmd_combo_box_delete)
			combo_box_menu.enable_item (Cmd_combo_box_count_item)
			combo_box_menu.enable_item (Cmd_combo_box_show_list)
			combo_box_menu.enable_item (Cmd_combo_box_hide_list)
		end

	menu_combo_box_delete
		do
			if {l_combo_box: like combo_box} combo_box then
				l_combo_box.hide_list
				l_combo_box.destroy
			end
			combo_box_menu.enable_item (Cmd_combo_box_create)
			combo_box_menu.disable_item (Cmd_combo_box_delete)
			combo_box_menu.disable_item (Cmd_combo_box_add_item)
			combo_box_menu.disable_item (Cmd_combo_box_count_item)
			combo_box_menu.disable_item (Cmd_combo_box_current_item)
			combo_box_menu.disable_item (Cmd_combo_box_show_list)
			combo_box_menu.disable_item (Cmd_combo_box_hide_list)
		end

	menu_combo_box_add_item
		do
			combo_box_menu.enable_item (Cmd_combo_box_current_item)
			text_info.wipe_out
			text_info.append ("Item ")
			text_info.append_integer (combo_box_item_num)
			if {l_combo_box: like combo_box} combo_box then
				l_combo_box.add_string (text_info)
				combo_box_item_num := combo_box_item_num + 1
			end
		end

	menu_combo_box_count_item
		local
			msg_box: WEL_MSG_BOX
		do
			text_info.wipe_out
			if {l_combo_box: like combo_box} combo_box then
				text_info.append_integer (l_combo_box.count)
				if l_combo_box.count > 1 then
					text_info.append (" items are present.")
				else
					text_info.append (" item is present.")
				end
			end
			create msg_box.make
			msg_box.information_message_box (Current, text_info, "Count item")
		end

	menu_combo_box_current_item
		local
			msg_box: WEL_MSG_BOX
		do
			if {l_combo_box: like combo_box} combo_box and then l_combo_box.selected then
				text_info.wipe_out
				text_info.append (l_combo_box.selected_string)
				text_info.append (" is selected.")
				create msg_box.make
				msg_box.information_message_box (Current, text_info, "Current item")
			else
				create msg_box.make
				msg_box.error_message_box (Current, "No item selected.", "Error")
			end
		end

	menu_combo_show_list
		do
			if {l_combo_box: like combo_box} combo_box then
				l_combo_box.show_list
			end
		end

	menu_combo_hide_list
		do
			if {l_combo_box: like combo_box} combo_box then
				l_combo_box.hide_list
			end
		end

	menu_button_create
		local
			l_button: like button
		do
			create l_button.make (Current, "Button", 10, 20, 100, 50, -1)
			button := l_button
			l_button.set_font (gui_font)
			button_menu.disable_item (Cmd_button_create)
			button_menu.enable_item (Cmd_button_delete)
			button_menu.uncheck_item (Cmd_button_enable)
			button_menu.uncheck_item (Cmd_button_disable)
			button_menu.enable_item (Cmd_button_enable)
			button_menu.enable_item (Cmd_button_disable)
			button_menu.check_item (Cmd_button_enable)
		end

	menu_button_delete
		do
			if {l_button: like button} button then
				l_button.destroy
			end
			button_menu.disable_item (Cmd_button_delete)
			button_menu.disable_item (Cmd_button_enable)
			button_menu.disable_item (Cmd_button_disable)
			button_menu.enable_item (Cmd_button_create)
			button_menu.uncheck_item (Cmd_button_enable)
			button_menu.uncheck_item (Cmd_button_disable)
		end

	menu_button_enable
		do
			if {l_button: like button} button then
				l_button.enable
			end
			button_menu.check_item (Cmd_button_enable)
			button_menu.uncheck_item (Cmd_button_disable)
		end

	menu_button_disable
		do
			if {l_button: like button} button then
				l_button.disable
			end
			button_menu.uncheck_item (Cmd_button_enable)
			button_menu.check_item (Cmd_button_disable)
		end

	menu_edit_create
		local
			l_edit: like edit
		do
			create l_edit.make (Current, "Edit", 250, 100, 100, 22, -1)
			edit := l_edit
			l_edit.set_font (gui_font)
			edit_menu.disable_item (Cmd_edit_create)
			edit_menu.enable_item (Cmd_edit_delete)
			edit_menu.enable_item (Cmd_edit_set_text)
			edit_menu.enable_item (Cmd_edit_clear_text)
			edit_menu.enable_item (Cmd_edit_text_length)
			edit_menu.enable_item (Cmd_edit_current_text)
		end

	menu_edit_delete
		do
			if {l_edit: like edit} edit then
				l_edit.destroy
			end
			edit_menu.enable_item (Cmd_edit_create)
			edit_menu.disable_item (Cmd_edit_delete)
			edit_menu.disable_item (Cmd_edit_set_text)
			edit_menu.disable_item (Cmd_edit_clear_text)
			edit_menu.disable_item (Cmd_edit_text_length)
			edit_menu.disable_item (Cmd_edit_current_text)
		end

	menu_edit_set_text
		do
			if {l_edit: like edit} edit then
				l_edit.set_text ("New text")
			end
		end

	menu_edit_clear_text
		do
			if {l_edit: like edit} edit then
				l_edit.clear
			end
		end

	menu_edit_text_length
		local
			msg_box: WEL_MSG_BOX
		do
			text_info.wipe_out
			if {l_edit: like edit} edit then
				text_info.append ("The length is ")
				text_info.append_integer (l_edit.text_length)
			end
			create msg_box.make
			msg_box.information_message_box (Current, text_info, "Text length")
		end

	menu_edit_current_text
		local
			msg_box: WEL_MSG_BOX
		do
			if {l_edit: like edit} edit then
				create msg_box.make
				msg_box.information_message_box (Current, l_edit.text, "Current text")
			end
		end

	menu_multi_edit_create
		local
			l_multi_edit: like multi_edit
		do
			create l_multi_edit.make (Current, "Multiple line edit", 250, 20, 300, 70, -1)
			multi_edit := l_multi_edit
			l_multi_edit.set_font (gui_font)
			multi_edit_menu.disable_item (Cmd_multi_edit_create)
			multi_edit_menu.enable_item (Cmd_multi_edit_delete)
			multi_edit_menu.enable_item (Cmd_multi_edit_set_text)
			multi_edit_menu.enable_item (Cmd_multi_edit_clear_text)
			multi_edit_menu.enable_item (Cmd_multi_edit_text_length)
			multi_edit_menu.enable_item (Cmd_multi_edit_current_text)
		end

	menu_multi_edit_delete
		do
			if {l_multi_edit: like multi_edit} multi_edit then
				l_multi_edit.destroy
			end
			multi_edit_menu.enable_item (Cmd_multi_edit_create)
			multi_edit_menu.disable_item (Cmd_multi_edit_delete)
			multi_edit_menu.disable_item (Cmd_multi_edit_set_text)
			multi_edit_menu.disable_item (Cmd_multi_edit_clear_text)
			multi_edit_menu.disable_item (Cmd_multi_edit_text_length)
			multi_edit_menu.disable_item (Cmd_multi_edit_current_text)
		end

	menu_multi_edit_set_text
		do
			if {l_multi_edit: like multi_edit} multi_edit then
				l_multi_edit.set_text ("New text")
			end
		end

	menu_multi_edit_clear_text
		do
			if {l_multi_edit: like multi_edit} multi_edit then
				l_multi_edit.clear
			end
		end

	menu_multi_edit_text_length
		local
			msg_box: WEL_MSG_BOX
		do
			text_info.wipe_out
			if {l_multi_edit: like multi_edit} multi_edit then
				text_info.append ("The length is ")
				text_info.append_integer (l_multi_edit.text_length)
			end
			create msg_box.make
			msg_box.information_message_box (Current, text_info, "Text length")
		end

	menu_multi_edit_current_text
		local
			msg_box: WEL_MSG_BOX
		do
			if {l_multi_edit: like multi_edit} multi_edit then
				create msg_box.make
				msg_box.information_message_box (Current, l_multi_edit.text, "Current text")
			end
		end

	menu_scroll_bar_create
		local
			l_scroll_bar: like scroll_bar
			l_static: like static
		do
			create l_static.make (Current, "static", 250, 270, 30, 20, -1)
			static := l_static
			l_static.set_font (gui_font)
			if vertical_scroll_bar then
				create l_scroll_bar.make_vertical (Current, 250, 170, 20, 100, -1)
			else
				create l_scroll_bar.make_horizontal (Current, 250, 250, 100, 20, -1)
			end
			scroll_bar := l_scroll_bar
			scroll_bar_menu.enable_item (Cmd_scroll_bar_delete)
			scroll_bar_sub_menu.disable_item (Cmd_scroll_bar_set_vertical)
			scroll_bar_sub_menu.disable_item (Cmd_scroll_bar_set_horizontal)
			l_scroll_bar.set_range (0, 100)
			l_scroll_bar.set_position (50)
			text_info.wipe_out
			text_info.append_integer (l_scroll_bar.position)
			l_static.set_text (text_info)
		end

	menu_scroll_bar_delete
		do
			if {l_static: like static} static then
				l_static.destroy
			end
			if {l_scroll_bar: like scroll_bar} scroll_bar then
				l_scroll_bar.destroy
			end
			scroll_bar_menu.disable_item (Cmd_scroll_bar_delete)
			scroll_bar_sub_menu.enable_item (Cmd_scroll_bar_set_vertical)
			scroll_bar_sub_menu.enable_item (Cmd_scroll_bar_set_horizontal)
		end

	menu_scroll_bar_set_vertical
		do
			vertical_scroll_bar := True
			menu_scroll_bar_create
		end

	menu_scroll_bar_set_horizontal
		do
			vertical_scroll_bar := False
			menu_scroll_bar_create
		end

	menu_radio_create
		local
			l_group1: like group1
			l_radio1: like radio1
			l_radio2: like radio2
		do
			create l_group1.make (Current, "Group box", 380, 90, 85, 70, -1)
			group1 := l_group1
			l_group1.set_font (gui_font)
			create l_radio1.make (Current, "Radio1", 390, 110, 65, 20, -1)
			radio1 := l_radio1
			l_radio1.set_font (gui_font)
			create l_radio2.make (Current, "Radio2", 390, 130, 65, 20, -1)
			radio2 := l_radio2
			l_radio2.set_font (gui_font)
			radio_menu.enable_item (Cmd_radio_delete)
			radio_menu.enable_item (Cmd_radio_state)
			radio_menu.disable_item (Cmd_radio_create)
		end

	menu_radio_delete
		do
			if {l_radio1: like radio1} radio1 then
				l_radio1.destroy
			end
			if {l_radio2: like radio2} radio2 then
				l_radio2.destroy
			end
			if {l_group1: like group1} group1 then
				l_group1.destroy
			end
			radio_menu.disable_item (Cmd_radio_delete)
			radio_menu.disable_item (Cmd_radio_state)
			radio_menu.enable_item (Cmd_radio_create)
		end

	menu_radio_state
		local
			msg_box: WEL_MSG_BOX
		do
			text_info.wipe_out
			if {l_radio1: like radio1} radio1 then
				text_info.append (l_radio1.text)
				text_info.append (" is ")
				if l_radio1.checked then
					text_info.append ("checked.%N")
				else
					text_info.append ("unchecked.%N")
				end
			end
			if {l_radio2: like radio2} radio2 then
				text_info.append (l_radio2.text)
				text_info.append (" is ")
				if l_radio2.checked then
					text_info.append ("checked.")
				else
					text_info.append ("unchecked.")
				end
			end
			create msg_box.make
			msg_box.information_message_box (Current, text_info, "State")
		end

	menu_check_create
		local
			l_group2: like group2
			l_bcheck1: like bcheck1
			l_bcheck2: like bcheck2
		do
			create l_group2.make (Current, "Group box", 380, 180, 85, 70, -1)
			group2 := l_group2
			l_group2.set_font (gui_font)
			create l_bcheck1.make (Current, "Check1", 390, 200, 65, 20, -1)
			bcheck1 := l_bcheck1
			l_bcheck1.set_font (gui_font)
			create l_bcheck2.make (Current, "Check2", 390, 220, 65, 20, -1)
			bcheck2 := l_bcheck2
			l_bcheck2.set_font (gui_font)
			check_menu.enable_item (Cmd_check_delete)
			check_menu.enable_item (Cmd_check_state)
			check_menu.disable_item (Cmd_check_create)
		end

	menu_check_delete
		do
			if {l_bcheck1: like bcheck1} bcheck1 then
				l_bcheck1.destroy
			end
			if {l_bcheck2: like bcheck2} bcheck2 then
				l_bcheck2.destroy
			end
			if {l_group2: like group2} group2 then
				l_group2.destroy
			end
			check_menu.disable_item (Cmd_check_delete)
			check_menu.disable_item (Cmd_check_state)
			check_menu.enable_item (Cmd_check_create)
		end

	menu_check_state
		local
			msg_box: WEL_MSG_BOX
		do
			text_info.wipe_out
			if {l_bcheck1: like bcheck1} bcheck1 then
				text_info.append (l_bcheck1.text)
				text_info.append (" is ")
				if l_bcheck1.checked then
					text_info.append ("checked.%N")
				else
					text_info.append ("unchecked.%N")
				end
			end
			if {l_bcheck2: like bcheck2} bcheck2 then
				text_info.append (l_bcheck2.text)
				text_info.append (" is ")
				if l_bcheck2.checked then
					text_info.append ("checked.")
				else
					text_info.append ("unchecked.")
				end
			end
			create msg_box.make
			msg_box.information_message_box (Current, text_info, "State")
		end

	Title: STRING = "WEL Controls";
			-- Window's title

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


end -- class MAIN_WINDOW

