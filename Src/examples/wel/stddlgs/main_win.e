class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			class_icon,
			on_menu_command,
			on_paint
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Create the main window.
		do
			txt := "Windows Eiffel Library"
			make_top (Title)
			set_menu (main_menu)
			resize (500, 300)
		end

feature {NONE} -- Implementation

	log_font: WEL_LOG_FONT
			-- Selected log font

	font: WEL_FONT
			-- Selected font

	color: WEL_COLOR_REF
			-- Selected color

	txt: STRING
			-- Default shown text

	printer_dc: WEL_PRINTER_DC
			-- Printer dc used to print

	on_menu_command (menu_id: INTEGER) is
			-- Create the appropriate dialog.
		local
			rect: WEL_RECT
		do
			inspect
				menu_id
			when Cmd_exit then
				destroy
			when Cmd_choose_file then
				choose_file.activate (Current)
				if choose_file.selected then
					txt := choose_file.file_name
					invalidate
				end
			when Cmd_choose_font then
				if log_font /= Void then
					-- To select the previous font (optional)
					choose_font.set_log_font (log_font)
				end
				choose_font.activate (Current)
				if choose_font.selected then
					-- A new font has been selected, let's
					-- repaint the text with this new font.
					log_font := choose_font.log_font
					log_font.set_weight (choose_font.log_font.weight)
					if choose_font.log_font.italic then
						log_font.set_italic
					else
						log_font.set_not_italic
					end
					color := choose_font.color
					create font.make_indirect (log_font)
					invalidate
				end
			when Cmd_choose_color then
				if color /= Void then
					-- To select the previous color (optional)
					choose_color.set_rgb_result (color)
				end
				choose_color.activate (Current)
				if choose_color.selected then
					-- A new color has been selected, let's
					-- repaint the text with this new color.
					color := choose_color.rgb_result
					invalidate
				end
			when Cmd_print_dialog then
				print_dialog.activate (Current)
				if print_dialog.selected then
					printer_dc := print_dialog.dc
					printer_dc.start_document ("WEL Print Test")
					printer_dc.start_page
					create rect.make (0, 0, printer_dc.width, printer_dc.height)
					draw (printer_dc, rect)
					printer_dc.end_page
					printer_dc.end_document
				else
					printer_dc := Void
				end
			end
		end

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Paint the text with the selected font and the
			-- selected color.
		do
			draw (paint_dc, client_rect)
		end

	draw (dc: WEL_DC; rect: WEL_RECT) is
			-- Paint the text with the selected font and the
			-- selected color.
		do
			if color /= Void then
				dc.set_text_color (color)
			end
			if font /= Void then
				dc.select_font (font)
			end
			dc.rectangle (0, 0, rect.width, rect.height)
			dc.draw_centered_text (txt, rect)
		end

	choose_file: WEL_OPEN_FILE_DIALOG is
			-- Dialog box to choose a file.
		once
			create Result.make
		ensure
			result_not_void: Result /= Void
		end

	choose_font: WEL_CHOOSE_FONT_DIALOG is
			-- Dialog box to choose a text font.
		once
			create Result.make
		ensure
			result_not_void: Result /= Void
		end

	choose_color: WEL_CHOOSE_COLOR_DIALOG is
			-- Dialog box to choose a text color.
		once
			create Result.make
		ensure
			result_not_void: Result /= Void
		end

	print_dialog: WEL_PRINT_DIALOG is
			-- Dialog box to setup the print job.
		once
			create Result.make
		ensure
			result_not_void: Result /= Void
		end

	class_icon: WEL_ICON is
			-- Window's icon
		once
			create Result.make_by_id (Id_ico_application)
		end

	main_menu: WEL_MENU is
			-- Window's menu
		once
			create Result.make_by_id (Id_main_menu)
		ensure
			result_not_void: Result /= Void
		end

	Title: STRING is "WEL Standard Dialogs"
			-- Window's title

end -- class MAIN_WINDOW

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

