indexing
	description: ""

class
	CHANGE_COLOR_DLG

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

--			dtp := my_window.get_parent.get_dtpicker
			create dtp.make

			synchronize_panel_colors

			dummy := my_window.show_dialog
		end

feature -- Access

	my_window: WINFORMS_FORM
			-- Main window.

	components: SYSTEM_DLL_SYSTEM_CONTAINER	
			-- System.ComponentModel.Container

	dtp: WINFORMS_DATE_TIME_PICKER
			-- DateTimePicker 

	color_dialog: WINFORMS_COLOR_DIALOG
			-- System.Windows.Forms.ColorDialog

	label_1, label_2, label_3, label_4, label_5: WINFORMS_LABEL
			-- System.Windows.Forms.Label 

	btn_OK: WINFORMS_BUTTON
			-- System.Windows.Forms.Button 

	pnl_fore_color , pnl_month_background, pnl_title_back_color, pnl_title_fore_color, pnl_trailing_fore_color: WINFORMS_PANEL
			-- System.Windows.Forms.Panel 

	btn_fore_color, btn_month_background, btn_title_back_color, btn_title_fore_color, btn_trailing_fore_color: WINFORMS_BUTTON			
			-- System.Windows.Forms.Button


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
			create btn_trailing_fore_color.make
			create btn_OK.make
			create pnl_month_background.make
			create btn_title_back_color.make
			create pnl_fore_color.make
			create pnl_title_fore_color.make
			create btn_month_background.make
			create pnl_title_back_color.make
			create btn_title_fore_color.make
			create label_5.make
			create btn_fore_color.make
			create pnl_trailing_fore_color.make
			create label_4.make
			create color_dialog.make
			create label_2.make
			create label_3.make
			create label_1.make

			my_window.set_text (("Change Color").to_cil)
			my_window.set_maximize_box (False)
			l_size.make_from_width_and_height (5, 13)
			my_window.set_auto_scale_base_size (l_size)
			my_window.set_form_border_style (feature {WINFORMS_FORM_BORDER_STYLE}.fixed_dialog)
			my_window.set_minimize_box (False)
			l_size.make_from_width_and_height (406, 194)
			my_window.set_client_size_size (l_size)

			l_point.make_from_x_and_y (232, 112)
			btn_trailing_fore_color.set_location (l_point)
			l_size.make_from_width_and_height (75, 23)
			btn_trailing_fore_color.set_size (l_size)
			btn_trailing_fore_color.set_tab_index (12)
			btn_trailing_fore_color.set_text (("Change").to_cil)
			btn_trailing_fore_color.add_click (create {EVENT_HANDLER}.make (Current, $btn_trailing_fore_color_Click))

			l_point.make_from_x_and_y (320, 160)
			btn_OK.set_location (l_point)
			btn_OK.set_dialog_result (feature {WINFORMS_DIALOG_RESULT}.OK)
			l_size.make_from_width_and_height (75, 23)
			btn_OK.set_size (l_size)
			btn_OK.set_tab_index (9)
			btn_OK.set_text (("&OK").to_cil)

			pnl_month_background.set_border_style (feature {WINFORMS_BORDER_STYLE}.fixed_3_d)
			l_point.make_from_x_and_y (160, 43)
			pnl_month_background.set_location (l_point)
			l_size.make_from_width_and_height (48, 16)
			pnl_month_background.set_size (l_size)
			pnl_month_background.set_tab_index (3)
			pnl_month_background.set_text (("panel1").to_cil)

			l_point.make_from_x_and_y (232, 64)
			btn_title_back_color.set_location (l_point)
			l_size.make_from_width_and_height (75, 23)
			btn_title_back_color.set_size (l_size)
			btn_title_back_color.set_tab_index (14)
			btn_title_back_color.set_text (("Change").to_cil)
			btn_title_back_color.add_click (create {EVENT_HANDLER}.make (Current, $btn_title_back_color_Click))

			pnl_fore_color.set_border_style (feature {WINFORMS_BORDER_STYLE}.fixed_3_d)
			l_point.make_from_x_and_y (160, 19)
			pnl_fore_color.set_location (l_point)
			l_size.make_from_width_and_height (48, 16)
			pnl_fore_color.set_size (l_size)
			pnl_fore_color.set_tab_index (10)
			pnl_fore_color.set_text (("panel1").to_cil)

			pnl_title_fore_color.set_border_style (feature {WINFORMS_BORDER_STYLE}.fixed_3_d)
			l_point.make_from_x_and_y (160, 91)
			pnl_title_fore_color.set_location (l_point)
			l_size.make_from_width_and_height (48, 16)
			pnl_title_fore_color.set_size (l_size)
			pnl_title_fore_color.set_tab_index (1)
			pnl_title_fore_color.set_text (("panel1").to_cil)

			l_point.make_from_x_and_y (232, 40)
			btn_month_background.set_location (l_point)
			l_size.make_from_width_and_height (75, 23)
			btn_month_background.set_size (l_size)
			btn_month_background.set_tab_index (15)
			btn_month_background.set_text (("Change").to_cil)
			btn_month_background.add_click (create {EVENT_HANDLER}.make (Current, $btn_month_background_Click))

			pnl_title_back_color.set_border_style (feature {WINFORMS_BORDER_STYLE}.fixed_3_d)
			l_point.make_from_x_and_y (160, 67)
			pnl_title_back_color.set_location (l_point)
			l_size.make_from_width_and_height (48, 16)
			pnl_title_back_color.set_size (l_size)
			pnl_title_back_color.set_tab_index (2)
			pnl_title_back_color.set_text (("panel1").to_cil)

			l_point.make_from_x_and_y (232, 88)
			btn_title_fore_color.set_location (l_point)
			l_size.make_from_width_and_height (75, 23)
			btn_title_fore_color.set_size (l_size)
			btn_title_fore_color.set_tab_index (13)
			btn_title_fore_color.set_text (("Change").to_cil)
			btn_title_fore_color.add_click (create {EVENT_HANDLER}.make (Current, $btn_title_fore_color_Click))

			l_point.make_from_x_and_y (16, 115)
			label_5.set_location (l_point)
			label_5.set_text (("CalendarTrailingForeColor:").to_cil)
			l_size.make_from_width_and_height (136, 16)
			label_5.set_size (l_size)
			label_5.set_tab_index (4)

			l_point.make_from_x_and_y (232, 16)
			btn_fore_color.set_location (l_point)
			l_size.make_from_width_and_height (75, 23)
			btn_fore_color.set_size (l_size)
			btn_fore_color.set_tab_index (11)
			btn_fore_color.set_text (("Change").to_cil)
			btn_fore_color.add_click (create {EVENT_HANDLER}.make (Current, $btn_fore_color_Click))

			pnl_trailing_fore_color.set_border_style (feature {WINFORMS_BORDER_STYLE}.fixed_3_d)
			l_point.make_from_x_and_y (160, 115)
			pnl_trailing_fore_color.set_location (l_point)
			l_size.make_from_width_and_height (48, 16)
			pnl_trailing_fore_color.set_size (l_size)
			pnl_trailing_fore_color.set_tab_index (0)
			pnl_trailing_fore_color.set_text (("panel1").to_cil)

			l_point.make_from_x_and_y (16, 91)
			label_4.set_location (l_point)
			label_4.set_text (("CalendarTitleForeColor:").to_cil)
			l_size.make_from_width_and_height (136, 16)
			label_4.set_size (l_size)
			label_4.set_tab_index (5)

			l_point.make_from_x_and_y (16, 43)
			label_2.set_location (l_point)
			label_2.set_text (("CalendarMonthBackground:").to_cil)
			l_size.make_from_width_and_height (144, 16)
			label_2.set_size (l_size)
			label_2.set_tab_index (7)

			l_point.make_from_x_and_y (16, 67)
			label_3.set_location (l_point)
			label_3.set_text (("CalendarTitleBackColor:").to_cil)
			l_size.make_from_width_and_height (136, 16)
			label_3.set_size (l_size)
			label_3.set_tab_index (6)

			l_point.make_from_x_and_y (16, 19)
			label_1.set_location (l_point)
			label_1.set_text (("CalendarForeColor:").to_cil)
			l_size.make_from_width_and_height (136, 16)
			label_1.set_size (l_size)
			label_1.set_tab_index (8)

			my_window.get_controls.add (btn_trailing_fore_color)
			my_window.get_controls.add (btn_title_fore_color)
			my_window.get_controls.add (btn_title_back_color)
			my_window.get_controls.add (btn_month_background)
			my_window.get_controls.add (btn_fore_color)
			my_window.get_controls.add (pnl_trailing_fore_color)
			my_window.get_controls.add (pnl_title_fore_color)
			my_window.get_controls.add (pnl_title_back_color)
			my_window.get_controls.add (pnl_month_background)
			my_window.get_controls.add (pnl_fore_color)
			my_window.get_controls.add (btn_OK)
			my_window.get_controls.add (label_5)
			my_window.get_controls.add (label_4)
			my_window.get_controls.add (label_3)
			my_window.get_controls.add (label_2)
			my_window.get_controls.add (label_1)

		end


feature {NONE} -- Implementation

        synchronize_panel_colors is
        		-- 
        	do
	            pnl_fore_color.set_back_color (dtp.get_calendar_fore_color)
	            pnl_month_background.set_back_color (dtp.get_calendar_month_background)
	            pnl_title_back_color.set_back_color (dtp.get_calendar_title_back_color)
	            pnl_title_fore_color.set_back_color (dtp.get_calendar_title_fore_color)
	            pnl_trailing_fore_color.set_back_color (dtp.get_calendar_trailing_fore_color)
        	end

--		protected override void Dispose(bool disposing)
--				--      ChangeColorDlg overrides dispose so it can clean up the
--				--      component list.
--			do
--			{
--			   if (disposing) {
--					if (components != null) {
--						components.Dispose()
--					}
--			   }
--			   base.Dispose(disposing)
--			end

		btn_fore_color_Click (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
				--
			local
				res: WINFORMS_DIALOG_RESULT
			do
				color_dialog.set_color (dtp.get_calendar_fore_color)
				res := color_dialog.show_dialog
				if res.equals (feature {WINFORMS_DIALOG_RESULT}.OK) then
					dtp.set_calendar_fore_color (color_dialog.get_color)
					synchronize_panel_colors()
				end
			end

		btn_month_background_Click (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
				--
			local
				res: WINFORMS_DIALOG_RESULT
			do
				color_dialog.set_color (dtp.get_calendar_month_background)
				res := color_dialog.show_dialog
				if res.equals (feature {WINFORMS_DIALOG_RESULT}.OK) then
					dtp.set_calendar_month_background (color_dialog.get_color)
					synchronize_panel_colors()
				end
			end

		btn_title_back_color_Click (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
				--
			local
				res: WINFORMS_DIALOG_RESULT
			do
				color_dialog.set_color (dtp.get_calendar_title_back_color)
				res := color_dialog.show_dialog
				if res.equals (feature {WINFORMS_DIALOG_RESULT}.OK) then 
					dtp.set_calendar_title_back_color (color_dialog.get_color)
					synchronize_panel_colors()
				end
			end

		btn_title_fore_color_Click (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
				--
			local
				res: WINFORMS_DIALOG_RESULT
			do
				color_dialog.set_color (dtp.get_calendar_title_fore_color)
				res := color_dialog.show_dialog
				if res.equals (feature {WINFORMS_DIALOG_RESULT}.OK) then
					dtp.set_calendar_title_fore_color (color_dialog.get_color)
					synchronize_panel_colors
				end
			end

		btn_trailing_fore_color_Click (sender: SYSTEM_OBJECT; args: EVENT_ARGS) is
				--
			local
				res: WINFORMS_DIALOG_RESULT
			do
				color_dialog.set_color (dtp.get_calendar_trailing_fore_color)
				res := color_dialog.show_dialog
				if res.equals (feature {WINFORMS_DIALOG_RESULT}.OK) then
					dtp.set_calendar_trailing_fore_color (color_dialog.get_color)
					synchronize_panel_colors
				end
			end


end -- Class CHANGE_COLOR_DLG

