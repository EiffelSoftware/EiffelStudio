indexing
	description: ""
	
class
	DATE_TIME_PICKER_CTL

inherit 
	WINFORMS_FORM
		rename
			make as make_form
		undefine
			to_string, finalize, equals, get_hash_code
		redefine
			dispose_boolean
		end

	ANY
	
create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Entry point."
		local
			dummy: SYSTEM_OBJECT
		do
			initialize_components
			
			feature {WINFORMS_APPLICATION}.run_form (Current)
		end

feature -- Access

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

	btn_change_font: WINFORMS_BUTTON
			-- System.Windows.Forms.Button 

	font_dialog: WINFORMS_FONT_DIALOG
			-- System.Windows.Forms.FontDialog

	tool_tip: WINFORMS_TOOL_TIP
			-- System.Windows.Forms.ToolTip 
	
	error_max, error_min: WINFORMS_ERROR_PROVIDER
			-- System.Windows.Forms.ErrorProvider
			
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
		do
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
			create error_max.make
			create dtp_max_date.make
			create chk_show_up_down.make
			
			set_text (("DateTimePicker").to_cil)
			set_auto_scale_base_size (create {DRAWING_SIZE}.make_from_width_and_height (5, 13))
			set_client_size (create {DRAWING_SIZE}.make_from_width_and_height (504, 293))
			
			tool_tip.set_active (True)
			
			label_3.set_location (create {DRAWING_POINT}.make_from_x_and_y (16, 80))
			label_3.set_text (("set_format:").to_cil)
			label_3.set_size (create {DRAWING_SIZE}.make_from_width_and_height (64, 16))
			label_3.set_tab_index (0)
			
			error_min.set_data_member (("").to_cil)
			error_min.set_data_source (Void)
			error_min.set_container_control (Void)
			
				-- Init `cmd_format'.
			cmb_format.set_location (create {DRAWING_POINT}.make_from_x_and_y (128, 72))
			cmb_format.set_size (create {DRAWING_SIZE}.make_from_width_and_height (104, 21))
			cmb_format.set_drop_down_style (feature {WINFORMS_COMBO_BOX_STYLE}.drop_down_list)
			tool_tip.set_tool_tip(cmb_format, ("A value indicating the whether the control displays date and time%R%Ninformation in long date set_format(for example, %"Wednesday, April 7, 1999%"),%R%Nshort date set_format(for example, %"4/7/99%"), time set_format(for example,%R%N%"5:31:34 PM%"), or custom format.").to_cil)
			cmb_format.set_tab_index (7)
			cmb_format.set_anchor (	feature {WINFORMS_ANCHOR_STYLES}.top | 
									feature {WINFORMS_ANCHOR_STYLES}.left | 
									feature {WINFORMS_ANCHOR_STYLES}.right )
			cmb_format.items.add_range (format_choisse_array)
			cmb_format.add_selected_index_changed (create {EVENT_HANDLER}.make (Current, $cmb_format_selected_index_changed))
			
				-- Init `dtp_min_date'.
			dtp_min_date.set_location (create {DRAWING_POINT}.make_from_x_and_y (128, 24))
			dtp_min_date.set_size (create {DRAWING_SIZE}.make_from_width_and_height (104, 20))
			dtp_min_date.set_calendar_fore_color (feature {DRAWING_SYSTEM_COLORS}.window_text)
			dtp_min_date.set_checked (True)
			dtp_min_date.set_fore_color (feature {DRAWING_SYSTEM_COLORS}.window_text)
			dtp_min_date.set_format (feature {WINFORMS_DATE_TIME_PICKER_FORMAT}.Short)
			tool_tip.set_tool_tip (dtp_min_date, ("The value indicating the first date that%R%Nthe control allows the user to select").to_cil)
			dtp_min_date.set_tab_index (6)
			dtp_min_date.set_anchor ( feature {WINFORMS_ANCHOR_STYLES}.Top |
										feature {WINFORMS_ANCHOR_STYLES}.Left |
										feature {WINFORMS_ANCHOR_STYLES}.Right )
			dtp_min_date.set_back_color (feature {DRAWING_SYSTEM_COLORS}.window)
			dtp_min_date.add_value_changed (create {EVENT_HANDLER}.make (Current, $dtp_min_date_value_changed))
			
				-- Init `label_2'.
			label_2.set_location (create {DRAWING_POINT}.make_from_x_and_y (16, 56))
			label_2.set_text (("MaxDate:").to_cil)
			label_2.set_size (create {DRAWING_SIZE}.make_from_width_and_height (96, 16))
			label_2.set_tab_index (1)
			
				-- Init `my_group_box'.
			my_group_box.set_location (create {DRAWING_POINT}.make_from_x_and_y (248, 16))
			my_group_box.set_ime_mode (feature {WINFORMS_IME_MODE}.disable)
			my_group_box.set_tab_index (0)
			my_group_box.set_anchor ( feature {WINFORMS_ANCHOR_STYLES}.Top |
									   feature {WINFORMS_ANCHOR_STYLES}.Bottom |
									   feature {WINFORMS_ANCHOR_STYLES}.Right )
			my_group_box.set_tab_stop (False)
			my_group_box.set_text (("DateTimePicker").to_cil)
			my_group_box.set_size (create {DRAWING_SIZE}.make_from_width_and_height (248, 264))
			
				-- Init `label_1'.
			label_1.set_location (create {DRAWING_POINT}.make_from_x_and_y (16, 32))
			label_1.set_text (("MinDate:").to_cil)
			label_1.set_size (create {DRAWING_SIZE}.make_from_width_and_height (80, 16))
			label_1.set_tab_index (3)
			
				-- Init `btn_change_font'.
			btn_change_font.set_flat_style (feature {WINFORMS_FLAT_STYLE}.Flat)
			btn_change_font.set_location (create {DRAWING_POINT}.make_from_x_and_y (16, 216))
			btn_change_font.set_text (("Change &Font").to_cil)
			btn_change_font.set_size (create {DRAWING_SIZE}.make_from_width_and_height (104, 32))
			btn_change_font.set_tab_index (5)
			btn_change_font.set_anchor ( feature {WINFORMS_ANCHOR_STYLES}.Bottom |
								  		 feature {WINFORMS_ANCHOR_STYLES}.Right )
			btn_change_font.add_click (create {EVENT_HANDLER}.make (Current, $btn_change_font_click))
			
				-- Init `date_time_picker'.
			date_time_picker.set_location (create {DRAWING_POINT}.make_from_x_and_y (24, 24))
			date_time_picker.set_size (create {DRAWING_SIZE}.make_from_width_and_height (200, 20))
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
			
			error_max.set_data_member (("").to_cil)
--			error_max.set_data_source (null)
--			error_max.set_container_control (null)
			
				-- Init `dtp_max_date'.
			dtp_max_date.set_location (create {DRAWING_POINT}.make_from_x_and_y (128, 48))
			dtp_max_date.set_size (create {DRAWING_SIZE}.make_from_width_and_height (104, 20))
			dtp_max_date.set_calendar_fore_color (feature {DRAWING_SYSTEM_COLORS}.window_text)
			dtp_max_date.set_checked (True)
			dtp_max_date.set_fore_color (feature {DRAWING_SYSTEM_COLORS}.window_text)
			dtp_max_date.set_format (feature {WINFORMS_DATE_TIME_PICKER_FORMAT}.Short)
			tool_tip.set_tool_tip(dtp_max_date, ("The value indicating the last date that %R%Nthe control allows the user to select").to_cil)
			dtp_max_date.set_tab_index (4)
			dtp_max_date.set_anchor ( feature {WINFORMS_ANCHOR_STYLES}.Top |
									feature {WINFORMS_ANCHOR_STYLES}.Left |
									feature {WINFORMS_ANCHOR_STYLES}.Right)
			dtp_max_date.set_back_color ( feature {DRAWING_SYSTEM_COLORS}.window)
			dtp_max_date.add_value_changed (create {EVENT_HANDLER}.make (Current, $dtp_max_date_value_changed))
			
				-- Init `chk_show_up_down'.
			chk_show_up_down.set_location (create {DRAWING_POINT}.make_from_x_and_y (16, 104))
			chk_show_up_down.set_text (("ShowUpDown:").to_cil)
			chk_show_up_down.set_check_align (feature {DRAWING_CONTENT_ALIGNMENT}.middle_right)
			chk_show_up_down.set_size (create {DRAWING_SIZE}.make_from_width_and_height (100, 23))
			chk_show_up_down.set_accessible_role (feature {WINFORMS_ACCESSIBLE_ROLE}.check_button)
			chk_show_up_down.set_tab_index (8)
			chk_show_up_down.add_click (create {EVENT_HANDLER}.make (Current, $chk_show_up_down_click))
			
			my_group_box.controls.add (chk_show_up_down)
			my_group_box.controls.add (btn_change_font)
			my_group_box.controls.add (dtp_max_date)
			my_group_box.controls.add (dtp_min_date)
			my_group_box.controls.add (label_3)
			my_group_box.controls.add (label_2)
			my_group_box.controls.add (label_1)
			my_group_box.controls.add (cmb_format)
			
			controls.add (date_time_picker)
			controls.add (my_group_box)
		end


feature {NONE} -- Implementation

	dispose_boolean (a_disposing: BOOLEAN) is
			-- method called when form is disposed.
		local
			dummy: WINFORMS_DIALOG_RESULT
			retried: BOOLEAN
		do
			if not retried then
				if components /= Void then
					components.dispose	
				end
			end
			Precursor {WINFORMS_FORM}(a_disposing)
		rescue
			retried := true
			retry
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

	dtp_min_date_value_changed (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			-- feature performed when `dtp_min_date_value' is changed.
		local
			res_comp: INTEGER
		do
			if feature {SYSTEM_DATE_TIME}.compare (dtp_min_date.value, dtp_max_date.value) < 0 then
				error_min.set_error (dtp_min_date, ("").to_cil)
				date_time_picker.set_min_date (dtp_min_date.value)
			else
				dtp_min_date.set_value (date_time_picker.min_date)
				error_min.set_error (dtp_min_date, ("Min Date must be lower than Max Date").to_cil)
			end
		end
		
	dtp_max_date_value_changed (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			-- feature performed when `dtp_max_date_value' is changed.
		do
			if feature {SYSTEM_DATE_TIME}.compare (dtp_max_date.value, dtp_min_date.value) >= 0 then
				date_time_picker.set_max_date (dtp_max_date.value)
				error_max.set_error (dtp_max_date, ("").to_cil)
			else
				dtp_max_date.set_value (date_time_picker.max_date)
				error_max.set_error (dtp_max_date, ("Max Date must be greater than Min Date").to_cil)
			end
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
       		-- feature performed when `chk_show_up_down' is changed.
       	local
       		show_up_down: BOOLEAN
       	do
       		show_up_down := chk_show_up_down.checked
       		date_time_picker.set_show_up_down (show_up_down)
       	end
		
end -- class DATE_TIME_PICKER_CTL
