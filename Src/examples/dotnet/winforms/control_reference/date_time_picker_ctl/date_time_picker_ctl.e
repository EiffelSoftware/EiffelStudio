indexing
	description: ""
	
class
	DATE_TIME_PICKER_CTL

--inherit 
--	WINFORMS_FORM
--		redefine
--			make,
--			dispose
--		end

create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Entry point."
		local
			dummy: SYSTEM_OBJECT
		do
--			Precursor {WINFORMS_FORM}
			initialize_components
			
			dummy := my_window.show_dialog
		end

feature -- Access

	my_window: WINFORMS_FORM
			-- Main window.

	components: SYSTEM_DLL_SYSTEM_CONTAINER	
			-- System.ComponentModel.Container
	
	my_button: WINFORMS_BUTTON			
			-- System.Windows.Forms.Button
	
	my_text_box: WINFORMS_TEXT_BOX		
			-- System.Windows.Forms.TextBox 

	my_group_box: WINFORMS_GROUP_BOX
			-- System.Windows.Forms.GroupBox
	
	label_1, label_2, label_3: WINFORMS_LABEL
			-- System.Windows.Forms.Label

	date_time_picker, dtp_min_date, dtp_max_date: WINFORMS_DATE_TIME_PICKER
			-- System.Windows.Forms.DateTimePicker
			
	chk_show_up_down: WINFORMS_CHECK_BOX
			-- System.Windows.Forms.CheckBox

	cmb_format: WINFORMS_COMBO_BOX
			-- System.Windows.Forms.ComboBox

	btn_change_font, btn_change_color: WINFORMS_BUTTON
			-- System.Windows.Forms.Button 

	font_dialog: WINFORMS_FONT_DIALOG
			-- System.Windows.Forms.FontDialog

	tool_tip: WINFORMS_TOOL_TIP
			-- System.Windows.Forms.ToolTip 
	
	error_max, error_min: WINFORMS_ERROR_PROVIDER
			-- System.Windows.Forms.ErrorProvider errorMax;
			
	format_choisse_array: NATIVE_ARRAY [SYSTEM_STRING] is
			-- Choisses of format.
		once
			create Result.make (4)
			Result.put (0, ("Long").to_cil)
			Result.put (1, ("Short").to_cil)
			Result.put (2, ("Time").to_cil)
			Result.put (3, ("Custom").to_cil)
		ensure
			non_void_result: Result /= Void
		end


feature -- Implementation

	initialize_components is
			--
		local
			l_array: NATIVE_ARRAY [SYSTEM_STRING]
			l_point: DRAWING_POINT
			l_size: DRAWING_SIZE
		do
			create my_window.make
			
			create components.make
			create label_3.make
			create error_min.make
			create cmb_format.make
			create dtp_min_date.make
			create label_2.make
			create my_group_box.make
			create label_1.make
			create font_dialog.make
			create tool_tip.make
			create btn_change_font.make
			create date_time_picker.make
			create btn_change_color.make
			create error_max.make
			create dtp_max_date.make
			create chk_show_up_down.make
			
			my_window.set_text (("DateTimePicker").to_cil)
--			my_window.set_auto_scale_base_size (create {DRAWING_SIZE}.make_from_width_and_height (5, 13))
--			my_window.set_client_size_size (create {DRAWING_SIZE}.make_from_width_and_height (504, 293))
			l_size.make_from_width_and_height (5, 13)
			my_window.set_auto_scale_base_size (l_size)
			l_size.make_from_width_and_height (504, 293)
			my_window.set_client_size (l_size)
			
			tool_tip.set_active (True)
			
--			label_3.set_location (create {DRAWING_POINT}.make_from_x_and_y (16, 80))
			l_point.make_from_x_and_y (16, 80)
			label_3.set_location (l_point)
			label_3.set_text (("set_format:").to_cil)
--			label_3.set_size (create {DRAWING_SIZE}.make_from_width_and_height (64, 16))
			l_size.make_from_width_and_height (64, 16)
			label_3.set_size (l_size)
			label_3.set_tab_index (0)
			
			error_min.set_data_member (("").to_cil)
--			error_min.set_data_source (Void)
--			error_min.set_container_control (Void)
			
				-- Init `cmd_format'.
--			cmb_format.set_location (create {DRAWING_POINT}.make_from_x_and_y (128, 72))
--			cmb_format.set_size (create {DRAWING_SIZE}.make_from_width_and_height (104, 21))
			l_point.make_from_x_and_y (128, 72)
			cmb_format.set_location (l_point)
			l_size.make_from_width_and_height (104, 21)
			cmb_format.set_size (l_size)
			cmb_format.set_drop_down_style (feature {WINFORMS_COMBO_BOX_STYLE}.drop_down_list)	--System.Windows.Forms.ComboBoxStyle.DropDownList
--			tool_tip.set_tool_tip(cmb_format, "A value indicating the whether the control displays date and time\r\ninformation in long date set_format(for example, \"Wednesday, April 7, 1999\"),\r\nshort date set_format(for example, \"4/7/99\"), time set_format(for example,\r\n\"5:31:34 PM\"), or custom format.")
			cmb_format.set_tab_index (7)
			cmb_format.set_anchor (	feature {WINFORMS_ANCHOR_STYLES}.top | 
									feature {WINFORMS_ANCHOR_STYLES}.left | 
									feature {WINFORMS_ANCHOR_STYLES}.right )
--			create l_array.make (4)
--			l_array.put (0, ("Long").to_cil)
--			l_array.put (1, ("Short").to_cil)
--			l_array.put (2, ("Time").to_cil)
--			l_array.put (3, ("Custom").to_cil)
--			cmb_format.items.add_range (l_array)
			cmb_format.items.add_range (format_choisse_array)
			cmb_format.add_selected_index_changed (create {EVENT_HANDLER}.make (Current, $cmb_format_selected_index_changed))
			
				-- Init `dtp_min_date'.
--			dtp_min_date.set_location (create {DRAWING_POINT}.make_from_x_and_y (128, 24))
--			dtp_min_date.set_size (create {DRAWING_SIZE}.make_from_width_and_height (104, 20))
			l_point.make_from_x_and_y (128, 24)
			dtp_min_date.set_location (l_point)
			l_size.make_from_width_and_height (104, 20)
			dtp_min_date.set_size (l_size)
			dtp_min_date.set_calendar_fore_color (feature {DRAWING_SYSTEM_COLORS}.window_text)
			dtp_min_date.set_checked (True)
			dtp_min_date.set_fore_color (feature {DRAWING_SYSTEM_COLORS}.window_text)
			dtp_min_date.set_format (feature {WINFORMS_DATE_TIME_PICKER_FORMAT}.Short)
--			tool_tip.set_tool_tip (dtp_min_date, "The value indicating the first date that\r\nthe control allows the user to select")
			dtp_min_date.set_tab_index (6)
			dtp_min_date.set_anchor ( feature {WINFORMS_ANCHOR_STYLES}.Top |
										feature {WINFORMS_ANCHOR_STYLES}.Left |
										feature {WINFORMS_ANCHOR_STYLES}.Right )
			dtp_min_date.set_back_color (feature {DRAWING_SYSTEM_COLORS}.window)
			dtp_min_date.add_value_changed (create {EVENT_HANDLER}.make (Current, $dtp_min_date_value_changed))
			
				-- Init `label_2'.
--			label_2.set_location (create {DRAWING_POINT}.make_from_x_and_y (16, 56))
			l_point.make_from_x_and_y (16, 56)
			label_2.set_location (l_point)
			label_2.set_text (("MaxDate:").to_cil)
--			label_2.set_size (create {DRAWING_SIZE}.make_from_width_and_height (96, 16))
			l_size.make_from_width_and_height (96, 16)
			label_2.set_size (l_size)
			label_2.set_tab_index (1)
			
				-- Init `my_group_box'.
--			my_group_box.set_location (create {DRAWING_POINT}.make_from_x_and_y (248, 16))
			l_point.make_from_x_and_y (248, 16)
			my_group_box.set_location (l_point)
			my_group_box.set_ime_mode (feature {WINFORMS_IME_MODE}.disable)
			my_group_box.set_tab_index (0)
			my_group_box.set_anchor ( feature {WINFORMS_ANCHOR_STYLES}.Top |
									   feature {WINFORMS_ANCHOR_STYLES}.Bottom |
									   feature {WINFORMS_ANCHOR_STYLES}.Right )
			my_group_box.set_tab_stop (False)
			my_group_box.set_text (("DateTimePicker").to_cil)
--			my_group_box.set_size (create {DRAWING_SIZE}.make_from_width_and_height (248, 264))
			l_size.make_from_width_and_height (248, 264)
			my_group_box.set_size (l_size)
			
				-- Init `label_1'.
--			label_1.set_location (create {DRAWING_POINT}.make_from_x_and_y (16, 32))
			l_point.make_from_x_and_y (16, 32)
			label_1.set_location (l_point)
			label_1.set_text (("MinDate:").to_cil)
--			label_1.set_size (create {DRAWING_SIZE}.make_from_width_and_height (80, 16))
			l_size.make_from_width_and_height (80, 16)
			label_1.set_size (l_size)
			label_1.set_tab_index (3)
			
				-- Init `btn_change_font'.
			btn_change_font.set_flat_style (feature {WINFORMS_FLAT_STYLE}.Flat)
--			btn_change_font.set_location (create {DRAWING_POINT}.make_from_x_and_y (16, 216))
			l_point.make_from_x_and_y (16, 216)
			btn_change_font.set_location (l_point)
			btn_change_font.set_text (("Change &Font").to_cil)
--			btn_change_font.set_size (create {DRAWING_SIZE}.make_from_width_and_height (104, 32))
			l_size.make_from_width_and_height (104, 32)
			btn_change_font.set_size (l_size)
			btn_change_font.set_tab_index (5)
			btn_change_font.set_anchor ( feature {WINFORMS_ANCHOR_STYLES}.Bottom |
								  		 feature {WINFORMS_ANCHOR_STYLES}.Right )
			btn_change_font.add_click (create {EVENT_HANDLER}.make (Current, $btn_change_font_click))
			
				-- Init `date_time_picker'.
--			date_time_picker.set_location (create {DRAWING_POINT}.make_from_x_and_y (24, 24))
--			date_time_picker.set_size (create {DRAWING_SIZE}.make_from_width_and_height (200, 20))
			l_point.make_from_x_and_y (24, 24)
			date_time_picker.set_location (l_point)
			l_size.make_from_width_and_height (200, 20)
			date_time_picker.set_size (l_size)
			date_time_picker.set_calendar_fore_color ((feature {DRAWING_SYSTEM_COLORS}.window_text))
			date_time_picker.set_checked (True)
			date_time_picker.set_fore_color (feature {DRAWING_SYSTEM_COLORS}.window_text)
			date_time_picker.set_format (feature {WINFORMS_DATE_TIME_PICKER_FORMAT}.Custom)
			date_time_picker.set_tab_index (1)
			date_time_picker.set_back_color (feature {DRAWING_SYSTEM_COLORS}.window)
			date_time_picker.set_custom_format (("\'The date is: \'yy MM d - HH\':\'mm\':\'s ddd").to_cil)
			date_time_picker.set_anchor ( feature {WINFORMS_ANCHOR_STYLES}.Top |
											feature {WINFORMS_ANCHOR_STYLES}.Bottom |
											feature {WINFORMS_ANCHOR_STYLES}.Left |
											feature {WINFORMS_ANCHOR_STYLES}.Right )

				-- Init `btn_change_color'.
			btn_change_color.set_flat_style (feature {WINFORMS_FLAT_STYLE}.Flat)
--			btn_change_color.set_location (create {DRAWING_POINT}.make_from_x_and_y (128, 216))
			l_point.make_from_x_and_y (128, 216)
			btn_change_color.set_location (l_point)
			btn_change_color.set_text (("Change &Color").to_cil)
--			btn_change_color.set_size (create {DRAWING_SIZE}.make_from_width_and_height (104, 32))
			l_size.make_from_width_and_height (104, 32)
			btn_change_color.set_size (l_size)
			btn_change_color.set_tab_index (2)
			btn_change_color.set_anchor (feature {WINFORMS_ANCHOR_STYLES}.Bottom |
										feature {WINFORMS_ANCHOR_STYLES}.Right )
			btn_change_color.add_click (create {EVENT_HANDLER}.make (Current, $btn_change_color_click))
			
			error_max.set_data_member (("").to_cil)
--			error_max.set_data_source (null)
--			error_max.set_container_control (null)
			
				-- Init `dtp_max_date'.
--			dtp_max_date.set_location (create {DRAWING_POINT}.make_from_x_and_y (128, 48))
--			dtp_max_date.set_size (create {DRAWING_SIZE}.make_from_width_and_height (104, 20))
			l_point.make_from_x_and_y (128, 48)
			dtp_max_date.set_location (l_point)
			l_size.make_from_width_and_height (104, 20)
			dtp_max_date.set_size (l_size)
			dtp_max_date.set_calendar_fore_color (feature {DRAWING_SYSTEM_COLORS}.window_text)
			dtp_max_date.set_checked (True)
			dtp_max_date.set_fore_color (feature {DRAWING_SYSTEM_COLORS}.window_text)
			dtp_max_date.set_format (feature {WINFORMS_DATE_TIME_PICKER_FORMAT}.Short)
--			tool_tip.set_tool_tip(dtp_max_date, "The value indicating the last date that \r\nthe control allows the user to select")
			dtp_max_date.set_tab_index (4)
			dtp_max_date.set_anchor ( feature {WINFORMS_ANCHOR_STYLES}.Top |
									feature {WINFORMS_ANCHOR_STYLES}.Left |
									feature {WINFORMS_ANCHOR_STYLES}.Right)
			dtp_max_date.set_back_color ( feature {DRAWING_SYSTEM_COLORS}.window)
			dtp_max_date.add_value_changed (create {EVENT_HANDLER}.make (Current, $dtp_max_date_value_changed))
			
				-- Init `chk_show_up_down'.
--			chk_show_up_down.set_location (create {DRAWING_POINT}.make_from_x_and_y (16, 104))
			l_point.make_from_x_and_y (16, 104)
			chk_show_up_down.set_location (l_point)
			chk_show_up_down.set_text (("ShowUpDown:").to_cil)
			chk_show_up_down.set_check_align (feature {DRAWING_CONTENT_ALIGNMENT}.middle_right)
--			chk_show_up_down.set_size (create {DRAWING_SIZE}.make_from_width_and_height (100, 23))
			l_size.make_from_width_and_height (100, 23)
			chk_show_up_down.set_size (l_size)
			chk_show_up_down.set_accessible_role (feature {WINFORMS_ACCESSIBLE_ROLE}.check_button)
			chk_show_up_down.set_tab_index (8)
			chk_show_up_down.add_click (create {EVENT_HANDLER}.make (Current, $chk_show_up_down_click))
			
			my_group_box.controls.add (chk_show_up_down)
			my_group_box.controls.add (btn_change_font)
			my_group_box.controls.add (btn_change_color)
			my_group_box.controls.add (dtp_max_date)
			my_group_box.controls.add (dtp_min_date)
			my_group_box.controls.add (label_3)
			my_group_box.controls.add (label_2)
			my_group_box.controls.add (label_1)
			my_group_box.controls.add (cmb_format)
			
			my_window.controls.add (date_time_picker)
			my_window.controls.add (my_group_box)
		end


feature {NONE} -- Implementation

	dispose is
			-- method call when form is disposed.
		local
			dummy: WINFORMS_DIALOG_RESULT
		do
			dummy := feature {WINFORMS_MESSAGE_BOX}.show (("Disposed !").to_cil)
		end
	
	btn_change_font_click (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			-- feature performed when `btn_change_font' is clicked.
		local
			new_font: DRAWING_FONT
			dummy: SYSTEM_OBJECT
		do
			dummy := font_dialog.show_dialog
			new_font := font_dialog.font
			date_time_picker.set_font (new_font)
		end

	btn_change_color_click (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			-- feature performed when `btn_change_color' is clicked.
		local
--			dlg: CHANGE_COLOR_DLG
--			dummy: SYSTEM_OBJECT
		do
--			create dlg.make
--			dummy := dlg.show_dialog
		end

	dtp_min_date_value_changed (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			-- feature performed when `dtp_min_date_value' is changed.
		do
--			if dtp_min_date.value < dtp_max_date.value then
--				error_min.set_error (dtp_min_date, "")
--				date_time_picker.set_min_date (dtp_min_date.value)
--			else
--				dtp_min_date.set_value (date_time_picker.min_date)
--				error_min.set_error (dtp_min_date, "Max Date must be greater than Min Date")
--			end
		end
		
	dtp_max_date_value_changed (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			-- feature performed when `dtp_max_date_value' is changed.
		do
--			if dtp_max_date.value > dtp_min_date.value then
--				date_time_picker.set_max_date (dtp_max_date.value)
--				error_max.set_error (dtp_max_date, "")
--			else
--				dtp_max_date.set_value (date_time_picker.max_date)
--				error_max.set_error (dtp_max_date, "Max Date must be greater than Min Date")
--			end
		end

	cmb_format_selected_index_changed (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			-- feature performed when `cmd_format' is changed.
		local
			l_format: WINFORMS_DATE_TIME_PICKER_FORMAT
			item_selected: SYSTEM_STRING
		do
			if cmb_format.selected_index >= 0 then
				item_selected := cmb_format.selected_item.to_string

				if item_selected.equals (format_choisse_array.item (1)) then
					l_format := feature {WINFORMS_DATE_TIME_PICKER_FORMAT}.short
				elseif item_selected.equals (format_choisse_array.item (2)) then
					l_format := feature {WINFORMS_DATE_TIME_PICKER_FORMAT}.time
				elseif item_selected.equals (format_choisse_array.item (3)) then
					l_format := feature {WINFORMS_DATE_TIME_PICKER_FORMAT}.custom
				else
					l_format := feature {WINFORMS_DATE_TIME_PICKER_FORMAT}.long
				end

				date_time_picker.set_format (l_format)
			end
		end

        chk_show_up_down_click (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
        		--
        	local
        		show_up_down: BOOLEAN
        	do
        		show_up_down := chk_show_up_down.checked
        		date_time_picker.set_show_up_down (show_up_down)
        	end
		
end -- class DATE_TIME_PICKER_CTL
