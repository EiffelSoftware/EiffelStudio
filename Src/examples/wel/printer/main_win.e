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
		do
			make_top (Title)
			set_menu (main_menu)
			resize (500, 300)
		end

feature {NONE} -- Implementation

	on_menu_command (menu_id: INTEGER) is
		local
			rect: WEL_RECT
			msg_box: WEL_MSG_BOX
		do
			inspect
				menu_id
			when Cmd_exit then
				destroy
			when Cmd_print then
				!! printer_dc.make
				if printer_dc.exists then
					printer_dc.start_document ("WEL Print Test")
					printer_dc.start_page
					!! rect.make (0, 0, printer_dc.width, printer_dc.height)
					draw (printer_dc, rect)
					printer_dc.end_page
					printer_dc.end_document
				else
					!!msg_box.make
					msg_box.error_message_box (Current, "Unable to print. %
						%There is no default printer.", "No default printer")
				end
			end
		end

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
		do
			draw (paint_dc, client_rect)
		end

	draw (a_dc: WEL_DC; a_rect: WEL_RECT) is
			-- Draw the figures on the dc
		do
			a_dc.rectangle (0, 0, a_rect.width, a_rect.height)
			a_dc.ellipse (0, 0, a_rect.width, a_rect.height)
			a_dc.move_to (0, 0)
			a_dc.line_to (a_rect.width, a_rect.height)
			a_dc.move_to (a_rect.width, 0)
			a_dc.line_to (0, a_rect.height)
			a_dc.draw_centered_text ("Hello, Printer!", a_rect)
		end

	printer_dc: WEL_DEFAULT_PRINTER_DC
			-- DC used to print

	class_icon: WEL_ICON is
			-- Window's icon
		once
			!! Result.make_by_id (Id_ico_application)
		end

	main_menu: WEL_MENU is
			-- Window's menu
		once
			!! Result.make_by_id (Id_main_menu)
		ensure
			result_not_void: Result /= Void
		end

	Title: STRING is "WEL Print"
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
