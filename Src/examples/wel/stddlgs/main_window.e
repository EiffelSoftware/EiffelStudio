note
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
	make

feature {NONE} -- Initialization

	make
			-- Create the main window.
		do
			txt := "Windows Eiffel Library"
			make_top (Title)
			set_menu (main_menu)
			resize (500, 300)
		end

feature {NONE} -- Implementation

	log_font: detachable WEL_LOG_FONT
			-- Selected log font

	font: detachable WEL_FONT
			-- Selected font

	color: detachable WEL_COLOR_REF
			-- Selected color

	txt: STRING
			-- Default shown text

	on_menu_command (menu_id: INTEGER)
			-- Create the appropriate dialog.
		local
			printer_dc: WEL_PRINTER_DC
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
			when Cmd_choose_folder then
				choose_folder.activate (Current)
				if choose_folder.selected then
					txt := choose_folder.folder_name
					invalidate
				end
			when Cmd_choose_font then
				if attached log_font as l_log_font then
						-- To select the previous font (optional)
					choose_font.set_log_font (l_log_font)
				end
				choose_font.activate (Current)
				if choose_font.selected then
						-- A new font has been selected, let's
						-- repaint the text with this new font.
					log_font := choose_font.log_font
					color := choose_font.color
					create font.make_indirect (choose_font.log_font)
					invalidate
				end
			when Cmd_choose_color then
				if attached color as l_color then
						-- To select the previous color (optional)
					choose_color.set_rgb_result (l_color)
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
				end
			end
		end

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT)
			-- Paint the text with the selected font and the
			-- selected color.
		do
			draw (paint_dc, client_rect)
		end

	draw (dc: WEL_DC; rect: WEL_RECT)
			-- Paint the text with the selected font and the
			-- selected color.
		do
			if attached color as l_color then
				dc.set_text_color (l_color)
			end
			if attached font as l_font then
				dc.select_font (l_font)
			end
			dc.rectangle (0, 0, rect.width, rect.height)
			dc.draw_centered_text (txt, rect)
		end

	choose_file: WEL_OPEN_FILE_DIALOG
			-- Dialog box to choose a file.
		once
			create Result.make
		ensure
			result_not_void: Result /= Void
		end

	choose_font: WEL_CHOOSE_FONT_DIALOG
			-- Dialog box to choose a text font.
		once
			create Result.make
		ensure
			result_not_void: Result /= Void
		end

	choose_color: WEL_CHOOSE_COLOR_DIALOG
			-- Dialog box to choose a text color.
		once
			create Result.make
		ensure
			result_not_void: Result /= Void
		end

	choose_folder: WEL_CHOOSE_FOLDER_DIALOG
			-- Dialog box to choose a directory.
		once
			create Result.make
			Result.set_flags ({WEL_BIF_CONSTANTS}.Bif_usenewui)
		ensure
			result_not_void: Result /= Void
		end

	print_dialog: WEL_PRINT_DIALOG
			-- Dialog box to setup the print job.
		once
			create Result.make
		ensure
			result_not_void: Result /= Void
		end

	class_icon: WEL_ICON
			-- Window's icon
		once
			create Result.make_by_id (Id_ico_application)
		end

	main_menu: WEL_MENU
			-- Window's menu
		once
			create Result.make_by_id (Id_main_menu)
		ensure
			result_not_void: Result /= Void
		end

	Title: STRING = "WEL Standard Dialogs";
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

