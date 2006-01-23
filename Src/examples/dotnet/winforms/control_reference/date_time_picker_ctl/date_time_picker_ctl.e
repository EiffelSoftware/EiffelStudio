indexing
	description: "[
		Date time picker sample.
		Show how to use and how to configure the DATE_TIME_PICKER control.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	
class
	DATE_TIME_PICKER_CTL

inherit 
	WINFORMS_FORM
		rename
			make as make_form
		redefine
			dispose_boolean
		end

	ANY
	
create
	make

feature {NONE} -- Initialization

	make is
			-- Entry point.
			-- Call `initialize_components'
		do
			initialize_components
			{WINFORMS_APPLICATION}.run_form (Current)
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

	btn_change_font, btn_change_color: WINFORMS_BUTTON
			-- System.Windows.Forms.Button 

	font_dialog: WINFORMS_FONT_DIALOG
			-- System.Windows.Forms.FontDialog

	tool_tip: WINFORMS_TOOL_TIP
			-- System.Windows.Forms.ToolTip 
	
	error_max, error_min: WINFORMS_ERROR_PROVIDER
			-- System.Windows.Forms.ErrorProvider
			
	format_choice_array: NATIVE_ARRAY [SYSTEM_STRING] is
			-- Choisses of format.
		once
			create Result.make (4)
			Result.put (0, "Long")
			Result.put (1, "Short")
			Result.put (2, "Time")
			Result.put (3, "Custom")
		ensure
			non_void_result: Result /= Void
		end

feature -- Implementation

	initialize_components is
			--
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
			create btn_change_color.make
			create date_time_picker.make
			create error_max.make
			create dtp_max_date.make
			create chk_show_up_down.make

			set_text ("DateTimePicker")
			set_auto_scale_base_size (create {DRAWING_SIZE}.make (5, 13))
			set_client_size (create {DRAWING_SIZE}.make (504, 293))

			tool_tip.set_active (True)

			label_3.set_location (create {DRAWING_POINT}.make (16, 80))
			label_3.set_text ("set_format:")
			label_3.set_size (create {DRAWING_SIZE}.make (64, 16))
			label_3.set_tab_index (0)

			error_min.set_data_member ("")
			error_min.set_data_source (Void)
			error_min.set_container_control (Void)

				-- Init `cmd_format'.
			cmb_format.set_location (create {DRAWING_POINT}.make (128, 72))
			cmb_format.set_size (create {DRAWING_SIZE}.make (104, 21))
			cmb_format.set_drop_down_style ({WINFORMS_COMBO_BOX_STYLE}.drop_down_list)
			tool_tip.set_tool_tip (cmb_format, "A value indicating the whether the control displays date and time%R%Ninformation in long date set_format(for example, %"Wednesday, April 7, 1999%"),%R%Nshort date set_format(for example, %"4/7/99%"), time set_format(for example,%R%N%"5:31:34 PM%"), or custom format.")
			cmb_format.set_tab_index (7)
			cmb_format.set_anchor (	{WINFORMS_ANCHOR_STYLES}.top | 
									{WINFORMS_ANCHOR_STYLES}.left | 
									{WINFORMS_ANCHOR_STYLES}.right )
			cmb_format.items.add_range (format_choice_array)
			cmb_format.add_selected_index_changed (create {EVENT_HANDLER}.make (Current, $on_cmb_format_selected_index_changed))

				-- Init `dtp_min_date'.
			dtp_min_date.set_location (create {DRAWING_POINT}.make (128, 24))
			dtp_min_date.set_size (create {DRAWING_SIZE}.make (104, 20))
			dtp_min_date.set_calendar_fore_color ({DRAWING_SYSTEM_COLORS}.window_text)
			dtp_min_date.set_checked (True)
			dtp_min_date.set_fore_color ({DRAWING_SYSTEM_COLORS}.window_text)
			dtp_min_date.set_format ({WINFORMS_DATE_TIME_PICKER_FORMAT}.Short)
			tool_tip.set_tool_tip (dtp_min_date, "The value indicating the first date that%R%Nthe control allows the user to select")
			dtp_min_date.set_tab_index (6)
			dtp_min_date.set_anchor ( {WINFORMS_ANCHOR_STYLES}.Top |
										{WINFORMS_ANCHOR_STYLES}.Left |
										{WINFORMS_ANCHOR_STYLES}.Right )
			dtp_min_date.set_back_color ({DRAWING_SYSTEM_COLORS}.window)
			dtp_min_date.add_value_changed (create {EVENT_HANDLER}.make (Current, $on_dtp_min_date_value_changed))

				-- Init `label_2'.
			label_2.set_location (create {DRAWING_POINT}.make (16, 56))
			label_2.set_text ("MaxDate:")
			label_2.set_size (create {DRAWING_SIZE}.make (96, 16))
			label_2.set_tab_index (1)

				-- Init `my_group_box'.
			my_group_box.set_location (create {DRAWING_POINT}.make (248, 16))
			my_group_box.set_ime_mode ({WINFORMS_IME_MODE}.disable)
			my_group_box.set_tab_index (0)
			my_group_box.set_anchor ( {WINFORMS_ANCHOR_STYLES}.Top |
									   {WINFORMS_ANCHOR_STYLES}.Bottom |
									   {WINFORMS_ANCHOR_STYLES}.Right )
			my_group_box.set_tab_stop (False)
			my_group_box.set_text ("DateTimePicker")
			my_group_box.set_size (create {DRAWING_SIZE}.make (248, 264))

				-- Init `label_1'.
			label_1.set_location (create {DRAWING_POINT}.make (16, 32))
			label_1.set_text ("MinDate:")
			label_1.set_size (create {DRAWING_SIZE}.make (80, 16))
			label_1.set_tab_index (3)

				-- Init `btn_change_font'.
			btn_change_font.set_flat_style ({WINFORMS_FLAT_STYLE}.Flat)
			btn_change_font.set_location (create {DRAWING_POINT}.make (16, 216))
			btn_change_font.set_text ("Change &Font")
			btn_change_font.set_size (create {DRAWING_SIZE}.make (104, 32))
			btn_change_font.set_tab_index (5)
			btn_change_font.set_anchor ( {WINFORMS_ANCHOR_STYLES}.Bottom |
								  		 {WINFORMS_ANCHOR_STYLES}.Right )
			btn_change_font.add_click (create {EVENT_HANDLER}.make (Current, $on_btn_change_font_click))

				-- Init `date_time_picker'.
			date_time_picker.set_location (create {DRAWING_POINT}.make (24, 24))
			date_time_picker.set_size (create {DRAWING_SIZE}.make (200, 20))
			date_time_picker.set_calendar_fore_color (({DRAWING_SYSTEM_COLORS}.window_text))
			date_time_picker.set_checked (True)
			date_time_picker.set_fore_color ({DRAWING_SYSTEM_COLORS}.window_text)
			date_time_picker.set_format ({WINFORMS_DATE_TIME_PICKER_FORMAT}.Custom)
			date_time_picker.set_tab_index (1)
			date_time_picker.set_back_color ({DRAWING_SYSTEM_COLORS}.window)
			date_time_picker.set_custom_format ("'The date is: 'yy MM d - HH':'mm':'s ddd")
			date_time_picker.set_anchor ( {WINFORMS_ANCHOR_STYLES}.Top |
											{WINFORMS_ANCHOR_STYLES}.Bottom |
											{WINFORMS_ANCHOR_STYLES}.Left |
											{WINFORMS_ANCHOR_STYLES}.Right )

				-- Init `btn_change_color'.
			btn_change_color.set_flat_style ({WINFORMS_FLAT_STYLE}.Flat)
			btn_change_color.set_location (create {DRAWING_POINT}.make (128, 216))
			btn_change_color.set_text ("Change &Color")
			btn_change_color.set_size (create {DRAWING_SIZE}.make (104, 32))
			btn_change_color.set_tab_index (2)
			btn_change_color.set_anchor ({WINFORMS_ANCHOR_STYLES}.Bottom |
										{WINFORMS_ANCHOR_STYLES}.Right )
			btn_change_color.add_click (create {EVENT_HANDLER}.make (Current, $on_btn_change_color_click))

			error_max.set_data_member ("")
			error_max.set_data_source (Void)
			error_max.set_container_control (Void)

				-- Init `dtp_max_date'.
			dtp_max_date.set_location (create {DRAWING_POINT}.make (128, 48))
			dtp_max_date.set_size (create {DRAWING_SIZE}.make (104, 20))
			dtp_max_date.set_calendar_fore_color ({DRAWING_SYSTEM_COLORS}.window_text)
			dtp_max_date.set_checked (True)
			dtp_max_date.set_fore_color ({DRAWING_SYSTEM_COLORS}.window_text)
			dtp_max_date.set_format ({WINFORMS_DATE_TIME_PICKER_FORMAT}.Short)
			tool_tip.set_tool_tip(dtp_max_date, "The value indicating the last date that %R%Nthe control allows the user to select")
			dtp_max_date.set_tab_index (4)
			dtp_max_date.set_anchor ( {WINFORMS_ANCHOR_STYLES}.Top |
									{WINFORMS_ANCHOR_STYLES}.Left |
									{WINFORMS_ANCHOR_STYLES}.Right)
			dtp_max_date.set_back_color ( {DRAWING_SYSTEM_COLORS}.window)
			dtp_max_date.add_value_changed (create {EVENT_HANDLER}.make (Current, $on_dtp_max_date_value_changed))

				-- Init `chk_show_up_down'.
			chk_show_up_down.set_location (create {DRAWING_POINT}.make (16, 104))
			chk_show_up_down.set_text ("ShowUpDown:")
			chk_show_up_down.set_check_align ({DRAWING_CONTENT_ALIGNMENT}.middle_right)
			chk_show_up_down.set_size (create {DRAWING_SIZE}.make (100, 23))
			chk_show_up_down.set_accessible_role ({WINFORMS_ACCESSIBLE_ROLE}.check_button)
			chk_show_up_down.set_tab_index (8)
			chk_show_up_down.add_click (create {EVENT_HANDLER}.make (Current, $on_chk_show_up_down_click))

			my_group_box.controls.add (chk_show_up_down)
			my_group_box.controls.add (btn_change_font)
			my_group_box.controls.add (btn_change_color)
			my_group_box.controls.add (dtp_max_date)
			my_group_box.controls.add (dtp_min_date)
			my_group_box.controls.add (label_3)
			my_group_box.controls.add (label_2)
			my_group_box.controls.add (label_1)
			my_group_box.controls.add (cmb_format)

			controls.add (date_time_picker)
			controls.add (my_group_box)
		ensure
			non_void_components: components /= Void
			non_void_label_3: label_3 /= Void
			non_void_error_min: error_min /= Void
			non_void_cmb_format: cmb_format /= Void
			non_void_dtp_min_date: dtp_min_date /= Void
			non_void_label_2: label_2 /= Void
			non_void_my_group_box: my_group_box /= Void
			non_void_label_1: label_1 /= Void
			non_void_font_dialog: font_dialog /= Void
			non_void_tool_tip: tool_tip /= Void
			non_void_btn_change_font: btn_change_font /= Void
			non_void_btn_change_color: btn_change_color /= Void
			non_void_date_time_picker: date_time_picker /= Void
			non_void_error_max: error_max /= Void
			non_void_dtp_max_date: dtp_max_date /= Void
			non_void_chk_show_up_down: chk_show_up_down /= Void
		end

feature {NONE} -- Implementation

	dispose_boolean (a_disposing: BOOLEAN) is
			-- method called when form is disposed.
		local
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

	on_btn_change_font_click (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			-- feature performed when `btn_change_font' is clicked.
		require
			non_void_sender: sender /= Void
			non_void_args: args /= Void
		local
			new_font: DRAWING_FONT
			dummy: SYSTEM_OBJECT
		do
			dummy := font_dialog.show_dialog
			new_font := font_dialog.font
			date_time_picker.set_font (new_font)
		end

	on_btn_change_color_click (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is   
			-- feature performed when `btn_change_color' is clicked.   
		require
			non_void_sender: sender /= Void
			non_void_args: args /= Void
		local   
			dlg: CHANGE_COLOR_DLG   
			dummy: SYSTEM_OBJECT   
		do   
			create dlg.make (date_time_picker)
			dummy := dlg.show_dialog
		end 

	on_dtp_min_date_value_changed (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			-- feature performed when `dtp_min_date_value' is changed.
		require
			non_void_sender: sender /= Void
			non_void_args: args /= Void
		do
			if {SYSTEM_DATE_TIME}.compare (dtp_min_date.value, dtp_max_date.value) < 0 then
				error_min.set_error (dtp_min_date, "")
				date_time_picker.set_min_date (dtp_min_date.value)
			else
				dtp_min_date.set_value (date_time_picker.min_date)
				error_min.set_error (dtp_min_date, "Min Date must be lower than Max Date")
			end
		end

	on_dtp_max_date_value_changed (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			-- feature performed when `dtp_max_date_value' is changed.
		require
			non_void_sender: sender /= Void
			non_void_args: args /= Void
		do
			if {SYSTEM_DATE_TIME}.compare (dtp_max_date.value, dtp_min_date.value) >= 0 then
				date_time_picker.set_max_date (dtp_max_date.value)
				error_max.set_error (dtp_max_date, "")
			else
				dtp_max_date.set_value (date_time_picker.max_date)
				error_max.set_error (dtp_max_date, "Max Date must be greater than Min Date")
			end
		end

	on_cmb_format_selected_index_changed (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
			-- feature performed when `cmd_format' is changed.
		require
			non_void_sender: sender /= Void
			non_void_args: args /= Void
		local
			l_format: WINFORMS_DATE_TIME_PICKER_FORMAT
			item_selected: SYSTEM_STRING
		do
			if cmb_format.selected_index >= 0 then
				item_selected := cmb_format.selected_item.to_string

				if item_selected.equals (format_choice_array.item (1)) then
					l_format := {WINFORMS_DATE_TIME_PICKER_FORMAT}.short
				elseif item_selected.equals (format_choice_array.item (2)) then
					l_format := {WINFORMS_DATE_TIME_PICKER_FORMAT}.time
				elseif item_selected.equals (format_choice_array.item (3)) then
					l_format := {WINFORMS_DATE_TIME_PICKER_FORMAT}.custom
				else
					l_format := {WINFORMS_DATE_TIME_PICKER_FORMAT}.long
				end

				date_time_picker.set_format (l_format)
			end
		end

	on_chk_show_up_down_click (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
       		-- feature performed when `chk_show_up_down' is changed.
		require
			non_void_sender: sender /= Void
			non_void_args: args /= Void
       	local
       		show_up_down: BOOLEAN
       	do
       		show_up_down := chk_show_up_down.checked
       		date_time_picker.set_show_up_down (show_up_down)
       	end

invariant
	non_void_components: components /= Void
	non_void_label_3: label_3 /= Void
	non_void_error_min: error_min /= Void
	non_void_cmb_format: cmb_format /= Void
	non_void_dtp_min_date: dtp_min_date /= Void
	non_void_label_2: label_2 /= Void
	non_void_my_group_box: my_group_box /= Void
	non_void_label_1: label_1 /= Void
	non_void_font_dialog: font_dialog /= Void
	non_void_tool_tip: tool_tip /= Void
	non_void_btn_change_font: btn_change_font /= Void
	non_void_btn_change_color: btn_change_color /= Void
	non_void_date_time_picker: date_time_picker /= Void
	non_void_error_max: error_max /= Void
	non_void_dtp_max_date: dtp_max_date /= Void
	non_void_chk_show_up_down: chk_show_up_down /= Void

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


end -- class DATE_TIME_PICKER_CTL
